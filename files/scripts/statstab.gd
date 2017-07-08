extends Node


var slave
var player
var tab = ''



func _on_stats_visibility_changed():
	if get_parent().is_hidden() == true:
		return
	if get_parent().get_name() == 'prisoner_tab':
		tab = 'prison'
	else:
		tab = 'normal'
	var text
	player = globals.player
	slave = globals.slaves[get_tree().get_current_scene().currentslave]


func _on_trainingcancel_pressed():
	get_node("trainingpanel").set_hidden(true)

func _on_training_pressed():
	get_node("trainingpanel").set_hidden(false)
	_on_skillname_item_selected(get_node("trainingpanel/skillname").get_selected())


var skills = {
combat = {
description = "Combat is a primal fighting skill representing both offensive and defensive capabilities of a person as well as knowledge of battle tools. Main use - fighting.",
novice = {reqstats = "courage - 10", reqskills = ""},
apprentice = {reqstats = "courage - 30", reqskills = ""},
journeyman = {reqstats = "courage - 50", reqskills = "body - 20"},
expert = {reqstats = "courage - 70", reqskills = "body - 40"},
master = {reqstats = "courage - 90", reqskills = "body - 60"},
},
body = {
description = "Body Control represents agility and dexterity of a person. It plays major role in both combat and entertainment.",
novice = {reqstats = "confidence - 10", reqskills = ""},
apprentice = {reqstats = "confidence - 30", reqskills = ""},
journeyman = {reqstats = "confidence - 50", reqskills = ""},
expert = {reqstats = "confidence - 70", reqskills = ""},
master = {reqstats = "confidence - 90", reqskills = ""},
},
survival = {
description = "Survival represents how good person can manage in the wild. Affects tracking, forage and hunting.",
novice = {reqstats = "courage - 10, wit - 10", reqskills = ""},
apprentice = {reqstats = "courage - 25, wit - 25", reqskills = ""},
journeyman = {reqstats = "courage - 40, wit - 40", reqskills = ""},
expert = {reqstats = "courage - 55, wit - 55", reqskills = ""},
master = {reqstats = "courage - 70, wit - 70", reqskills = ""},
},
management = {
description = "Management relates to the capability of holding administrative roles. Is a must for anyone involved in working with subordinates. Affects headgirl and other management assignments.",
novice = {reqstats = "confidence - 10, wit - 10", reqskills = ""},
apprentice = {reqstats = "confidence - 25, wit - 25", reqskills = ""},
journeyman = {reqstats = "confidence - 40, wit - 40", reqskills = ""},
expert = {reqstats = "confidence - 55, wit - 55", reqskills = ""},
master = {reqstats = "confidence - 70, wit - 70", reqskills = ""},
},
service = {
description = "Service represents householding skills and etiquette. Affects house workers and escort.",
novice = {reqstats = "charm - 10, wit - 10", reqskills = ""},
apprentice = {reqstats = "charm - 25, wit - 15", reqskills = ""},
journeyman = {reqstats = "charm - 40, wit - 25", reqskills = ""},
expert = {reqstats = "charm - 55, wit - 35", reqskills = ""},
master = {reqstats = "charm - 70, wit - 50", reqskills = ""},
},
allure = {
description = "Allure represents ability to attract other people by your apperance and actions. Affects public related occupations. ",
novice = {reqstats = "charm - 10", reqskills = ""},
apprentice = {reqstats = "charm - 30", reqskills = ""},
journeyman = {reqstats = "charm - 50", reqskills = ""},
expert = {reqstats = "charm - 70", reqskills = ""},
master = {reqstats = "charm - 90", reqskills = ""},
},
sexual = {
description = "Sexual Proficiency represents how good person can satisfy partner in sex. Affects sexual related tasks.",
novice = {reqstats = "courage - 10, charm - 10", reqskills = ""},
apprentice = {reqstats = "courage - 25, charm - 25", reqskills = ""},
journeyman = {reqstats = "courage - 40, charm - 40", reqskills = "body - 40"},
expert = {reqstats = "courage - 55, charm - 55", reqskills = "body - 60"},
master = {reqstats = "courage - 70, charm - 70", reqskills = "body - 80"},
},
magic = {
description = "Magic arts represents various knowledge about nature and functions of magic. It is highly required to those actively working in such direction. Affects occupations of complex nature (i.e. laboratory assistant).",
novice = {reqstats = "wit - 10", reqskills = ""},
apprentice = {reqstats = "wit - 30", reqskills = ""},
journeyman = {reqstats = "wit - 50", reqskills = ""},
expert = {reqstats = "wit - 70", reqskills = ""},
master = {reqstats = "wit - 90", reqskills = ""},
},
}

