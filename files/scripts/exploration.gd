
extends Node

var progress = 0.0
var enemygroup
var defeated = {}
var currentzone
var awareness = 0
var ambush = false
var scout
var launchonwin = null
var combatdata = load("res://files/scripts/combatdata.gd").new()

var enemygrouppools = combatdata.enemygrouppools
var capturespool = combatdata.capturespool
var enemypool = combatdata.enemypool


var zones = {

forest = {
background = 'crossroads',
reqs = "true",
combat = true,
code = 'forest',
name = 'Ancient Forest',
description = "You stand deep within this ancient forest. Giant trees tower above you, reaching into the skies and casting deep shadows on the ground below. As the wind whispers past, you can hear the movement of small creature in the undergrowth and birds singing from their perches above.",
enemies = [['thugseasy',10],['banditseasy', 20], ['peasant', 25],['solobear', 40], ['wolveseasy', 100]],
encounters = [['chloeforest','globals.state.sidequests.chloe in [0,1]',10]],
length = 5,
exits = ['shaliq', 'wimbornoutskirts'],
tags = [],
races = [['Elf', 20], ['Beastkin Wolf',25],['Halfkin Bunny',30],['Beastkin Bunny',35],['Halfkin Wolf',40],['Human', 100]]
},

elvenforest = {
background = 'forest',
reqs = "true",
combat = true,
code = 'elvenforest',
name = 'Deep Elven Grove',
description = "This portion of the forest is located dangerously close to eleven lands. They take poorly to intruders in their part of the woods so you should remain on your guard.",
enemies = [['fairy',3],['thugseasy',10],['solobear', 15], ['peasantgroup', 20], ['peasant', 25],['elfguards',35],['banditseasy', 50],['plantseasy',65],['wolveseasy', 100]],
encounters = [],
length = 5,
exits = ['wimbornoutskirts','amberguard'],
tags = [],
races = [['Dark Elf', 20],['Drow', 25],['Elf', 100]]
},


amberguardforest = {
background = 'amberroad',
reqs = "true",
combat = true,
code = 'amberguardforest',
name = 'Amber Road',
description = "Amber Road is a long way through seeming glade and various small settlements and hills. ",
enemies = [['solobear', 15], ['wolveshard', 65], ['direwolveseasy', 100]],
encounters = [['aynerisencounter','globals.state.sidequests.ayneris in [0,1,2]',15]],
length = 4,
exits = ['amberguard','witchhut','undercityentrance'],
tags = [],
races = [["Elf", 100]]
},

witchhut = {
background = 'amberroad',
reqs = 'globals.state.mainquest >= 21',
combat = false,
code = 'witchhut',
name = 'Lone Hut',
description = "You come across a lone wooden hut hidden in the thicket. ",
enemies = [],
encounters = [],
length = 1,
exits = ['witchhut'],
tags = [],
races = []
},

undercityentrance = {
background = 'mountains',
reqs = 'globals.state.mainquest >= 18',
combat = false,
code = 'undercityentrance',
name = "Cliff Entrance",
description = "The entrance to the old tunnels is tucked away in a maze of cliff walls. If not for numerous marks and signs, you would have had a hard time figuring out where the correct passage is. A large boulder blocks the entrance way and has been sealed in place with magic. The ritual used to seal the tunnel is beyond your ability to break and without a large team of miners to try break a way in around through the extremely hard rock, you’ll need to search for another way in.",
enemies = [],
encounters = [],
length = 1,
exits = ['undercityentrance'],
tags = [],
races = []
},

undercitytunnels = {
background = 'tunnels',
reqs = 'globals.state.mainquest >= 18',
combat = true,
code = 'undercitytunnels',
name = "Underground Tunnels",
description = "The dark tunnels twist back and forth as they wind their way into the mountainside. Your light from your torches cast shadows around every corner. You cautiously move forward brushing spiderwebs and other hanging obstructions side. Passages repeatedly intersect some ending in short dead ends others going deeper.",
enemies = [['solospider', 35], ['oozesgroup', 50], ['troglodytesmall', 75], ['mutant', 100]],
encounters = [],
length = 8,
exits = ['undercityentrance', 'undercityruins'],
tags = ['noreturn'],
races = [],
},
undercityruins = {
background = 'undercity',
reqs = 'true',
combat = true,
code = 'undercityruins',
name = "Underground Ruins",
description = "Dilapidated ruined buildings line long winding pathways that were once streets. Their age is hard to estimate, they could be 50 years they could be 500 years old. The air is damp and oppressive, there is little to no sound except for each of your steps which seem to echo on forever. ",
enemies = [['spidergroup',25],['gembeetle', 30], ['troglodytelarge', 50], ['troglodytesmall', 75], ['mutant', 100]],
encounters = [],
length = 8,
exits = ['undercitytunnels','undercityhall'],
tags = ['noreturn'],
races = [],
},
undercityhall = {
background = 'undercity',
reqs = 'true',
combat = false,
code = 'undercityhall',
name = "Underground Hall",
description = "You approach a huge, mostly intact building. Its' state seems to be the result of magically enhanced walls, traces of which you can still feel. Searching this building may offer the most potential of all the buildings in the area due to it being mostly intact. Of course it also may provide shelter to the inhabitants of the ruins.",
enemies = [],
encounters = [],
length = 1,
exits = ['undercityhall'],
tags = ['noreturn'],
races = []
},
grove = {
background = 'grove',
reqs = "true",
combat = true,
code = 'grove',
name = 'Far Eerie Woods',
description = "This portion of the forest is deeply shadowed, and strange sounds drift in and out of hearing. Something about the atmosphere keeps the normal forest creatures silent, lending an eerie, mystic feeling to the grove you stand within.",
enemies = [['dryad',10], ['solobear', 15], ['fairy', 30],['wolveshard', 45],['plantseasy',80], ['wolveseasy', 100]],
encounters = [['chloegrove','globals.state.sidequests.chloe == 6',25],['snailevent','globals.state.mansionupgrades.farmhatchery >= 1 && globals.state.snails < 10',10]],
length = 7,
exits = ['wimbornoutskirts'],
tags = [],
races = [['Fairy', 60],["Dryad", 100]]
},

marsh = {
background = 'marsh',
reqs = "true",
combat = true,
code = 'marsh',
name = 'Marsh',
description = "Dank bog lies at the border of the forest and swamps beyond. Noxious smells and a sinister aura prevail throughout. The landscape itself is hostile, with pitch-black pools of water mixed among the solid ground and you doubt that the creatures that live here are any more pleasant than the land they live in.",
enemies = [['banditcamp',10],['monstergirl',20], ['oozesgroup',35], ['solospider',85], ['solobear', 100]],
encounters = [],
length = 6,
exits = ['frostfordoutskirts'],
tags = [],
races = [['Arachna', 15],['Lamia', 40],['Slime', 55],['Demon', 100]]
},

mountains = {
background = 'mountains',
reqs = "true",
combat = true,
code = 'mountains',
name = 'Mountains',
description = "You climb over small hills in search for any activity in these elevated grounds.",
enemies = [['slaversmedium',5],['harpy',15],['banditsmedium', 20],['travelersgroup', 35],['fewcougars',100]],
encounters = [],
length = 6,
exits = ['gornoutskirts'],
tags = [],
races = [['Dragonkin',3],['Seraph',8],['Gnome', 20],['Centaur',30],['Goblin', 70],['Orc',100]]
},

sea = {
background = 'sea',
reqs = "true",
combat = true,
code = 'sea',
name = 'Sea',
description = "You are at the beach of a Big Sea. Air smells of salt and you can spot some sea caves formed by plateau and incoming waves.",
enemies = [['banditcamp',10],['monstergirl', 35],['travelersgroup',50],['oozesgroup',100]],
encounters = [],
length = 5,
exits = ['gornoutskirts'],
tags = [],
races = [['Scylla', 40],['Lamia', 70],['Nereid', 100]]
},

shaliq = {
background = 'shaliq',
reqs = "true",
combat = false,
code = 'shaliq',
name = 'Shaliq Village',
description = "This small, rural village looks calm and peaceful. It seems many personal portals lead here and travelers are not rare sight for locals, as you barely get any attention.",
enemies = [],
encounters = [],
length = 0,
exits = ['shaliq'],
tags = [],
},

wimbornoutskirts = {
background = 'meadows',
reqs = "true",
combat = false,
code = 'wimbornoutskirts',
name = 'Wimborn Outskirts',
description = "You walk out of Wimborn and get far away from its walls until road brings you to the intersection. From here you may choose what area you would like to scout. ",
enemies = [],
encounters = [],
length = 0,
exits = ['wimbornoutskirts'],
tags = [],
},

wimbornoutskirtsexplore = {
background = 'meadows',
reqs = "true",
combat = true,
code = 'wimbornoutskirtsexplore',
name = 'Wimborn Outskirts',
description = "The town's outskirts look spacy and green. ",
enemies = [['banditsmedium',10],['slaverseasy',15],['peasant',20],['banditseasy',50],['thugseasy',65],['wolveseasy',100]],
encounters = [],
length = 5,
exits = ['wimbornoutskirts'],
tags = [],
races = [['Beastkin Cat', 5], ['Halfkin Cat', 10],['Beastkin Tanuki', 12], ['Halfkin Tanuki', 15],['Elf', 19],['Taurus',30],['Human', 100]]
},
wimborn = {
background = 'wimborn',
reqs = "true",
combat = false,
code = 'wimborn',
name = 'Wimborn',
description = "Though the weather is commonly hot, the streets are rich with many kinds of races. Orcs and goblins are the most prevalent citizens, and small traders can be seen virtually everywhere, however, you can still frequently notice some humans, gnomes and even centaurs among the bystanders. Rare Orc Guard Patrols keep their eyes out for any potential troublemakers. ",
enemies = [],
encounters = [],
length = 0,
exits = ['wimborn'],
tags = [],
},
gorn = {
background = 'gorn',
reqs = "true",
combat = false,
code = 'gorn',
name = 'Gorn',
description = "Though the weather is commonly hot, the streets are rich with many kinds of races. Orcs and goblins are the most prevalent citizens, and small traders can be seen virtually everywhere, however, you can still frequently notice some humans, gnomes and even centaurs among the bystanders. Rare Orc Guard Patrols keep their eyes out for any potential troublemakers. ",
enemies = [],
encounters = [],
length = 0,
exits = ['gorn'],
tags = [],
},

gornalchemist = {
background = 'gorn',
reqs = "true",
combat = false,
code = 'gornalchemist',
name = 'Alchemical Shop',
description = "",
enemies = [],
encounters = [],
length = 0,
exits = ['gornalchemist'],
tags = [],
},

gornoutskirts = {
background = 'highlands',
reqs = "true",
combat = false,
code = 'gornoutskirts',
name = 'Gorn Outskirts',
description = "You walk out of Gorn and get far away from its walls until road brings you to the intersection. These arid areas lead to moutains and cave systems. You can feel sun getting hotter over your head.",
enemies = [],
encounters = [],
length = 0,
exits = ['gornoutskirts'],
tags = [],
},

gornoutskirtsexplore = {
background = 'highlands',
reqs = "true",
combat = true,
code = 'gornoutskirtsexplore',
name = 'Gorn Outskirts',
description = "The town's outskirts look bright and green. ",
enemies = [['slaverseasy',10],['peasant',20],['banditseasy',60],['thugseasy',75],['wolveseasy', 100]],
encounters = [],
length = 5,
exits = ['gornoutskirts'],
tags = [],
races = [['Centaur',5],['Dark Elf', 15],['Goblin', 40],['Orc', 100]]
},

frostfordoutskirts = {
background = 'borealforest',
reqs = "true",
combat = false,
code = 'frostfordoutskirts',
name = 'Frostford Outskirts',
description = "Main road quickly branches off at thick boreal forest. Even though Frostford is considerably dense in population, its periphery is far less inhabitable due to harsh climat. ",
enemies = [],
encounters = [],
length = 0,
exits = ['frostfordoutskirts']
},

frostfordoutskirtsexplore = {
background = 'borealforest',
reqs = "true",
combat = true,
code = 'frostfordoutskirtsexplore',
name = 'Frostford Outskirts',
description = "You make your way through semi-utilized forest paths paying attention to the surroundings. ",
enemies = [['banditsmedium',10],['travelersgroup',25],['peasant',60],['thugseasy',75],['solobear', 100]],
encounters = [],
length = 5,
exits = ['frostfordoutskirts','frostfordclearing'],
tags = [],
races = [['Beastkin Wolf', 40],['Halfkin Fox', 45],['Beastkin Fox', 50],['Halfkin Cat', 55],['Beastkin Cat',65],['Halfkin Wolf', 75],['Beastkin Wolf', 85],['Human', 100]]
},

frostfordclearing = {
background = 'borealforest',
reqs = "globals.state.mainquest in [28,28.1,30, 32]",
combat = false,
code = 'frostfordclearing',
name = 'Clearing',
description =  "",
enemies = [],
encounters = [],
length = 0,
exits = ['frostfordclearing'],
tags = [],
},

frostford = {
background = 'frostford',
reqs = "true",
combat = false,
code = 'frostford',
name = 'Frostford',
description =  "Despite this region being frequently covered in snow, it's not terribly cold here; it’s even warmer on the streets, perhaps thankfully to the density of the population.\n\n The roads are lively, with many beastkins and halfkins of different kinds strolling and talking to one another - despite the activity, the whole town has a very relaxed and calm atmosphere. ",
enemies = [],
encounters = [],
length = 0,
exits = ['frostford'],
tags = [],
},
amberguard = {
background = 'amberguard',
reqs = "globals.state.mainquest >= 17",
combat = false,
code = 'amberguard',
name = 'Amberguard',
description = "The journey to Amberguard is rather uneventful. A large wall surrounds the town with a fortified gate controlling entrance into the inner city. Passing through the gates you are coldly greeted with hostile stares, reminding you while you may be permitted to enter the city you are not welcome here, and help may be difficult to find. \n\nYou make your way through the town. Large marble buildings of elvish design line the streets and provide shelter to the local residents. Despite their lavish architecture they look dilapidated and unkempt. Sections of the city seem almost deserted. While the streets are far from crowded by  the elves that live here, you are often rudely jostled and bumped. Other elves simply glare at you or cautiously give you lots of space.\n\nThe unwelcoming attitude explains why so few outsiders especially those of other races are to be found within the city.",
enemies = [],
encounters = [],
length = 1,
exits = ['amberguard'],
tags = [],
races = [],
},

}

