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
description = "$name will attempt to sell excessive supplies or will try to make some profit by speculating with cheap products. \n\n[color=yellow]Efficiency grows with Charm, Wit and Grade. [/color]",
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
description = "$name will be used in harsh experiments in Umbra. \n\n[color=yellow]\n\nWill earn a lot of money, but quickly deteriorate physical and mental health.[/color] \n[color=#ff4949]Possess number of risks leading to bad events up to losing a servant. [/color]",
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
reqs = "slave.charm >= 75 && slave.beautybase >= 60 && !slave.origins in ['slave','poor'] && slave.consent == true"
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
descriptbonus = "+ 4 Armor, +20% Maximum Health, 'Protect' action doubles the amount of reduced damage.",
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
reqs = "slave.origins in ['slave','poor','commoner'] && slave.consent == true && slave.cour >= 50 && slave.charm >= 50"
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
relationship = {reqs = "slave.consent == false && slave.tags.find('nosex') < 0", speech = "you should unlock [color=aqua]intimacy[/color] with $name to unlock $his potential.", descript = "$name needs to have [color=aqua]intimacy unlocked[/color] to advance $his level. ", execfunc = 'startrelationship'},
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
		if !(i in ['fluidsubstanceing','taintedessenceing'] && globals.state.mainquest < 17):
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
	var finalitems = {}
	var item
	var text = ''
	var temptext = ''
	var itemarray = []
	for i in ingredlist:
		if !(i in ['fluidsubstanceing','taintedessenceing'] && globals.state.mainquest < 17):
			itemarray.append(i)
	while ingnumber >= 1:
		ingnumber -= 1
		item = itemarray[rand_range(0,itemarray.size())]
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



func rest(slave):
	var text = '$name has spent most of the day relaxing.\n'
	slave.health += 10
	slave.stress -= 20
	return {text = text}

func forage(slave):
	var text = '$name went to the forest in search of wild edibles.\n'
	var food = rand_range(15,25) - min(globals.resources.day/10,10)
	food += slave.wit/4
	if slave.race == 'Dryad':
		food = food*1.4
	if slave.cour < 50 && rand_range(0,100) + slave.cour/5 < 33:
		food = food*rand_range(0.25, 0.75)
		text += "Due to [color=yellow]lack of courage[/color], $he obtained less food than $he could. \n"
	if slave.smaf * 3 + 2 >= rand_range(0,100):
		text += "$name has found nature's essence. \n"
		globals.itemdict.natureessenceing.amount += 1
	food = round(min(food, (slave.sstr+slave.send)*20+25))
	if slave.spec == 'ranger':
		food *= 1.25
	text += '$He brought back [color=aqua]'+ str(food) + '[/color] units of food.\n'
	slave.xp += food/5
	var dict = {text = text, food = food}
	
	return dict

func hunt(slave):#agility, strength, endurance, courage
	var text = "$name went to the forest in search for wild animals.\n"
	var food = slave.awareness()*rand_range(2,4) + slave.send*rand_range(5,10)
	if slave.cour < 60 && rand_range(0,100) + slave.cour/4 < 45:
		food = food*rand_range(0.25, 0.50)
		text +=  "Due to [color=yellow]lack of courage[/color], $he obtained less food than $he could. \n"
	if slave.race == 'Arachna':
		food = food*1.3
	if slave.spec in ['ranger','trapper']:
		food *= 1.25
	globals.itemdict.supply.amount += round(food/12)
	slave.xp += food/7
	slave.cour += rand_range(0,2)
	food = min(food, (slave.sstr+slave.send)*30+40)
	text += "In the end $he brought [color=aqua]" + str(round(food)) + "[/color] food and [color=yellow]" + str(round(food/12)) + "[/color] supplies. \n"
	if slave.smaf * 3 + 3 >= rand_range(0,100):
		text += "$name has found beastial essence. \n"
		globals.itemdict.bestialessenceing.amount += 1
	
	var dict = {text = text, food = food}
	return dict

