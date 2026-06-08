-- PokeGypt SQLite schema (auto-generated from schema.sql)
-- Structure only: a fresh database with no player data.
PRAGMA foreign_keys = OFF;
BEGIN TRANSACTION;

CREATE TABLE `account_ban_history` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `account_id` INTEGER NOT NULL,
  `reason` TEXT NOT NULL,
  `banned_at` INTEGER NOT NULL,
  `expired_at` INTEGER NOT NULL,
  `banned_by` INTEGER NOT NULL,
  FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`banned_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX `account_ban_history_account_id` ON `account_ban_history` (`account_id`);
CREATE INDEX `account_ban_history_banned_by` ON `account_ban_history` (`banned_by`);

CREATE TABLE `account_bans` (
  `account_id` INTEGER NOT NULL,
  `reason` TEXT NOT NULL,
  `banned_at` INTEGER NOT NULL,
  `expires_at` INTEGER NOT NULL,
  `banned_by` INTEGER NOT NULL,
  PRIMARY KEY (`account_id`),
  FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`banned_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX `account_bans_banned_by` ON `account_bans` (`banned_by`);

CREATE TABLE `account_viplist` (
  `account_id` INTEGER NOT NULL,
  `player_id` INTEGER NOT NULL,
  `description` TEXT NOT NULL DEFAULT '',
  `icon` INTEGER NOT NULL DEFAULT '0',
  `notify` INTEGER NOT NULL DEFAULT '0',
  FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
);
CREATE UNIQUE INDEX `account_viplist_account_player_index` ON `account_viplist` (`account_id`,`player_id`);
CREATE INDEX `account_viplist_player_id` ON `account_viplist` (`player_id`);

CREATE TABLE `accounts` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `name` TEXT NOT NULL,
  `password` TEXT NOT NULL,
  `secret` TEXT DEFAULT NULL,
  `type` INTEGER NOT NULL DEFAULT '1',
  `premdays` INTEGER NOT NULL DEFAULT '0',
  `lastday` INTEGER NOT NULL DEFAULT '0',
  `email` TEXT NOT NULL DEFAULT '',
  `creation` INTEGER NOT NULL DEFAULT '0'
);
CREATE UNIQUE INDEX `accounts_name` ON `accounts` (`name`);

CREATE TABLE `guild_invites` (
  `player_id` INTEGER NOT NULL DEFAULT '0',
  `guild_id` INTEGER NOT NULL DEFAULT '0',
  PRIMARY KEY (`player_id`,`guild_id`),
  FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE,
  FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE
);
CREATE INDEX `guild_invites_guild_id` ON `guild_invites` (`guild_id`);