var buttoncontainer
var button
var newbutton
var main
var outside

func mansionreturn():
	main._on_mansion_pressed()

func event(eventname):
	globals.events.call(eventname)

func zoneenter(zone):
	zone = self.zones[zone]
	main.background_set(zone.background)
	if OS.get_name() != "HTML5" && globals.rules.fadinganimation == true:
		yield(main, "animfinished")
	if globals.state.playergroup.size() > 0:
		for i in globals.state.playergroup:
			var scouttemp = globals.state.findslave(i)
			var scoutawareness = 0
			if scouttemp == null:
				globals.state.playergroup.erase(i)
			else:
				if scouttemp.awareness() > scoutawareness:
					scout = scouttemp
					scoutawareness = scout.awareness()
	else:
		scout = globals.player
	main.checkplayergroup()
	outside.playergrouppanel()
	outside.get_node('exploreprogress/locationname').set_text(zone.name)
	globals.get_tree().get_current_scene().get_node("outside/exploreprogress").set_val((progress/max(zone.length,1))*100)
	currentzone = zone
	outside.clearbuttons()
	outside.maintext.set_bbcode('[center]'+ zone.name + '[/center]\n\n' + zone.description)
	if zone.combat == false:
		call(zone.exits[0])
		return
	else:
		main.music_set('explore')
	var array = []
	if zone.combat == true && progress >= zone.length:
		for i in zone.exits:
			var temp = self.zones[i]
			if globals.evaluate(temp.reqs) == true:
				array.append({name = 'Move to ' + temp.name, function = 'zoneenter', args = temp.code})
		progress = 0
		array.insert(0,{name = 'Explore this area again', function = 'zoneenter', args = currentzone.code})
		outside.buildbuttons(array, self)
	else:
		array.append({name = "Proceed through area", function = 'enemyencounter'})
		if globals.developmode == true:
			array.append({name = "Skip", function = 'areaskip'})
	if globals.state.sidequests.cali == 19 && zone.code == 'forest':
		array.append({name = "Look for bandits' camp", function = 'event',args = 'calibanditcamp'})
	elif (globals.state.sidequests.cali == 23 || globals.state.sidequests.cali == 24) && zone.code == 'wimbornoutskirtsexplore':
		array.append({name = "Visit slaver's camp", function = 'event',args = 'calislavercamp'})
	elif (globals.state.sidequests.cali == 25) && zone.code == 'wimbornoutskirtsexplore':
		array.append({name = "Find the Bandit",function = 'event',args = 'calistraybandit'})
	elif (globals.state.sidequests.cali == 26) && zone.code == 'grove':
		array.append({name = "Find Cali's village",function = 'event',args = 'calireturnhome'})
	if globals.state.mainquest == 13 && zone.code == 'gornoutskirtsexplore':
		array.append({name = "Search for Ivran's location",function = 'event',args = 'gornivran'})
	if zone.code == 'undercitytunnels' && progress >= 6 && globals.state.lorefound.find('amberguardlog1') < 0:
		globals.state.lorefound.append('amberguardlog1')
		outside.maintext.set_bbcode(outside.maintext.get_bbcode() + "[color=yellow]\n\nYou've found some old writings in the ruins. Does not look like what you came for, but you can read them later.[/color]")
	if zone.code == 'undercityruins' && progress >= 5 && globals.state.lorefound.find('amberguardlog2') < 0:
		globals.state.lorefound.append('amberguardlog2')
		outside.maintext.set_bbcode(outside.maintext.get_bbcode() + "[color=yellow]\n\nYou've found some old writings in the ruins. Does not look like what you came for, but you can read them later.[/color]")
	if zone.code == 'frostfordoutskirtsexplore' && globals.state.mainquest in [27,30,32] && progress >= 5:
		array.append({name = "Explore hunting grounds to South-East", function = 'event', args = 'frostforddryad'})
	if zone.code == 'frostfordoutskirtsexplore' && globals.state.sidequests.zoe == 1 && progress >= 3:
		globals.state.sidequests.zoe = 2
		main.dialogue(true, self, globals.questtext.MainQuestFrostfordBeforeForestZoe, [], null)
	var hasinjuries = false
	for i in globals.state.playergroup:
		var slave = globals.state.findslave(i)
		if slave.health < slave.stats.health_max:
			hasinjuries = true
			continue
	if globals.spelldict.heal.learned == true && (globals.player.health < globals.player.stats.health_max || hasinjuries == true) :
		var tempdict = {name = "Use Heal to restore everyone's health", function = 'healeveryone', args = null}
		if globals.resources.mana < 10:
			tempdict.disabled = true
			tempdict.tooltip = 'not enough mana'
		array.append(tempdict)
	if globals.spelldict.invigorate.learned == true && globals.state.playergroup.size() >= 1:
		var tempdict = {name = "Cast Invigorate", function = 'castinvig', args = null}
		if globals.resources.mana < 5:
			tempdict.disabled = true
			tempdict.tooltip = 'not enough mana'
		array.append(tempdict)
	if zone.tags.find('noreturn') < 0 || progress == 0:
		array.append({name = "Return to Mansion", function = "mansionreturn"})
	outside.buildbuttons(array, self)