var skillsarray = ['combat','body','survival','management','service','allure','sexual','magic']
var skilllevelsarray = ['novice','apprentice','journeyman','expert','master']
var selectedskill
var selectedskilllevel
var effectiveskillvalue
var slaveskillvalue
var cost
var selectedid


func _on_skillname_item_selected( ID ):
	var textnode = get_node("trainingpanel/trainingtext")
	var disabledbutton = false
	selectedid = ID
	selectedskill = skills[skillsarray[ID]]
	selectedskilllevel = skilllevelsarray[get_node("trainingpanel/skilllevel").get_selected()]
	effectiveskillvalue = (get_node("trainingpanel/skilllevel").get_selected()+1)*20
	slaveskillvalue = slave.skills[skillsarray[ID]].value
	cost = ((((1+slaveskillvalue/20) + effectiveskillvalue/20)*(effectiveskillvalue-slaveskillvalue)/20)*50)/2
	var skillname = ''
	var skilllevel = ''
	var text = []
	textnode.set_bbcode(selectedskill.description)
	textnode.set_bbcode(textnode.get_bbcode()+'\n\nCurrent level : ' + slave.skill_level(slave['skills'][skillsarray[ID]]['value']))
	if slaveskillvalue >= effectiveskillvalue:
		disabledbutton = true
		textnode.set_bbcode(slave.dictionary(textnode.get_bbcode()+'\n\n$name already mastered this level. '))
	else:
		text = selectedskill[selectedskilllevel].reqskills.replace(' ', '').split('-')
		if text.size() > 1:
			skillname = slave.skills[text[0]].name
			skilllevel = slave.skill_level(int(text[1]))
		textnode.set_bbcode(textnode.get_bbcode()+'\n\nRequirements(total) : ' + selectedskill[selectedskilllevel].reqstats + ', '+ str((effectiveskillvalue-slaveskillvalue)/20) + globals.fastif((effectiveskillvalue-slaveskillvalue)/20 > 1,' skillpoints',' skillpoint') + globals.fastif(text.size()>1,', '+ skillname + ': '+ skilllevel ,'') + ', ')
		textnode.set_bbcode(textnode.get_bbcode() + str(cost) + ' gold.\n' + slave.dictionary('$name will be absent for ')+ str(((effectiveskillvalue-slaveskillvalue)/20)*2)+' days.\n')
		
		
		if cost > globals.resources.gold:
			textnode.set_bbcode(textnode.get_bbcode()+"[color=red]You don't have enough gold. [/color]\n")
			disabledbutton = true
		elif slave.level.skillpoints < (effectiveskillvalue-slaveskillvalue)/20:
			textnode.set_bbcode(textnode.get_bbcode()+slave.dictionary("[color=red]$name doesn't have enough available skillpoints.\n[/color]"))
			disabledbutton = true
		else:
			var array = selectedskill[selectedskilllevel].reqstats.replace(' ','')
			var array2 = []
			if array.find(',') > 0:
				array = array.split(',')
				for string in array:
					var temp = string.split('-')
					for i in temp:
						array2.append(i)
			else:
				array2 = array.split('-')
			while array2.size() > 0:
				if (skillsarray[ID] == 'combat' && slave.race == 'Taurus') || (skillsarray[ID] == 'body' && slave.race == 'Seraph') || (skillsarray[ID] == 'allure' && slave.race.find('Fox') >= 0) || (skillsarray[ID] == 'survival' && slave.race.find('Wolf') >= 0):
					break
				array2[0] = globals.fastif(array2[0] == 'courage', 'cour', array2[0])
				array2[0] = globals.fastif(array2[0] == 'confidence', 'conf', array2[0])
				if float(array2[1]) > slave[array2[0]]:
					disabledbutton = true
					textnode.set_bbcode(textnode.get_bbcode()+slave.dictionary("[color=red]$name does not fullfil mental stat requirement.[/color]\n"))
				array2.remove(0)
				array2.remove(0)
	if slaveskillvalue >= effectiveskillvalue || slave.level.skillpoints < (effectiveskillvalue-slaveskillvalue)/20:
		disabledbutton = true
	var array = selectedskill[selectedskilllevel].reqskills.replace(' ','').split('-')
	if array.size() > 1:
		if slave.skills[array[0]].value < int(array[1]):
			disabledbutton = true
			textnode.set_bbcode(textnode.get_bbcode()+slave.dictionary("[color=red]$name doesn't meet secondary skill requirements.[/color]\n"))
	if slave.traits.has('Sex-crazed') == true && skillsarray[ID] != 'sexual':
		disabledbutton = true
		textnode.set_bbcode(textnode.get_bbcode() + slave.dictionary("[color=red]$name can't focus enough on anything, but sex.[/color]\n"))
	if disabledbutton == false:
		get_node("trainingpanel/trainingconfirm").set_disabled(false)
	else:
		get_node("trainingpanel/trainingconfirm").set_disabled(true)



