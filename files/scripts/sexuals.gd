
extends Node

var slave
var lewddict = {'1' : 'innocent', '2' : 'curious', '3' : 'naughty', '4' : 'twisted'}
var domdict = {'1':'submissive','2': 'low','3':'neutral','4': 'high','5':'dominant'}
var hole = 'pussy'

var sexbuttons = globals.sexscenes.sexbuttons
var categories = globals.sexscenes.categories
var actiondescriptdict = globals.sexscenes.normalscenes




var sex_action = ''
var tab = ''
var partner

func _ready():
	for i in get_tree().get_nodes_in_group('sexunlockbuttons'):
		i.connect('pressed',self,'choosesection', [i])
		i.set_meta('button', i.get_name())
	
	for i in sexbuttons:
		sexbuttons[i].code = i

func _on_sexual_visibility_changed():
	slave = globals.slaves[get_tree().get_current_scene().currentslave]
	var tab = get_parent().tab
	var text = ''
	var button
	var allactions = []
	
	get_node("togglerape").set_pressed(slave.forcedsex)
	
	var rape = get_node("togglerape").is_pressed()
	
	if partner == null:
		partner = globals.player
	globals.partner = partner
	
	if tab == 'prison':
		get_node("togglerape").set_pressed(true)
		rape = true
		get_node("togglerape").set_disabled(true)
	else:
		get_node("togglerape").set_disabled(false)
	
	if slave.sexuals.unlocked == false:
		get_node("hidingpanel").set_hidden(false)
		get_node("hidingpanel/RichTextLabel").set_bbcode(slave.dictionary("You don't have $name's consent for personal actions. \n\n[color=red]Forcing $him into having sex will greatly impact $his opinion of you.[/color]"))
		return
	else:
		get_node("hidingpanel").set_hidden(true)
	
	
	for i in get_node("foreplaycontainer/VBoxContainer").get_children():
		if i != get_node("foreplaycontainer/VBoxContainer/Button"):
			i.set_hidden(true)
			i.queue_free()
	
	for i in get_node("penetrationcontainer/VBoxContainer").get_children():
		i.set_hidden(true)
		i.queue_free()
	
	for i in get_node("fetishcontainer/VBoxContainer").get_children():
		i.set_hidden(true)
		i.queue_free()
	
	
	globals.currentslave = slave
	globals.partner = partner
	
	if slave.sexuals.has('lastaction') == false:
		slave.sexuals.lastaction = null
	
	var actionarray = []
	for i in sexbuttons.values():
		actionarray.append(i)
	actionarray.sort_custom(globals, 'sortbycost')
	
	if rape == false:
		for action in actionarray:
			if !slave.sexuals.actions.has(action.code) || globals.evaluate(action.slavereqs) == false || globals.evaluate(action.playerreqs) == false:
				continue
			if (action.code == "rimjob" || action.code == "rimjobtake") && slave.sexuals.unlocks.has('anal') == false:
				continue
			if globals.rules.receiving == false && action.tags.find('receiving') == true:
				continue
			button = get_node("foreplaycontainer/VBoxContainer/Button").duplicate()
			button.set_hidden(false)
			button.add_to_group('sexactions')
			button.get_node("Label").set_text(str(action.cost))
			if action.type == "foreplay":
				get_node("foreplaycontainer/VBoxContainer").add_child(button)
			elif action.type == 'penetration':
				get_node("penetrationcontainer/VBoxContainer").add_child(button)
			else:
				get_node("fetishcontainer/VBoxContainer").add_child(button)
			button.set_text(action.name)
			button.set_meta('action', action)
			allactions.append(button)
			button.connect("pressed",self,"sexactionchosen",[button])
	else:
		for i in sexbuttons.values():
			if  globals.evaluate(i.slavereqs) == false || globals.evaluate(i.playerreqs) == false:
				continue
			if i.canbeforced == true && (i.code in ['bestiality', 'ass', 'dildo', 'lbondage', 'hbondage','oral','blowjobgive','tribadism','pussytake'] || slave.sexuals.actions.has(i.code) ||(i.code == 'pussy' && slave.pussy.has == true)):
				button = get_node("foreplaycontainer/VBoxContainer/Button").duplicate()
				button.set_hidden(false)
				button.add_to_group('sexactions')
				button.get_node("Label").set_text(str(i.cost))
				if i.type == "foreplay":
					get_node("foreplaycontainer/VBoxContainer").add_child(button)
				elif i.type == 'penetration':
					get_node("penetrationcontainer/VBoxContainer").add_child(button)
				else:
					get_node("fetishcontainer/VBoxContainer").add_child(button)
				button.set_text(i.name)
				button.set_meta('action', i)
				allactions.append(button)
				button.connect("pressed",self,"sexactionchosen",[button])
	
	
	updateinfo()
	
	if slave.sexuals.unlocks.has('swing') == false && rape == false:
		get_node("partner").set_disabled(true)
		get_node("partner").set_tooltip(slave.dictionary("Must unlock Swing category before $name would agree to change partners."))
	else:
		get_node("partner").set_disabled(false)
		get_node("partner").set_tooltip("")
	
	if slave.sexuals.unlocks.has('group') == false:
		get_node("group").set_disabled(true)
		get_node("group").set_tooltip(slave.dictionary("Must unlock Group category before $name would agree to participate in group sex. "))
	else:
		get_node("group").set_disabled(false)
		get_node("group").set_tooltip("")
	
	get_node("descriptpanel").set_hidden(true)
	get_node("confirmbutton").set_disabled(true)
	
	for i in allactions:
		if i.get_meta('action').code == slave.sexuals.lastaction:
			sexactionchosen(i)
	
####Sexuals

