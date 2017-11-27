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
	var dict = {'sstr': 'Strength', 'sagi' : 'Agility', 'smaf': 'Magic', 'level': 'Level'}
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
	slave.abilityactive.append(abil.code)
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








func _on_castspell_pressed():
	slave = globals.currentslave
	get_node("selectspellpanel").set_hidden(false)
	get_node("selectspellpanel/spellusedescription").set_bbcode('')
	var spelllist = get_node("selectspellpanel/ScrollContainer/selectspelllist")
	var button = get_node("selectspellpanel/ScrollContainer/selectspelllist/spellbutton")
	for i in spelllist.get_children():
		if i != button:
			i.set_hidden(true)
			i.queue_free()
	for i in globals.spelldict.values():
		if i.learned == true && i.personal == true:
			var newspellbutton = button.duplicate()
			newspellbutton.set_text(i.name)
			newspellbutton.set_hidden(false)
			newspellbutton.connect('pressed', self, 'spellbuttonpressed', [i])
			spelllist.add_child(newspellbutton)
	if  spelllist.get_children().size() <= 1:
		get_node("selectspellpanel/spellusebutton").set_disabled(true)
		get_node("selectspellpanel/spellusedescription").set_bbcode('You have no fitting spells. ')
	else:
		get_node("selectspellpanel/spellusebutton").set_disabled(false)

var spellselected

func spellbuttonpressed(spell):
	get_node("selectspellpanel").popup()
	spellselected = spell
	var description = get_node("selectspellpanel/spellusedescription")
	var spelllist = get_node("selectspellpanel/ScrollContainer/selectspelllist")
	for i in get_tree().get_nodes_in_group('spells'):
		if i.get_text() != spell.name && i.is_pressed() == true:
			i.set_pressed(false)
	description.set_bbcode(spell.description + '\nMana cost - ' + str(spell.manacost))
	if spell.manacost > globals.resources.mana:
		get_node("selectspellpanel/spellusebutton").set_disabled(true)
	else:
		get_node("selectspellpanel/spellusebutton").set_disabled(false)


func _on_spellcancelbutton_pressed():
	get_node("selectspellpanel").set_hidden(true)
	spellselected = ''

func _on_spellusebutton_pressed():
	slave.metrics.spell += 1
	var spellnode = get_tree().get_current_scene().get_node('spellnode')
	spellnode.slave = slave
	spellnode.call(spellselected.effect)
	slave.attention = 0
	get_node("selectspellpanel").set_hidden(true)
	get_parent()._on_slave_tab_visibility_changed()
	get_tree().get_current_scene().rebuild_slave_list()



onready var nakedspritesdict = get_parent().get_node("sexual").nakedspritesdict