func _on_skilllevel_item_selected( ID ):
	_on_skillname_item_selected(get_node("trainingpanel/skillname").get_selected())

func _on_trainingconfirm_pressed():
	get_tree().get_current_scene().yesnopopup("Confirm assignment?", "trainingconfirm", self)

func trainingconfirm():
	_on_trainingcancel_pressed()
	globals.resources.gold -= cost
	slave.skills[skillsarray[selectedid]].value = effectiveskillvalue
	slave.level.skillpoints -= (effectiveskillvalue-slaveskillvalue)/20
	slave.away.duration = ((effectiveskillvalue-slaveskillvalue)/20)*2
	slave.away.at = 'training'
	get_tree().get_current_scene()._on_nobutton_pressed()
	get_tree().get_current_scene().rebuild_slave_list()
	get_tree().get_current_scene()._on_mansion_pressed()
	if globals.slaves[globals.state.companion] == slave:
		globals.state.companion = -1
		slave.work = 'rest'
	get_tree().get_current_scene().popup(slave.dictionary("You have sent $name away for training."))



func _on_trainingstats_pressed():
	var array = ['str_base', 'agi_base', 'maf_base', 'end_base']
	var array2 = ['Strength', 'Agility', 'Magic', 'Endurance']
	get_node("trainingstatspanel").set_hidden(false)
	if slave.level.skillpoints <= 0:
		get_node("trainingstatspanel/statconfirm").set_disabled(true)
		get_node("trainingstatspanel/statconfirm").set_tooltip('No skillpoints available')
	else:
		get_node("trainingstatspanel/statconfirm").set_disabled(false)
		get_node("trainingstatspanel/statconfirm").set_tooltip('')
	get_node("trainingstatspanel/statoptionbutton").clear()
	var counter = 0
	for i in array:
		var temp = i.replace('_base', '_max')
		if slave.stats[i] < slave.stats[temp]:
			get_node("trainingstatspanel/statoptionbutton").add_item(array2[counter])
		counter += 1
	if get_node("trainingstatspanel/statoptionbutton").get_item_count() <= 0:
		get_node("trainingstatspanel/statconfirm").set_disabled(true)



func alphabeticalsortbycode(first, second):
	if first.code > second.code:
		return false
	else:
		return true


func _on_trainingabils_pressed():
	get_node("trainingabilspanel").set_hidden(false)
	for i in get_node("trainingabilspanel/ScrollContainer/VBoxContainer").get_children():
		if i != get_node("trainingabilspanel/ScrollContainer/VBoxContainer/Button"):
			i.set_hidden(false)
			i.free()
	
	get_node("trainingabilspanel/abilitytext").set_bbcode('')
	
	var array = []
	for i in globals.abilities.abilitydict.values():
		if i.attributes.find('onlyself') < 0:
			array.append(i)
	array.sort_custom(self, 'alphabeticalsortbycode')
	
	for i in array:
		if i.learnable == true:
			var newbutton = get_node("trainingabilspanel/ScrollContainer/VBoxContainer/Button").duplicate()
			get_node("trainingabilspanel/ScrollContainer/VBoxContainer").add_child(newbutton)
			newbutton.set_hidden(false)
			newbutton.connect("pressed", self, "chooseability", [i])
			newbutton.set_text(i.name)


