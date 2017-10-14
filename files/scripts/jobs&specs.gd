extends Node

var jobdict = {
rest = {
code = 'rest',
name = "Rest",
type = 'basic',
description = "$name will rest for today",
workline = "$name will be taking a rest for today.",
reqs = 'true',
unlockreqs = 'true',
maxnumber = 0,
order = 1,
location = 'mansion',
tags = ['mansion'],
},forage = {
code = 'forage',
name = 'Forage',
type = 'basic',
description = "$name will be looking around for edible berries and fungi.\n\n[color=yellow]Efficiency grows with Wit. Penalty affected by Courage. Strength and Endurance affect carrying weight. [/color]",
workline = '$name will be foraging at the nearby woods.',
reqs = 'true',
unlockreqs = 'true',
maxnumber = 0,
order = 2,
location = 'wild',
tags = ['wild','physical'],
},hunt = {
code = 'hunt',
name = "Hunt",
type = 'basic',
description = '$name will try hunting wild animals.\n\n[color=yellow]Efficiency grows Agility and Endurance. Penalty affected by Courage. Strength and Endurance affect carrying weight. [/color]',
workline = '$name will be hunting at the nearby woods.',
reqs = 'true',
unlockreqs = 'true',
maxnumber = 0,
order = 3,
location = 'wild',
tags = ['wild','physical'],
},library = {
code = 'library',
name = "Library",
type = 'basic',
description = '$name will manage the library and study.\n\n[color=yellow]Provides experience based on Wit and Library level.\nEffeciency decreases with level.[/color]',
workline = "$name will be studying at the library.",
reqs = 'true',
unlockreqs = 'true',
maxnumber = 0,
order = 6,
location = 'mansion',
tags = ['mansion'],
},cooking = {
code = 'cooking',
name = "Cooking",
type = 'basic',
description = '$name will cook for the other residents and buy food from market when it runs short.\n\n[color=yellow]Requires grade of a [color=aqua]Poor[/color] or higher. \n\nEfficiency grows with Agility and Wit. [/color]',
workline = "$name will be cooking for residents.",
reqs = 'globals.originsarray.find(globals.currentslave.origins) >= 1',
unlockreqs = 'true',
maxnumber = 1,
order = 5,
location = 'mansion',
tags = ['mansion','physical'],
},maid = {
code = 'maid',
name = "Cleaning",
type = 'basic',
description = '$name will dedicate $his time to tidying your mansion. \n\n[color=yellow]Efficiency grows with Agility and Endurance.[/color]',
workline = "$name will spend $his day dedicated to cleaning your mansion.",
reqs = 'true',
unlockreqs = 'true',
maxnumber = 0,
order = 4,
location = 'mansion',
tags = ['mansion','physical'],
},nurse = {
code = 'nurse',
name = "Nurse",
type = 'basic',
description = '$name will helps residents maintain and recover their health.\n\n[color=yellow]Efficiency grows with Wit and Magic Affinity.[/color]',
workline = "$name will be watching over residents' health.",
reqs = 'true',
unlockreqs = 'true',
maxnumber = 1,
order = 7,
location = 'mansion',
tags = ['mansion'],
},whorewimborn = {
code = 'whorewimborn',
name = "W - Prostitution",
type = 'sexual',
description = "$name will be assigned to town's brothel as a common whore.\n\n[color=yellow]Efficiency grows with Charm, Endurance, Beauty and basic sexual actions. \n\nRequires unlocked sex actions for sufficient performance.[/color]",
workline = "$name will whore $himself at the brothel.",
reqs = "true",
unlockreqs = 'globals.state.sidequests.brothel >= 2',
maxnumber = 0,
order = 10,
location = 'wimborn',
tags = ['sex', 'wimborn', 'social'],
},
escortwimborn = {
code = 'escortwimborn',
name = "W - Escort",
type = 'sexual',
description = "$name will be assigned to town's brothel as a high class whore for rich men. \n\n[color=yellow]Requires grade of a [color=aqua]Commoner[/color] or higher. \n\nEfficiency grows with Charm, Confidence, Beauty and your reputation. [/color]",
workline = "$name will be earning money by escorting rich people.",
reqs = "globals.originsarray.find(globals.currentslave.origins) >= 2",
unlockreqs = 'globals.state.sidequests.brothel >= 2',
maxnumber = 0,
order = 11,
location = 'wimborn',
tags = ['sex', 'wimborn', 'social'],
},fucktoywimborn = {
code = 'fucktoywimborn',
name = "W - Exotic Whore",
type = 'sexual',
description = "$name will be used by the most deviant men in brothel. \n\n[color=yellow]Efficiency grows with Courage, Endurance, Beauty, and advanced sex actions. \n\nRequires unlocked advanced sex actions for sufficient performance. [/color]",
workline = "$name will be earning money by offering $his body for all sorts of deviant plays.",
reqs = "true",
unlockreqs = 'globals.state.sidequests.brothel >= 2',
maxnumber = 0,
order = 12,
location = 'wimborn',
tags = ['sex', 'wimborn', 'social'],
},fucktoy = {
code = 'fucktoy',
name = "U - Fucktoy",
type = 'sexual',
description = "$name will be subjugated and abused by all sorts of criminals at Umbra without $his consent. \n\n[color=yellow]Builds obedience in exchange for mental degeneration. Income is based on your negative reputation. [/color]",
workline = "$name will be subjugated and abused by all sorts of criminals at Umbra without $his consent. ",
reqs = "true",
unlockreqs = 'globals.state.portals.umbra.enabled == true',
maxnumber = 0,
order = 12,
location = 'umbra',
tags = ['sex', 'umbra'],
},storewimborn = {
code = 'storewimborn',
name = "W - Market",
type = 'social',
description = "$name will attempt to sell excessive supplies (above 10) or will try to make some profit by speculating with cheap products. \n\n[color=yellow]Efficiency grows with Charm, Wit and Grade. [/color]",
workline = "$name will be working at town's market.",
reqs = 'true',
unlockreqs = 'true',
maxnumber = 0,
order = 8,
location = 'wimborn',
tags = ['wimborn','vocal', 'social','physical'],
},assistwimborn = {
code = 'assistwimborn',
name = "W - Mage Order Assistant",
type = 'social',
description = "$name will work as a staff member on various guild assignments. \n\n[color=yellow]Requires grade of a [color=aqua]Commoner[/color] or higher. \n\nEfficiency grows with Magic Affinity, Wits and your reputation.[/color]",
workline = "$name will be working at Mage's Order.",
reqs = "globals.originsarray.find(globals.currentslave.origins) >= 2 && globals.currentslave.traits.has('Mute') == false ",
unlockreqs = 'globals.state.rank >= 2',
maxnumber = 0,
order = 10,
location = 'wimborn',
tags = ['wimborn','social','physical'],
},artistwimborn = {
code = 'artistwimborn',
name = "W - Public Entertainer",
type = 'social',
description = "$name will earn money by doing dances, shows and other stage performances. \n\n[color=yellow]Requires grade of a [color=aqua]Commoner[/color] or higher. \n\nEfficiency grows with Charm, Courage, Agility and beauty.[/color]",
workline = "$name will be working as public entertainer.",
reqs = "globals.originsarray.find(globals.currentslave.origins) >= 2 && globals.currentslave.traits.has('Mute') == false",
unlockreqs = 'true',
maxnumber = 0,
order = 9,
location = 'wimborn',
tags = ['wimborn','vocal','social'],
},lumberer = {
code = 'lumberer',
name = "F - Lumberer",
type = 'social',
description = "$name will be cutting down trees near Frostford for a woodcutting establishment. [color=yellow]\n\nEfficiency grows with Strength and Endurance.[/color]",
workline = "$name will be cutting down trees near Frostford.",
reqs = "true",
unlockreqs = 'true',
maxnumber = 0,
order = 9,
location = 'frostford',
tags = ['frostford','physical'],
},ffprostitution = {
code = 'ffprostitution',
name = "F - Prostitution",
type = 'sexual',
description = "$name will be serving lone customers with $his body at Frostford. \n\n[color=yellow]\n\nEfficiency grows with Charm and beauty.[/color]",
workline = "$name will be serving lone customers with $his body at Frostford.",
reqs = "globals.currentslave.tags.find('nosex') < 0",
unlockreqs = 'true',
maxnumber = 0,
order = 9,
location = 'frostford',
tags = ['sex','frostford','social'],
},guardian = {
code = 'guardian',
name = "G - Guardian",
type = 'social',
description = "$name will be patrolling streets with Gorn's city guard. \n\n[color=yellow]Requires grade of a [color=aqua]Poor[/color] or higher. \n\nEfficiency grows with Strength, Courage.[/color]",
workline = "$name will be patrolling streets with Gorn's city guard.",
reqs = "globals.originsarray.find(globals.currentslave.origins) >= 1 && globals.currentslave.traits.has('Mute') == false && globals.currentslave.traits.has('Mute') == false ",
unlockreqs = 'true',
maxnumber = 0,
order = 9,
location = 'gorn',
tags = ['gorn','social'],
},research = {
code = 'research',
name = "U - Research Subject",
type = 'social',
description = "$name will be used in harsh experiments in Umbra. \n\n[color=yellow]\n\nWill earn a lot of money, but quickly deteriorate physical and mental health.[/color] \n[color=red]Possess number of risks leading to bad events up to losing a servant. [/color]",
workline = "$name will be used in harsh experiments in Umbra.",
reqs = "true",
unlockreqs = 'globals.state.portals.umbra.enabled == true',
maxnumber = 0,
order = 9,
location = 'umbra',
tags = ['umbra'],
},slavecatcher = {
code = 'slavecatcher',
name = "G - Slave Catcher",
type = 'social',
description = "$name will be joining slaver parties and help catching and transporting slaves. \n\n[color=yellow]Requires grade of a [color=aqua]Poor[/color] or higher. \n\nEfficiency grows with Agility, Strength and Courage.[/color]",
workline = "$name will be joining slaver parties and help catching and transporting slaves at Gorn.",
reqs = "globals.originsarray.find(globals.currentslave.origins) >= 1",
unlockreqs = 'true',
maxnumber = 0,
order = 9,
location = 'gorn',
tags = ['gorn','social','physical'],
},headgirl = {
code = 'headgirl',
name = "Headgirl",
type = 'social',
description = "$name will watch over other servants improving their behavior. \n\n[color=yellow]Requires grade of a [color=aqua]Rich[/color] or higher. ",
workline = "$name will be directing and consulting other residents.",
reqs = "globals.originsarray.find(globals.currentslave.origins) >= 3 && globals.currentslave.traits.has('Mute') == false ",
unlockreqs = 'globals.slaves.size() >= 8',
maxnumber = 1,
order = 12,
location = 'mansion',
tags = ['mansion','management'],
},jailer = {
code = 'jailer',
name = "Jailer",
type = 'social',
description = "$name will be feeding and watching over your prisoners.\n\n[color=yellow]Requires grade of a [color=aqua]Poor[/color] or higher. ",
workline = "$name will be managing prisoners.",
reqs = 'globals.originsarray.find(globals.currentslave.origins) >= 1',
unlockreqs = 'true',
maxnumber = 1,
order = 12,
location = 'mansion',
tags = ['mansion','management'],
},farmmanager = {
code = 'farmmanager',
name = "Farm Manager",
type = 'basic',
description = "$name will be managing your farm and slaves assigned to it. \n\n[color=yellow]Requires grade of a [color=aqua]Commoner[/color] or higher. ",
workline = "$name will be looking over your farm and collect its' income.",
reqs = 'globals.originsarray.find(globals.currentslave.origins) >= 2',
unlockreqs = 'globals.state.farm >= 3',
maxnumber = 1,
order = 13,
location = 'mansion',
tags = ['mansion','management'],
},labassist = {
code = 'labassist',
name = "Laboratory Assistant",
type = 'basic',
description = "$name will be helping out and managing your laboratory operations.\n\n[color=yellow]Requires grade of a [color=aqua]Commoner[/color] or higher. ",
workline = "$name will be assisting you at the laboratory.",
reqs = 'globals.originsarray.find(globals.currentslave.origins) >= 2',
unlockreqs = 'globals.state.mansionupgrades.mansionlab >= 1',
maxnumber = 1,
order = 14,
location = 'mansion',
tags = ['mansion'],
},

}