func _on_talk_pressed(mode = 'talk'):
	var state = true
	var sprite = []
	var buttons = []
	var text = ''
	if slave.unique == 'Cali' && globals.state.sidequests.cali in [12,13,22]:
		globals.events.calitalk0()
		return
	if nakedspritesdict.has(slave.unique):
		if slave.obed >= 50 || slave.stress < 10:
			sprite = [[nakedspritesdict[slave.unique].clothcons, 'pos1', 'opac']]
		else:
			sprite = [[nakedspritesdict[slave.unique].clothrape, 'pos1', 'opac']]
	elif slave.imagefull != null:
		sprite = [[slave.imagefull,'pos1','opac']]
	if mode == 'talk':
		if slave.sleep == 'jail':
			text = "You enter jail cell with $name handcuffed in it. "
		else:
			text = "You summon $name to your appartments. "
		if slave.rules.silence:
			text = "After giving $him a permission to talk, you begin a conversation. "
		
		text += '\n\n'
		if slave.traits.has("Mute"):
			text += "Despite your best attempts, you can't get more out of $name, than uncomfortable look. "
		else:
			if slave.obed < 50:
				text = text + "— I don't wanna talk with you after all you've done!\n"
			elif slave.traits.has('Sex-crazed') == true:
				text = text + "— I don't care about my life, or anything, can we just fuck here, Master?"
			else:
				if slave.loyal < 25:
					text = text + '— Yes, I will obey your orders, $master. \n'
					if slave.brand != 'none':
						text = text + "It's not like I have much of an option anyway. \n$name gives you a trapped look. "
				elif slave.loyal < 60:
					text = text + "—It wasn't easy at first, but I think warmly of you, $master. \n"
					if slave.brand != 'none':
						text = text + "Even though I'm just your little slave now. \n"
				else:
					text = text + "— I'll try my best for you, $master. Despite what others might think, you are invaluable to me!\n"
				if slave.stress > 50:
					text = text + "— It has been tough for me recently... Could you consider giving me a small break, please?\n"
				if slave.lust >= 60 && slave.consent == true && slave.sexuals.actions.has('pussy'):
					text = text + "— I actually would love to fuck right now. \n"
				elif slave.lust >= 60 && slave.consent == true:
					text = text + "— Uhm... would you like to give me some private attention? — $name gives you a deep lusting look. \n"
		if slave.xp >= 100 && slave.levelupreqs.has('code') == false:
			buttons.append({text = slave.dictionary("Investigate $name's potential"), function = 'levelreqs'})
		elif slave.levelupreqs.has('code'):
			text += "\n\n[color=yellow]Your investigation shown, that " + slave.dictionary(slave.levelupreqs.speech) + '[/color]'
			if slave.levelupreqs.activate == 'fromtalk':
				buttons.append({text = slave.levelupreqs.button, function = 'levelup', args = slave.levelupreqs.effect})
		if slave.sleep != 'jail':
			buttons.append({text = slave.dictionary("Praise $name"), function = '_on_talk_pressed', args = 'praise'})
		buttons.append({text = slave.dictionary("Punish $name"), function = '_on_talk_pressed', args = 'punish'})
		if slave.sleep != 'jail' && slave.consent == false:
			buttons.append({text = slave.dictionary("Propose intimate relationship (25 energy)"), function = 'unlocksex'})
			if globals.player.energy < 25: buttons[buttons.size()-1].disabled = true
		buttons.append({text = slave.dictionary("Order to call you ..."), function = 'callorder'})
		buttons.append({text = slave.dictionary("Release $name"), function = 'release'})
	elif mode == 'praise':
		if slave.obed >= 85 && slave.praise == 0:
			text = "$name obediently waits for your reaction looking beneath $himself. "
		elif slave.praise > 0:
			text = "$name seems to be still in high spirits probably keeping in mind your recent approval. "
		elif slave.obed < 85:
			text = "$name appears to be not very disciplined as $his eyes wander around the room. "
		buttons.append({text = "Praise (10 energy)", function = 'action', args = 'praise'})
		if globals.player.energy < 10: buttons[buttons.size()-1].disabled = true
		buttons.append({text = "Make a Gift (15 energy, 15 gold)", function = 'action', args = 'gift'})
		if globals.player.energy < 15 || globals.resources.gold < 15: buttons[buttons.size()-1].disabled = true
	elif mode in ['punish', 'sexpunish']:
		if slave.punish.expect == true:
			text = "$name gives you a fearsome look indicating strong recent memories of your authority. "
		elif slave.obed <= 65:
			text = "$name appears to be not very disciplined as $he shows slight irritation having to submit to you. "
		else:
			text = "$name shows mild awareness to your authority. "
		if mode == 'punish':
			buttons.append({text = "Berate (10 energy)", function = 'action', args = 'berate'})
			if globals.player.energy < 10: buttons[buttons.size()-1].disabled = true
			buttons.append({text = "Beat (15 energy)", function = 'action', args = 'beat'})
			if globals.player.energy < 15: buttons[buttons.size()-1].disabled = true
			buttons.append({text = "Sexual Punishments (20 energy)", function = "_on_talk_pressed", args = 'sexpunish'})
			if globals.player.energy < 20: buttons[buttons.size()-1].disabled = true
		elif mode == 'sexpunish':
			text += "\n\nYou can take $name to the punishment room for more oscure actions. These are not specifically harmful, but sufficiently painful and stimulating to provide a lesson. \nIf 'Public' is checked, other servants will also be watching and it will severe the punishment."
			buttons.append({text = "Tickling", function = 'action', args = 'tickling'})
			buttons.append({text = "Spanking", function = 'action', args = 'spanking'})
			buttons.append({text = "Whipping", function = 'action', args = 'whipping'})
			buttons.append({text = "Wooden Horse", function = 'action', args = 'woodenhorse'})
			buttons.append({text = "Hot Wax", function = 'action', args = 'hotwax'})
	if mode in ['praise', 'punish']:
		buttons.append({text = "Return", function = '_on_talk_pressed'})
	elif mode == 'sexpunish':
		buttons.append({text = "Return", function = '_on_talk_pressed', args = 'punish'})
	get_tree().get_current_scene().dialogue(state, self, slave.dictionary(text), buttons, sprite)
	get_tree().get_current_scene().rebuild_slave_list()
	get_parent()._on_slave_tab_visibility_changed()