CREATE TABLE `guild_membership` (
  `player_id` INTEGER NOT NULL,
  `guild_id` INTEGER NOT NULL,
  `rank_id` INTEGER NOT NULL,
  `nick` TEXT NOT NULL DEFAULT '',
  PRIMARY KEY (`player_id`),
  FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`rank_id`) REFERENCES `guild_ranks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX `guild_membership_guild_id` ON `guild_membership` (`guild_id`);
CREATE INDEX `guild_membership_rank_id` ON `guild_membership` (`rank_id`);

CREATE TABLE `guild_ranks` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `guild_id` INTEGER NOT NULL,
  `name` TEXT NOT NULL,
  `level` INTEGER NOT NULL,
  FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE
);
CREATE INDEX `guild_ranks_guild_id` ON `guild_ranks` (`guild_id`);

CREATE TABLE `guild_wars` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `guild1` INTEGER NOT NULL DEFAULT '0',
  `guild2` INTEGER NOT NULL DEFAULT '0',
  `name1` TEXT NOT NULL,
  `name2` TEXT NOT NULL,
  `status` INTEGER NOT NULL DEFAULT '0',
  `started` INTEGER NOT NULL DEFAULT '0',
  `ended` INTEGER NOT NULL DEFAULT '0'
);
CREATE INDEX `guild_wars_guild1` ON `guild_wars` (`guild1`);
CREATE INDEX `guild_wars_guild2` ON `guild_wars` (`guild2`);

CREATE TABLE `guilds` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `name` TEXT NOT NULL,
  `ownerid` INTEGER NOT NULL,
  `creationdata` INTEGER NOT NULL,
  `motd` TEXT NOT NULL DEFAULT '',
  FOREIGN KEY (`ownerid`) REFERENCES `players` (`id`) ON DELETE CASCADE
);
CREATE UNIQUE INDEX `guilds_name` ON `guilds` (`name`);
CREATE UNIQUE INDEX `guilds_ownerid` ON `guilds` (`ownerid`);

CREATE TABLE `guildwar_kills` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `killer` TEXT NOT NULL,
  `target` TEXT NOT NULL,
  `killerguild` INTEGER NOT NULL DEFAULT '0',
  `targetguild` INTEGER NOT NULL DEFAULT '0',
  `warid` INTEGER NOT NULL DEFAULT '0',
  `time` INTEGER NOT NULL,
  FOREIGN KEY (`warid`) REFERENCES `guild_wars` (`id`) ON DELETE CASCADE
);
CREATE INDEX `guildwar_kills_warid` ON `guildwar_kills` (`warid`);

CREATE TABLE `house_lists` (
  `house_id` INTEGER NOT NULL,
  `listid` INTEGER NOT NULL,
  `list` TEXT NOT NULL,
  FOREIGN KEY (`house_id`) REFERENCES `houses` (`id`) ON DELETE CASCADE
);
CREATE INDEX `house_lists_house_id` ON `house_lists` (`house_id`);

CREATE TABLE `houses` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `owner` INTEGER NOT NULL,
  `paid` INTEGER NOT NULL DEFAULT '0',
  `warnings` INTEGER NOT NULL DEFAULT '0',
  `name` TEXT NOT NULL,
  `rent` INTEGER NOT NULL DEFAULT '0',
  `town_id` INTEGER NOT NULL DEFAULT '0',
  `bid` INTEGER NOT NULL DEFAULT '0',
  `bid_end` INTEGER NOT NULL DEFAULT '0',
  `last_bid` INTEGER NOT NULL DEFAULT '0',
  `highest_bidder` INTEGER NOT NULL DEFAULT '0',
  `size` INTEGER NOT NULL DEFAULT '0',
  `beds` INTEGER NOT NULL DEFAULT '0'
);
CREATE INDEX `houses_owner` ON `houses` (`owner`);
CREATE INDEX `houses_town_id` ON `houses` (`town_id`);

CREATE TABLE `ip_bans` (
  `ip` INTEGER NOT NULL,
  `reason` TEXT NOT NULL,
  `banned_at` INTEGER NOT NULL,
  `expires_at` INTEGER NOT NULL,
  `banned_by` INTEGER NOT NULL,
  PRIMARY KEY (`ip`),
  FOREIGN KEY (`banned_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX `ip_bans_banned_by` ON `ip_bans` (`banned_by`);

CREATE TABLE `market_history` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `player_id` INTEGER NOT NULL,
  `sale` INTEGER NOT NULL DEFAULT '0',
  `itemtype` INTEGER NOT NULL,
  `amount` INTEGER NOT NULL,
  `price` INTEGER NOT NULL DEFAULT '0',
  `expires_at` INTEGER NOT NULL,
  `inserted` INTEGER NOT NULL,
  `state` INTEGER NOT NULL,
  FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
);
CREATE INDEX `market_history_player_id` ON `market_history` (`player_id`,`sale`);

CREATE TABLE `market_offers` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `player_id` INTEGER NOT NULL,
  `sale` INTEGER NOT NULL DEFAULT '0',
  `itemtype` INTEGER NOT NULL,
  `amount` INTEGER NOT NULL,
  `created` INTEGER NOT NULL,
  `anonymous` INTEGER NOT NULL DEFAULT '0',
  `price` INTEGER NOT NULL DEFAULT '0',
  FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
);
CREATE INDEX `market_offers_sale` ON `market_offers` (`sale`,`itemtype`);
CREATE INDEX `market_offers_created` ON `market_offers` (`created`);
CREATE INDEX `market_offers_player_id` ON `market_offers` (`player_id`);