func library(slave):
	var text = "$name spends $his time studying in library.\n"
	slave.wit += rand_range(1,3)
	if slave.race == 'Gnome':
		slave.xp += max((30 + 5*globals.state.mansionupgrades.mansionlibrary + slave.wit/12) - (slave.level-1)*8,0)
	else:
		slave.xp += max((15 + 5*globals.state.mansionupgrades.mansionlibrary + slave.wit/12) - (slave.level-1)*8,0)
	var dict = {text = text}
	return dict

func nurse(slave):
	var text = "$name is taking care of residents' health.\n"
	
	globals.player.health += slave.wit/15+slave.smaf*3
	for i in globals.slaves:
		if i.away.duration == 0 && i.health < i.stats.health_max:
			if globals.itemdict.supply.amount > 0:
				i.health += slave.wit/25+slave.smaf*2
			else:
				i.health += slave.wit/35+slave.smaf*3
			slave.xp += rand_range(1,3)
	
	var dict = {text = text}
	return dict

func cooking(slave):
	var text = ''
	var gold = 0
	var food = 0
	slave.xp += globals.slaves.size()
	if globals.resources.food < 200:
		if globals.resources.gold >= globals.state.foodbuy/2:
			text = '$name went to purchase groceries and brought back new food supplies.\n'
			gold = -globals.state.foodbuy/2
			food = globals.state.foodbuy
		else:
			text = '$name complained about the lack of food and no money to supply kitchen on $his own.\n'
	text += '$name spent $his time prepearing meals for everyone.\n'
	text = slave.dictionary(text)
	var dict = {text = text, gold = gold, food = food}
	return dict

func lumberer(slave):
	var text = "$name spent the day in the Frostford woods, cutting and chopping trees. \n"
	var gold = max(slave.sstr*rand_range(4,8) + slave.send*rand_range(4,8),5)
	slave.xp += gold/4
	text += "In the end $he made [color=yellow]" + str(round(gold)) + "[/color] gold\n"
	var dict = {text = text, gold = gold}
	return dict

func ffprostitution(slave):
	var text = "$name spent the day at Frostford, selling $his body for sexual pleasure.\n"
	var gold = 0
	slave.metrics.brothel += 1
	var jobactions = ['vaginal','anal','oral','toys']
	if slave.vagvirgin == true:
		slave.sexuals.actions.pussy = 1
		slave.vagvirgin = false
		#slave.pussy.first = 'brothel'
		slave.health -= 5
		slave.stress += 15
		text += "$His virginity was taken by one of the customers.\n"
	slave.lust = rand_range(-15,-25)
	slave.loyal += rand_range(-1,-3)
	if rand_range(1,10) > 4:
		globals.impregnation(slave)
	var counter = 0
	for i in jobactions:
		if slave.sexuals.unlocks.has(i):
			counter += 1
	gold = rand_range(1,5) + slave.charm/4 + slave.send*15 + slave.beauty/5 + counter*5
	if slave.traits.has('Sex-crazed') == true:
		slave.stress += -counter*4
		gold = gold*1.2
	if slave.mods.has("augmenttongue"):
		gold = gold * 1.15
	slave.metrics.randompartners += round(rand_range(2,4))
	slave.metrics.sex += round(rand_range(2,5))
	if slave.sexuals.unlocks.find('penetration') && slave.vagina != 'none':
		slave.metrics.vag += round(rand_range(1,4))
	if slave.sexuals.unlocks.find('anal') >= 0:
		slave.metrics.anal += round(rand_range(1,4))
	if slave.sexuals.unlocks.find('oral') >= 0:
		slave.metrics.oral += round(rand_range(1,2))
	if slave.race.find('Bunny') >= 0 || slave.spec in ['geisha','nympho']:
		slave.stress += 12 - min(counter*4, 10)
	else:
		slave.stress += 25 - min(counter*5, 20)
	if slave.spec == 'geisha':
		gold = gold*1.25
	gold = round(gold)
	slave.xp += gold/5
	text += "By the end of the day $he earned [color=yellow]"+ str(gold) + "[/color] gold.\n"
	
	var dict = {text = text, gold = gold}
	return dict