func callorder():
	get_node("callorder").popup()
	get_node("callorder/Label").set_text(slave.dictionary("How $name should call you?"))
	get_node("callorder/LineEdit").set_text(slave.masternoun)

func _on_callconfirm_pressed():
	get_node("callorder").set_hidden(true)
	var text = "You have ordered $name to call $master from this moment. "
	if slave.traits.has('Mute'): text += "However $he only returned you a guilty look. "
	slave.masternoun = get_node("callorder/LineEdit").get_text()
	get_tree().get_current_scene().close_dialogue()
	get_tree().get_current_scene().popup(slave.dictionary(text))

func unlocksex():
	var text = ''
	var difficulty = 0
	var state = false
	var buttons = []
	var sprite = []
	globals.player.energy -= 25
	text += "You make a proposal to $name saying how you would like to move your relationship on a new level. \n\n"
	if slave.obed < 40:
		text += "$name gives you an indignant look and laughs your suggestion off. [color=yellow]$His lack of respect of you will have to be corrected first[/color]  "
	else:
		difficulty = slave.loyal/3 + slave.sexuals.affection + slave.lust/10 + slave.sexuals.actions.size()*2
		if slave.sex == globals.player.sex:
			difficulty -= 10
		if slave.relatives.father == 0 || slave.relatives.mother == 0:
			difficulty -= 10
		for i in slave.traits:
			if i == 'Prude':
				difficulty -= 5
		if difficulty <= 30:
			text += "[color=yellow]— Sorry, $master, but I don't think I'm ready for this. [/color]\n\nIt seems something holds $name back and $he does not like you enough. "
		else:
			if slave.conf >= 40:
				text += "[color=yellow]— Sure, I'd love to get to know you more... intimately, $master![/color]"
			else:
				text += "[color=yellow]— Uhm... I don't mind... I mean if you wish so, $master. [/color]"
			text+= "\n\n[color=green]Unlocked sexual actions with $name.[/color]"
			if slave.levelupreqs.has('code') && slave.levelupreqs.code == 'relationship':
				text += "\n\n[color=green]As you got closer with $name, you felt like $he unlocked new potential. [/color]"
				slave.levelup()
			slave.consent = true
	if nakedspritesdict.has(slave.unique):
		if slave.consent:
			sprite = [[nakedspritesdict[slave.unique].clothcons, 'pos1']]
		else:
			sprite = [[nakedspritesdict[slave.unique].clothrape, 'pos1']]
	elif slave.imagefull != null:
		sprite = [[slave.imagefull,'pos1','opac']]
	buttons.append({text = slave.dictionary("Continue"), function = '_on_talk_pressed'})
	get_tree().get_current_scene().dialogue(state, self, slave.dictionary(text), buttons, sprite)





func levelreqs():
	globals.jobs.getrequest(slave)
	_on_talk_pressed()
	get_parent()._on_slave_tab_visibility_changed()

func levelup(command):
	globals.jobs.call(command, slave)
	globals.get_tree().get_current_scene().close_dialogue()
	get_parent()._on_slave_tab_visibility_changed()