var specs = {
geisha = {
name = "Geisha",
code = 'geisha',
descript = "A Geisha is an adept of love. They are trained to please both men and women, not only with sex but also in companionship. They are genuinely pleasant to have around as they try their best to feel what potential partner might want. ",
descriptbonus = "+25% to escort and prostitution, no penalties for same-sex, opposite dominance or perverted actions",
descriptreqs = "Charm 75+, Beauty 60+, grade Commoner or above, unlocked sex.",
reqs = "slave.charm >= 75 && slave.beautybase >= 60 && !slave.origins in ['slave','poor'] && slave.sexuals.unlocked == true"
},
ranger = {
name = "Ranger",
code = 'ranger',
descript = "Rangers are quick and resourceful individuals who are at home in any natural environment.. Not only do they have an eye for better opportunities, but also can spot richer prey. ",
descriptbonus = "+50% drop rate from combat encounters, forage and hunt efficiency + 25%, scouting bonus",
descriptreqs = "Wit 75+, Endurance 3+.",
reqs = "slave.wit >= 75 && slave.send >= 3"
},
executor = {
name = "Executor",
code = 'executor',
descript = "Executors are trained to work with people in a most efficient way. Their commands are always straight and on-point and their attitude is met with respect. ",
descriptbonus = "Management-related tasks ignore confidence (will always count as 100). Obedience can't drop above 50.",
descriptreqs = "Conf 75+, Wit 50+, grade Rich or above",
reqs = "slave.conf >= 75 && slave.wit >= 50 && slave.origins in ['rich', 'noble']"
},
bodyguard = {
name = "Bodyguard",
code = 'bodyguard',
descript = "A Bodyguard is trained to put their life before their master's. Not only they are capable of taking down threats on their own, but are substantially more resilient. ",
descriptbonus = "Bonus armor and health, 'Protect' action doubles the amount of reduced damage.",
descriptreqs = "Courage 60+, agility 3+, strength 4+, loyalty 50+",
reqs = "slave.cour >= 60 && slave.sagi >= 3 && slave.sstr >= 4 && slave.loyal >= 50"
},
assassin = {
name = "Assassin",
code = 'assassin',
descript = "Assassins are trained to act swiftly and surely, when required. They prefer efficiency over show and offence to defence.  ",
descriptbonus = "Speed +5, Damage +5",
descriptreqs = "Agility 5+, Wit 65+",
reqs = "slave.wit >= 65 && slave.sagi >= 5"
},
housekeeper = {
name = "Housekeeper",
code = 'housekeeper',
descript = "Housekeepers are experts at supplying and taking care of the living quarters. ",
descriptbonus = "Will clean the house on stationary jobs (half effect of normal cleaning). Personal daily expenses are cut in half.",
descriptreqs = "None",
reqs = "true"
},
trapper = {
name = "Trapper",
code = 'trapper',
descript = "Trappers are generally common professionals you can find in any slavers party. They are also reasonably well trained in hunting. ",
descriptbonus = "Bonus hunting +20%, 50% chance to automatically capture escaping person, bonus capture rate. ",
descriptreqs = "Wit 50+, Grade: Commoner and above ",
reqs = "slave.wit >= 50 && !slave.origins in ['slave','poor']"
},
nympho = {
name = "Nympho",
code = 'nympho',
descript = "Nymphos devote their life entirely to the lewdness. They are ready for anything and everything and want more. It's common practice to make such slaves into tools and toys by owners. ",
descriptbonus = "Sex actions take only half energy, + 2 mana from sex actions, + 25% to fucktoy, no penalties from any sex activities. ",
descriptreqs = "Grade: Commoner and below, Unlocked sex, Charm and Courage 50+ ",
reqs = "slave.origins in ['slave','poor','commoner'] && slave.sexuals.unlocked == true && slave.cour >= 50 && slave.charm >= 50"
},
merchant = {
name = "Merchant",
code = 'merchant',
descript = "People with a kink for bargains, not only profitable to keep around, but also good at connecting with others. ",
descriptbonus = "Bonus shopping activities, bonus item selling while in party 25% (does not stack). ",
descriptreqs = "Wit and Charm 50+ ",
reqs = "slave.wit >= 50 && slave.charm >= 50"
},
tamer = {
name = "Tamer",
code = 'tamer',
descript = "Tamers are trained to work with wild animals and savagely behaving individuals. By utilizing many simple lessons they even may eventually bring true potential out of those. ",
descriptbonus = "Uncivilized races more obedient and can lose trait while Tamer is resting, managing or working on same occupation. ",
descriptreqs = "Confidence and charm 50+, Grade: Commoner and above",
reqs = "slave.conf >= 50 && slave.charm >= 50 && slave.origins in ['commoner','rich','noble']"
},
}