func chooseability(ability):
	var text = ''
	var confirmbutton = get_node("trainingabilspanel/abilityconfirm")
	var dict = {'stats.str_cur': 'Strength', 'stats.agi_cur' : 'Agility', 'stats.maf_cur': 'Magic', 'level.value': 'Level'}
	for i in get_node("trainingabilspanel/ScrollContainer/VBoxContainer").get_children():
		if i.get_text() != ability.name:
			i.set_pressed(false)
	
	confirmbutton.set_disabled(false)
	
	text = '[center]'+ ability.name + '[/center]\n' + ability.description + '\nCooldown:' + str(ability.cooldown) + '\nLearn requirements: ' 
	
	var array = []
	for i in ability.reqs:
		array.append(i)
	array.sort_custom(self, 'levelfirst')
	
	for i in array:
		var temp = i
		var ref = slave
		if i.find('.') >= 0:
			var temp = i.split('.')
			for ii in temp:
				ref = ref[ii]
		else:
			ref = slave[i]
		if ref < ability.reqs[i]:
			confirmbutton.set_disabled(true)
			text += '[color=red]'+dict[i] + ': ' + str(ability.reqs[i]) + '[/color], '
		else:
			text += '[color=green]'+dict[i] + ': ' + str(ability.reqs[i]) + '[/color], '
	text = text.substr(0, text.length() - 2) + '.'
	
	confirmbutton.set_meta('abil', ability)
	
	
	
	if slave.ability.find(ability.code) >= 0:
		confirmbutton.set_disabled(true)
		text += slave.dictionary('\n[color=green]$name already knows this ability. [/color]')
	elif globals.resources.gold < ability.price:
		text += '\n\n[color=red]Price to learn: ' + str(ability.price) + ' gold.[/color]' 
		confirmbutton.set_disabled(true)
	else:
		text += '\n\n[color=green]Price to learn: ' + str(ability.price) + ' gold.[/color]' 
	
	if slave.level.skillpoints < 1:
		confirmbutton.set_disabled(true)
		text += slave.dictionary('\n$name has available skillpoints to learn this ability. ') 
	
	if ability.has('requiredspell') == true:
		if globals.spelldict[ability.requiredspell].learned == false:
			confirmbutton.set_disabled(true)
			text += slave.dictionary('\n[color=red]You must purchase this spell before you will be able to teach it others. [/color]')
	get_node("trainingabilspanel/abilitytext").set_bbcode(text)

func levelfirst(first, second):
	if first == 'level':
		return true
	else:
		return false

func _on_statconfirm_pressed():
	var text = 's'+globals.decapitalize(get_node("trainingstatspanel/statoptionbutton").get_item_text(get_node("trainingstatspanel/statoptionbutton").get_selected()).substr(0, 3))
	if text == 'smag':
		text = 'smaf'
	slave.level.skillpoints -= 1
	slave[text] = 1
	get_node("trainingstatspanel").set_hidden(true)
	get_parent()._on_slave_tab_visibility_changed()
	slave.stats.health_max = 35 + slave.stats.end_cur*25
	get_tree().get_current_scene().popup(slave.name + "'s " +get_node("trainingstatspanel/statoptionbutton").get_item_text(get_node("trainingstatspanel/statoptionbutton").get_selected()) + ' has increased.' )


func _on_statcancel_pressed():
	get_node("trainingstatspanel").set_hidden(true)

func _on_abilcancel_pressed():
	get_node("trainingabilspanel").set_hidden(true)


func _on_abilityconfirm_pressed():
	var abil = get_node("trainingabilspanel/abilityconfirm").get_meta('abil')
	if abil == null:
		return
	elif slave.ability.find(abil.code) >= 0:
		return
	slave.ability.append(abil.code)
	globals.resources.gold -= abil.price
	slave.level.skillpoints -= 1
	get_tree().get_current_scene().popup(slave.dictionary('$name has learned '+ abil.name))
	_on_trainingabils_pressed()
	get_node("trainingabilspanel").update()


func _on_spcancel_pressed():
	get_node("trainingskillpointspanel").set_hidden(true)


func _on_trainskillpoints_pressed():
	get_node("trainingskillpointspanel").set_hidden(false)
	get_node("trainingskillpointspanel/spspin").set_value(0)





func _on_spspin_value_changed( value ):
	var text = ''
	#var price = str(((100+slave.level.skillpointsbought*50) + value*50)*(((100+slave.level.skillpointsbought*50) + value*50)+50)/2)
	var price = str((((1+slave.level.skillpointsbought+value)*(value+slave.level.skillpointsbought))*50+200*value)/2 -50*slave.level.skillpointsbought)
	var days = str(value * 2)
	text = 'Price: ' + price + '; Required Time: ' + days + ' days.' 
	if value == 0:
		text = ''
	
	get_node("trainingskillpointspanel/sptext").set_bbcode(text)

#var start = slave.skillpointsbought + value
#var firstpointprice = ((((1+slave.level.skillpointsbought) + value)*(value-lave.level.skillpointsbought))*50)/2
 




func _on_spconfirm_pressed():
	var value = get_node("trainingskillpointspanel/spspin").get_value()
	var price = (((1+slave.level.skillpointsbought+value)*(value+slave.level.skillpointsbought))*50+200*value)/2 - 50*slave.level.skillpointsbought
	var days = value * 2
	
	if globals.resources.gold < price:
		get_tree().get_current_scene().popup("You don't have enough gold.")
	elif value == 0:
		pass
	else:
		globals.resources.gold -= price
		slave.away.duration = days
		slave.away.at = 'training'
		slave.level.skillpointsbought += value
		slave.level.skillpoints += value
		get_node("trainingskillpointspanel").set_hidden(true)
		get_tree().get_current_scene().rebuild_slave_list()