func frostfordclearing():
	event('frostforddryad')

func healeveryone(args = null):
	var slave
	var manaused = 0
	if globals.player.health < globals.player.stats.health_max:
		globals.player.stats.health_cur = globals.player.stats.health_max
		manaused += 10
	for i in globals.state.playergroup:
		slave = globals.state.findslave(i)
		if slave.stats.health_cur < slave.stats.health_max:
			slave.stats.health_cur = slave.stats.health_max
			manaused += 5
	manaused = min(manaused, globals.resources.mana)
	globals.resources.mana -= manaused
	if manaused > 0:
		main.popup("You've patched up everyone by using " + str(manaused) +  " mana. ")
	else:
		main.popup("Nobody has injuries in your party. ")
	outside.playergrouppanel()

func castinvig(args = null):
	main.selectslavelist(false, 'castinvigtarget', self, 'true', false, true)

func castinvigtarget(slave):
	get_tree().get_current_scene().get_node('spellnode').slave = slave
	get_tree().get_current_scene().get_node('spellnode').invigorateeffect()
	zoneenter(currentzone.code)

func areaskip():
	progress = currentzone.length
	zoneenter(currentzone.code)
	

func enemyencounter():
	var enc
	var encmoveto
	var scouttemp
	var scoutawareness = -1
	outside.clearbuttons()
	if globals.state.playergroup.size() > 0:
		for i in globals.state.playergroup:
			scouttemp = globals.state.findslave(i)
			if scouttemp.awareness() > scoutawareness:
				scout = scouttemp
				scoutawareness = scout.awareness()
	else:
		scout = globals.player
		scoutawareness = scout.awareness()
	if currentzone.encounters.size() > 0:
		for i in currentzone.encounters:
			enc = i[0]
			var condition = i[1]
			var chance = i[2]
			if globals.evaluate(condition) == true && rand_range(0,100) < chance:
				encmoveto = enc
				break
	if encmoveto != null:
		call(enc)
		return
	else:
		buildenemies()
		var counter = 0
		for i in enemygroup.units:
			if i.capture == true:
				var race = ''
				var sex = ''
				var age = ''
				var origins = ''
				var rand = 0
				if i.capturerace.find('area') >= 0:
					rand = rand_range(0,100)
					for ii in currentzone.races:
						if rand < ii[1]:
							race = ii[0]
							break
				elif i.capturerace.find('any') >= 0:
					race = globals.allracesarray[rand_range(0,globals.allracesarray.size())]
				elif i.capturerace.find('bandits') >= 0:
					if rand_range(0,10) <= 7:
						race = 'Human'
					else:
						race = globals.banditraces[rand_range(0,globals.banditraces.size())]
				else:
					rand = rand_range(0,100)
					for ii in i.capturerace:
						if rand < ii[1]:
							race = ii[0]
							break
				if i.capturesex.find('any') >= 0:
					sex = 'random'
				else:
					rand = rand_range(0,100)
					for ii in i.capturesex:
						if rand < ii[1]:
							sex = ii[0]
							break
				rand = rand_range(0,100)
				for ii in i.captureagepool:
					if rand < ii[1]:
						age = ii[0]
						break
				rand = rand_range(0,100)
				for ii in i.captureoriginspool:
					if rand < ii[1]:
						origins = ii[0]
						break
				var slavetemp = globals.slavegen.newslave(race, age, sex, origins)
				var location
				if !i.faction in ['bandit','monster']:
					if currentzone.exits.find("wimbornoutskirts") >= 0:
						location = 'wimborn'
					elif currentzone.exits.find("frostfordoutskirts") >= 0:
						location = 'frostford'
					elif currentzone.exits.find("gornoutskirts") >= 0:
						location = 'gorn'
				enemygroup.units[counter].capture = slavetemp
			counter += 1
		if enemygroup.captured != null:
			var group = enemygroup.captured
			enemygroup.captured = []
			for i in group:
				var slave = capturespool[i]
				var race = ''
				var sex = ''
				var age = ''
				var origins = ''
				var rand = 0
				if slave.race.find('area') >= 0:
					rand = rand_range(0,100)
					for i in currentzone.races:
						if rand < i[1]:
							race = i[0]
							break
				elif slave.race.find('any') >= 0:
					race = globals.allracesarray[rand_range(0,globals.allracesarray.size())]
				elif slave.race.find('bandits') >= 0:
					race = globals.banditraces[rand_range(0,globals.banditraces.size())]
				else:
					rand = rand_range(0,100)
					for i in slave.race:
						if rand < i[1]:
							race = i[0]
							break
				if slave.sex.find('any') >= 0:
					sex = 'random'
				else:
					rand = rand_range(0,100)
					for i in slave.sex:
						if rand < i[1]:
							sex = i[0]
							break
				rand = rand_range(0,100)
				for ii in slave.agepool:
					if rand < ii[1]:
						age = ii[0]
						break
				rand = rand_range(0,100)
				for ii in slave.originspool:
					if rand < ii[1]:
						origins = ii[0]
						break
				slave = globals.slavegen.newslave(race, age, sex, origins)
				if !capturespool[i].faction in ['bandit','monster']:
					var location
					if currentzone.exits.find("wimbornoutskirts") >= 0:
						location = 'wimborn'
					elif currentzone.exits.find("frostfordoutskirts") >= 0:
						location = 'frostford'
					elif currentzone.exits.find("gornoutskirts") >= 0:
						location = 'gorn'
				enemygroup.captured.append(slave)
	if scoutawareness < enemygroup.awareness:
		ambush = true
		var text = encounterdictionary(enemygroup.descriptionambush)
		outside.maintext.set_bbcode(text)
		if enemygroup.special == null:
			encounterbuttons()
		else:
			call(enemygroup.specialambush)
	else:
		ambush = false
		var text = encounterdictionary(enemygroup.description)
		outside.maintext.set_bbcode(text)
		if enemygroup.special == null:
			encounterbuttons()
		else:
			call(enemygroup.special)