var leveluprequests = {
weakitem = {reqs = 'true', speech = "you will need a [color=aqua]$item[/color] to unlock $his potential. ", descript = '$name needs a [color=aqua]$item[/color] to advance $his level.  ', execfunc = 'weakitem'},
multitem = {reqs = 'true', speech = "you will need a [color=aqua]$item[/color] to unlock $his potential. ", descript = '$name needs a [color=aqua]$item[/color] to advance $his level.  ', execfunc = 'multitem'},
gearitem = {reqs = 'true', speech = "you will need a [color=aqua]$item[/color] to unlock $his potential. ", descript = '$name needs a [color=aqua]$item[/color] to advance $his level.  ', execfunc = 'gearitem'},
ingreditem = {reqs = 'true', speech = "you will need a [color=aqua]$item[/color] to unlock $his potential. ", descript = '$name needs [color=aqua]$item[/color] to advance $his level. ', execfunc = 'ingreditem'},
vacation = {reqs = 'true', speech = "you should provide $name with [color=aqua]3 free days[/color] to furtherly unlock $his potential.", descript = '$name needs a [color=aqua]vacation[/color] to advance $his level. ', execfunc = 'vacationshort'},
relationship = {reqs = "slave.sexuals.unlocked == false && slave.tags.find('nosex') < 0", speech = "you should unlock [color=aqua]intimacy[/color] with $name to unlock $his potential.", descript = "$name needs to have [color=aqua]intimacy unlocked[/color] to advance $his level. ", execfunc = 'startrelationship'},
wincombat = {reqs = 'true', speech = "you should let $name to [color=aqua]win in a fight[/color] to unlock $his potential.", descript = "$name needs to [color=aqua]win in a fight[/color] to advance $his level. ", execfunc = 'wincombat'},
improvegrade = {reqs = 'globals.originsarray.find(slave.origins) <= 3', speech = "you should raise $name's [color=aqua]grade[/color] to unlock $his potential.", descript = "$name needs to [color=aqua]raise $his grade[/color] to advance $his level. ", execfunc = 'raisegrade'},
specialization = {reqs = 'slave.spec == null', speech = "you should let $name's [color=aqua]to learn specialization[/color] to unlock $his potential.", descript = "$name needs to [color=aqua]learn specialization[/color] to advance $his level. ", execfunc = 'getspec'},
}