func updateinfo():
	var text = ''
	if slave.lust < 20:
		text = text + '$name looks calm and uninterested in sex. '
	elif slave.lust < 50:
		text = text + '$name looks slightly horny and restless. '
	else:
		text = text + '$name looks fairly aroused and provocative. '
	if slave.obed < 50:
		text = text + "\n$name's poor behavior makes cooperation unlikable. "
	
	if slave.dom < 40:
		text += "\n$name acts fairly timid and expects you to take intiative and ready to serve, rather than being served. "
	elif slave.dom > 60:
		text += "\n$name acts more assertive towards you and seemingly finds more pleasure in being served, rather than serving $himself. "
	
	text += "\nChosen partner: "
	if partner != globals.player:
		text += partner.dictionary("$name")
	else:
		text += 'You'
	
	get_node("description").set_bbcode(slave.dictionary(text))
	
	get_node("lewdness").set_text("Available affection: "+ str(slave.sexuals.affection) + '; Energy left: ' + str(round(slave.stats.energy_cur)))


func _on_togglerape_pressed():
	partner = null
	slave.forcedsex = get_node("togglerape").is_pressed()
	_on_sexual_visibility_changed()

func sexactionchosen(button):
	var text = ''
	var action = button.get_meta('action')
	slave.sexuals.lastaction = action.code
	button.set_pressed(true)
	get_node("confirmbutton").set_meta('action', action)
	for i in get_tree().get_nodes_in_group("sexactions"):
		if i != button:
			i.set_pressed(false)
	text += slave.dictionary(action.description)
	if globals.player != partner:
		text = text.replace('your', "$name's")
		text = text.replace('You', '$name')
		text = text.replace('you', '$name')
	text = partner.dictionary(text)
	if slave.sexuals.actions.has(action.code):
		if slave.sexuals.actions[action.code] >= 1:
			text += slave.dictionary("\n\n$name has engaged in this " + str(slave.sexuals.actions[action.code]) + " times. ")
	get_node("descriptpanel").set_hidden(false)
	get_node("confirmbutton").set_disabled(false)
	get_node("descriptpanel/holebutton").set_hidden(true)
	get_node("descriptpanel/holebutton").clear()
	if action.tags.find("choosehole") >= 0:
		text += slave.dictionary("\n\nWhich hole $name should use?")
		get_node("descriptpanel/holebutton").set_hidden(false)
		if slave.pussy.has == true:
			get_node("descriptpanel/holebutton").add_item("Pussy", 1)
		if (slave.sexuals.unlocks.has('anal') == true || slave.pussy.has == false) || get_node("togglerape").is_pressed() == true:
			get_node("descriptpanel/holebutton").add_item("Ass", 2)
		if get_node("descriptpanel/holebutton").get_item_count() < 1:
			get_node("descriptpanel/holebutton").set_hidden(true)
			
			
	elif action.tags.find("chooseholeself") >= 0:
		get_node("descriptpanel/holebutton").set_hidden(false)
		if partner == globals.player:
			text += "\n\nWhich of your holes you would like to use?"
		else:
			text += partner.dictionary("\n\nWhich of $name's holes should be used")
		if partner.pussy.has == true:
			get_node("descriptpanel/holebutton").add_item("Pussy", 1)
		get_node("descriptpanel/holebutton").add_item("Ass", 2)
	get_node("descriptpanel/RichTextLabel").set_bbcode(text)


func _on_confirmbutton_pressed():
	var text = ''
	var rape = get_node("togglerape").is_pressed()
	var action = get_node("confirmbutton").get_meta('action')
	
	if rape == false && slave.traits.has("Sex-crazed") == false && !slave.spec in ['geisha','nympho'] :
		var difficulty = 0
		if action.tags.find('degrading') >= 0 && slave.traits.has("Deviant") == false:
			difficulty += 20
		if action.tags.find('penetration') >= 0 && slave.pussy.virgin == true && action.tags.find('anal') < 0:
			difficulty += 10
		if action.tags.find('fetish') >= 0 && slave.traits.has("Deviant") == false && slave.traits.has("Pervert") == false && slave.traits.has("Slutty") == false:
			difficulty += 15
		if slave.traits.has("Prude") == true: 
			difficulty += 10
		if action.tags.find("anal") >= 0 || (get_node("descriptpanel/holebutton").is_hidden() == false && get_node("descriptpanel/holebutton").get_selected_ID() == 2):
			difficulty += 15
		if partner.sex == slave.sex && slave.traits.has("Bisexual") == false:
			difficulty += 10
		if (slave.relatives.father == 0 || slave.relatives.mother == 0):
			difficulty += 10
		if action.tags.find('sub') >= 0 && slave.dom > 60:
			difficulty += 10
		elif action.tags.find('sub') >= 0 && slave.dom < 40:
			difficulty -= 15
		elif action.tags.find('dom') >= 0 && slave.dom < 40:
			difficulty += 10
		elif action.tags.find('dom') >= 0 && slave.dom > 60:
			difficulty -= 10
		difficulty -= slave.lust/5 + slave.sexuals.actions.size()
		difficulty += max(80-slave.obed, 0) + max(15-slave.loyal, 0)
		if difficulty >= 15:
			text += slave.dictionary("[color=yellow]—I'm sorry $master, but I'm not in the mood for this... [/color]\n\n$name looks reluctant at your suggestion. Perhaps it's better to start with something smaller. Or force $him...")
			get_tree().get_current_scene().popup(text)
			return
	
	if action.cost > slave.energy:
		text = slave.dictionary("$name has not enough energy for this action. ")
		get_tree().get_current_scene().popup(text)
		return
	elif action.cost > partner.energy || action.cost > globals.player.energy:
		if partner == globals.player:
			text = "You don't have enough energy for this action. "
		else:
			text = partner.dictionary("$name has not enough energy for this action. ")
		get_tree().get_current_scene().popup(text)
		return
	elif slave.stress >= 80 && rape == false:
		text = slave.dictionary("$name is too stressed and wishes to stay alone.")
		return
	elif slave.pussy.virgin == true && action.tags.find('penetration') >= 0 && (get_node("descriptpanel/holebutton").get_selected_ID() == 1 || action.tags.find('pussy') >= 0):
		get_tree().get_current_scene().yesnopopup(slave.dictionary("$name currently is a virgin. Continue?"), 'sexinitiate' ,self)
		return
	
	sexinitiate()

