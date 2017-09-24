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


func alphabeticalsortbycode(first, second):
	if first.code > second.code:
		return false
	else:
		return true


func _on_trainingabils_pressed():
	get_node("trainingabilspanel").popup()
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
	var dict = {'stats.str_cur': 'Strength', 'stats.agi_cur' : 'Agility', 'stats.maf_cur': 'Magic', 'level': 'Level'}
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
	get_tree().get_current_scene().popup(slave.dictionary('$name has learned '+ abil.name))
	_on_trainingabils_pressed()
	get_parent()._on_slave_tab_visibility_changed()
	get_node("trainingabilspanel").update()


func _on_spcancel_pressed():
	get_node("trainingskillpointspanel").set_hidden(true)


func _on_trainskillpoints_pressed():
	get_node("trainingskillpointspanel").set_hidden(false)
	get_node("trainingskillpointspanel/spspin").set_value(0)