var requestsbylevel = {
easy = ['weakitem', 'ingreditem', 'vacation', 'relationship', 'wincombat', 'improvegrade'],
medium = ['multitem','specialization','gearitem','improvegrade'],
}


var weakitemslist = ['aphrodisiac','hairdye', 'hairgrowthpot', 'stimulantpot', 'deterrentpot', 'beautypot']
var gearitemslist = ['clothsundress','clothmaid','clothkimono','clothmiko','clothbutler','underwearlacy','underwearboxers','armorleather','armorchain','weapondagger','weaponsword','accslavecollar','acchandcuffs']
var ingredlist = ['bestialessenceing', 'natureessenceing','taintedessenceing','magicessenceing','fluidsubstanceing']

func vacation(slave):
	slave.away.duration = int(slave.levelupreqs.value)
	globals.get_tree().get_current_scene()._on_mansion_pressed()
	globals.get_tree().get_current_scene().popup(slave.dictionary("You've sent $name on vacation, boosting $his mood with sudden reward. "))
	slave.levelup()

func itemlevelup(slave):
	if globals.itemdict[slave.levelupreqs.value].amount < 1:
		globals.get_tree().get_current_scene().popup(slave.dictionary("Sadly, you have no available " + globals.itemdict[slave.levelupreqs.value].name + " in possession. "))
	else:
		globals.itemdict[slave.levelupreqs.value].amount -= 1
		globals.get_tree().get_current_scene().popup(slave.dictionary("You gift $name " + globals.itemdict[slave.levelupreqs.value].name + ". After returning a surprised look, $he whole-heartedly shows $his gratitude"))
		slave.levelup()