var nakedspritesdict = {
	Cali = {cons = 'calinakedhappy', rape = 'calinakedangry', clothcons = 'calineutral', clothrape = 'caliangry2'},
	Tisha = {cons = 'tishanakedhappy', rape = 'tishanakedneutral', clothcons = 'tishahappy', clothrape = 'tishaneutral'},
	Emily = {cons = 'emilynakedhappy', rape = 'emilynakedneutral', clothcons = 'emily2happy', clothrape = 'emily2worried'},
	Chloe = {cons = 'chloenakedhappy', rape = 'chloenakedneutral', clothcons = 'chloehappy2', clothrape = 'chloeneutral2'},
	Maple = {cons = 'fairynaked', rape = 'fairynaked', clothcons = 'fairy', clothrape = 'fairy'},
	}

func sexinitiate(secondtime = false):
	var text = ''
	var endtext = ''
	var rape = get_node("togglerape").is_pressed()
	var action = get_node("confirmbutton").get_meta('action')
	var holedict = {1:'pussy', 2:'ass'}
	var orgasm = false
	var rapelike = false
	var wantsmore
	var managain
	var affectionreward = action.basereward
	var hasalternativetext = false
	var consecheck = 'consensual'
	var lusteffect = action.lusteffect
	var buttons = []
	var sprites = []
	
	slave.metrics.sex += 1
	partner.metrics.sex += 1
	
	if globals.state.sidequests.emily == 16 && slave.unique in ['Emily','Tisha'] && partner.unique in ['Emily','Tisha']:
		emilytishascene()
		return
	
	if partner.metrics.partners.find(slave.id) < 0:
		partner.metrics.partners.append(slave.id)
	if slave.metrics.partners.find(partner.id) < 0:
		slave.metrics.partners.append(partner.id)
	
	if slave.sexuals.actions.has(action.code) == false: 
		slave.sexuals.actions[action.code] = 0
	slave.sexuals.actions[action.code] += 1
	
	
	
	if get_node("descriptpanel/holebutton").is_hidden() == false && secondtime != true:
		hole = holedict[get_node("descriptpanel/holebutton").get_selected_ID()]
	
	if actiondescriptdict.has(action.code):
		if rape == true:
			slave.metrics.roughsex += 1
			if partner == globals.player:
				text += actiondescriptdict[action.code].rape
			else:
				text += actiondescriptdict[action.code].swingforced
		else:
			if partner == globals.player:
				text += actiondescriptdict[action.code].consensual
			else:
				text += actiondescriptdict[action.code].swing
	
	if action.tags.find('degrading') >= 0 && (slave.traits.has("Deviant") == true || slave.spec == 'nympho'):
		lusteffect = lusteffect*1.2
	if action.tags.find('fetish') >= 0 && (slave.traits.has("Deviant") == true || slave.traits.has("Pervert") == true || slave.traits.has("Slutty") == true || slave.spec in ['geisha','nympho']):
		lusteffect = lusteffect*1.3
	if slave.traits.has("Prude") == true && (action.tags.find("fetish") >= 0 || action.tags.find("degrading") >= 0) : 
		slave.stress += lusteffect
		lusteffect = lusteffect*0.5
	if partner.sex == slave.sex && slave.traits.has("Bisexual") == false && slave.traits.has("Sex-crazed") == false && !slave.spec in ['geisha','nympho']:
		slave.stress += max(-20 + slave.conf, 0)
		lusteffect = lusteffect*0.8
		text += "\n\n[color=yellow]$name experience some discomfort by having sex with someone of $his own gender. [/color]"
	if action.tags.find('sub') >= 0:
		slave.dom -= lusteffect/8
	elif action.tags.find('dom') >= 0:
		slave.dom += lusteffect/8
	
	
	if rape == true && (slave.traits.has("Likes it rough") == true || slave.traits.has("Sex-crazed") || slave.traits.has("Submissive") || slave.spec in ['geisha','nympho']):
		rapelike = true
		slave.metrics.roughsexlike += 1
	
	if rape == true && slave.traits.has("Sex-crazed") == false:
		if  slave.traits.has("Submissive") == false || slave.loyal < 40:
			slave.stress += lusteffect/1.5
	
	if rapelike == true && rape == true:
		text += "\nAfter some time, you notice that despite $name's initial resistance $he seems to be actually enjoying the rough treatment. "
		consecheck = 'nonconsensuallike'
		slave.loyal += rand_range(3,5)
	elif rapelike == false && rape == true:
		affectionreward = 1
		slave.loyal -= slave.conf/4
		slave.obed -= slave.cour/2
		lusteffect = lusteffect/2
		text += "\nAfter some time $name drops any active resistance and attempts to endure through your abuse. "
		consecheck = 'nonconsensualdislike'
	
	if slave.effects.has("stimulated"):
		lusteffect = lusteffect*1.5
	elif slave.effects.has('numbed'):
		lusteffect = lusteffect/0.6
	
	slave.lust = lusteffect
	
	if action.code == "lbondage":
		slave.obed += rand_range(20,30)
	elif action.code == "hbondage":
		slave.obed += rand_range(25,50)
	
	if action.tags.find('cancum') >= 0 && slave.lust+slave.loyal/2 >= 100:
		orgasm = true
		slave.loyal += rand_range(2,5)
	
	var temptext = checktext(action.code, consecheck)
	if temptext != '' && partner == globals.player:
		text = temptext
	
	managain = action.basemana + slave.stats.maf_cur
	if slave.race == "Drow" || (partner.race == "Drow" && partner != globals.player):
		managain = managain*1.2
	if slave.spec == 'nympho':
		managain += 2
	managain = round(managain)
	if action.tags.find('penetration') >= 0  && (action.tags.find('pussy') >= 0 || ( hole == 'pussy' && action.tags.find('choosehole') >= 0)):
		slave.metrics.vag += 1
		if slave.pussy.virgin == true:
			slave.pussy.virgin = false
			if action.code != 'bestiality':
				if partner == globals.player:
					slave.pussy.first = 'you'
					text += "\n\n[color=yellow]You tear through $name's hymen and claim $his virginity. [/color]"
				else:
					slave.pussy.first = partner.id
					text += ("\n\n[color=yellow]$2name tears through $name's hymen and claims $his virginity. [/color]")
				if (rape == false || rapelike == true) && partner == globals.player:
					slave.loyal += 10
					text += "[color=green]$He seems to be glad about it. [/color]"
	elif action.tags.find("selfpenetration") >= 0 && (hole == 'pussy'||action.code == 'pussytake'):
		partner.metrics.vag += 1
		if partner.pussy.virgin == true:
			partner.pussy.virgin = false
			partner.pussy.first = slave.id
			if globals.player == partner:
				text += slave.dictionary("[color=yellow]\n\n$name has taken your virginity.[/color] ")
			else:
				text += slave.dictionary("[color=yellow]\n\n$name") + partner.dictionary(" has taken $name's virginity.[/color] ")
	elif action.tags.find('penetration') >= 0  && (hole == 'ass' || action.tags.find('anal') >= 0):
		slave.metrics.anal += 1
	elif action.tags.find('selfpenetration') >= 0  && (hole == 'ass' || action.tags.find('anal') >= 0):
		partner.metrics.anal += 1
	if action.code == 'pussy':
		get_tree().get_current_scene().impregnation(slave, partner)
	if action.code in ['blowjob','oraltake','rimjob']:
		slave.metrics.oral += 1
	elif action.code in ['blowjobgive','oral','rimjobgive']:
		partner.metrics.oral += 1
	if action.code in ['frottage','tribadism'] && slave.traits.has('Bisexual') == false && rand_range(0,10) >= 2.5:
		slave.add_trait(globals.origins.trait("Bisexual"))
	if orgasm == true:
		managain += 1
		slave.metrics.orgasm += 1
		text += "\n\n$name has achieved orgasm. "
		affectionreward += 1
		slave.lust = -(slave.lust/2 + rand_range(10,20))
		if action.code == 'pussytake':
			get_tree().get_current_scene().impregnation(partner, slave)
		var counter = 0
		if slave.traits.has("Prude") == true && (rand_range(0,1) >= 0.8 || slave.effects.has('entranced') == true) :
			slave.trait_remove("Prude")
			text += "\n\n[color=yellow]$name is no longer Prude. [/color]"
		if action.tags.find("fetish") >= 0 && slave.traits.has("Pervert") == false  && (rand_range(0,1) >= 0.8 || slave.effects.has('entranced') == true):
			slave.add_trait(globals.origins.trait("Pervert"))
			counter += 1
		if action.tags.find("degrading") >= 0 && slave.traits.has("Deviant") == false && (rand_range(0,1) >= 0.8 || slave.effects.has('entranced') == true):
			slave.add_trait(globals.origins.trait("Deviant"))
			counter += 1
		if slave.sex == partner.sex && slave.traits.has("Bisexual") == false && (rand_range(0,1) >= 0.8 || slave.effects.has('entranced') == true):
			slave.add_trait(globals.origins.trait("Bisexual"))
			counter += 1
		if rape == true && slave.traits.has("Likes it rough") == false && (rand_range(0,1) >= 0.8 || slave.effects.has('entranced') == true):
			slave.add_trait(globals.origins.trait("Likes it rough"))
			counter += 1
		elif rape == true && slave.traits.has("Likes it rough") == true && rand_range(0,1) >= 0.9:
			slave.add_trait(globals.origins.trait("Submissive"))
			counter += 1
		if counter >= 1:
			text += "\n\n[color=yellow]$name has adopted a new quirk. [/color]"
		if action.tags.find("degrading") >= 0 && slave.traits.has("Deviant") == false && slave.spec != 'nympho':
			slave.stress += rand_range(15,20)
	elif action.tags.find('cancum') >= 0 && ((rapelike == false && rape == false) || rapelike == true):
		text += "\n\nBy the end, $name does not appear to be completely satisfied as $he wasn't able to cum. "
	
	if (rape == false || rapelike == true) && partner == globals.player && tab != 'prison':
		if orgasm == false:
			wantsmore = true
		elif slave.lust >= 50:
			wantsmore = true
	
	
	slave.metrics.manaearn += managain
	globals.resources.mana += managain
	if secondtime == true:
		globals.player.energy = round(-action.cost/2)
		slave.energy = round(-action.cost/2)
		slave.lust = -20
	else:
		slave.energy = -action.cost
		partner.energy = -action.cost
		if slave.spec == 'nympho':
			slave.energy = action.cost/2
			text += "\n[color=green]$name's skills and training helped $him waste less energy.[/color]"
		if globals.player != partner:
			globals.player.energy = -action.cost
	
	text += "\n\n[color=green]Earned " + str(affectionreward) + " affection with $name. [/color]"
	text += "\n\n[color=aqua]You've gained " + str(managain) + " mana. [/color]"
	
	slave.sexuals.affection += affectionreward
	
	
	
	for i in [slave, partner]:
		if i.unique in ['Cali','Tisha','Emily', 'Chloe','Maple']:
			var sprite
			var pos 
			if action.code == 'kiss':
				if rape == true && rapelike == false:
					sprite = nakedspritesdict[i.unique].clothrape
				else:
					sprite = nakedspritesdict[i.unique].clothcons
			else:
				if rape == true && rapelike == false:
					sprite = nakedspritesdict[i.unique].rape
				else:
					sprite = nakedspritesdict[i.unique].cons
			if i == slave:
				pos = 'pos1'
			else:
				pos = 'pos2'
			sprites.append([sprite, pos])
	
	text += getessencesfromsex(slave, managain)
	
	text = text.replace("$hole", hole)
	if wantsmore == true && slave.loyal+slave.lust >= 75:
		slave.charm += rand_range(3,6)
		var array = []
		for i in slave.sexuals.actions:
			if sexbuttons[i].tags.find('cancum') >= 0 &&  globals.evaluate(sexbuttons[i].playerreqs) && globals.evaluate(sexbuttons[i].slavereqs) && ((sexbuttons[i].receive == true && globals.rules.receiving == true) || sexbuttons[i].receive == false ):
				if sexbuttons[i].tags.find('dom') >= 0 && slave.dom < 40:
					continue
				if sexbuttons[i].tags.find("sub") >= 0 && slave.dom > 60:
					continue
				if sexbuttons[i].tags.find('degrading') >= 0 && slave.traits.has("Deviant") == false:
					continue
				else:
					array.append(sexbuttons[i])
		if array.size() < 1:
			text += "\n\n$name does not seem to be completely satisfied, but won't dare to ask you for something more."
		else:
			var tempaction = array[rand_range(0,array.size())]
			if tempaction.tags.find('choosehole') >= 0:
				if slave.pussy.has == false:
					hole = 'ass'
				else:
					if slave.sexuals.unlocks.has('anal') == false:
						hole = 'pussy'
					else:
						if slave.pussy.virgin == true && tempaction.tags.find("penetration"):
							hole = 'ass'
						else:
							hole = holedict[int(round(rand_range(1,2)))]
				
			if tempaction.cost/2 <= partner.energy && tempaction.cost/2 <= slave.energy:
				text += "\n\n[color=#ee2269]" + moresexline(tempaction.name) + "[/color]"
				text = text.replace("$hole", hole)
				buttons.append([slave.dictionary('Concur with the request: '+ str(tempaction.cost/2) + " energy." ),'repeatsex',tempaction])
	text = slave.dictionary(text)
	text = text.replace('$2','$')
	text = partner.dictionary(text)
	get_tree().get_current_scene().dialogue(true, self, slave.dictionary(text), buttons, sprites)
	get_tree().get_current_scene().rebuild_slave_list()
	get_parent()._on_slave_tab_visibility_changed()
	updateinfo()