func buildenemies(enemyname = null):
	if enemyname == null:
		var rand = max(rand_range(0,100)-scout.sagi*3,0) 
		for i in currentzone.enemies:
			if rand < i[1]:
				enemygroup = str2var(var2str(enemygrouppools[i[0]]))
				break
	else:
		enemygroup = str2var(var2str(enemygrouppools[enemyname]))
	var tempunits = str2var(var2str(enemygroup.units))
	enemygroup.units = []
	for i in tempunits:
		var count = round(rand_range(i[1], i[2]))
		while count >= 1:
			enemygroup.units.append(str2var(var2str(enemypool[i[0]])))
			count -= 1


func encounterbuttons():
	var array = []
	if ambush == false:
		array.append({name = "Attack",function = "enemyfight"})
		array.append({name = "Leave", function = "enemyleave"})
	else:
		array.append({name = "Fight",function = "enemyfight"})
		if currentzone.tags.find('noreturn') < 0:
			array.append({name = "Escape", function = "mansionreturn"})
	outside.buildbuttons(array, self)

func slavers():
	globals.get_tree().get_current_scene().get_node('outside').clearbuttons()
	newbutton = button.duplicate()
	outside.maintext.set_bbcode(encounterdictionary(enemygroup.description))
	buttoncontainer.add_child(newbutton)
	newbutton.set_text('Greet them')
	newbutton.set_hidden(false)
	newbutton.connect("pressed",self,'slaversgreet')
	newbutton = button.duplicate()
	buttoncontainer.add_child(newbutton)
	newbutton.set_text('Attack them')
	newbutton.set_hidden(false)
	newbutton.connect("pressed",self,'enemyfight')
	newbutton = button.duplicate()
	buttoncontainer.add_child(newbutton)
	newbutton.set_text('Ignore them')
	newbutton.set_hidden(false)
	newbutton.connect("pressed",self,'enemyleave')

func banditcamp():
	globals.get_tree().get_current_scene().get_node('outside').clearbuttons()
	newbutton = button.duplicate()
	buttoncontainer.add_child(newbutton)
	newbutton.set_text('Attack them')
	newbutton.set_hidden(false)
	newbutton.connect("pressed",self,'enemyfight')
	newbutton = button.duplicate()
	buttoncontainer.add_child(newbutton)
	newbutton.set_text('Ignore them')
	newbutton.set_hidden(false)
	newbutton.connect("pressed",self,'enemyleave')

func slaversgreet():
	globals.get_tree().get_current_scene().get_node('outside').clearbuttons()
	globals.get_tree().get_current_scene().get_node('outside').maintext.set_bbcode(globals.player.dictionary("You reveal yourself to the slavers' group and wondering if they'd be willing to part with their merchandise saving them hassle of transportation.\n\n- You, $sir, know how to bargain. We'll agree to part with our treasure here for ")+str(max(round(enemygroup.captured.calculateprice()*0.3),40))+" gold.\n\nYou still might try to take their hostage by force, but given they know about your presence, you are at considerable disadvantage. ")
	newbutton = button.duplicate()
	buttoncontainer.add_child(newbutton)
	newbutton.set_text('Inspect')
	newbutton.set_hidden(false)
	newbutton.connect("pressed",self,'inspectenemy')
	newbutton = button.duplicate()
	buttoncontainer.add_child(newbutton)
	newbutton.set_text('Agree on the deal')
	newbutton.set_hidden(false)
	newbutton.connect("pressed",self,'slaverbuy')
	if globals.resources.gold < max((round(enemygroup.captured.calculateprice()*0.3)),40):
		newbutton.set_disabled(true)
		newbutton.set_tooltip("You don't have enough gold.")
	if globals.spelldict.mindread.learned == true:
		newbutton = button.duplicate()
		buttoncontainer.add_child(newbutton)
		newbutton.set_text('Cast Mindread to check personality')
		newbutton.set_hidden(false)
		newbutton.connect("pressed",self,'mindreadcapturee', ['slavers'])
		if globals.spelldict.mindread.manacost > globals.resources.mana:
			newbutton.set_disabled(true)
	newbutton = button.duplicate()
	buttoncontainer.add_child(newbutton)
	newbutton.set_text('Fight')
	newbutton.set_hidden(false)
	newbutton.connect("pressed",self,'enemyfight')
	newbutton = button.duplicate()
	buttoncontainer.add_child(newbutton)
	newbutton.set_text('Refuse and leave')
	newbutton.set_hidden(false)
	newbutton.connect("pressed",self,'enemyleave')

func snailevent():
	var array = []
	outside.maintext.set_bbcode("You come across a humongous snail making its way through the trees. It makes you remember hearing how you could use it for farming additional income but you will likely need to sacrifice some food to tame it first. ")
	if globals.resources.food >= 200:
		array.append({name = 'Feed Snail (200 food)', function = 'snailget'})
	else:
		array.append({name = 'Feed Snail (200 food)', function = 'snailget', disabled = true, tooltip = "not enough food"})
	array.append({name = "Ignore it", function = "zoneenter", args = 'grove'})
	outside.buildbuttons(array,self)

func snailget():
	globals.resources.food -= 200
	globals.state.snails += 1
	main.popup("You've brought a giant snail back with you and left it at your farm. ")
	main._on_mansion_pressed()

func slaverbuy():
	globals.resources.gold -= max(round(enemygroup.captured.calculateprice()*0.3),30)
	enemycapture()
	globals.get_tree().get_current_scene().popup("You purchase slavers' captive and return to mansion. " )

func inspectenemy():
	globals.get_tree().get_current_scene().popup(enemygroup.captured.description_small())

func mindreadcapturee(state = 'encounter'):
	globals.get_tree().get_current_scene().get_node("spellnode").slave = enemygroup.captured
	globals.get_tree().get_current_scene().get_node("spellnode").mindreadeffect()
	if state == 'win':
		enemydefeated()
	elif state == 'slavers':
		slaversgreet()
	else:
		encounterbuttons()

func mindreadenemy():
	var spell = globals.spelldict.mindread
	var text = ''
	globals.resources.mana -= spell.manacost
	globals.get_tree().get_current_scene().popup(str(enemygroup.stats))
	
	encounterbuttons()

func enemyleave():
	progress += 1.0
	var text = ''
	globals.player.energy = -max(5-floor((globals.player.sagi+globals.player.send)/2),1)
	for i in globals.state.playergroup:
		var slave = globals.state.findslave(i)
		slave.energy = -max(5-floor((slave.sagi+slave.send)/2),1)
		if slave.energy <= 10:
			globals.state.playergroup.erase(slave.id)
			text += slave.name + " is too exhausted to continue and returns back to mansion. "
		elif slave.stress >= 80:
			globals.state.playergroup.erase(slave.id)
			text += slave.name + " is too stressed to continue and returns back to mansion. "
	zoneenter(currentzone.code)
	if text != '':
		outside.maintext.set_bbcode(outside.maintext.get_bbcode()+'\n[color=yellow]'+text+'[/color]')

func enemyfight():
	outside.maintext.set_bbcode('')
	outside.clearbuttons()
	main.get_node("combat").currentenemies = enemygroup.units
	main.get_node('combat').area = currentzone
	main.get_node("combat").start_battle()

var capturedtojail = 0