func guardian(slave):
	var text = "$name spent the day in Gorn, patrolling the city as part of the guard.\n"
	var gold = max(slave.sstr*rand_range(5,10) + slave.cour/4,5)
	slave.xp += gold/6
	text += "In the end $he made [color=yellow]" + str(round(gold)) + "[/color] gold\n"
	slave.loyal -= 1
	var dict = {text = text, gold = gold}
	return dict

func research(slave):
	var text = "$name spent day by being used in magic experiments. \n"
	var gold = 25*(globals.originsarray.find(slave.origins)+1) + 20*slave.level + rand_range(0,10)
	var array = []
	var dead = false
	text += "In the end $he earned [color=yellow]" + str(round(gold)) + "[/color] gold\n"
	slave.obed += rand_range(15,25)
	if rand_range(0,100) >= 40:
		slave.health -= slave.health/3
	if rand_range(0,100) < 30:
		array = ['conf','cour','wit','charm']
		slave[array[rand_range(0,array.size())]] -= rand_range(15,25)
		text += "[color=#ff4949]$name's mental health has been damaged. [/color]"
	if rand_range(0,100) < 20 && slave.send >= 1:
		slave.send -= 1
		text += "[color=#ff4949]$name's physical health has been damaged. [/color]"
	if slave.wit >= 65 && slave.cour >= 65 && rand_range(0,100) <= 15:
		text = "[color=#ff4949]$name has managed to break free from place of $his employment and hasn't returned to mansion. [/color]"
		dead = true
	slave.stress += rand_range(10,25)
	if rand_range(35,50) > slave.health && rand_range(0,100) < 15:
		slave.health -= 200
		dead = true
		text = "[color=#ff4949]Due to life-threatening experiments $name has deceased.[/color]"
	var dict = {text = slave.dictionary(text), gold = gold, dead = dead}
	return dict

func fucktoy(slave):
	var gold = 0
	var text
	slave.metrics.brothel += 1
	text = "$name sent to Umbra to be used as a Fucktoy.\n"
	var jobactions = ['oral','anal','vaginal','fetish','fetish2','toy','group']
	if slave.vagvirgin == true:
		slave.sexuals.actions.pussy = 1
		slave.vagvirgin = false
		#slave.pussy.first = 'brothel'
		slave.health -= 5
		slave.stress += 10
		slave.loyal += rand_range(-2,-4)
		text += "$His virginity was taken by one of the customers.\n"
	if rand_range(1,10) > 2:
		globals.impregnation(slave)
	var counter = 0
	for i in jobactions:
		if slave.sexuals.unlocks.has(i) :
			counter += 1
	for i in globals.state.reputation:
		if globals.state.reputation[i] < 0:
			gold += abs(globals.state.reputation[i])
	gold += rand_range(5,10)
	if slave.traits.has('Sex-crazed'):
		slave.stress -= counter*3
	slave.metrics.sex += round(rand_range(3,6))
	slave.metrics.randompartners += round(rand_range(2,5))
	if slave.sexuals.unlocks.find('penetration') >= 0 && slave.vagina != 'none':
		slave.metrics.vag += round(rand_range(2,5))
	if slave.sexuals.unlocks.find('anal') >= 0:
		slave.metrics.anal += round(rand_range(2,5))
	if slave.sexuals.unlocks.find('oral') >= 0:
		slave.metrics.oral += round(rand_range(1,4))
	if slave.sexuals.unlocks.find('orgy') >= 0:
		slave.metrics.orgy += round(rand_range(1,3))
	if slave.mods.has("augmenttongue"):
		gold = gold * 1.15
	gold = round(gold)
	if slave.wit >= 25:
		slave.loyal -= 8
	if slave.conf >= 25:
		slave.stress += 15
	if slave.effects.has('captured'):
		slave.effects.captured.duration -= 3
	slave.obed += 20
	slave.asser -= rand_range(4,8)
	text += "By the end of the day $he earned [color=yellow]" + str(gold) + "[/color] gold.\n"
	var dict = {text = text, gold = gold}
	return dict