func gearlevelup(slave):
	var item = slave.levelupreqs.value
	var founditem = false
	for i in globals.state.unstackables.values():
		if i.code == item && i.owner == null:
			globals.state.unstackables.erase(i.id)
			founditem = true
			break
	if founditem == true:
		globals.get_tree().get_current_scene().popup(slave.dictionary("You gift $name " + globals.itemdict[slave.levelupreqs.value].name + ". After returning a surprised look, $he whole-heartedly shows $his gratitude"))
		slave.levelup()
	else:
		globals.get_tree().get_current_scene().popup("Sadly, there's no unused [color=aqua]" + globals.itemdict[slave.levelupreqs.value].name + "[/color] in your possessions. ")

func vacationshort(slave):
	var text = slave.dictionary(leveluprequests.vacation.speech)
	slave.levelupreqs = {code = 'vacation', value = '3', speech = leveluprequests.vacation.speech, descript = slave.dictionary(leveluprequests.vacation.descript), button = slave.dictionary('Send $name to vacation'), effect = 'vacation', activate = 'fromtalk'}
	return text

func weakitem(slave):
	var item = globals.itemdict[weakitemslist[rand_range(0,weakitemslist.size())]]
	var text = slave.dictionary(leveluprequests.weakitem.speech)
	text = text.replace('$item', item.name)
	var descript = slave.dictionary(leveluprequests.weakitem.descript).replace('$item', item.name)
	slave.levelupreqs = {code = 'weakitem', value = item.code, speech = text, descript = descript , button = slave.dictionary('Provide $name with $item').replace('$item', item.name), effect = 'itemlevelup', activate = 'fromtalk'}
	return text

