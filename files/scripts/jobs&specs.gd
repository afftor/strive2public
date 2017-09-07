extends Node



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
descriptbonus = "Bonus hunting +20%, 1/3 chance to automatically capture escaping person, bonus capture rate. ",
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
relationship = {reqs = 'slave.sexuals.unlocked == false', speech = "you should unlock [color=aqua]intimacy[/color] with $name to unlock $his potential.", descript = "$name needs to have [color=aqua]intimacy unlocked[/color] to advance $his level. ", execfunc = 'startrelationship'},
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
	slave.away.duration = slave.levelupreqs.value
	globals.get_tree().get_current_scene()._on_mansion_pressed()
	globals.get_tree().get_current_scene().popup(slave.dictionary("You've sent $name on vacation, boosting $his mood with sudden reward. "))
	slave.levelup()

func itemlevelup(slave):
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
		slave.levelup()
		globals.get_tree().get_current_scene().popup(slave.dictionary("Youg gift $name " + globals.itemdict[slave.levelupreqs.value].name + ". After returning a surprised look, $he whole-heartedly shows $his gratitude"))
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
		array2.append({code = item.code, number = itemnumber})
		
	
	var text = slave.dictionary(leveluprequests.multitem.speech)
	text = text.replace('$item', itemtext)
	var descript = slave.dictionary(leveluprequests.multitem.descript).replace('$item', itemtext)
	slave.levelupreqs = {code = 'multitem', value = array2, speech = text, descript = descript , button = slave.dictionary('Provide $name with necessary items'), effect = 'multitemlevelup', activate = 'fromtalk'}
	return text

func multitemlevelup(slave):
	var hasitems = true
	for i in slave.levelupreqs.value:
		if globals.itemdict[i.code].amount < i.number:
			hasitems = false
	if hasitems == false:
		globals.get_tree().get_current_scene().popup("Sadly, you don't have all required items in your possessions. ")
	else:
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
	slave.levelupreqs = {code = 'ingreditem', value = item.code, speech = text, descript = descript , button = slave.dictionary('Provide $name with $item').replace('$item', temptext), effect = 'ingredlevelup', activate = 'fromtalk'}
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