func slavecatcher(slave):
	var text = "$name spent day helping Gorn's slavers to acquire and tranport slaves. \n"
	var gold = slave.sstr*rand_range(5,10) + slave.sagi*rand_range(5,10) + slave.cour/4
	slave.xp += gold/6
	text += "In the end $he made [color=yellow]" + str(round(gold)) + "[/color] gold\n"
	slave.stress += rand_range(5,15)
	slave.loyal -= rand_range(1,3)
	var dict = {text = text, gold = gold}
	return dict

func storewimborn(slave):
	var text
	var gold
	var bonus = 1
	var supplyprice = round(rand_range(3,4))
	var supplysold
	text = "$name worked at the local market. "
	gold = rand_range(1,5) + (slave.charm + slave.wit)/3
	gold = gold*(min(0.30*(globals.originsarray.find(slave.origins)+1),1))
	if slave.race.find("Tanuki")>= 0:
		bonus = bonus + 0.3
		supplyprice += 1
	if slave.traits.has('Pretty voice') == true:
		bonus = bonus + 0.2
	elif slave.traits.has('Foul Mouth') == true:
		bonus = bonus - 0.3
	if slave.spec == 'merchant':
		bonus += 0.3
		supplyprice += 1
	gold = round(gold*bonus)
	supplysold = floor(gold/supplyprice)
	if globals.itemdict.supply.amount-globals.state.supplykeep >= supplysold:
		gold = supplysold*supplyprice
		globals.itemdict.supply.amount -= supplysold
	elif globals.state.supplybuy == true && globals.itemdict.supply.amount < globals.state.supplykeep:
		gold = ((gold-supplysold*supplyprice)*0.5) + (supplysold*supplyprice)
		var purchaseamount = globals.state.supplykeep - globals.itemdict.supply.amount
		var counter = 0
		supplysold = 0
		while purchaseamount > 0 && gold >= 5:
			counter += 1
			gold -= 5
			purchaseamount -= 1
			globals.itemdict.supply.amount += 1
		text += "With earned money $he purchased " + str(counter) + ' supply units. '
	else:
		supplysold = globals.itemdict.supply.amount - globals.state.supplykeep
		gold = ((gold-supplysold*supplyprice)*0.5) + (supplysold*supplyprice)
		globals.itemdict.supply.amount -= supplysold
	if supplysold > 0:
		text += "$He managed to sell [color=yellow]" + str(supplysold) + "[/color] units of supplies. "
	slave.metrics.goldearn += gold
	gold = round(gold)
	slave.xp += gold/4
	slave.stress += rand_range(5,10)
	text = text + "$He earned "+str(gold)+" gold by the end of day.\n"
	var dict = {text = text, gold = gold, supplies = -supplysold}
	return dict

func assistwimborn(slave):
	var text
	var gold
	text = "$name worked at the Mage's Order.\n"
	gold = rand_range(1,5) + slave.smaf*15 + slave.wit/4 + min(globals.state.reputation.wimborn/1.5,50)
	gold = round(gold)
	slave.metrics.goldearn += gold
	slave.xp += gold/5
	slave.stress += rand_range(5,10)
	text = text + "$He earned [color=yellow]"+str(gold)+"[/color] gold by the end of day.\n"
	var dict = {text = text, gold = gold}
	return dict

func artistwimborn(slave):
	var text
	var gold
	text ="$name worked in town as a public entertainer.\n"
	gold = rand_range(1,5) + slave.cour/7 + slave.charm/4 + slave.sagi*20 + slave.beauty/3
	if slave.race == 'Nereid':
		gold = gold*1.25
	if slave.traits.has('Pretty voice') == true:
		gold = gold*1.2
	elif slave.traits.has('Foul Mouth') == true:
		gold = gold*0.7
	gold = round(gold)
	slave.stress += rand_range(10,15)
	slave.xp += gold/7
	text += "$He earned [color=yellow]"+str(gold)+"[/color] gold by the end of day.\n"
	var dict = {text = text, gold = gold}
	return dict