func moresexline(actionname):
	var text = actionname
	var dict = {
	"Vaginal Sex":"$name presents $his pussy to you, asking to be penetrated. ",
	"Fuck with Dildo":"$name wants you to roughly fuck $his $hole with a dildo.",
	"Give Blowjob":"$name begs you to suck on $his cock. ",
	"Give Handjob":"$name presents you $his hard cock, hoping you would stroke it until $he achieves relief. ",
	"Give Titfuck":"$name asks you to give $him a titjob. ",
	"Give Footjob":"$name begs you to please $his hard penis with your feet. ",
	"Give Rimjob":"$name presents you $his butthole and hints that $he wants you to lick it. ",
	"Receive Vaginal Sex":"$name asks you for a permission to stick $his dick into your pussy.",
	"Receive Anal Sex":"$name requests you to let $him fuck you in the ass. ",
	"Nipplefuck":"$name presents you with $his soaking, stretched nipples and begs you to fuck them. ",
	"Tailpegging":"$name hopes you could fuck $his $hole with your tail. ",
	"Oral":"$name presents you with $his pussy, hinting $he would love cunnilingus from you. ",
	"Anal Sex":"$name begs you to fuck $his ass. ",
	"Fingering":"$name hopes you could finger $his $hole. ",
	"Light bondage":"$name timidly suggests you to tie $him up and punish $him for being a bad $child. ",
	"Hard bondage":"$name tells you, $he's in the mood for some heavy punishment delivered by you. ",
	}
	if dict.has(text):
		return dict[text]
	else:
		return text