func enemydefeated():
	if launchonwin != null:
		globals.events.call(launchonwin)
		launchonwin = null
		return
	main.checkplayergroup()
	var text = 'You have defeated enemy group!\n'
	defeated = {units = [], names = [], select = [], faction = []}
	var ranger = false
	for i in globals.state.playergroup:
		if globals.state.findslave(i).spec == 'ranger':
			ranger = true
	capturedtojail = 0
	#Fight rewards
	var winpanel = main.get_node("explorationnode/winningpanel")
	var goldearned = 0
	var expearned = 0
	var supplyearned = 0
	for unit in enemygroup.units:
		if unit.state == 'escaped':
			expearned += unit.rewardexp*0.66
			continue
		if unit.capture != null:
			defeated.units.append(unit.capture)
			defeated.names.append(unit.name)
			defeated.select.append(0)
			defeated.faction.append(unit.faction)
		for i in unit.rewardpool:
			var chance = unit.rewardpool[i]
			if ranger == true:
				chance = chance*1.5
			if rand_range(0,100) <= chance: 
				if i == 'gold':
					goldearned += round(rand_range(unit.rewardgold[0], unit.rewardgold[1]))
				elif i == 'supply':
					supplyearned += round(rand_range(unit.rewardsupply.low, unit.rewardsupply.high))
				else:
					var item = globals.itemdict[i]
					text = text + '\nLooted ' + item.name + '.'
					item.amount += 1
		expearned += unit.rewardexp
	expearned = round(expearned)
	globals.resources.gold += goldearned
	text += '\nYou have received a total sum of [color=yellow]' + str(round(goldearned)) +'[/color] pieces of gold and [color=aqua]' + str(expearned) + '[/color] experience points. '
	if supplyearned > 0:
		globals.itemdict.supply.amount += supplyearned
		text += "\nYou have collected " + str(supplyearned) + " units of supplies from defeated enemies. \n"
	globals.player.xp += round(expearned/(globals.state.playergroup.size()+1))
	for i in globals.state.playergroup:
		var slave = globals.state.findslave(i)
		slave.xp += round(expearned/(globals.state.playergroup.size()+1))
		if slave.levelupreqs.has('code') && slave.levelupreqs.code == 'wincombat':
			slave.levelup()
			text += slave.dictionary("\n[color=green]Your decisive win inspired $name, and made $him unlock new potential. \n")
		if slave.health > slave.stats.health_max/1.3:
			slave.cour += rand_range(1,3)
	
	winpanel.get_node("defeatedmindread").set_hidden(true)
	
	if defeated.units.size() > 0:
		text += 'Your group gathers defeated opponents in one place for you to decide what to do about them. \n'
	if enemygroup.captured != null:
		text += 'You are also free to decide what you wish to do with bystanders, who were in possession of your opponents. \n'
		for i in enemygroup.captured:
			defeated.units.append(i)
			defeated.names.append('Captured')
			defeated.select.append(0)
			defeated.faction.append('stranger')
	
	for i in winpanel.get_node("ScrollContainer/VBoxContainer").get_children():
		if i != winpanel.get_node("ScrollContainer/VBoxContainer/Button"):
			i.set_hidden(true)
			i.free()
	
	winpanel.set_hidden(false)
	winpanel.get_node("wintext").set_bbcode(text)
	for i in range(0, defeated.units.size()):
		defeated.units[i].stress += rand_range(20, 50)
		defeated.units[i].obed += rand_range(10, 20)
		defeated.units[i].health = -rand_range(40,70)
		if defeated.names[i] == 'Captured':
			defeated.units[i].obed += rand_range(10,20)
			defeated.units[i].loyal += rand_range(5,15)
		var newbutton = winpanel.get_node("ScrollContainer/VBoxContainer/Button").duplicate()
		winpanel.get_node("ScrollContainer/VBoxContainer").add_child(newbutton)
		newbutton.set_hidden(false)
		newbutton.get_node("Label").set_text(defeated.names[i] + ' ' + defeated.units[i].sex+ ' ' + defeated.units[i].age + ' ' + defeated.units[i].race)
		newbutton.connect("pressed", self, 'defeatedselected', [defeated.units[i]])
		newbutton.get_node("choice").set_meta('slave', defeated.units[i])
		newbutton.get_node("choice").add_to_group('winoption')
		newbutton.get_node("choice").connect("item_selected",self, 'defeatedchoice', [defeated.units[i], newbutton.get_node("choice")])
	checkjailbutton()
	
	
	if globals.state.sidequests.cali == 18 && defeated.names.find('Bandit') >= 0 && currentzone.code == 'forest':
		main.popup("One of the defeated bandits in exchange for their life reveal location of their camp you've been in search for. ")
		globals.state.sidequests.cali = 19



func defeatedselected(slave):
	var winpanel = main.get_node("explorationnode/winningpanel")
	winpanel.get_node("defeateddescript").set_bbcode(slave.description_small(true))
	if globals.spelldict.mindread.learned == true:
		winpanel.get_node("defeatedmindread").set_hidden(false)
		winpanel.get_node("defeateddescript").set_meta('slave', slave)
		if globals.resources.mana >= globals.spelldict.mindread.manacost:
			winpanel.get_node("defeatedmindread").set_disabled(false)
		else:
			winpanel.get_node("defeatedmindread").set_disabled(true)
	else:
		winpanel.get_node("defeatedmindread").set_hidden(true)

func defeatedchoice(ID, slave, node):
	checkjailbutton()
	defeated.select[defeated.units.find(slave)] = ID




func checkjailbutton():
	var counter = 0
	var winpanel = main.get_node("explorationnode/winningpanel")
	for i in get_tree().get_nodes_in_group('winoption'):
		if i.get_item_text(i.get_selected()) == 'Jail':
			counter += 1
	winpanel.get_node("Label").set_text("Defeated and Captured | Jail cells left: " + str(globals.state.mansionupgrades.jailcapacity - (globals.count_sleepers().jail + counter)) )
	if globals.state.mansionupgrades.jailcapacity <= globals.count_sleepers().jail + counter:
		for i in get_tree().get_nodes_in_group('winoption'):
			i.set_item_disabled(2, true)
	else:
		for i in get_tree().get_nodes_in_group('winoption'):
			i.set_item_disabled(2, false)


func _on_defeatedmindread_pressed():
	var spell = globals.spelldict.mindread
	var text = ''
	var winpanel = main.get_node("explorationnode/winningpanel")
	globals.get_tree().get_current_scene().get_node("spellnode").slave = winpanel.get_node("defeateddescript").get_meta('slave')
	globals.get_tree().get_current_scene().get_node("spellnode").mindreadeffect()
	defeatedselected(winpanel.get_node("defeateddescript").get_meta('slave'))