func whorewimborn(slave):
	var text = "$name went to work as whore at the brothel.\n"
	var gold = 0
	slave.metrics.brothel += 1
	var jobactions = ['vaginal','anal','oral','toys']
	if slave.vagvirgin == true:
		slave.sexuals.actions.pussy = 1
		slave.vagvirgin = false
		#slave.pussy.first = 'brothel'
		slave.health -= 5
		slave.stress += 15
		text += "$His virginity was taken by one of the customers.\n"
	slave.lust = rand_range(-15,-25)
	slave.loyal += rand_range(-1,-3)
	if rand_range(1,10) > 4:
		globals.impregnation(slave)
	var counter = 0
	for i in jobactions:
		if slave.sexuals.unlocks.has(i):
			counter += 1
	gold = rand_range(1,5) + slave.charm/4 + slave.send*15 + slave.beauty/5 + counter*7
	if slave.traits.has('Sex-crazed') == true:
		slave.stress += -counter*4
		gold = gold*1.2
	if slave.mods.has("augmenttongue"):
		gold = gold * 1.15
	if counter < 4:
		text += "\nBrothel owner complained that $name does not have sufficient skill and didn't satisfy many customers. $His salary was cut by half. \n"
		gold = gold/2
		slave.metrics.sex += round(rand_range(1,3))
		slave.metrics.randompartners += round(rand_range(1,2))
		if slave.sexuals.unlocks.find('penetration') && slave.vagina != 'none':
			slave.metrics.vag += round(rand_range(1,2))
		if slave.sexuals.unlocks.find('anal') >= 0:
			slave.metrics.anal += round(rand_range(1,2))
		if slave.sexuals.unlocks.find('oral') >= 0:
			slave.metrics.oral += round(rand_range(0,1))
	else:
		slave.metrics.randompartners += round(rand_range(2,4))
		slave.metrics.sex += round(rand_range(2,5))
		if slave.sexuals.unlocks.find('penetration') && slave.vagina != 'none':
			slave.metrics.vag += round(rand_range(1,4))
		if slave.sexuals.unlocks.find('anal') >= 0:
			slave.metrics.anal += round(rand_range(1,4))
		if slave.sexuals.unlocks.find('oral') >= 0:
			slave.metrics.oral += round(rand_range(1,2))
	if slave.race.find('Bunny') >= 0 || slave.spec in ['geisha','nympho']:
		slave.stress += 12 - min(counter*4, 10)
	else:
		slave.stress += 25 - min(counter*5, 20)
	if slave.spec == 'geisha':
		gold = gold*1.25
	gold = round(gold)
	slave.xp += gold/5
	text += "By the end of the day $he earned [color=yellow]"+ str(gold) + "[/color] gold.\n"
	
	var dict = {text = text, gold = gold}
	return dict

func escortwimborn(slave):
	slave.metrics.brothel += 1
	var text = "$name provided escort service to rich clients of the brothel.\n"
	var gold
	if slave.vagvirgin == true:
		slave.vagvirgin = false
		#slave.pussy.first = 'brothel'
		slave.sexuals.actions.pussy = 1
		slave.health -= 5
		if slave.race.find('Bunny') >= 0:
			slave.stress += 7
		else:
			slave.stress += 15
		slave.loyal += rand_range(-1,-3)
		text += "$His virginity was taken by one of the customers.\n"
		if slave.race.find('Bunny') >= 0:
			slave.stress += 10 - min(slave.sexuals.actions.size()*3, 8)
		else:
			slave.stress += 20 - min(slave.sexuals.actions.size()*2, 15)
	slave.lust = rand_range(-10,-20)
	if rand_range(1,10) > 7:
		globals.impregnation(slave)
	gold = rand_range(15,35) + slave.charm/1.8 + slave.conf/3 + slave.beauty/3 + min(globals.state.reputation.wimborn,60)
	if slave.traits.has('Pretty voice') == true:
		gold = gold*1.2
	elif slave.traits.has('Foul Mouth') == true:
		gold = gold*0.7
	if slave.race.find('Fox') >= 0:
		gold = gold*1.2
	if slave.spec == 'geisha':
		gold = gold*1.25
	if slave.mods.has("augmenttongue"):
		gold = gold * 1.15
	gold = round(gold)
	slave.xp += gold/6
	slave.metrics.randompartners += round(rand_range(1,2))
	slave.metrics.sex += round(rand_range(1,2))
	if slave.sexuals.unlocks.find('penetration') && slave.vagina != 'none':
		slave.metrics.vag += round(rand_range(1,3))
	if slave.sexuals.unlocks.find('anal') >= 0:
		slave.metrics.anal += round(rand_range(1,3))
	if slave.sexuals.unlocks.find('oral') >= 0:
		slave.metrics.oral += round(rand_range(0,2))
	text += "By the end of the day $he earned [color=yellow]"+ str(gold) + "[/color] gold.\n"
	
	var dict = {text = text, gold = gold}
	return dict

