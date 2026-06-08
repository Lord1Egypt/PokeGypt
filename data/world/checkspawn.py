import re

f = open("map-spawn.xml", "r")
g = open("map-spawn_editado.xml", "w")
lines = f.readlines()
for line in lines:
	words = line.split()
	for word in words:
		if not word.find('spawntime=') == -1:
			newword = re.sub('"','',word)
			newword = re.sub('spawntime=','',newword)
			if int(newword) > 180:
				line = line.replace(word,'spawntime="180"')
			elif int(newword) < 60:
				line = line.replace(word,'spawntime="60"')
	g.write(line)