CREATE TABLE `player_deaths` (
  `player_id` INTEGER NOT NULL,
  `time` INTEGER NOT NULL DEFAULT '0',
  `level` INTEGER NOT NULL DEFAULT '1',
  `killed_by` TEXT NOT NULL,
  `is_player` INTEGER NOT NULL DEFAULT '1',
  `mostdamage_by` TEXT NOT NULL,
  `mostdamage_is_player` INTEGER NOT NULL DEFAULT '0',
  `unjustified` INTEGER NOT NULL DEFAULT '0',
  `mostdamage_unjustified` INTEGER NOT NULL DEFAULT '0',
  FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
);
CREATE INDEX `player_deaths_player_id` ON `player_deaths` (`player_id`);
CREATE INDEX `player_deaths_killed_by` ON `player_deaths` (`killed_by`);
CREATE INDEX `player_deaths_mostdamage_by` ON `player_deaths` (`mostdamage_by`);

CREATE TABLE `player_depotitems` (
  `player_id` INTEGER NOT NULL,
  `sid` INTEGER NOT NULL,
  `pid` INTEGER NOT NULL DEFAULT '0',
  `itemtype` INTEGER NOT NULL,
  `count` INTEGER NOT NULL DEFAULT '0',
  `attributes` BLOB NOT NULL,
  FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
);
CREATE UNIQUE INDEX `player_depotitems_player_id_2` ON `player_depotitems` (`player_id`,`sid`);

CREATE TABLE `player_inboxitems` (
  `player_id` INTEGER NOT NULL,
  `sid` INTEGER NOT NULL,
  `pid` INTEGER NOT NULL DEFAULT '0',
  `itemtype` INTEGER NOT NULL,
  `count` INTEGER NOT NULL DEFAULT '0',
  `attributes` BLOB NOT NULL,
  FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
);
CREATE UNIQUE INDEX `player_inboxitems_player_id_2` ON `player_inboxitems` (`player_id`,`sid`);

CREATE TABLE `player_items` (
  `player_id` INTEGER NOT NULL DEFAULT '0',
  `pid` INTEGER NOT NULL DEFAULT '0',
  `sid` INTEGER NOT NULL DEFAULT '0',
  `itemtype` INTEGER NOT NULL DEFAULT '0',
  `count` INTEGER NOT NULL DEFAULT '0',
  `attributes` BLOB NOT NULL,
  FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
);
CREATE INDEX `player_items_player_id` ON `player_items` (`player_id`);
CREATE INDEX `player_items_sid` ON `player_items` (`sid`);

