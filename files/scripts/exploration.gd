
extends Node

var progress = 0.0
var enemygroup
var defeated = {}
var currentzone
var lastzone
var awareness = 0
var ambush = false
var scout
var launchonwin = null
var combatdata = load("res://files/scripts/combatdata.gd").new()
var deeperregion = false


var enemygrouppools = combatdata.enemygrouppools
var capturespool = combatdata.capturespool
var enemypool = combatdata.enemypool


var zones = {
wimbornoutskirts = {
background = 'meadows',
reqs = "true",
combat = true,
code = 'wimbornoutskirts',
name = 'Wimborn Outskirts',
description = "The rural road leads across green plains and various settlements. Bright scenery puts you at peace. ",
enemies = [{value = 'peasant', weight = 2},{value = 'banditseasy', weight = 1},{value = 'thugseasy',weight = 3}],
encounters = [],
length = 5,
exits = ['wimborn','forest', 'prairie'],
tags = ['wimborn'],
races = [{value = 'Taurus', weight = 2}, {value = 'Cat', weight = 1},{value = 'Human', weight = 12}],
},
prairie = {
background = 'highlands',
reqs = "true",
combat = true,
code = 'prairie',
name = 'Prairies',
description = "Long trading route goes through the wide prairies. Rarely you can spot mixed settlements and lone estates. ",
enemies = [{value = 'banditsmedium', weight = 2},{value = 'slaverseasy', weight = 1},{value = 'peasant', weight = 2},{value = 'banditseasy', weight = 3}],
encounters = [],
length = 5,
exits = ['wimbornoutskirts','gornoutskirts','sea'],
tags = ['wimborn'],
races = [{value = 'Orc', weight = 6},{value = 'Human', weight = 4}, {value = 'Cat', weight = 1}, {value = 'Bunny', weight = 1}]
},

forest = {
background = 'crossroads',
reqs = "true",
combat = true,
code = 'forest',
name = 'Ancient Forest',
description = "You stand deep within this ancient forest. Giant trees tower above you, reaching into the skies and casting deep shadows on the ground below. As the wind whispers past, you can hear the movement of small creature in the undergrowth and birds singing from their perches above.",
enemies = [{value = 'thugseasy', weight = 1},{value = 'banditseasy', weight = 1}, {value = 'peasant', weight = 2}, {value ='solobear', weight = 1.5}, {value = 'wolveseasy', weight = 3}],
encounters = [['chloeforest','globals.state.sidequests.chloe in [0,1]',10]],
length = 5,
exits = ['shaliq', 'wimbornoutskirts', 'elvenforest'],
tags = ['wimborn'],
races = [{value = 'Elf', weight = 2}, {value = 'Wolf', weight = 1}, {value = 'Bunny', weight = 1}, {value = 'Human', weight = 10}]
},

elvenforest = {
background = 'forest',
reqs = "true",
combat = true,
code = 'elvenforest',
name = 'Deep Elven Grove',
description = "This portion of the forest is located dangerously close to eleven lands. They take poorly to intruders in their part of the woods so you should remain on your guard.",
enemies = [{value = 'fairy', weight = 1},{value = 'solobear', weight = 3},{value = 'elfguards',weight = 3},{value = 'plantseasy', weight = 3},{value = 'wolveseasy', weight = 5}],
encounters = [],
length = 5,
exits = ['amberguard','forest'],
tags = ['amberguard'],
races = [{value = 'Drow', weight = 1},{value = 'Elf', weight = 12},{value = 'Bunny', weight = 2},{value = 'Tanuki', weight = 2}]
},


amberguardforest = {
background = 'amberroad',
reqs = "true",
combat = true,
code = 'amberguardforest',
name = 'Amber Road',
description = "Amber Road is a long way through seeming glade and various small settlements and hills. ",
enemies = [{value = 'solobear',weight = 1}, {value = 'wolveshard', weight = 3}, {value ='direwolveseasy', weight = 5}, {value = 'elfguards',weight = 3},],
encounters = [['aynerisencounter','globals.state.sidequests.ayneris in [0,1,2]',15]],
length = 4,
exits = ['amberguard','witchhut','undercityentrance'],
tags = ['amberguard'],
races = [{value = "Elf", weight = 100}]
},

grove = {
background = 'grove',
reqs = "true",
combat = true,
code = 'grove',
name = 'Far Eerie Woods',
description = "This portion of the forest is deeply shadowed, and strange sounds drift in and out of hearing. Something about the atmosphere keeps the normal forest creatures silent, lending an eerie, mystic feeling to the grove you stand within.",
enemies = [{value = 'dryad',weight = 2},  {value = 'fairy', weight = 2},{value = 'wolveshard', weight = 4},{value = 'plantseasy',weight = 5}],
encounters = [['chloegrove','globals.state.sidequests.chloe == 6',25],['snailevent','globals.state.mansionupgrades.farmhatchery >= 1 && globals.state.snails < 10',10]],
length = 7,
exits = ['shaliq','marsh'],
tags = ['wimborn'],
races = [{value = 'Fairy', weight = 3},{value = "Dryad", weight = 2}]
},

marsh = {
background = 'marsh',
reqs = "true",
combat = true,
code = 'marsh',
name = 'Marsh',
description = "Dank bog lies at the border of the forest and swamps beyond. Noxious smells and a sinister aura prevail throughout. The landscape itself is hostile, with pitch-black pools of water mixed among the solid ground and you doubt that the creatures that live here are any more pleasant than the land they live in.",
enemies = [{value = 'banditcamp',weight = 1},{value = 'monstergirl', weight = 1}, {value = 'oozesgroup', weight = 2}, {value = 'solospider', weight = 5}],
encounters = [],
length = 6,
exits = ['frostfordoutskirts','grove'],
tags = ['frostford'],
races = [{value = 'Arachna', weight = 1},{value = 'Lamia', weight = 2},{value = 'Slime', weight = 2}, {value = 'Demon', weight = 5}]
},

mountains = {
background = 'mountains',
reqs = "true",
combat = true,
code = 'mountains',
name = 'Mountains',
description = "You climb over small hills in search for any activity in these elevated grounds.",
enemies = [{value = 'slaversmedium', weight = 1},{value = 'harpy', weight = 2},{value = 'banditsmedium', weight = 3}, {value = 'fewcougars', weight = 4}],
encounters = [],
length = 6,
exits = ['gornoutskirts'],
tags = ['gorn'],
races = [{value = 'Dragonkin', weight = 1},{value = 'Seraph', weight = 2.5},{value = 'Gnome', weight = 3},{value = 'Centaur', weight = 2},{value = 'Goblin', weight = 4},{value = 'Orc', weight = 8}]
},

sea = {
background = 'sea',
reqs = "true",
combat = true,
code = 'sea',
name = 'Sea',
description = "You are at the beach of a Big Sea. Air smells of salt and you can spot some sea caves formed by plateau and incoming waves.",
enemies = [{value = 'banditcamp', weight = 1},{value = 'monstergirl', weight = 3},{value = 'travelersgroup', weight = 5},{value = 'oozesgroup', weight = 5}],
encounters = [],
length = 5,
exits = ['prairie'],
tags = ['gorn'],
races = [{value = 'Scylla', weight = 1},{value = 'Lamia', weight = 1},{value = 'Nereid', weight = 3}]
},

gornoutskirts = {
background = 'highlands',
reqs = "true",
combat = true,
code = 'gornoutskirts',
name = 'Gorn Outskirts',
description = "The town's outskirts look bright and green. ",
enemies = [{value = 'slaverseasy', weight = 1},{value = 'peasant', weight = 1},{value = 'banditseasy', weight = 3},{value = 'thugseasy', weight = 3},{value = 'wolveseasy', weight = 5}],
encounters = [],
length = 5,
exits = ['gorn','prairie'],
tags = ['gorn'],
races = [{value = 'Centaur', weight = 1},{value = 'Goblin', weight = 4},{value = 'Orc', weight = 12}]
},


frostfordoutskirts = {
background = 'borealforest',
reqs = "true",
combat = true,
code = 'frostfordoutskirts',
name = 'Frostford Outskirts',
description = "Main road quickly branches off at thick boreal forest. Even though Frostford is considerably dense in population, its periphery is far less inhabitable due to harsh climat. You make your way through semi-utilized forest paths paying attention to the surroundings. ",
enemies = [{value = 'banditsmedium', weight = 2},{value = 'travelersgroup', weight = 1.5},{value = 'peasant', weight = 2},{value = 'thugseasy', weight = 2},{value = 'solobear', weight = 4}],
encounters = [],
length = 5,
exits = ['frostford','marsh','frostfordclearing'],
tags = ['frostford'],
races = [{value = 'Halfkin Fox', weight = 1},{value = 'Beastkin Fox', weight = 1},{value = 'Halfkin Cat', weight = 2},{value = 'Beastkin Cat', weight = 2},{value = 'Halfkin Wolf', weight = 6},{value = 'Beastkin Wolf', weight = 6},{value = 'Human', weight = 5}]
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
enemies = [{value = 'solospider', weight = 1}, {value = 'oozesgroup', weight = 1}, {value = 'troglodytesmall', weight = 1}, {value = 'mutant', weight = 1}],
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
enemies = [{value = 'spidergroup',weight = 5},{value = 'gembeetle', weight = 1}, {value = 'troglodytelarge', weight = 5}, {value = 'troglodytesmall', weight = 4}, {value = 'mutant', weight = 4}],
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

umbra = {
background = 'undercity',
reqs = "true",
combat = false,
code = 'umbra',
name = 'Umbra',
description = "You are in the middle of vast enclosed cave. Below the ceiling resides a magical dim light source, providing slightly more illumination than at full moon night. Shabby buildings around the cave's walls have multiple people moving in and out. Most people resemble bandits and criminals, but occassinally you can spot riches with bodyguards. Despite slightly worring atmosphere, there seems to be no open danger or fight-seeking individuals.  ",
enemies = [],
encounters = [],
length = 0,
exits = ['umbra'],
tags = [],
},


wimborn = {
background = 'wimborn',
reqs = "true",
combat = false,
code = 'wimborn',
name = 'Wimborn',
description = "The Wimborn is a lively place at nearly all hours, as the cries of hawkers and shopkeepers vie with the songs of work crews for attention. Along the major roads, most of the buildings have been painted in a riot of colors to break up the monotony of grey-blue brick and plaster covered stone, with many of the storefronts sporting colorful awnings and signs to attract potential customers. Away from the bright colors and raucous noise of the market streets things tend to be restrained, the buildings more grey, and cries more a cause for worry.\n\nThe city is divided into a number of districts, but only a few areas are of interest to you at the moment. To the north are the Market District, and past that Auld Erellon which is the home of the Mage’s Guild and other government bodies. To the west is Red-Lantern and Riverside, where most of the city’s brothels and whorehouses might be found. To the south is the Guild District, where there is always some foreman looking for cheap but reliable labor.",
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

frostfordclearing = {
background = 'borealforest',
reqs = "str(globals.state.mainquest) in ['28','28.1','30','32']",
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
	var text = ''
	if lastzone == null:
		lastzone = zones[zone].code
	else:
		lastzone = currentzone.code
	zone = self.zones[zone]
	outside.location = zone.code
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
	text = zone.name
	if deeperregion:
		text += ' [Deep Area]'
	outside.get_node('exploreprogress/locationname').set_text(text)
	globals.get_tree().get_current_scene().get_node("outside/exploreprogress").set_val((progress/max(zone.length,1))*100)
	currentzone = zone
	outside.clearbuttons()
	text = '[center]'+ zone.name + '[/center]' + globals.fastif(deeperregion == true, ' [Deep Area]', '')
	text += '\n\n'+ zone.description
	if zone.code in ['wimborn','gorn','amberguard','frostford']:
		text += "\n\n[color=yellow]You can use public teleport to return to mansion from this location.[/color]"
	outside.maintext.set_bbcode(text)
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
		if globals.state.backpack.stackables.has('supply') && globals.state.backpack.stackables.supply >= 3 && globals.state.playergroup.size()*5+5 <= globals.resources.food:
			array.append({name = "Rest and eat", function = 'rest', tooltip = 'Requires 3 units of supplies and 5 food per party member'})
		else:
			array.append({name = "Rest and eat", function = 'rest', disabled = true, tooltip = 'Requires 3 units of supplies and 5 food per party member'})
		if globals.state.restday == globals.resources.day:
			array[array.size()-1].disabled = true
			array[array.size()-1].tooltip = 'Can only be done once per day'
		progress = 0
		if deeperregion == false:
			array.insert(0,{name = 'Move deeper into the region', function = 'deepzone', args = currentzone.code})
			array.insert(0,{name = 'Explore this area again', function = 'zoneenter', args = currentzone.code})
		else:
			array.insert(0,{name = 'Return to the central region', function = 'zoneenter', args = currentzone.code})
			array.insert(0,{name = 'Stay in the deeper region', function = 'deepzone', args = currentzone.code})
		deeperregion = false
		outside.buildbuttons(array, self)
	else:
		array.append({name = "Proceed through area", function = 'enemyencounter'})
		if globals.developmode == true:
			array.append({name = "Skip", function = 'areaskip'})
	if globals.state.sidequests.cali == 19 && zone.code == 'forest':
		array.append({name = "Look for bandits' camp", function = 'event',args = 'calibanditcamp'})
	elif (globals.state.sidequests.cali == 23 || globals.state.sidequests.cali == 24) && zone.code == 'wimbornoutskirts':
		array.append({name = "Visit slaver's camp", function = 'event',args = 'calislavercamp'})
	elif (globals.state.sidequests.cali == 25) && zone.code == 'wimbornoutskirts':
		array.append({name = "Find the Bandit",function = 'event',args = 'calistraybandit'})
	elif (globals.state.sidequests.cali == 26) && zone.code == 'grove':
		array.append({name = "Find Cali's village",function = 'event',args = 'calireturnhome'})
	if globals.state.mainquest == 13 && zone.code == 'gornoutskirts':
		array.append({name = "Search for Ivran's location",function = 'event',args = 'gornivran'})
	if zone.code == 'undercitytunnels' && progress >= 6 && globals.state.lorefound.find('amberguardlog1') < 0:
		globals.state.lorefound.append('amberguardlog1')
		outside.maintext.set_bbcode(outside.maintext.get_bbcode() + "[color=yellow]\n\nYou've found some old writings in the ruins. Does not look like what you came for, but you can read them later.[/color]")
	if zone.code == 'undercityruins' && progress >= 5 && globals.state.lorefound.find('amberguardlog2') < 0:
		globals.state.lorefound.append('amberguardlog2')
		outside.maintext.set_bbcode(outside.maintext.get_bbcode() + "[color=yellow]\n\nYou've found some old writings in the ruins. Does not look like what you came for, but you can read them later.[/color]")
	if zone.code == 'frostfordoutskirts' && globals.state.mainquest in [27,30,32] && progress >= 5:
		array.append({name = "Explore hunting grounds to South-East", function = 'event', args = 'frostforddryad'})
	if zone.code == 'frostfordoutskirts' && globals.state.sidequests.zoe == 1 && progress >= 3:
		globals.state.sidequests.zoe = 2
		main.dialogue(true, self, globals.questtext.MainQuestFrostfordBeforeForestZoe, [], null)
	if progress == 0 && lastzone != zone.code:
		array.append({name = "Return to " + zones[lastzone].name, function = "zoneenter", args = lastzone})
	outside.buildbuttons(array, self)

func deepzone(currentzonecode):
	deeperregion = true
	zoneenter(currentzonecode)


func rest():
	globals.state.backpack.stackables.supply -= 2
	globals.player.health = globals.player.stats.health_max/4
	globals.player.energy = globals.player.stats.energy_max
	globals.resources.food -= 5
	for i in globals.state.playergroup:
		var slave = globals.state.findslave(i)
		slave.health = slave.stats.health_max/4
		slave.energy = slave.stats.energy_max
		slave.stress -= slave.stress/1.5
		globals.resources.food -= 5
	outside.playergrouppanel()
	progress = currentzone.length
	globals.state.restday = globals.resources.day
	zoneenter(currentzone.code)
	get_parent().popup("You set up a small camp and take a rest with your party. ")

func frostfordclearing():
	event('frostforddryad')


#func healeveryone(args = null):
#	var slave
#	var manaused = 0
#	if globals.player.health < globals.player.stats.health_max:
#		globals.player.stats.health_cur = globals.player.stats.health_max
#		manaused += 10
#	for i in globals.state.playergroup:
#		slave = globals.state.findslave(i)
#		if slave.stats.health_cur < slave.stats.health_max:
#			slave.stats.health_cur = slave.stats.health_max
#			manaused += 5
#	manaused = min(manaused, globals.resources.mana)
#	globals.resources.mana -= manaused
#	if manaused > 0:
#		main.popup("You've patched up everyone by using " + str(manaused) +  " mana. ")
#	else:
#		main.popup("Nobody has injuries in your party. ")
#	outside.playergrouppanel()
#
#func castinvig(args = null):
#	main.selectslavelist(false, 'castinvigtarget', self, 'true', false, true)
#
#func castinvigtarget(slave):
#	get_tree().get_current_scene().get_node('spellnode').slave = slave
#	get_tree().get_current_scene().get_node('spellnode').invigorateeffect()
#	zoneenter(currentzone.code)

func areaskip():
	progress = currentzone.length
	zoneenter(currentzone.code)

func enemyencounter():
	var enc
	var encmoveto
	var scouttemp
	var scoutawareness = -1
	var patrol = 'none'
	var text = ''
	var enemyawareness
	enemygroup = {}
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
		for i in currentzone.tags:
			if i in ['wimborn','frostford','gorn','amberguard'] && globals.state.reputation[i] <= -10 && max(10, min(abs(globals.state.reputation[i])/1.2,30)) - scoutawareness/2 > rand_range(0,100):
				if globals.state.reputation[i] <= -25 && rand_range(0,10) > 3:
					buildenemies(i+'guardsmany')
					patrol = 'patrolbig'
					break
				elif globals.state.reputation[i] <= -10:
					buildenemies(i+'guards')
					patrol = 'patrolsmall'
					break
		if enemygroup.empty() == true:
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
					race = globals.weightedrandom(currentzone.races)
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
				race = globals.checkfurryrace(race)
				if i.capturesex.find('any') >= 0:
					sex = 'random'
				else:
					rand = rand_range(0,100)
					for ii in i.capturesex:
						if rand < ii[1]:
							sex = ii[0]
							break
				age = globals.weightedrandom(i.captureagepool)
				origins = globals.weightedrandom(i.captureoriginspool)
				if deeperregion == true && globals.originsarray.find(origins) < 4 && rand_range(0,1) > 0.3:
					origins = globals.originsarray[globals.originsarray.find(origins)+1]
				var slavetemp = globals.slavegen.newslave(race, age, sex, origins)
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
					race = globals.weightedrandom(currentzone.races)
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
				race = globals.checkfurryrace(race)
				age = globals.weightedrandom(slave.agepool)
				origins = globals.weightedrandom(slave.originspool)
				if deeperregion == true && globals.originsarray.find(origins) < 4 && rand_range(0,1) > 0.3:
					origins = globals.originsarray[globals.originsarray.find(origins)+1]
				slave = globals.slavegen.newslave(race, age, sex, origins)
				enemygroup.captured.append(slave)
	enemyawareness = enemygroup.awareness
	if deeperregion == true:
		enemyawareness *= 1.25
	if patrol != 'none':
		text = encounterdictionary(enemygroup.description) + "Your bad reputation around here will certainly lead to a difficult fight..."
		encounterbuttons(patrol)
	elif scoutawareness < enemygroup.awareness:
		ambush = true
		text = encounterdictionary(enemygroup.descriptionambush)
		if enemygroup.special == null:
			encounterbuttons()
		else:
			call(enemygroup.specialambush)
	else:
		ambush = false
		text = encounterdictionary(enemygroup.description)
		if enemygroup.special == null:
			encounterbuttons()
		else:
			call(enemygroup.special)
	outside.maintext.set_bbcode(text)

func buildenemies(enemyname = null):
	if enemyname == null:
		var rand = max(rand_range(0,100)-scout.sagi*3,0) 
		enemygroup = str2var(var2str(enemygrouppools[globals.weightedrandom(currentzone.enemies)]))
	else:
		enemygroup = str2var(var2str(enemygrouppools[enemyname]))
	var tempunits = str2var(var2str(enemygroup.units))
	enemygroup.units = []
	for i in tempunits:
		var count = round(rand_range(i[1], i[2]))
		if deeperregion:
			count = round(count * rand_range(1.2,1.6))
		while count >= 1:
			enemygroup.units.append(str2var(var2str(enemypool[i[0]])))
			count -= 1


func encounterbuttons(state = null):
	var array = []
	if state == null:
		if ambush == false:
			array.append({name = "Attack",function = "enemyfight"})
			array.append({name = "Leave", function = "enemyleave"})
		else:
			array.append({name = "Fight",function = "enemyfight"})
			#if currentzone.tags.find('noreturn') < 0:
			#	array.append({name = "Escape", function = "enemyleave"})
	elif state in ['patrolsmall', 'patrolbig']:
		array.append({name = "Fight",function = "enemyfight"})
		var dict = {}
		if state == 'patrolsmall':
			dict = {name = "Bribe with 100 gold", args = 100, function = 'patrolbribe'}
			if globals.resources.gold < 100 :
				dict.disabled = true
		elif state == 'patrolbig':
			dict = {name = "Bribe with 300 gold", args = 300, function = 'patrolbribe'}
			if globals.resources.gold < 300 :
				dict.disabled = true
		array.append(dict)
	outside.buildbuttons(array, self)

func patrolbribe(sum):
	var array = []
	globals.resources.gold -= sum
	array.append({name = "Leave", function = "enemyleave"})
	outside.maintext.set_bbcode("You bribe Patrol's leader and hastily escape from the scene. ")
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
var enemyloot = {stackables = {}, unstackables = []}

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
	enemyloot = {stackables = {}, unstackables = []}
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
			var bonus = 1
			if ranger == true:
				bonus += 0.5
			if deeperregion:
				bonus += 0.25
			chance = chance*bonus
			if rand_range(0,100) <= chance: 
				if i == 'gold':
					goldearned += round(rand_range(unit.rewardgold[0], unit.rewardgold[1]))
				else:
					if globals.itemdict.has(i):
						var item = globals.itemdict[i]
						if item.type != 'gear':
							if enemyloot.stackables.has(item.code):
								enemyloot.stackables[item.code] += 1
							else:
								enemyloot.stackables[item.code] = 1
						else:
							var tempitem = get_parent().get_node("itemnode").createunstackable(item.code)
							enemyloot.unstackables.append(tempitem)
		expearned += unit.rewardexp
	if deeperregion:
		expearned *= 1.2
	expearned = round(expearned)
	globals.resources.gold += goldearned
	text += '\nYou have received a total sum of [color=yellow]' + str(round(goldearned)) +'[/color] pieces of gold and [color=aqua]' + str(expearned) + '[/color] experience points. \n'
	globals.player.xp += round(expearned/(globals.state.playergroup.size()+1))
	for i in globals.state.playergroup:
		var slave = globals.state.findslave(i)
		slave.xp += round(expearned/(globals.state.playergroup.size()+1))
		if slave.levelupreqs.has('code') && slave.levelupreqs.code == 'wincombat':
			slave.levelup()
			text += slave.dictionary("[color=green]Your decisive win inspired $name, and made $him unlock new potential. \n")
		if slave.health > slave.stats.health_max/1.3:
			slave.cour += rand_range(1,3)
	
	
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
	buildcapturelist()
	checkoptionsbutton()
	if !enemyloot.stackables.empty() || enemyloot.unstackables.size() >= 1:
		get_node("winningpanel/lootpanel").set_hidden(false)
		builditemlists()
	else:
		get_node("winningpanel/lootpanel").set_hidden(true)
	
	if globals.state.sidequests.cali == 18 && defeated.names.find('Bandit') >= 0 && currentzone.code == 'forest':
		main.popup("One of the defeated bandits in exchange for their life reveal location of their camp you've been in search for. ")
		globals.state.sidequests.cali = 19

func buildcapturelist():
	var winpanel = main.get_node("explorationnode/winningpanel")
	for i in get_node("winningpanel/ScrollContainer/VBoxContainer").get_children():
		i.free() if i.get_name() != 'Button' else print()
	for i in range(0, defeated.units.size()):
		var newbutton = winpanel.get_node("ScrollContainer/VBoxContainer/Button").duplicate()
		winpanel.get_node("ScrollContainer/VBoxContainer").add_child(newbutton)
		newbutton.set_hidden(false)
		newbutton.get_node("capture").connect("pressed",self,'captureslave', [defeated.units[i]])
		if !globals.state.backpack.stackables.has('rope') || globals.state.backpack.stackables.rope < 1:
			newbutton.get_node('capture').set_disabled(true)
		newbutton.get_node("Label").set_text(defeated.names[i] + ' ' + defeated.units[i].sex+ ' ' + defeated.units[i].age + ' ' + defeated.units[i].race)
		newbutton.connect("pressed", self, 'defeatedselected', [defeated.units[i]])
		newbutton.get_node("choice").set_meta('slave', defeated.units[i])
		newbutton.get_node("mindread").connect("pressed",self,'mindreadslave', [defeated.units[i]])
		if globals.resources.mana < globals.spelldict.mindread.manacost && globals.spelldict.mindread.learned:
			newbutton.get_node('mindread').set_disabled(true)
		newbutton.get_node("choice").add_to_group('winoption')
		newbutton.get_node("choice").connect("item_selected",self, 'defeatedchoice', [defeated.units[i], newbutton.get_node("choice")])

func mindreadslave(slave):
	globals.get_tree().get_current_scene().get_node("spellnode").slave = slave
	globals.get_tree().get_current_scene().get_node("spellnode").mindreadeffect()
	buildcapturelist()

func captureslave(slave):
	var location
	globals.state.backpack.stackables.rope -= 1
	if globals.state.backpack.stackables.rope <= 0:
		globals.state.backpack.stackables.erase('rope')
	var effect = globals.effectdict.captured
	var dict = {'slave':0.7, 'poor':1,'commoner':1.2,"rich": 2, "noble": 4}
	effect.duration = round((4 + (slave.conf+slave.cour)/20) * dict[slave.origins])
	slave.add_effect(effect)
	if slave.race in ['Lamia','Arachna','Harpy','Nereid','Slime','Scylla','Dryad','Fairy']:
		slave.add_trait(globals.origins.trait('Uncivilized'))
	globals.state.capturedgroup.append(slave)
	if defeated.names[defeated.units.find(slave)] == 'Captured':
		if currentzone.tags.find("wimborn") >= 0:
			location = 'wimborn'
		elif currentzone.tags.find("frostford") >= 0:
			location = 'frostford'
		elif currentzone.tags.find("gorn") >= 0:
			location = 'gorn'
		elif currentzone.tags.find("amberguard") >= 0:
			location = 'amberguard'
		globals.state.reputation[location] -= 1
	defeated.names.remove(defeated.units.find(slave))
	defeated.units.erase(slave)
	buildcapturelist()
	builditemlists()

func builditemlists():
	var newbutton
	var tempitem
	for i in get_node("winningpanel/lootpanel/backpack/VBoxContainer").get_children()+get_node("winningpanel/lootpanel/enemyloot/VBoxContainer").get_children():
		if i.get_name() != "Button":
			i.set_hidden(true)
			i.queue_free()
	for i in enemyloot.stackables:
		tempitem = globals.itemdict[i]
		newbutton = get_node("winningpanel/lootpanel/enemyloot/VBoxContainer/Button").duplicate()
		get_node("winningpanel/lootpanel/enemyloot/VBoxContainer").add_child(newbutton)
		newbutton.set_hidden(false)
		newbutton.get_node("amount").set_text(str(enemyloot.stackables[i]))
		if tempitem.icon != null:
			newbutton.get_node("image").set_texture(tempitem.icon)
		newbutton.connect("pressed",self,'moveitemtobackpack',[newbutton])
		newbutton.set_meta("item", tempitem)
		newbutton.connect("mouse_enter", self, 'itemtooltip', [tempitem])
		newbutton.connect("mouse_exit", self, 'itemtooltiphide')
	for i in enemyloot.unstackables:
		newbutton = get_node("winningpanel/lootpanel/enemyloot/VBoxContainer/Button").duplicate()
		get_node("winningpanel/lootpanel/enemyloot/VBoxContainer").add_child(newbutton)
		newbutton.set_hidden(false)
		if i.icon != null:
			newbutton.get_node("image").set_texture(load(i.icon))
		newbutton.connect("pressed",self,'moveitemtobackpack',[newbutton])
		newbutton.set_meta("item", i)
		newbutton.get_node("amount").set_hidden(true)
		newbutton.connect("mouse_enter", self, 'itemtooltip', [i])
		newbutton.connect("mouse_exit", self, 'itemtooltiphide')
	
	
	
	for i in globals.state.backpack.stackables:
		tempitem = globals.itemdict[i]
		newbutton = get_node("winningpanel/lootpanel/backpack/VBoxContainer/Button").duplicate()
		get_node("winningpanel/lootpanel/backpack/VBoxContainer").add_child(newbutton)
		newbutton.set_hidden(false)
		newbutton.get_node("amount").set_text(str(globals.state.backpack.stackables[i]))
		if tempitem.icon != null:
			newbutton.get_node("image").set_texture(tempitem.icon)
		newbutton.connect("pressed",self,'moveitemtoenemy',[newbutton])
		newbutton.set_meta("item", tempitem)
		newbutton.connect("mouse_enter", self, 'itemtooltip', [tempitem])
		newbutton.connect("mouse_exit", self, 'itemtooltiphide')
	for i in globals.state.backpack.unstackables:
		newbutton = get_node("winningpanel/lootpanel/backpack/VBoxContainer/Button").duplicate()
		get_node("winningpanel/lootpanel/backpack/VBoxContainer").add_child(newbutton)
		newbutton.set_hidden(false)
		newbutton.get_node("amount").set_hidden(true)
		if i.icon != null:
			newbutton.get_node("image").set_texture(load(i.icon))
		newbutton.connect("pressed",self,'moveitemtoenemy',[newbutton])
		newbutton.set_meta("item", i)
		newbutton.connect("mouse_enter", self, 'itemtooltip', [i])
		newbutton.connect("mouse_exit", self, 'itemtooltiphide')
	calculateweight()

func calculateweight():
	var slave
	var tempitem
	var weight = globals.state.calculateweight()
	
	get_node("winningpanel/lootpanel/weightmeter/Label").set_text("Weight: " + str(weight.currentweight) + '/' + str(weight.maxweight))
	get_node("winningpanel/lootpanel/weightmeter/").set_val((weight.currentweight*10/max(weight.maxweight,1)*10))
	if weight.currentweight > weight.maxweight:
		get_node("winningpanel/confirmwinning").set_tooltip("Reduce carry weight before proceeding")
		get_node("winningpanel/confirmwinning").set_disabled(true)
	else:
		get_node("winningpanel/confirmwinning").set_tooltip("")
		get_node("winningpanel/confirmwinning").set_disabled(false)

func moveitemtobackpack(button):
	var item = button.get_meta('item')
	if item.has('owner') == false:
		enemyloot.stackables[item.code] -= 1
		if enemyloot.stackables[item.code] <= 0:
			enemyloot.stackables.erase(item.code)
		if globals.state.backpack.stackables.has(item.code):
			globals.state.backpack.stackables[item.code] += 1
		else:
			globals.state.backpack.stackables[item.code] = 1
	else:
		globals.state.backpack.unstackables.append(item)
		enemyloot.unstackables.erase(item)
	itemtooltiphide()
	builditemlists()

func moveitemtoenemy(button):
	var item = button.get_meta('item')
	if item.has('owner') == false:
		if enemyloot.stackables.has(item.code):
			enemyloot.stackables[item.code] += 1
		else:
			enemyloot.stackables[item.code] = 1
		globals.state.backpack.stackables[item.code] -= 1
		if globals.state.backpack.stackables[item.code] <= 0:
			globals.state.backpack.stackables.erase(item.code)
	else:
		enemyloot.unstackables.append(item)
		globals.state.backpack.unstackables.erase(item)
	itemtooltiphide()
	builditemlists()

func itemtooltip(item):
	var text = '[center]'+item.name + '[/center]\n' +item.description 
	if item.has('weight'):
		text += "\n\nWeight: [color=yellow]" + str(item.weight)+"[/color]"
	if item.has('owner'):
		if item.effects.size() > 0:
			text += "\n\n[color=green]Effects: [/color]"
			for k in item.effects:
				text += "\n" + k.descript
	globals.showtooltip(text)

func itemtooltiphide():
	globals.hidetooltip()


func defeatedselected(slave):
	get_tree().get_current_scene().popup(slave.description_small(true))
#	var winpanel = main.get_node("explorationnode/winningpanel")
#	winpanel.get_node("defeateddescript").set_bbcode(slave.description_small(true))
#	if globals.spelldict.mindread.learned == true:
#		winpanel.get_node("defeatedmindread").set_hidden(false)
#		winpanel.get_node("defeateddescript").set_meta('slave', slave)
#		if globals.resources.mana >= globals.spelldict.mindread.manacost:
#			winpanel.get_node("defeatedmindread").set_disabled(false)
#		else:
#			winpanel.get_node("defeatedmindread").set_disabled(true)
#	else:
#		winpanel.get_node("defeatedmindread").set_hidden(true)

func defeatedchoice(ID, slave, node):
	checkoptionsbutton()
	defeated.select[defeated.units.find(slave)] = ID




func checkoptionsbutton():
	var counter = 0
	var winpanel = main.get_node("explorationnode/winningpanel")
	var text = ''
	
	for i in get_tree().get_nodes_in_group('winoption'):
		if i.get_item_text(i.get_selected()) == 'Capture':
			counter += 1
	text = "Defeated and Captured | Free ropes left: "
	text += str(globals.state.backpack.rope) if globals.state.backpack.has('rope') else '0'
	winpanel.get_node("Label").set_text(text)
	if globals.itemdict.rope.amount < counter:
		for i in get_tree().get_nodes_in_group('winoption'):
			i.set_item_disabled(1, true)
	else:
		for i in get_tree().get_nodes_in_group('winoption'):
			i.set_item_disabled(1, false)





func _on_confirmwinning_pressed(secondary = false): #0 leave, 1 capture, 2 rape, 3 kill
	var text = ''
	var selling = false
	var sellyourself = false
	var orgy = false
	var orgyarray = []
	var location
	var reward = false
	if currentzone.tags.find("wimborn") >= 0:
		location = 'wimborn'
	elif currentzone.tags.find("frostford") >= 0:
		location = 'frostford'
	elif currentzone.tags.find("gorn") >= 0:
		location = 'gorn'
	elif currentzone.tags.find("amberguard") >= 0:
		location = 'amberguard'
	for i in range(0, defeated.units.size()):
		if defeated.faction[i] == 'stranger' && defeated.names[i] != "Captured":
			globals.state.reputation[location] -= 1
		if defeated.select[i] == 0:
			if defeated.names[i] != 'Captured':
				text += defeated.units[i].dictionary("You have left $race $child alone.\n")
			else:
				text += defeated.units[i].dictionary("You have released $race $child and set $him free.\n")
				globals.state.reputation[location] += rand_range(1,2)
				if rand_range(0,100) < 25 + globals.state.reputation[location]/3 && reward == false:
					reward = true
					rewardslave = defeated.units[i]
					rewardslavename = defeated.names[i]
		elif defeated.select[i] == 1:
			if !defeated.faction[i] in ['bandit','monster']:
				globals.state.reputation[location] -= rand_range(0,1)
			orgy = true
			orgyarray.append(defeated.units[i])
		elif defeated.select[i] == 2:
			if !defeated.faction[i] in ['monster','bandit']:
				globals.state.reputation[location] -= 3
			elif defeated.faction[i] == 'bandit':
				globals.state.reputation[location] -= 1
			if defeated.faction[i] == 'elf':
				globals.state.reputation.amberguard -= 3
			text += defeated.names[i] + " has been killed. \n"
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
	if currentzone.tags.find("wimborn") >= 0:
		location = 'wimborn'
	elif currentzone.tags.find("frostford") >= 0:
		location = 'frostford'
	elif currentzone.tags.find("gorn") >= 0:
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




func wimborn():
	main.get_node('outside').wimborn()

func gorn():
	outside.location = 'gorn'
	outside.get_node("charactersprite").set_hidden(true)
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
	if globals.state.location == 'gorn':
		array.append({name = "Return to Mansion",function = 'mansion'})
	outside.buildbuttons(array,self)

func mansion():
	get_parent().mansion()

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
	var sprite = [['yrisnormal', 'pos1', 'opac']]
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
	main.dialogue(state, self, text, buttons, sprite)

func gornyrisleave(args):
	zoneenter('gorn')
	main.close_dialogue()

func gornyrisaccept(stage):
	var text = ''
	var state = false
	var buttons = []
	var sprite = []
	if stage == 0:
		sprite = [['yrisnormal', 'pos1']]
		text = globals.questtext.GornYrisRefuse
		buttons.append({text = "Continue", function = 'gornyrisleave', args = null})
	elif stage == 1:
		sprite = [['yrisnormalnaked', 'pos1']]
		globals.charactergallery.yris.scenes[0].unlocked = true
		globals.charactergallery.yris.nakedunlocked = true
		text = globals.questtext.GornYrisAccept1
		globals.resources.gold -= 200
		globals.resources.mana += 15
		globals.state.sidequests.yris = 2
		state = true
	elif stage == 2:
		sprite = [['yrisnormalnaked', 'pos1']]
		text = globals.questtext.GornYrisAcceptRepeat
		state = true
		globals.resources.gold -= 200
		globals.resources.mana += 15
	elif stage == 3:
		sprite = [['yrisnormalnaked', 'pos1']]
		text = globals.questtext.GornYrisAccept2
		globals.charactergallery.yris.scenes[1].unlocked = true
		globals.state.sidequests.yris += 1
		globals.itemdict.deterrentpot.amount -= 1
		state = true
		globals.resources.mana += 25
	elif stage == 4:
		sprite = [['yrisshocknaked', 'pos1']]
		globals.charactergallery.yris.scenes[2].unlocked = true
		globals.itemdict.deterrentpot.amount -= 1
		text = globals.questtext.GornYrisAccept3
		buttons.append({text = "Reveal everything", function = 'gornyrisaccept', args = 5})
		buttons.append({text = "Demand the gold", function = 'gornyrisaccept', args = 6})
	elif stage == 5:
		sprite = [['yrisnormalnaked', 'pos1']]
		text = globals.questtext.GornYrisReveal
		buttons.append({text = "Offer Yris to work for you", function = 'gornyrisaccept', args = 8})
		buttons.append({text = "Demand the gold", function = 'gornyrisaccept', args = 7})
	elif stage == 6:
		sprite = [['yrisaltnaked', 'pos1']]
		text = globals.questtext.GornYrisTakeGold
		globals.state.sidequests.yris = 100
		globals.resources.gold += 1000
		text += "\n\nIn the end you get the gold you asked for, but never seen Yris again. "
		state = true
	elif stage == 7:
		sprite = [['yrisaltnaked', 'pos1']]
		text = globals.questtext.GornYrisTakeGold2
		globals.state.sidequests.yris = 100
		text += "\n\nIn the end you get the gold you asked for, but never seen Yris again. "
		globals.resources.gold += 1000
		state = true
	elif stage == 8:
		state = true
		sprite = [['yrisnormalnaked', 'pos1']]
		text = globals.questtext.GornYrisHire
		globals.state.sidequests.yris += 1
		var slave = globals.slavegen.newslave('Beastkin Cat', 'adult', 'female', 'commoner')
		slave.name = 'Yris'
		slave.unique = 'Yris'
		slave.surname = ''
		slave.tits.size = 'big'
		slave.ass = 'average'
		slave.beautybase = 72
		slave.hairlength = 'neck'
		slave.height = 'average'
		slave.haircolor = 'blond'
		slave.eyecolor = 'blue'
		slave.eyeshape = 'slit'
		slave.skin = 'fair'
		slave.furcolor = 'orange_white'
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
		slave.imageportait = "res://files/images/yris/yrisportrait.png"
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
	main.dialogue(state, self, text, buttons, sprite)

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
	if globals.state.sidequests.ayneris == 4:
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
	if globals.state.location == 'frostford':
		array.append({name = "Return to Mansion",function = 'mansion'})
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
	array.append({name = "Leave to the Forest", function = 'zoneenter', args = 'forest'})
	array.append({name = "Leave to the Eerie Grove", function = 'zoneenter', args = 'grove'})
	if globals.state.sidequests.chloe == 15:
		globals.state.sidequests.chloe = 16
		outside.maintext.set_bbcode("You lead Chloe back to her house and give her some time to rest and clean herself.")
		
	outside.buildbuttons(array,self)

func shaliqshop():
	outside.shopinitiate('shaliqshop')

func umbra():
	if globals.state.umbrafirstvisit == true:
		globals.state.umbrafirstvisit = false
		outside.maintext.set_bbcode(outside.maintext.get_bbcode() + "\n\n" + globals.questtext.UmbraFirstVisit)
	var array = []
	outside.location = 'umbra'
	array.append({name = "Visit Black Market", function = 'umbrashop'})
	array.append({name = "Buy Slaves", function = 'umbrabuyslaves'})
	array.append({name = "Sell Servants", function = 'umbrasellslaves'})
	array.append({name = "Return to Mansion", function = 'mansionreturn'})
	outside.buildbuttons(array,self)

func umbrashop():
	outside.shopinitiate('blackmarket')

func umbrabuyslaves():
	outside.mindread = false
	outside.slavearray = globals.guildslaves.umbra
	outside.slaveguildslaves()

func umbrasellslaves():
	outside.sellslavelist('umbra')
	outside.sellslavelocation = 'umbra'

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
	if enemygroup.units.size() <= 1 && enemygroup.units[0].capture != null:
		string = enemygroup.units[0].capture.dictionary(string)
	string = string.replace('$scoutname', scout.dictionary('$name'))
	return string

func unloadgroup():
	for i in globals.state.capturedgroup:
		globals.slaves = i
		if globals.count_sleepers().jail < globals.state.mansionupgrades.jailcapacity:
			i.sleep = 'jail'
			get_parent().infotext(i.dictionary("[color=green]$name has been moved to jail.[/color]"))
		else:
			get_parent().infotext(i.dictionary("[color=yellow]With no free cells in jail $name has been assigned to communal room.[/color]"))
	for i in globals.state.backpack.stackables:
		var item = globals.itemdict[i]
		if item.type in ['ingredient']:
			item.amount += globals.state.backpack.stackables[i]
			globals.state.backpack.stackables.erase(i)