func _on_confirmwinning_pressed(secondary = false):
	var text = ''
	var selling = false
	var sellyourself = false
	var orgy = false
	var orgyarray = []
	var location
	var reward = false
	if currentzone.exits.find("wimbornoutskirts") >= 0:
		location = 'wimborn'
	elif currentzone.exits.find("frostfordoutskirts") >= 0:
		location = 'frostford'
	elif currentzone.exits.find("gornoutskirts") >= 0:
		location = 'gorn'
	for i in get_tree().get_nodes_in_group('winoption'):
		if i.get_item_text(i.get_selected()) == 'Sell':
			selling = true
	if selling == true && secondary == false:
		get_node("winningpanel/sellpanel").set_hidden(false)
		get_node("winningpanel/sellpanel/selectlist").clear()
		get_node("winningpanel/sellpanel/selectlist").add_item('Personal')
		for i in globals.state.playergroup:
			get_node("winningpanel/sellpanel/selectlist").add_item(globals.state.findslave(i).name)
		return
	else:
		if selling == true:
			if get_node("winningpanel/sellpanel/selectlist").get_selected() == 0:
				sellyourself = true
			else:
				var sellslave = globals.state.findslave(globals.state.playergroup[get_node("winningpanel/sellpanel/selectlist").get_selected()-1])
				globals.state.playergroup.remove(get_node("winningpanel/sellpanel/selectlist").get_selected()-1)
				text += sellslave.name + ' left you to transit capturees to nearby slave market.\n'
			for i in range(0, defeated.units.size()):
				if defeated.select[i] == 1:
					if defeated.faction[i] == 'stranger':
						globals.state.reputation[location] -= 2
					elif defeated.faction[i] == 'bandit':
						globals.state.reputation[location] += 1
					var rand = rand_range(5,10)
					defeated.units[i].add_effect(globals.effectdict.captured)
					text += defeated.names[i] + ' has been sold for ' + str(round(max(defeated.units[i].calculateprice()*0.3,rand))) + ' gold.\n'
					globals.resources.gold += max(defeated.units[i].calculateprice()*0.3,rand)
		for i in range(0, defeated.units.size()):
			if defeated.faction[i] == 'stranger':
				globals.state.reputation[location] -= 1
			if defeated.select[i] == 0:
				if defeated.names[i] != 'Captured':
					text += defeated.units[i].dictionary("You have left $race $child alone.\n")
				else:
					text += defeated.units[i].dictionary("You have released $race $child and set $him free.\n")
					globals.state.reputation[location] += rand_range(2,3)
					if rand_range(0,100) < 25 + globals.state.reputation[location]/3 && reward == false:
						reward = true
						rewardslave = defeated.units[i]
						rewardslavename = defeated.names[i]
			elif defeated.select[i] == 2:
				var slave = defeated.units[i]
				if defeated.faction[i] == 'stranger':
					globals.state.reputation[location] -= 1
				text += defeated.names[i] + " has been sent to your jail. \n"
				enemycapture(slave)
			elif defeated.select[i] == 3:
				if !defeated.faction[i] in ['monster','bandit']:
					globals.state.reputation[location] -= 3
				elif defeated.faction[i] == 'bandit':
					globals.state.reputation[location] -= 1
				text += defeated.names[i] + " has been killed. \n"
			elif defeated.select[i] == 4:
				if !defeated.faction[i] in ['bandit','monster']:
					globals.state.reputation[location] -= rand_range(0,1)
				orgy = true
				orgyarray.append(defeated.units[i])
	if sellyourself == true:
		get_node("winningpanel").set_hidden(true)
		main._on_mansion_pressed()
	else:
		get_node("winningpanel").set_hidden(true)
		enemyleave()
	get_node("winningpanel/defeateddescript").set_bbcode('')
	outside.playergrouppanel()
	if orgy == true:
		var totalmanagain = 0
		if orgyarray.size() >= 2: ### See if there's more than 1 enemy to rape
			text += "After freeing those left from their clothes, you joyfully start to savour their bodies one after another. "
		else:
			text += "You undress sole defeated and without further hesitation mercilessly rape " + orgyarray[0].dictionary("$race $child") + ". \n"
		for i in globals.state.playergroup:
			var slave = globals.state.findslave(i)
			if slave.sexuals.unlocked == false:
				if slave.loyal < 30:
					text+= slave.dictionary('\n$name watches at your actions with digust, eventually averting $his eyes. ')
					slave.obed += -rand_range(15,25)
				else:
					text += slave.dictionary('\n$name watches at your deeds with interest, occassionally rustling around $his waist. ')
					slave.lust = 20
			elif slave.sexuals.unlocked == true:
				if slave.lust >= 50 && slave.dom >= 40:
					slave.sexuals.affection += round(rand_range(2,4))
					slave.dom = rand_range(6,12)
					text += slave.dictionary('\n$name, overwhelemed by situation, joins you and pleasures $himself with one of the captives. ')
				else:
					text += slave.dictionary("\n$name does not appear to be very interested in ongoing action and just waits patiently.")
		for i in orgyarray:
			var temp = rand_range(3,5)
			globals.resources.mana += temp
			totalmanagain += temp
		text += "You've earned [color=aqua]" + str(round(totalmanagain)) + "[/color] mana. " 
	if reward == true:
		capturereward()
	if text != '':
		main.popup(text)

var rewardslave
var rewardslavename

func capturereward():
	var text = ""
	var buttons = [['Take no reward','capturedecide',1],['Ask for material reward','capturedecide',2],['Ask for sex','capturedecide',3],['Ask to join you','capturedecide',4]]
	text = "As you are about to move on, " + rewardslavename + " person, that you have rescued, appeals to you. $His name is $name and $he's very thankful for your help. $race $child wishes to repay you somehow.  "
	
	
	main.dialogue(false,self,rewardslave.dictionary(text),buttons)

func capturedecide(stage): #1 - no reward, 2 - material, 3 - sex, 4 - join
	var text = ""
	var location
	if currentzone.exits.find("wimbornoutskirts") >= 0:
		location = 'wimborn'
	elif currentzone.exits.find("frostfordoutskirts") >= 0:
		location = 'frostford'
	elif currentzone.exits.find("gornoutskirts") >= 0:
		location = 'gorn'
	
	if stage == 1:
		text = "$race $child is surprised by your generosity, and after thanking you again, leaves. "
		globals.state.reputation[location] += 1
	elif stage == 2:
		text = "After getting through $his belongings, $name passes you some valueable and gold. "
		globals.resources.gold += round(rand_range(3,6)*10)
	elif stage == 3:
		if rand_range(0,100) >= 35 + globals.state.reputation[location]/2:
			text = "$name hastily refuses and retreats excusing $himself. "
		else:
			text = "After brief pause, $name gives you an accepting nod. After you seclude to nearby bushes, $he rewards you with passionate session. "
			globals.resources.mana += 5
	elif stage == 4:
		if rand_range(0,100) >= 20 + globals.state.reputation[location]/4:
			text = "$name excuses $himself, but can't accept your proposal and quickly leaves. "
		else:
			rewardslave.obed = 85
			rewardslave.stress = 10
			globals.slaves = rewardslave
			text = "$name observes you for some time, measuring you words, but to your surprise, $he complies either out of symphathy, or out of desperate life $he had to carry. "
	main.dialogue(true,self,rewardslave.dictionary(text))
	

func _on_sellconfirm_pressed():
	_on_confirmwinning_pressed(true)
	get_node("winningpanel/sellpanel").set_hidden(true)


func enemycapture(slave):
	slave.sleep = 'jail'
	var effect = globals.effectdict.captured
	var dict = {'slave':0.7, 'poor':1,'commoner':1.2,"rich": 2, "noble": 4}
	effect.duration = round((4 + (slave.conf+slave.cour)/20) * dict[slave.origins])
	slave.add_effect(effect)
	if slave.race in ['Lamia','Arachna','Harpy','Nereid','Slime','Scylla','Dryad','Fairy']:
		slave.add_trait(globals.origins.trait('Uncivilized'))
	globals.slaves = slave


func wimbornoutskirts():
	var array = []
	array.append({name = "Explore Outskirts", function = 'zoneenter', args = 'wimbornoutskirtsexplore'})
	array.append({name = "Explore Forest", function = 'zoneenter', args = 'forest'})
	array.append({name = "Explore Deep Elven Grove", function = 'zoneenter', args = 'elvenforest'})
	array.append({name = "Explore Far Eerie Woods", function = 'zoneenter', args = 'grove'})
	array.append({name = "Return to Wimborn", function = 'wimborn'})
	outside.buildbuttons(array, self)

func gornoutskirts():
	var array = []
	array.append({name = "Explore Outskirts", function = 'zoneenter', args = 'gornoutskirtsexplore'})
	array.append({name = "Explore Mountain Ridge", function = 'zoneenter', args = 'mountains'})
	array.append({name = "Explore Sea Beach", function = 'zoneenter', args = 'sea'})
	array.append({name = "Return to Gorn", function = 'zoneenter', args = 'gorn'})
	outside.buildbuttons(array,self)


func frostfordoutskirts():
	var array = []
	array.append({name = "Explore Outskirts", function = 'zoneenter', args = 'frostfordoutskirtsexplore'})
	array.append({name = "Explore Marsh", function = 'zoneenter', args = 'marsh'})
	array.append({name = "Return to Frostford", function = 'zoneenter', args = 'frostford'})
	outside.buildbuttons(array,self)

func wimborn():
	main.get_node('outside').town()
	main.get_node('outside').gooutside()

func gorn():
	outside.location = 'gorn'
	main.music_set('gorn')
	var array = []
	array.append({name = "Visit local Slave Guild", function = 'gornslaveguild'})
	array.append({name = "Visit local bar", function = 'gornbar'})
	if globals.state.mainquest in [12,13,14,15]:
		array.append({name = "Visit Palace", function = 'gornpalace'})
	if globals.state.sidequests.ivran in ['tobetaken','tobealtered','potionreceived'] || globals.state.mainquest >= 16:
		array.append({name = "Visit Alchemist", function = 'gornayda'})
	array.append({name = "Gorn's Market", function = 'gornmarket'})
	array.append({name = "Outskirts", function = 'zoneenter', args = 'gornoutskirts'})
	array.append({name = "Return to Mansion", function = 'mansionreturn'})
	outside.buildbuttons(array,self)