func repeatsex(action):
	get_node("confirmbutton").set_meta('action', action)
	get_node("togglerape").set_pressed(false)
	sexinitiate(true)

func _on_fix_pressed():
	if slave.sexuals.actions.has('kiss') == false:
		slave.sexuals.actions.kiss = 0
	if slave.sexuals.actions.has('massage') == false:
		slave.sexuals.actions.massage = 0
	_on_sexual_visibility_changed()


func _on_group_pressed():
	get_node("group/grouppopup/Panel/threesome").set_pressed(false)
	get_node("group/grouppopup/Panel/orgy").set_pressed(false)
	get_node("group/grouppopup/Panel/partner2").set_hidden(true)
	get_node("group/grouppopup").popup()
	groupcheck()

var threesomepartner

func groupcheck(slave2 = null):
	threesomepartner = slave2
	var text = 'Select one option you wish to initiate. \n\n[color=yellow]You can only initiate one group sex per day. [/color]'
	if get_node("group/grouppopup/Panel/threesome").is_pressed() == true:
		get_node("group/grouppopup/Panel/partner2").set_hidden(false)
		get_node("group/grouppopup/Panel/confirm").set_disabled(false)
		get_node("group/grouppopup/Panel/confirm").set_meta("action",'threesome')
		text = "Threesome will include an additional person, who has group sex unlocked. You can only have group sex once a day. "
		text += "You've selected " + globals.fastif(threesomepartner == null, 'nobody', '[color=aqua]$name[/color]') + " as third person. "
		if threesomepartner != null:
			text = threesomepartner.dictionary(text)
		if threesomepartner != null && globals.state.groupsex == true:
			get_node("group/grouppopup/Panel/confirm").set_disabled(false)
		elif globals.state.groupsex == false:
			text += "\n[color=red]You've already done group sex today. [/color]"
		else:
			get_node("group/grouppopup/Panel/confirm").set_disabled(true)
	else:
		get_node("group/grouppopup/Panel/partner2").set_hidden(true)
		threesomepartner = null
	if get_node("group/grouppopup/Panel/orgy").is_pressed() == true:
		get_node("group/grouppopup/Panel/partner2").set_hidden(true)
		get_node("group/grouppopup/Panel/confirm").set_disabled(false)
		get_node("group/grouppopup/Panel/confirm").set_meta("action",'orgy')
		text = "Orgy will involve everyone available with Group sex unlocked. Mana generation will depend on number of participants. This action will cause mess and might cause stat drop on people involved. \nRequires [color=yellow]1 Aphrodite Brew[/color]. "
	if (get_node("group/grouppopup/Panel/threesome").is_pressed() == false && get_node("group/grouppopup/Panel/orgy").is_pressed() == false) || globals.player.energy < 35 || globals.state.groupsex == false || (get_node("group/grouppopup/Panel/orgy").is_pressed() == true && globals.itemdict.aphroditebrew.amount < 1):
		get_node("group/grouppopup/Panel/confirm").set_disabled(true)
	get_node("group/grouppopup/Panel/groupdescript").set_bbcode(text)