func fucktoywimborn(slave):
	var gold
	var text
	slave.metrics.brothel += 1
	text = "$name departed to work as an exotic whore.\n"
	var jobactions = ['oral','anal','vaginal','fetish','fetish2','toy','group']
	if slave.vagvirgin == true:
		slave.sexuals.actions.pussy = 1
		slave.vagvirgin = false
		#slave.pussy.first = 'brothel'
		slave.health -= 5
		slave.stress += 10
		slave.loyal += rand_range(-2,-4)
		text += "$His virginity was taken by one of the customers.\n"
	if rand_range(1,10) > 2:
		globals.impregnation(slave)
	var counter = 0
	for i in jobactions:
		if slave.sexuals.unlocks.has(i) :
			counter += 1
	gold = rand_range(5,10) + slave.cour/2.3 + slave.send*15 + slave.beauty/5 + counter*4
	if slave.traits.has('Sex-crazed') == true:
		slave.stress += -counter*4
		gold = gold*1.2
	if slave.vagina != 'none' && slave.penis != 'none':
		gold = gold*1.1
	if slave.mods.has("hollownipples") == true:
		gold = gold*1.2
	if slave.mods.has("augmenttongue"):
		gold = gold * 1.15
	if counter < 4:
		text += "\nBrothel owner complained that $name does not have sufficient skill and didn't satisfy many customers. $His salary was cut by half. \n"
		slave.conf += -rand_range(5,10)
		slave.cour += -rand_range(5,10)
		slave.metrics.sex += round(rand_range(2,4))
		gold = gold/2
		slave.metrics.randompartners += round(rand_range(1,4))
		if slave.sexuals.unlocks.find('penetration') && slave.vagina != 'none':
			slave.metrics.vag += round(rand_range(1,3))
		if slave.sexuals.unlocks.find('anal') >= 0:
			slave.metrics.anal += round(rand_range(1,3))
		if slave.sexuals.unlocks.find('oral') >= 0:
			slave.metrics.oral += round(rand_range(1,2))
		if slave.sexuals.unlocks.find('orgy') >= 0:
			slave.metrics.orgy += round(rand_range(0,2))
	else:
		
		slave.metrics.sex += round(rand_range(3,6))
		slave.metrics.randompartners += round(rand_range(2,5))
		if slave.sexuals.unlocks.find('penetration') >= 0 && slave.vagina != 'none':
			slave.metrics.vag += round(rand_range(2,5))
		if slave.sexuals.unlocks.find('anal') >= 0:
			slave.metrics.anal += round(rand_range(2,5))
		if slave.sexuals.unlocks.find('oral') >= 0:
			slave.metrics.oral += round(rand_range(1,4))
		if slave.sexuals.unlocks.find('orgy') >= 0:
			slave.metrics.orgy += round(rand_range(1,3))
	
	
	if slave.race.find('Bunny') >= 0 || slave.spec == 'nympho':
		slave.stress += 25 - min(counter*4, 20)
	else:
		slave.stress += 50 - min(counter*7, 35)
	slave.lust = rand_range(-20,-30)
	if slave.spec == 'nympho':
		gold = gold*1.25
	gold = round(gold)
	slave.xp += gold/6
	text += "By the end of the day $he earned [color=yellow]" + str(gold) + "[/color] gold.\n"
	var dict = {text = text, gold = gold}
	return dict

func maid(slave):
	var text = ""
	var temp = 5.5 + (slave.sagi+slave.send)*6
	slave.xp += temp/4
	globals.state.condition = temp
	text = "$name spent the day cleaning around the mansion. \n"
	var dict = {text = text}
	return dict