func action(actionname):
	var text = ''
	var buttons = []
	var sprite = []
	if actionname in ['berate', 'praise']: globals.player.energy -= 10
	elif actionname in ['beat','gift']: globals.player.energy -= 15
	elif actionname in ['whipping','tickling','spanking','woodenhorse','hotwax']: globals.player.energy -= 20
	if actionname == 'berate':
		text = "You scold $name for their lousy behavior and make few remarks on possible future punishments if $he doesn't improve it. "
		if slave.obed < 85 && slave.punish.expect == false:
			if slave.effects.has('captured') == true:
				slave.effects.captured.duration -= 1
			slave.obed += 30 - slave.conf/5
			text = text + "\n$He seems to be taking your repremand seriously."
			slave.punish.expect = true
			if slave.race == 'Human':
				slave.punish.strength = 10 - slave.cour/25
			else:
				slave.punish.strength = 5 - slave.cour/25
			slave.stress += rand_range(5,10)
		elif slave.obed >= 85:
			text = text + '\n$He unhappy to your repremand, as $he does not believe $he has offended you rightly.'
			slave.stress += 15
		else:
			text = text + "\n$He does not seems to be very afraid of your threats, as you haven't followed through on them previously."
			slave.obed += max(20 - slave.conf/5,0)
			slave.punish.expect = true
			if slave.race == 'Human':
				slave.punish.strength = 10 - slave.cour/25
			else:
				slave.punish.strength = 5 - slave.cour/25
			slave.stress += rand_range(5,10)
			if slave.effects.has('captured') == true:
				slave.effects.captured.duration += 1
	elif actionname == 'beat':
		text = "You give $name a painful, but relatively harmless beating, providing $him a valueable lesson in subordination. "
		slave.stress += rand_range(15,25)
		slave.health -= rand_range(5,10)
		if slave.health <= 0:
			text += "\n\n[color=red]Due to $his already poor health that was simply too much for $name and $he falls into a coma. You are unable to resuscitate $him despite trying for a while, and eventually can't help but to accept $his death.[/color] "
			globals.slaves.erase(slave)
			if globals.slaves.size() > 1:
				text += "\n[color=red]Your other servants are shocked by this incident. [/color]"
				for i in globals.slaves:
					i.obed += rand_range(10, 50)
					i.stress += rand_range(25, 50)
			get_tree().get_current_scene().popup(slave.dictionary(text))
			get_tree().get_current_scene().rebuild_slave_list()
			get_tree().get_current_scene().close_dialogue()
			return
		if slave.obed < 75||slave.traits.has('Masochist') == true:
			if slave.effects.has('captured') == true:
				slave.effects.captured.duration -= 1
				text = text + "\nBy the end $he glares at you with sorrow and hatred, showing leftovers of a yet untamed spirit."
			else:
				text = text + "\nBy the end $he is begging for mercy and takes your lesson to heart."
				slave.obed += rand_range(30,60)
			if slave.punish.expect == true:
				slave.obed += rand_range(20,40)
				if slave.race == 'Human':
					slave.punish.strength += 10 - slave.cour/25
				else:
					slave.punish.strength += 5 - slave.cour/25
			else:
				slave.conf += -rand_range(2,5)
				slave.cour += -rand_range(2,5)
		else:
			text = text + "\n$He obediently takes $his punishment and begs for your pardon, but $name doesn't feel like $he trully deserves such a treatment."
			slave.obed += rand_range(20,30)
			slave.conf += -rand_range(3,6)
			slave.cour += -rand_range(3,6)
			slave.stress += rand_range(5,15)
			slave.loyal -= rand_range(4,8)
	elif actionname == 'tickling':
		text = "After bringing $name to the torture room, you tie $him securely to the special chair and work your way over $his body with the feathers and brushes, until $his laughter turn into cries for mercy. You give $him small break then start over. Before long, $his overstimulated feet, armpits and genitals are aching so much that $he nearly loses coherence... "
	elif actionname == 'spanking':
		text = "After bringing $name to the torture room, you tie $him securely to the table, baring $his defenseless bare butt for open access. Then you begin spanking $him, slowly at first. With each hit $his bottom gets redder and soon $his cries are filled with whimpers and tears. Despite $his appeals you don't stop until $he is nearly hoarse, making sure your lesson made its point. "
	elif actionname == 'whipping':
		text = "After bringing $name to the torture room, you place $him in standing position, naked before you. Then you take out a whip and start the lashings. At first $he stays silent but soon $he bursts out in tears and painful cries as you rain further lashes across $his body - making them string, especially when you focus on $his delicate parts. Despite $his appeals you don't stop until $he nearly hoarse, making sure your lesson made its point. "
	elif actionname == 'hotwax':
		text = "After bringing $name to the torture room, you tie $him securely to the bed, spread eagled and naked. Then you light a few candles and proceed to slowly drip hot wax over $his body. $He tries to break free and avoid the painful sensations, but it is to no avail. Irritating $his nipples and genitals seems to produce the best results. After some time you finally stop, making sure the lesson had an impact. "
	elif actionname == 'woodenhorse':
		text = "After bringing $name to the torture room, you tie $him securely to the wooden horse with $his legs spread wide. Adding some extra weights to hand from $his feet, you increase the pull against the uncomfortable seat and proceed to watch $his suffering. In no time $he starts begging for mercy, but you already made your decision and are not about to stop now. After some time you finally untie $him, making sure the lesson had an impact. "
	elif actionname == 'praise':
		text = "You give $name short speech praising $his recent behavior and achievments. "
		if slave.obed >= 85 && slave.praise == 0:
			slave.conf += rand_range(2,6)
			slave.loyal += rand_range(3,8)
			slave.sexuals.affection += round(rand_range(1,2))
			if slave.race == 'Human':
				slave.praise = 4
			else:
				slave.praise = 2
			slave.stress += -rand_range(5,10)
			text = text + "$He looks happy with your adoration and obediently bows to you. "
		elif slave.obed >= 85:
			text = text + "$He takes your words calmly without much of enthusiasm. You probably overpraised $him lately. "
			slave.praise += 1
		else:
			text = text + "$He takes your praise arrogantly, gaining joy from it. "
			if slave.race == 'Human':
				slave.praise = 2
			else:
				slave.praise = 1
			slave.cour += rand_range(2,5)
			slave.loyal += -rand_range(1,2)
			slave.obed += -rand_range(15,25)
	elif actionname == 'gift':
		globals.resources.gold -= 15
		text = "You present $name with small gift of adoration. "
		if slave.obed >= 85 && slave.praise == 0:
			slave.conf += rand_range(2,5)
			slave.sexuals.affection += round(rand_range(2,4))
			if slave.race == 'Human':
				slave.praise = 8
			else:
				slave.praise = 4
			slave.loyal += rand_range(5,12)
			slave.stress += -rand_range(10,20)
			text = text + "$He looks greatly pleased with it and thanks you properly. "
		elif slave.obed >= 85:
			text = text + "$He takes it with reasonable respect, but it seems you may have overpraised $him lately. "
			slave.praise += 1
			slave.loyal += rand_range(2,5)
			slave.stress += -rand_range(5,10)
		elif slave.obed < 85 && slave.praise == 0:
			text = text + "$He takes your gift with cautious expression but thanks you afterwards. $He does not feel like $he quite deserved it but slightly softens up to you. "
			if slave.race == 'Human':
				slave.praise = 4
			else:
				slave.praise = 2
			slave.obed += rand_range(20,40)
		else:
			text = text + "$He takes your gift without much of consideration. It seems your recent actions barely give $him any reason to appreciate your attention. "
			slave.praise += 1
			slave.obed += -rand_range(10,20)
			slave.loyal += -rand_range(4,8)
	if actionname in ['tickling','spanking','whipping','hotwax','woodenhorse']:
		if slave.lust > 70 || (slave.lust > 30 && (slave.traits.has('Masochist') == true||slave.asser <= 20)):
			text = text + "\nDuring the procedure $name twitches and climaxes, unable to hold back $his excitement."
			slave.lust = -rand_range(8,15)
			if rand_range(1,10) > 7 || slave.effects.has('entranced') == true:
				slave.add_trait('Masochist')
		if slave.traits.has('Masochist'):
			slave.sexuals.affection += round(rand_range(1,3))
		slave.stress += rand_range(15,25)
		slave.lust = rand_range(2,10)
		if slave.obed < 75||slave.traits.has('Masochist') == true:
			text = text + "\nBy the end $he begs for mercy and clearly takes your lesson to heart."
			slave.obed += rand_range(15,30)
			if slave.punish.expect == true:
				slave.obed += rand_range(30,60)
				if slave.race == 'Human':
					slave.punish.strength += 10 - slave.cour/25
				else:
					slave.punish.strength += 5 - slave.cour/25
			else:
				slave.conf += -rand_range(1,4)
				slave.cour += -rand_range(1,4)
		else:
			text = text + "\n$He obediently takes $his punishment and begs for your pardon, but it seems like $he doesn't feel $he trully deserved it."
			slave.obed += rand_range(15,25)
			slave.conf += -rand_range(1,4)
			slave.cour += -rand_range(1,4)
			slave.stress += rand_range(10,20)
			slave.loyal -= rand_range(5,10)
	
	
	if get_parent().get_node("customization/publiccheckbox").is_pressed() == true && globals.slaves.size() > 1 && !actionname in ['date','gift','praise','sex']:
		text = text + "Other servants watch your actions closely."
		for i in globals.slaves:
			if i.traits.has('Loner') == false && i.away.duration < 1:
				i.obed += max(rand_range(5,15)-i.conf/10,0)
			if actionname in ['tickling','spanking','whiping','hotwax','woodenhorse']:
				i.lust = rand_range(5,10)
	
	slave.attention = 0
	if nakedspritesdict.has(slave.unique):
		if actionname in ['praise','gift']:
			sprite = [[nakedspritesdict[slave.unique].clothcons, 'pos1']]
		else:
			sprite = [[nakedspritesdict[slave.unique].clothrape, 'pos1']]
	get_tree().get_current_scene().dialogue(true, self, slave.dictionary(text), buttons, sprite)
	get_tree().get_current_scene().rebuild_slave_list()
	get_parent()._on_slave_tab_visibility_changed()


func release():
	get_tree().get_current_scene().yesnopopup(slave.dictionary("[color=red]Let $name leave? You can't cancel this action.[/color]"),'getridof')