func _on_close_pressed():
	get_node("group/grouppopup").set_hidden(true)
	get_node("group/grouppopup/Panel/orgy").set_pressed(false)
	get_node("group/grouppopup/Panel/threesome").set_pressed(false)


func _on_orgy_pressed():
	get_node("group/grouppopup/Panel/threesome").set_pressed(false)
	groupcheck()


func _on_threesome_pressed():
	get_node("group/grouppopup/Panel/orgy").set_pressed(false)
	groupcheck()


func _on_confirm_pressed():
	var action = get_node("group/grouppopup/Panel/confirm").get_meta("action") #orgy threesome
	var text = ''
	var mana = 0
	var array = []
	var drows = 0
	var sprites = []
	if globals.state.sidequests.emily == 16 && (action == 'threesome' && slave.unique in ['Emily','Tisha'] && threesomepartner.unique in ['Emily','Tisha']):
		emilytishascene()
		return
	if action == 'threesome':
		
		array = [slave, threesomepartner]
		for i in [slave, threesomepartner]:
			if i.unique in ['Cali','Tisha','Emily']:
				var sprite
				var pos 
				sprite = nakedspritesdict[i.unique].cons
				if i == slave:
					pos = 'pos1'
				else:
					pos = 'pos2'
				sprites.append([sprite, pos])
		globals.player.energy = -30
		text += "You, " + slave.dictionary("$name, ") + threesomepartner.dictionary("and $name get onto the bed and spend next few hours having wild sex with each other. ")
		mana += round(slave.lust/15 + threesomepartner.lust/15 + 4)
		slave.metrics.manaearn += round(mana/2)
		threesomepartner.metrics.manaearn += round(mana/2)
		if slave.race == "Drow":
			drows += 1
		if threesomepartner.race == "Drow":
			drows += 1
		if drows > 0:
			mana += mana*(1.2*drows)
		if slave.spec == 'nympho':
			mana += 2
		if threesomepartner.spec == 'nympho':
			mana += 2
		text += getessencesfromsex(slave, slave.lust/15)
		text += getessencesfromsex(threesomepartner, threesomepartner.lust/15)
		get_tree().get_current_scene().impregnation(slave, threesomepartner)
		get_tree().get_current_scene().impregnation(threesomepartner, slave)
		for i in array:
			i.metrics.threesome += 1
			i.lust = -rand_range(20,35)
			i.obed += rand_range(10,20)
			i.loyal += rand_range(5,10)
			i.energy = -30
			get_tree().get_current_scene().impregnation(i, globals.player)
			get_tree().get_current_scene().impregnation(globals.player, i)
		text += "\nAfter you're done your both partners look exhausted and satisfied. "
	elif action == 'orgy':
		for i in globals.slaves:
			if i.sexuals.unlocks.has('group') && i.away.duration == 0:
				array.append(i)
		if array.size() < 3:
			text += "You don't have enough slaves who would willingly participate in orgy. " 
			get_tree().get_current_scene().popup(text)
			return
		text += "You gather " + str(array.size()) + " servants and make an announcement, that today they will be learning more about themselves and those around them. As you pass everyone some spiked drinks it does not take long for them to lose themselves in their lust and begin pleasuring eachother. " 
		for i in array:
			i.metrics.orgy += 1
			globals.state.condition = -rand_range(5,10)
			text += getessencesfromsex(i, 5)
			get_tree().get_current_scene().impregnation(i, array[rand_range(0, array.size())])
			mana += round(slave.lust/15)+3
			if i.race == "Drow":
				mana += 1
			if i.spec == 'nympho':
				mana += 2
			i.lust = -rand_range(10,25)
			if rand_range(0,100) >= 95:
				i.wit += -rand_range(5,10)
		globals.itemdict.aphroditebrew.amount -= 1
	text += "\n\nYou earned " + str(mana) + " mana."
	globals.resources.mana += round(mana)
	
	globals.state.groupsex = false
	get_node("group/grouppopup").set_hidden(true)
	get_tree().get_current_scene().dialogue(true, self, text, [], sprites)