func multitem(slave):
	var array = []
	var count = 2
	var item
	var itemnumber
	var itemtext = ''
	var array2 = []
	for i in ingredlist:
		array.append(i)
	while count < array.size():
		array.remove(rand_range(0,array.size()))
	for i in array:
		item = globals.itemdict[i]
		itemnumber = round(rand_range(1,3))
		itemtext += item.name + ': ' + str(itemnumber) + ", "
		array2.append({item.code : itemnumber})
		
	
	var text = slave.dictionary(leveluprequests.multitem.speech)
	text = text.replace('$item', itemtext)
	var descript = slave.dictionary(leveluprequests.multitem.descript).replace('$item', itemtext)
	slave.levelupreqs = {code = 'multitem', value = array2, speech = text, descript = descript , button = slave.dictionary('Provide $name with necessary items'), effect = 'multitemlevelup', activate = 'fromtalk'}
	return text

func multitemlevelup(slave):
	var hasitems = true
	for i in slave.levelupreqs.value:
		for k in i:
			if globals.itemdict[k].amount < i[k]:
				hasitems = false
	if hasitems == false:
		globals.get_tree().get_current_scene().popup("Sadly, you don't have all required items in your possessions. ")
	else:
		for i in slave.levelupreqs.value:
			for k in i:
				globals.itemdict[k].amount -= i[k]
		globals.get_tree().get_current_scene().popup(slave.dictionary("You gift $name assortment of variable items. After returning a surprised look, $he whole-heartedly shows $his gratitude"))
		slave.levelup()