CREATE TABLE `player_namelocks` (
  `player_id` INTEGER NOT NULL,
  `reason` TEXT NOT NULL,
  `namelocked_at` INTEGER NOT NULL,
  `namelocked_by` INTEGER NOT NULL,
  PRIMARY KEY (`player_id`),
  FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`namelocked_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX `player_namelocks_namelocked_by` ON `player_namelocks` (`namelocked_by`);

CREATE TABLE `player_spells` (
  `player_id` INTEGER NOT NULL,
  `name` TEXT NOT NULL,
  FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
);
CREATE INDEX `player_spells_player_id` ON `player_spells` (`player_id`);

CREATE TABLE `player_storage` (
  `player_id` INTEGER NOT NULL DEFAULT '0',
  `key` INTEGER NOT NULL DEFAULT '0',
  `value` INTEGER NOT NULL DEFAULT '0',
  PRIMARY KEY (`player_id`,`key`),
  FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
);

CREATE TABLE `players` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `name` TEXT NOT NULL,
  `group_id` INTEGER NOT NULL DEFAULT '1',
  `account_id` INTEGER NOT NULL DEFAULT '0',
  `level` INTEGER NOT NULL DEFAULT '1',
  `vocation` INTEGER NOT NULL DEFAULT '0',
  `health` INTEGER NOT NULL DEFAULT '150',
  `healthmax` INTEGER NOT NULL DEFAULT '150',
  `experience` INTEGER NOT NULL DEFAULT '0',
  `lookbody` INTEGER NOT NULL DEFAULT '0',
  `lookfeet` INTEGER NOT NULL DEFAULT '0',
  `lookhead` INTEGER NOT NULL DEFAULT '0',
  `looklegs` INTEGER NOT NULL DEFAULT '0',
  `looktype` INTEGER NOT NULL DEFAULT '136',
  `lookaddons` INTEGER NOT NULL DEFAULT '0',
  `maglevel` INTEGER NOT NULL DEFAULT '0',
  `mana` INTEGER NOT NULL DEFAULT '0',
  `manamax` INTEGER NOT NULL DEFAULT '0',
  `manaspent` INTEGER NOT NULL DEFAULT '0',
  `soul` INTEGER NOT NULL DEFAULT '0',
  `town_id` INTEGER NOT NULL DEFAULT '0',
  `posx` INTEGER NOT NULL DEFAULT '0',
  `posy` INTEGER NOT NULL DEFAULT '0',
  `posz` INTEGER NOT NULL DEFAULT '0',
  `conditions` BLOB NOT NULL,
  `cap` INTEGER NOT NULL DEFAULT '0',
  `sex` INTEGER NOT NULL DEFAULT '0',
  `lastlogin` INTEGER NOT NULL DEFAULT '0',
  `lastip` INTEGER NOT NULL DEFAULT '0',
  `save` INTEGER NOT NULL DEFAULT '1',
  `skull` INTEGER NOT NULL DEFAULT '0',
  `skulltime` INTEGER NOT NULL DEFAULT '0',
  `lastlogout` INTEGER NOT NULL DEFAULT '0',
  `blessings` INTEGER NOT NULL DEFAULT '0',
  `onlinetime` INTEGER NOT NULL DEFAULT '0',
  `deletion` INTEGER NOT NULL DEFAULT '0',
  `balance` INTEGER NOT NULL DEFAULT '0',
  `offlinetraining_time` INTEGER NOT NULL DEFAULT '43200',
  `offlinetraining_skill` INTEGER NOT NULL DEFAULT '-1',
  `stamina` INTEGER NOT NULL DEFAULT '2520',
  `skill_fist` INTEGER NOT NULL DEFAULT '10',
  `skill_fist_tries` INTEGER NOT NULL DEFAULT '0',
  `skill_club` INTEGER NOT NULL DEFAULT '10',
  `skill_club_tries` INTEGER NOT NULL DEFAULT '0',
  `skill_sword` INTEGER NOT NULL DEFAULT '10',
  `skill_sword_tries` INTEGER NOT NULL DEFAULT '0',
  `skill_axe` INTEGER NOT NULL DEFAULT '10',
  `skill_axe_tries` INTEGER NOT NULL DEFAULT '0',
  `skill_dist` INTEGER NOT NULL DEFAULT '10',
  `skill_dist_tries` INTEGER NOT NULL DEFAULT '0',
  `skill_shielding` INTEGER NOT NULL DEFAULT '10',
  `skill_shielding_tries` INTEGER NOT NULL DEFAULT '0',
  `skill_fishing` INTEGER NOT NULL DEFAULT '10',
  `skill_fishing_tries` INTEGER NOT NULL DEFAULT '0',
  FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE
);
CREATE UNIQUE INDEX `players_name` ON `players` (`name`);
CREATE INDEX `players_account_id` ON `players` (`account_id`);
CREATE INDEX `players_vocation` ON `players` (`vocation`);

CREATE TABLE `players_online` (
  `player_id` INTEGER NOT NULL,
  PRIMARY KEY (`player_id`)
);

CREATE TABLE `server_config` (
  `config` TEXT NOT NULL,
  `value` TEXT NOT NULL DEFAULT '',
  PRIMARY KEY (`config`)
);

CREATE TABLE `tile_store` (
  `house_id` INTEGER NOT NULL,
  `data` BLOB NOT NULL,
  FOREIGN KEY (`house_id`) REFERENCES `houses` (`id`) ON DELETE CASCADE
);
CREATE INDEX `tile_store_house_id` ON `tile_store` (`house_id`);

DELETE FROM `server_config`;
INSERT INTO `server_config` (`config`,`value`) VALUES ('db_version','19'),('motd_hash',''),('motd_num','1'),('players_record','0');

COMMIT;
PRAGMA foreign_keys = ON;