func emilytishascene():
	globals.state.sidequests.emily = 17
	globals.events.emilytishasex()

func _on_partner2_pressed():
	globals.partner = slave
	get_tree().get_current_scene().selectslavelist(false, 'groupcheck', self, 'globals.currentslave.sexuals.unlocks.has("group") && globals.partner != globals.currentslave')


func checktext(action, cons):
	var text = globals.sexscenes.getscene(action, slave, cons, hole)
	return text

func getessencesfromsex(slave, mana):
	var text = ''
	if mana*3 + slave.stats.maf_cur*20 > rand_range(0,100):
		if slave.race in ['Demon', 'Arachna', 'Lamia']:
			text = text + '\n\nYou have acquired [color=yellow]Tainted Essence[/color].'
			globals.itemdict.taintedessenceing.amount += 1
		elif slave.race in ['Fairy', 'Drow', 'Dragonkin']:
			text = text + '\n\nYou have acquired [color=yellow]Magic Essence[/color].'
			globals.itemdict.magicessenceing.amount += 1
		elif slave.race == 'Dryad':
			text = text + '\n\nYou have acquired [color=yellow]Nature Essence[/color].'
			globals.itemdict.natureessenceing.amount += 1
		elif  slave.race in ['Harpy', 'Centaur'] || slave.race.find('Beastkin') >= 0 || slave.race.find('Halfkin') >= 0:
			text = text + '\n\nYou have acquired [color=yellow]Bestial Essence[/color].'
			globals.itemdict.bestialessenceing.amount += 1
		elif slave.race in ['Slime','Nereid', "Scylla"]:
			text += '\n\nYou have acquired [color=yellow]Fluid Substance[/color].'
			globals.itemdict.fluidsubstanceing.amount += 1
	return text


var piercingdict = {

earlobes = {
name = 'earlobes', options = ['earrings', 'stud'], requirement = null, id = 1
},
eyebrow = {
name = 'eyebrow', options = ['stud'], requirement = null, id = 2
},
nose = {
name = 'nose', options = ['stud', 'ring'], requirement = null, id = 3
},
lips = {
name = 'lips', options = ['stud', 'ring'], requirement = null, id = 4
},
tongue = {
name = 'tongue', options = ['stud'], requirement = null, id = 5
},
navel = {
name = 'navel', options = ['stud'], requirement = null, id = 6
},
nipples = {
name = 'nipples', options = ['ring', 'stud', 'chain'], requirement = 'lewdness', id = 7
},
clit = {
name = 'clit', options = ['ring', 'stud'], requirement = 'lewdness, pussy', id = 8
},
labia = {
name = 'labia', options = ['ring', 'stud'], requirement = 'lewdness, pussy', id = 9
},
penis = {
name = 'penis', options = ['ring', 'stud'], requirement = 'lewdness, penis', id = 10
},
}

func _on_piercing_pressed():
	get_node("piercingpanel").set_hidden(false)
	for i in get_node("piercingpanel/ScrollContainer/VBoxContainer").get_children():
		if i != get_node("piercingpanel/ScrollContainer/VBoxContainer/piercingline"):
			i.set_hidden(true)
			i.queue_free()
	if slave.lewd >= 100:
		get_node("piercingpanel/piercestate").set_text(slave.dictionary('$name does not seems to mind you piercing $his private places.'))
	else:
		get_node("piercingpanel/piercestate").set_text(slave.dictionary('$name refuses to let you pierce $his private places'))
	
	for i in piercingdict:
		if slave.piercing.has(i) == false:
			slave.piercing[i] = null
	
	var array = []
	for i in piercingdict.values():
		array.append(i)
	array.sort_custom(self, 'idsort')
	
	
	for ii in array:
		if ii.requirement == null || (slave.lewd >= 100 && ii.requirement == 'lewdness') || (slave.penis.number >= 1 && slave.lewd >= 100 && ii.id == 10) || (slave.pussy.has == true && slave.lewd >= 100 && (ii.id == 8 || ii.id == 9)):
			var newline = get_node("piercingpanel/ScrollContainer/VBoxContainer/piercingline").duplicate()
			newline.set_hidden(false)
			get_node("piercingpanel/ScrollContainer/VBoxContainer").add_child(newline)
			newline.get_node("placename").set_text(ii.name.capitalize())
			for i in ii.options:
				newline.get_node("pierceoptions").add_item(i)
				if slave.piercing[ii.name] == i:
					newline.get_node("pierceoptions").select(newline.get_node("pierceoptions").get_item_count()-1) 
				#elif slave.piercing[ii.name] == null:
				#	newline.get_node('pierceoptions').set_disabled(true)
				#	newline.get_node('pierceoptions').set_text('Non Pierced')
			newline.get_node('pierceoptions').set_meta('pierce', ii.name)
			newline.get_node("pierceoptions").connect("item_selected", self, 'pierceselect', [newline.get_node("pierceoptions").get_meta('pierce')])

func idsort(first, second):
	if first.id < second.id:
		return true
	else:
		return false

func pierceselect(ID, node):
	if ID == 0:
		slave.piercing[node] = 'pierced'
	else:
		slave.piercing[node] = piercingdict[node].options[ID-1]
	_on_piercing_pressed()



func _on_closebutton_pressed():
	get_node("unlockbutton/unlockpopup").set_hidden(true)


var unlockpressedbutton

func _on_unlockbutton_pressed():
	get_node("unlockbutton/unlockpopup").popup()
	get_node("unlockbutton/unlockpopup/Panel/affectionstatus").set_text("Affection left: " + str(slave.sexuals.affection))
	unlockpressedbutton = null
	for i in get_tree().get_nodes_in_group('sexunlockbuttons'):
		i.set_pressed(false)
	buildlist()