func gearitem(slave):
	var item = globals.itemdict[gearitemslist[rand_range(0,gearitemslist.size())]]
	var text = slave.dictionary(leveluprequests.gearitem.speech)
	text = text.replace('$item', item.name)
	var descript = slave.dictionary(leveluprequests.gearitem.descript).replace('$item', item.name)
	slave.levelupreqs = {code = 'gearitem', value = item.code, speech = text, descript = descript , button = slave.dictionary('Provide $name with $item').replace('$item', item.name), effect = 'gearlevelup', activate = 'fromtalk'}
	return text

func getspec(slave):
	var text = slave.dictionary(leveluprequests.specialization.speech)
	slave.levelupreqs = {code = 'specialization', value = '0', speech = leveluprequests.specialization.speech, descript = slave.dictionary(leveluprequests.specialization.descript), effect = 'specialization', activate = 'action'}
	return text

func ingreditem(slave):
	var ingnumber = 1
	var ingrange = [1,3]
	var inglist = ingredlist
	var finalitems = {}
	var item
	var text = ''
	var temptext = ''
	while ingnumber >= 1:
		ingnumber -= 1
		item = ingredlist[rand_range(0,ingredlist.size())]
		finalitems[item] = round(rand_range(ingrange[0], ingrange[1]))
	for i in finalitems:
		item = globals.itemdict[i]
		temptext += item.name + ": " + str(finalitems[i]) + ", "
	temptext = temptext.substr(0, temptext.length() -2)+ ' '
	text = slave.dictionary(leveluprequests.ingreditem.speech.replace('$item', temptext)) 
	var descript = slave.dictionary(leveluprequests.ingreditem.descript).replace('$item', temptext)
	slave.levelupreqs = {code = 'ingreditem', value = [finalitems], speech = text, descript = descript , button = slave.dictionary('Provide $name with $item').replace('$item', temptext), effect = 'multitemlevelup', activate = 'fromtalk'}
	return text

func startrelationship(slave):
	var text = slave.dictionary(leveluprequests.relationship.speech)
	slave.levelupreqs = {code = 'relationship', value = '0', speech = leveluprequests.relationship.speech, descript = slave.dictionary(leveluprequests.relationship.descript), effect = 'relationship', activate = 'action'}
	return text

func wincombat(slave):
	var text = slave.dictionary(leveluprequests.wincombat.speech)
	slave.levelupreqs = {code = 'wincombat', value = '0', speech = leveluprequests.wincombat.speech, descript = slave.dictionary(leveluprequests.wincombat.descript), effect = 'wincombat', activate = 'action'}
	return text

func raisegrade(slave):
	var text = slave.dictionary(leveluprequests.improvegrade.speech)
	slave.levelupreqs = {code = 'improvegrade', value = '0', speech = leveluprequests.improvegrade.speech, descript = slave.dictionary(leveluprequests.improvegrade.descript), effect = 'improvegrade', activate = 'action'}
	return text

func getrequest(slave):
	var array = []
	if slave.level in [1,2]:
		for i in requestsbylevel.easy:
			if globals.evaluate(leveluprequests[i].reqs) == true:
				array.append(leveluprequests[i])
	else:
		for i in requestsbylevel.medium:
			if globals.evaluate(leveluprequests[i].reqs) == true:
				array.append(leveluprequests[i])
	var request = array[rand_range(0, array.size())]
	var text = call(request.execfunc, slave)
	return text