func gornbar():
	var array = []
	var text = globals.questtext.GornBar
	
	if globals.state.sidequests.yris == 0:
		text += "As you move towards the bar your presence is noticed by a girl of beastkin origins. Drawing your attention she gives you an  undoubtedly interested look. "
		array.append({name = "Approach the girl", function = "gornyris"}) 
	elif globals.state.sidequests.yris < 6:
		array.append({name = "Approach Yris", function = 'gornyris'}) 
	array.append({name = "Leave",function = 'zoneenter', args = 'gorn'})
	outside.maintext.set_bbcode(text)
	outside.buildbuttons(array,self)

func gornyris():
	var state = false
	var text
	var buttons = []
	if globals.player.penis.number < 1:
		main.popup("This encounter requires your character to possess a penis. ")
		return
	if globals.state.sidequests.yris == 0:
		text = globals.questtext.GornYrisMeet
		globals.charactergallery.yris.unlocked = true
		if globals.resources.gold >= 200:
			buttons.append({text = "Accept (200 Gold)", function = "gornyrisaccept", args = 1})
		else:
			buttons.append({text = "Accept (200 Gold)", function = "gornyrisaccept", args = 1, disabled = true})
		globals.state.sidequests.yris = 1
	elif globals.state.sidequests.yris == 1:
		text = globals.questtext.GornYrisRepeatMeet
		if globals.resources.gold >= 200:
			buttons.append({text = "Accept (200 Gold)", function = "gornyrisaccept", args = 1})
		else:
			buttons.append({text = "Accept (200 Gold)", function = "gornyrisaccept", args = 1, disabled = true})
	elif globals.state.sidequests.yris == 2:
		text = globals.questtext.GornYrisRepeatMeet
		if globals.resources.gold >= 200:
			buttons.append({text = "Accept (200 Gold)", function = "gornyrisaccept", args = 2})
			if globals.itemdict.deterrentpot.amount >= 1:
				buttons.append({text = "Accept and use Deterrent potion (200 Gold)", function = "gornyrisaccept", args = 3})
		else:
			buttons.append({text = "Accept (200 Gold)", function = "gornyrisaccept", args = 2, disabled = true})
	elif globals.state.sidequests.yris == 3:
		text = globals.questtext.GornYrisOffer2
		globals.state.sidequests.yris += 1
	elif globals.state.sidequests.yris in [4,5]:
		text = globals.questtext.GornYrisOffer2Repeat
		if globals.resources.gold < 1000 || globals.itemdict.deterrentpot.amount < 1 || globals.state.sidequests.yris < 5:
			text += "\n\n[color=yellow]You decide, that you should prepare before putting your money on the table.[/color] "
			if globals.state.sidequests.yris < 5:
				text += "\n\nPerhaps, somebody skilled in aclhemy might shine some light upon your previous finding. " 
			buttons.append({text = "Accept (1000 Gold)", function = "gornyrisaccept", args = 4, disabled = true})
		else:
			buttons.append({text = "Accept (1000 Gold)", function = "gornyrisaccept", args = 4})
	buttons.append({text = "Refuse", function = "gornyrisaccept", args = 0})
	gornbar()
	main.dialogue(state, self, text, buttons)

func gornyrisleave(args):
	zoneenter('gorn')
	main.close_dialogue()

func gornyrisaccept(stage):
	var text = ''
	var state = false
	var buttons = []
	if stage == 0:
		text = globals.questtext.GornYrisRefuse
		buttons.append({text = "Continue", function = 'gornyrisleave', args = null})
	elif stage == 1:
		globals.charactergallery.yris.scenes[0].unlocked = true
		globals.charactergallery.yris.nakedunlocked = true
		text = globals.questtext.GornYrisAccept1
		globals.resources.gold -= 200
		globals.resources.mana += 15
		globals.state.sidequests.yris = 2
		state = true
	elif stage == 2:
		text = globals.questtext.GornYrisAcceptRepeat
		state = true
		globals.resources.gold -= 200
		globals.resources.mana += 15
	elif stage == 3:
		text = globals.questtext.GornYrisAccept2
		globals.charactergallery.yris.scenes[1].unlocked = true
		globals.state.sidequests.yris += 1
		globals.itemdict.deterrentpot.amount -= 1
		state = true
		globals.resources.mana += 25
	elif stage == 4:
		globals.charactergallery.yris.scenes[2].unlocked = true
		globals.itemdict.deterrentpot.amount -= 1
		text = globals.questtext.GornYrisAccept3
		buttons.append({text = "Reveal everything", function = 'gornyrisaccept', args = 5})
		buttons.append({text = "Demand the gold", function = 'gornyrisaccept', args = 6})
	elif stage == 5:
		text = globals.questtext.GornYrisReveal
		buttons.append({text = "Offer Yris to work for you", function = 'gornyrisaccept', args = 8})
		buttons.append({text = "Demand the gold", function = 'gornyrisaccept', args = 7})
	elif stage == 6:
		text = globals.questtext.GornYrisTakeGold
		globals.state.sidequests.yris = 100
		globals.resources.gold += 1000
		text += "\n\nIn the end you get the gold you asked for, but never seen Yris again. "
		state = true
	elif stage == 7:
		text = globals.questtext.GornYrisTakeGold2
		globals.state.sidequests.yris = 100
		text += "\n\nIn the end you get the gold you asked for, but never seen Yris again. "
		globals.resources.gold += 1000
		state = true
	elif stage == 8:
		state = true
		text = globals.questtext.GornYrisHire
		globals.state.sidequests.yris += 1
		var slave = globals.slavegen.newslave('Beastkin Cat', 'adult', 'female', 'commoner')
		slave.name = 'Yris'
		slave.unique = 'Yris'
		slave.surname = ''
		slave.tits.size = 'big'
		slave.ass = 'average'
		slave.beautybase = 72
		slave.hairlength = 'waist'
		slave.height = 'average'
		slave.haircolor = 'blond'
		slave.eyecolor = 'green'
		slave.skin = 'fair'
		slave.furcolor = 'white'
		slave.hairstyle = 'straight'
		slave.pussy.virgin = false
		slave.pussy.first = 'unknown'
		slave.relatives.father = -1
		slave.relatives.mother = -1
		slave.sexuals.affection += 1
		slave.charm = 71
		slave.wit = 62
		slave.cour = 33
		slave.conf = 48
		slave.sexuals.unlocked = true
		slave.sexuals.unlocks.append("petting")
		slave.sexuals.unlocks.append('oral')
		slave.sexuals.unlocks.append('vaginal')
		slave.unlocksexuals()
		slave.cleartraits()
		slave.sagi += 1
		slave.send += 1
		slave.loyal = 25
		slave.obed += 90
		globals.slaves = slave
	gornbar()
	main.dialogue(state, self, text, buttons)

func amberguard():
	var array = []
	outside.location = 'amberguard'
	main.music_set('gorn')
	if globals.state.portals.amberguard.enabled == false:
		globals.state.portals.amberguard.enabled = true
		outside.maintext.set_bbcode(outside.maintext.get_bbcode() + "\n\n[color=yellow]You have unlocked new portal![/color]")
	if globals.state.mainquest == 17:
		globals.state.mainquest = 18
	elif globals.state.mainquest == 19:
		array.append({name = "Search for clues", function = "amberguardsearch"})
	elif globals.state.mainquest == 20:
		array.append({name = 'Find stranger', function = 'amberguardsearch', args = 2})
	array.append({name = "Check local market", function = 'amberguardmarket'})
	array.append({name = "Return to Elven Grove", function = 'zoneenter', args = 'elvenforest'})
	array.append({name = "Move to the Amber Road", function = 'zoneenter', args = 'amberguardforest'})
	outside.buildbuttons(array,self)

func amberguardsearch(stage = 1):
	var text
	var buttons = []
	globals.state.mainquest = 20
	if stage == 1:
		text = globals.questtext.MainQuestAmberguardSearch
	elif stage == 2:
		text = globals.questtext.MainQuestAmberguardReturn
	if globals.resources.gold >= 1000:
		buttons.append({text = 'Pay 1000 gold',function = 'amberguardpurchase',args = 1})
	else:
		buttons.append({text = 'Pay 1000 gold',function = 'amberguardpurchase',args = 1, disabled = true})
	buttons.append({text = 'Leave',  function = 'amberguardpurchase', args = 2})
	main.dialogue(false,self,text,buttons)
	amberguard()

func amberguardpurchase(stage):
	var text
	if stage == 1:
		globals.state.mainquest = 21
		globals.resources.gold -= 1000
		text = globals.questtext.MainQuestAmberguardPay
	elif stage == 2:
		text = "You return to the main street."
	amberguard()
	main.dialogue(true, self, text, null)