func choosesection(button):
	for i in get_tree().get_nodes_in_group('sexunlockbuttons'):
		if i != button:
			i.set_pressed(false)
	unlockpressedbutton = button.get_meta('button')
	buildlist()

func buildlist():
	var button
	var array = []
	
	for i in get_node("unlockbutton/unlockpopup/Panel/ScrollContainer/VBoxContainer").get_children():
		if i != get_node("unlockbutton/unlockpopup/Panel/ScrollContainer/VBoxContainer/Button"):
			i.set_hidden(true)
			i.queue_free()
	
	get_node("unlockbutton/unlockpopup/Panel/unlockdescription").set_bbcode('')
	get_node("unlockbutton/unlockpopup/Panel/learnbutton").set_disabled(true)
	
	for i in categories:
		array.append(categories[i])
	array.sort_custom(globals, 'sortbynumber')
	
	for i in array:
		button = get_node("unlockbutton/unlockpopup/Panel/ScrollContainer/VBoxContainer/Button").duplicate()
		button.set_hidden(false)
		get_node("unlockbutton/unlockpopup/Panel/ScrollContainer/VBoxContainer").add_child(button)
		button.set_text(i.name)
		button.connect('pressed', self, 'selectedactionforlearn',[button])
		button.add_to_group("learnsexbuttons")
		button.set_meta("action", i)
		button.get_node("Label").set_text(str(i.cost))
		if slave.sexuals.unlocks.has(i.code):
			button.set_disabled(true)
			button.set_text(button.get_text() + ": Unlocked")
		if slave.sexuals.affection >= i.cost:
			button.get_node("Label").set('custom_colors/font_color', Color(0,1,0,1))
		else:
			button.get_node("Label").set('custom_colors/font_color', Color(1,0,0,1))

func selectedactionforlearn(actionbutton):
	var text = ''
	var disabled = false
	var action = actionbutton.get_meta('action')
	for i in get_tree().get_nodes_in_group("learnsexbuttons"):
		if i.get_meta("action") != action:
			i.set_pressed(false)
	
	if actionbutton.is_pressed() == false:
		buildlist()
		return
	get_node("unlockbutton/unlockpopup/Panel/unlockdescription").set_meta("action", action)
	text = slave.dictionary(action.description)
	text += "\n\nRequired Affection: " + str(action.cost) + "\nPrerequisites: "
	for i in action.prereq:
		text += '[color='
		if slave.sexuals.unlocks.has(i) == false:
			text += 'red]' + categories[i].name + '[/color]'
			disabled = true
		else:
			text += 'green]' + categories[i].name + '[/color]'
	if action.actions.size() >= 1:
		text += "\nUnlocks: "
	for i in action.actions:
		var tempaction = sexbuttons[i]
		text += tempaction.name + ', '
	if action.actions.size() >= 1:
		text = text.substr(0, text.length() -2)+ '. '
	if slave.sexuals.affection < action.cost:
		text += "\n\n[color=red]Not enough affection[/color]"
		disabled = true
	if disabled == true:
		get_node("unlockbutton/unlockpopup/Panel/learnbutton").set_disabled(true)
	else:
		get_node("unlockbutton/unlockpopup/Panel/learnbutton").set_disabled(false)
	
	get_node("unlockbutton/unlockpopup/Panel/unlockdescription").set_bbcode(text)

func _on_learnbutton_pressed():
	var action = get_node("unlockbutton/unlockpopup/Panel/unlockdescription").get_meta('action')
	var text = ''
	slave.sexuals.affection -= action.cost
	slave.sexuals.unlocks.append(action.code)
	for i in action.actions:
		var tempaction = sexbuttons[i]
		slave.sexuals.actions[tempaction.code] = 0
	
	
	text = slave.dictionary(action.unlockdescript + "\n\n[color=green]New actions unlocked for $name[/color]")
	get_tree().get_current_scene().popup(slave.dictionary(text))
	_on_sexual_visibility_changed()
	_on_unlockbutton_pressed()






func _on_announcerape_pressed():
	if slave.tags.find("nosex") >= 0:
		slaverapeconfirm()
		return
	var text = "You announce $name, that you will be using $him however you please not only in daily life, but also in bed with or without $his cooperation. "
	slave.sexuals.unlocked = true
	if !slave.traits.has("Sex-crazed") && !slave.traits.has("Submissive"):
		text += "$He's seemingly shocked with your words. "
		slave.loyal -= 30
		slave.obed += -65
		slave.stress += 50
		slave.sexuals.affection = max(slave.sexuals.affection-40,0)
		if slave.cour >= 50:
			var temp = (slave.cour - 50)*1.5 + 25
			if temp >= rand_range(1,100):
				slave.add_effect(globals.effectdict.captured)
				slave.effects.captured.duration = slave.cour/10+2
				text += "\n\n[color=red]$name seems to detest you now and $he appears to be rebellious. [/color]"
	else:
		text += "Despite somewhat troubled look, it does not seem to bother $him too much. "
	get_tree().get_current_scene().popup(slave.dictionary(text))
	_on_sexual_visibility_changed()
	get_tree().get_current_scene().rebuild_slave_list()

func slaverapeconfirm():
	get_tree().get_current_scene().yesnopopup(slave.dictionary("This action might block off quests related to $name. Continue?"), 'slaverapeconfirmyes' ,self)

func slaverapeconfirmyes():
	slave.tags.erase("nosex")
	if slave.unique == 'Emily':
		globals.state.sidequests.emily = 100
	_on_announcerape_pressed()

func _on_patrner_pressed():
	globals.partner = slave
	get_tree().get_current_scene().selectslavelist(false,'partnerchoose',self,'globals.currentslave != globals.partner && globals.currentslave.sexuals.unlocks.has("swing") == true', true)

func partnerchoose(slave2):
	partner = slave2
	_on_sexual_visibility_changed()




