/**
 * The Forgotten Server - a free and open-source MMORPG server emulator
 * Copyright (C) 2016  Mark Samman <mark.samman@gmail.com>
 *
 * SQLite backend for PokeGypt (originally MySQL).
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 */

#include "otpch.h"

#include "configmanager.h"
#include "database.h"

extern ConfigManager g_config;

Database::~Database()
{
	if (handle != nullptr) {
		sqlite3_close(handle);
	}
}

bool Database::connect()
{
	const std::string& file = g_config.getString(ConfigManager::SQLITE_DB);
	if (sqlite3_open(file.c_str(), &handle) != SQLITE_OK) {
		std::cout << std::endl << "SQLite error: failed to open database '" << file << "': "
				  << (handle ? sqlite3_errmsg(handle) : "unknown error") << std::endl;
		return false;
	}

	// wait up to 10s when the database is locked instead of failing immediately
	sqlite3_busy_timeout(handle, 10000);

	// sensible defaults for a game server
	executeQuery("PRAGMA foreign_keys = ON");
	executeQuery("PRAGMA journal_mode = WAL");
	executeQuery("PRAGMA synchronous = NORMAL");
	return true;
}

bool Database::beginTransaction()
{
	if (!executeQuery("BEGIN")) {
		return false;
	}

	databaseLock.lock();
	return true;
}

bool Database::rollback()
{
	if (!executeQuery("ROLLBACK")) {
		databaseLock.unlock();
		return false;
	}

	databaseLock.unlock();
	return true;
}

bool Database::commit()
{
	if (!executeQuery("COMMIT")) {
		databaseLock.unlock();
		return false;
	}

	databaseLock.unlock();
	return true;
}

bool Database::executeQuery(const std::string& query)
{
	databaseLock.lock();

	char* errmsg = nullptr;
	bool success = true;
	if (sqlite3_exec(handle, query.c_str(), nullptr, nullptr, &errmsg) != SQLITE_OK) {
		std::cout << "[Error - sqlite3_exec] Query: " << query.substr(0, 256) << std::endl
				  << "Message: " << (errmsg ? errmsg : sqlite3_errmsg(handle)) << std::endl;
		success = false;
	}

	if (errmsg) {
		sqlite3_free(errmsg);
	}

	databaseLock.unlock();
	return success;
}

DBResult_ptr Database::storeQuery(const std::string& query)
{
	databaseLock.lock();

	sqlite3_stmt* stmt = nullptr;
	if (sqlite3_prepare_v2(handle, query.c_str(), -1, &stmt, nullptr) != SQLITE_OK) {
		std::cout << "[Error - sqlite3_prepare_v2] Query: " << query << std::endl
				  << "Message: " << sqlite3_errmsg(handle) << std::endl;
		if (stmt) {
			sqlite3_finalize(stmt);
		}
		databaseLock.unlock();
		return nullptr;
	}

	DBResult_ptr result = std::make_shared<DBResult>(stmt);
	sqlite3_finalize(stmt);
	databaseLock.unlock();

	if (!result->hasNext()) {
		return nullptr;
	}
	return result;
}

std::string Database::escapeString(const std::string& s) const
{
	std::string escaped;
	escaped.reserve(s.length() + 2);
	escaped.push_back('\'');
	for (char c : s) {
		if (c == '\'') {
			escaped.push_back('\'');
		}
		escaped.push_back(c);
	}
	escaped.push_back('\'');
	return escaped;
}

std::string Database::escapeBlob(const char* s, uint32_t length) const
{
	if (length == 0 || s == nullptr) {
		return "''";
	}

	static const char hexchars[] = "0123456789ABCDEF";

	std::string escaped;
	escaped.reserve((length * 2) + 3);
	escaped.push_back('X');
	escaped.push_back('\'');
	for (uint32_t i = 0; i < length; ++i) {
		const unsigned char c = static_cast<unsigned char>(s[i]);
		escaped.push_back(hexchars[c >> 4]);
		escaped.push_back(hexchars[c & 0x0F]);
	}
	escaped.push_back('\'');
	return escaped;
}

DBResult::DBResult(sqlite3_stmt* stmt)
{
	const int columns = sqlite3_column_count(stmt);
	for (int i = 0; i < columns; ++i) {
		listNames[sqlite3_column_name(stmt, i)] = i;
	}

	while (sqlite3_step(stmt) == SQLITE_ROW) {
		std::vector<Cell> row;
		row.reserve(columns);
		for (int i = 0; i < columns; ++i) {
			Cell cell;
			const int type = sqlite3_column_type(stmt, i);
			if (type == SQLITE_NULL) {
				cell.isNull = true;
			} else if (type == SQLITE_BLOB) {
				const void* blob = sqlite3_column_blob(stmt, i);
				const int bytes = sqlite3_column_bytes(stmt, i);
				cell.value.assign(static_cast<const char*>(blob), bytes);
				cell.isNull = false;
			} else {
				const unsigned char* text = sqlite3_column_text(stmt, i);
				const int bytes = sqlite3_column_bytes(stmt, i);
				cell.value.assign(reinterpret_cast<const char*>(text), bytes);
				cell.isNull = false;
			}
			row.push_back(std::move(cell));
		}
		rows.push_back(std::move(row));
	}

	cursor = 0;
}

std::string DBResult::getString(const std::string& s) const
{
	auto it = listNames.find(s);
	if (it == listNames.end()) {
		std::cout << "[Error - DBResult::getString] Column '" << s << "' does not exist in result set." << std::endl;
		return std::string();
	}

	const Cell& cell = rows[cursor][it->second];
	if (cell.isNull) {
		return std::string();
	}
	return cell.value;
}

const char* DBResult::getStream(const std::string& s, unsigned long& size) const
{
	auto it = listNames.find(s);
	if (it == listNames.end()) {
		std::cout << "[Error - DBResult::getStream] Column '" << s << "' doesn't exist in the result set" << std::endl;
		size = 0;
		return nullptr;
	}

	const Cell& cell = rows[cursor][it->second];
	if (cell.isNull) {
		size = 0;
		return nullptr;
	}

	size = cell.value.size();
	return cell.value.data();
}

bool DBResult::hasNext() const
{
	return cursor < rows.size();
}

bool DBResult::next()
{
	if (cursor + 1 >= rows.size()) {
		++cursor;
		return false;
	}
	++cursor;
	return true;
}

DBInsert::DBInsert(std::string query) : query(std::move(query))
{
	this->length = this->query.length();
}

bool DBInsert::addRow(const std::string& row)
{
	// adds new row to buffer
	const size_t rowLength = row.length();
	length += rowLength;
	if (length > Database::getInstance()->getMaxPacketSize() && !execute()) {
		return false;
	}

	if (values.empty()) {
		values.reserve(rowLength + 2);
		values.push_back('(');
		values.append(row);
		values.push_back(')');
	} else {
		values.reserve(values.length() + rowLength + 3);
		values.push_back(',');
		values.push_back('(');
		values.append(row);
		values.push_back(')');
	}
	return true;
}

bool DBInsert::addRow(std::ostringstream& row)
{
	bool ret = addRow(row.str());
	row.str(std::string());
	return ret;
}

bool DBInsert::execute()
{
	if (values.empty()) {
		return true;
	}

	// executes buffer
	bool res = Database::getInstance()->executeQuery(query + values);
	values.clear();
	length = query.length();
	return res;
}