func witchhut():
	var array = []
	if globals.state.mainquest == 21:
		globals.state.mainquest = 22
		outside.maintext.set_bbcode(globals.questtext.MainQuestAmberguardWitch)
		array.append({name = "Go inside", function = 'shuriyavisit', args = 1})
	else:
		array.append({name = "Go inside", function = 'shuriyavisit', args = 2})
	array.append({name = "Return to Amber Road", function = 'zoneenter', args = 'amberguardforest'})
	outside.buildbuttons(array,self)

func shuriyavisit(stage):
	var text
	var buttons = []
	var state = true
	if stage == 1:
		text = globals.questtext.AmberguardShuriyaVisit
	elif stage == 2:
		text = "Shuriya greets you with frown on her face. \n\n[color=yellow]— Oh, it's you again? What do you need?[/color]"
	elif stage == 3:
		text = globals.questtext.MainQuestAmberguardTunnelsAsk
	elif stage == 4:
		text = globals.questtext.MainQuestAmberguardTunnelEnterAsk
		globals.state.mainquest = 23
	buttons.append({text = 'Ask about the tunnels', function = 'shuriyavisit', args = 3})
	if globals.state.mainquest == 22:
		buttons.append({text = 'Ask about entrance', function = 'shuriyavisit', args = 4})
	if globals.state.mainquest == 23:
		buttons.append({text = 'Deliver slaves', function = 'shuriyaslaves', args = true})
	zoneenter(currentzone.code)
	main.dialogue(state, self, text, buttons)

var slave1 = null
var slave2 = null

func shuriyaslaves(first = true):
	var state = true
	var text = '[color=yellow]— Well, who do you have?[/color]'
	var buttons = []
	var cancontinue = false
	if first == true:
		slave1 = null
		slave2 = null
	else:
		if slave1 != null && slave2 != null:
			cancontinue = true
	
	if slave1 != null:
		text += slave1.dictionary("\n$name will be given away as an Elf.")
	if slave2 != null:
		text += slave2.dictionary("\n$name will be given away as a Drow.")
	
	if cancontinue == true:
		buttons.append({text = "Confirm", function = 'shuriyaslavesgive', args = null})
	else:
		if slave1 == null:
			buttons.append({text = 'Select an Elf', function = 'shuriyaslaveselect', args = 1})
		if slave2 == null:
			buttons.append({text = 'Select a Drow', function = 'shuriyaslaveselect', args = 2})
	main.dialogue(state, self, text, buttons)

func shuriyaslaveselect(stage):
	if stage == 1:
		main.selectslavelist(true, 'shuriyaelfselect', self, 'slave.race == "Elf"')
	else:
		main.selectslavelist(true, 'shuriyadrowselect', self, 'slave.race == "Drow"')

func shuriyaslavesgive(none):
	globals.state.mainquest = 24
	globals.slaves.erase(slave1)
	globals.slaves.erase(slave2)
	var text = globals.questtext.MainQuestAmberguardSlaveDeliver
	main.popup(text)
	main.close_dialogue()

func shuriyaelfselect(slave):
	slave1 = slave
	shuriyaslaves(false)

func shuriyadrowselect(slave):
	slave2 = slave
	shuriyaslaves(false)


func undercityentrance():
	var array = []
	if globals.state.mainquest == 18:
		globals.state.mainquest = 19
	if globals.state.mainquest >= 24:
		array.append({name = 'Go through hidden passage', function = 'zoneenter', args = 'undercitytunnels'})
	array.append({name = "Return to Amber Road", function = 'zoneenter', args = 'amberguardforest'})
	outside.buildbuttons(array,self)

func undercityhall():
	var array = []
	if globals.state.mainquest == 24:
		array.append({name = "Search for documents", function = 'undercityboss'})
	else:
		array.append({name = "Search for valuables", function = 'undercityboss'})
	outside.buildbuttons(array,self)

func undercityboss():
	main.get_node("combat").nocaptures = true
	if globals.state.mainquest == 24:
		buildenemies("bossgolem")
		launchonwin = 'undercitybosswin'
		enemyfight()
	else:
		buildenemies("bosswyvern")
		launchonwin = 'undercitybosswin'
		enemyfight()



func gornmarket():
	outside.shopinitiate('gornmarket')

func amberguardmarket():
	if globals.state.sidequests.ayneris >= 4:
		globals.events.aynerismarket()
		return
	outside.shopinitiate('amberguardmarket')

func gornpalace():
	globals.events.gornpalace()
	zoneenter('gorn')

func gornayda():
	globals.events.gornayda()

func frostford():
	outside.location = 'frostford'
	main.music_set('gorn')
	var array = []
	if globals.state.mainquest in [28, 29, 30, 31, 33, 34, 35]:
		array.append({name = "Visit City Hall", function = "frostfordcityhall"})
	if globals.state.reputation.frostford >= 20 && globals.state.mainquest == 30 && globals.state.sidequests.zoe == 0:
		var text = globals.questtext.MainQuestFrostfordCityhallZoe
		var buttons = []
		var sprite = []
		buttons.append({text = 'Accept', function = "frostfordzoe", args = 1})
		buttons.append({text = 'Refuse', function = "frostfordzoe", args = 2})
		main.dialogue(false, self, text, buttons, sprite)
	array.append({name = "Visit local Slave Guild", function = 'frostfordslaveguild'})
	array.append({name = "Frostford's Market", function = 'frostfordmarket'})
	array.append({name = "Outskirts", function = 'zoneenter', args = 'frostfordoutskirts'})
	array.append({name = "Return to Mansion", function = 'mansionreturn'})
	outside.buildbuttons(array,self)

func frostfordzoe(stage):
	var text
	var buttons = []
	var sprite = []
	if stage == 1:
		text = globals.questtext.MainQuestFrostfordCityhallZoeAccept
		globals.state.sidequests.zoe = 1
	elif stage == 2:
		text = globals.questtext.MainQuestFrostfordCityhallZoeRefuse
		globals.state.sidequests.zoe = 100
	
	main.dialogue(true, self, text, buttons, sprite)

func frostfordcityhall():
	globals.events.frostfordcityhall()

func frostfordmarket():
	outside.shopinitiate('frostfordmarket')

func gornslaveguild():
	outside.slaveguild('gorn')

func frostfordslaveguild():
	outside.slaveguild('frostford')


func shaliq():
	var array = []
	if globals.state.sidequests.cali == 17:
		globals.events.calivillage()
	elif globals.state.sidequests.cali in [20,21]:
		globals.events.calivillage2()
	array.append({name = "Visit Local Trader", function = 'shaliqshop'})
	if globals.state.sidequests.chloe >= 1:
		array.append({name = "Visit Chloe's house", function = "chloehouse"})
	array.append({name = "Leave to the forest", function = 'zoneenter', args = 'forest'})
	if globals.state.sidequests.chloe == 15:
		globals.state.sidequests.chloe = 16
		outside.maintext.set_bbcode("You lead Chloe back to her house and give her some time to rest and clean herself.")
		
	outside.buildbuttons(array,self)

func shaliqshop():
	outside.shopinitiate('shaliqshop')

func chloeforest():
	globals.events.chloeforest()

func aynerisencounter():
	globals.events.aynerisforest()


func chloehouse():
	if globals.state.sidequests.chloe in [2,3]:
		globals.events.chloevillage(1)
	elif globals.state.sidequests.chloe in [4,5,6]:
		globals.events.chloevillage(4)
	elif globals.state.sidequests.chloe in [7,8,9]:
		globals.events.chloevillage(5)
	elif globals.state.sidequests.chloe == 10:
		globals.events.chloevillage(8)

func chloegrove():
	globals.events.chloegrove()

func encounterdictionary(text):
	var string = text
	var temp
	temp = str(enemygroup.units.size())
	if temp == '1':
		temp = 'sole'
	string = string.replace('$unitnumber', temp)
	if enemygroup.captured != null:
		temp = str(enemygroup.captured.size())
		if temp == '1':
			temp = 'sole'
		string = string.replace('$capturednumber', temp)
	if enemygroup.units.size() <= 1 &&  enemygroup.units[0].capture != null:
		string = enemygroup.units[0].capture.dictionary(string)
	string = string.replace('$scoutname', scout.dictionary('$name'))
	return string

