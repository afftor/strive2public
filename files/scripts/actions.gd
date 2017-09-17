
extends Node

var slave
var player

func _ready():
	get_node("berate").set_meta('cost', 10)
	get_node("beat").set_meta('cost', 15)
	get_node("praise").set_meta('cost', 10)
	get_node("gift").set_meta('cost', 15)
	get_node("punishroom").set_meta('cost', 20)
	get_node("sex").set_meta('cost', 25)
	get_node("date").set_meta('cost', 30)
	for i in get_node("punishroom/Popup/Panel").get_children():
		if i.is_in_group('actions'):
			i.set_meta('cost', 20)
	for i in get_tree().get_nodes_in_group('actions'):
		i.connect('pressed', self, 'actionbuttons', [i])
		if i.is_in_group("sexpunish") != true:
			i.connect("mouse_enter", self, 'showenergytooltip', [i])
			i.connect("mouse_exit", self, 'hideenergytooltip')
	
	for i in get_node("tattoopanel/VBoxContainer").get_children():
		i.connect('pressed',self,'choosetattooarea',[i])

func _on_actions_visibility_changed():
	if get_parent().is_hidden() == true:
		return
	var tab = get_parent().tab
	var text
	player = globals.player
	slave = globals.slaves[get_tree().get_current_scene().currentslave]
	var dict = {}
	for i in get_tree().get_nodes_in_group('actions'):
		if i.get_meta("cost") > globals.player.energy :
			i.set_disabled(true)
			i.set_tooltip("You don't have enough energy for this action")
		else:
			i.set_disabled(false)
			i.set_tooltip('')
	get_node("punishroom/Popup/Panel/punishtext").set_bbcode(slave.dictionary(get_node("punishroom/Popup/Panel/punishtext").get_bbcode()))
	if tab == 'prison':
		return
	if slave.hairlength == 'ear':
		get_node("cuthair").set_disabled(true)
		get_node("cuthair").set_tooltip(slave.dictionary("$name's hair cannot get any shorter."))
	else:
		get_node("cuthair").set_disabled(false)
		get_node("cuthair").set_tooltip('')
	get_node("hairstyle").set_text(slave.hairstyle)
	get_node("cuthair/Label").set_text(slave.dictionary("$name's hair length - "+slave.hairlength))
	if globals.state.mansionupgrades.mansionparlor >= 1:
		get_node("tattoo").set_disabled(false)
		get_node("piercing").set_disabled(false)
		get_node("tattoo").set_tooltip("")
		get_node("piercing").set_tooltip("")
	else:
		get_node("tattoo").set_disabled(true)
		get_node("piercing").set_disabled(true)
		get_node("tattoo").set_tooltip("Unlock Beauty Parlor to access Tattoo options. ")
		get_node("piercing").set_tooltip("Unlock Beauty Parlor to access Piercing options. ")
	if globals.resources.gold >= 15 && globals.player.energy >= 10:
		get_node("gift").set_disabled(false)
	else:
		get_node("gift").set_disabled(true)
	if slave.sexuals.unlocked == true || globals.player.energy < 25:
		get_node("sex").set_disabled(true)
		get_node("sex").set_tooltip(slave.dictionary("Sexual options with $name are already unlocked."))
	elif slave.tags.find('nosex') >= 0:
		get_node("sex").set_disabled(true)
		get_node("punishroom").set_disabled(true)
		get_node("punishroom").set_tooltip(slave.dictionary("You need to advance $name's quest or unlock sex with $him before this option will be available."))
		get_node("sex").set_tooltip(slave.dictionary("You need to advance $name's quest before $he will sleep with you."))
	else:
		get_node("sex").set_disabled(false)
		get_node("punishroom").set_disabled(false)
		get_node("punishroom").set_tooltip("")
		get_node("sex").set_tooltip(slave.dictionary("Openly propose consensual sex to $name\nWill unlock sex actions if sucessful"))


func showenergytooltip(button):
	var pos = button.get_global_pos()
	var xsize = button.get_size().x
	pos = Vector2(pos.x,pos.y-15)
	get_node("energycosttooltip").set_hidden(false)
	get_node("energycosttooltip").set_size(Vector2(xsize, get_node("energycosttooltip").get_size().y))
	get_node("energycosttooltip").set_global_pos(pos)
	get_node("energycosttooltip").set_text(str(button.get_meta('cost')) + ' energy')
	if button.get_meta('cost') > globals.player.energy:
		get_node("energycosttooltip").set('custom_colors/font_color', Color(1,0,0,1))
	else:
		get_node("energycosttooltip").set('custom_colors/font_color', Color(0,1,0,1))

func hideenergytooltip():
	get_node("energycosttooltip").set_hidden(true)

func actionbuttons(button):
	var buttonname = button.get_name()
	var text = ''
	if buttonname == 'punishroom':
		return
	globals.player.energy = -button.get_meta('cost')
	if buttonname == 'berate':
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
	elif buttonname == 'beat':
		text = "You give $name a painful, but relatively harmless beating, providing $him a valueable lesson in subordination. "
		slave.stress += rand_range(15,25)
		slave.health = -rand_range(5,10)
		if slave.obed < 75||slave.traits.has('Masochist') == true:
			if slave.health <= 0:
				text += "[color=red]Due to $his already poor health that was simply too much for $name and $he falls into a coma. You are unable to resuscitate $him despite trying for a while, and eventually can't help but to accept $his death.[/color] "
				globals.slaves.erase(slave)
				if globals.slaves.size() > 1:
					text += "\n[color=red]Your other servants are shocked by this incident. [/color]"
					for i in globals.slaves:
						i.obed += rand_range(10, 50)
						i.stress += rand_range(25, 50)
				get_tree().get_current_scene().popup(slave.dictionary(text))
				get_tree().get_current_scene().rebuild_slave_list()
				return
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
	elif buttonname == 'tickling':
		text = "After bringing $name to the torture room, you tie $him securely to the special chair and work your way over $his body with the feathers and brushes, until $his laughter turn into cries for mercy. You give $him small break then start over. Before long, $his overstimulated feet, armpits and genitals are aching so much that $he nearly loses coherence... "
	elif buttonname == 'spanking':
		text = "After bringing $name to the torture room, you tie $him securely to the table, baring $his defenseless bare butt for open access. Then you begin spanking $him, slowly at first. With each hit $his bottom gets redder and soon $his cries are filled with whimpers and tears. Despite $his appeals you don't stop until $he is nearly hoarse, making sure your lesson made its point. "
	elif buttonname == 'whipping':
		text = "After bringing $name to the torture room, you place $him in standing position, naked before you. Then you take out a whip and start the lashings. At first $he stays silent but soon $he bursts out in tears and painful cries as you rain further lashes across $his body - making them string, especially when you focus on $his delicate parts. Despite $his appeals you don't stop until $he nearly hoarse, making sure your lesson made its point. "
	elif buttonname == 'hotwax':
		text = "After bringing $name to the torture room, you tie $him securely to the bed, spread eagled and naked. Then you light a few candles and proceed to slowly drip hot wax over $his body. $He tries to break free and avoid the painful sensations, but it is to no avail. Irritating $his nipples and genitals seems to produce the best results. After some time you finally stop, making sure the lesson had an impact. "
	elif buttonname == 'woodenhorse':
		text = "After bringing $name to the torture room, you tie $him securely to the wooden horse with $his legs spread wide. Adding some extra weights to hand from $his feet, you increase the pull against the uncomfortable seat and proceed to watch $his suffering. In no time $he starts begging for mercy, but you already made your decision and are not about to stop now. After some time you finally untie $him, making sure the lesson had an impact. "
	elif buttonname == 'praise':
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
	elif buttonname == 'gift':
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
	elif buttonname == 'sex':
		var difficulty = 0
		text += "You make a proposal to $name saying how you would like to move your relationship on a new level. \n\n"
		if slave.obed < 40:
			text += "$name gives you an indignant look and laughs your suggestion off. [color=yellow]$His lack of respect of you will have to be corrected first[/color]  "
		else:
			difficulty = slave.loyal/3 + slave.sexuals.affection + slave.lust/10 + slave.sexuals.actions.size()*2
			if slave.sex == globals.player.sex:
				difficulty -= 10
			if slave.relatives.father == 0 || slave.relatives.mother == 0:
				difficulty -= 10
			for i in slave.traits.values():
				if i.tags.find('sexual') && i.name != 'Prude':
					difficulty += 2
				elif i.name == 'Prude':
					difficulty -= 5
			if difficulty <= 30:
				text += "[color=yellow]— Sorry, $master, but I don't think I'm ready for this. [/color]\n\n$name hastily retreats from your sight."
			else:
				if slave.conf >= 40:
					text += "[color=yellow]— Sure, I'd love to get to know you more... intimately, $master![/color]"
				else:
					text += "[color=yellow]— Uhm... I don't mind... I mean if you wish so, $master. [/color]"
				text+= "\n\n[color=green]Unlocked sexual actions with $name.[/color]"
				if slave.levelupreqs.has('code') && slave.levelupreqs.code == 'relationship':
					text += "\n\n[color=green]As you got closer with $name, you felt like $he unlocked new potential. [/color]"
					slave.levelup()
				slave.sexuals.unlocked = true
	if button.is_in_group('sexpunish') == true:
		if slave.lust > 70 || (slave.lust > 30 && (slave.traits.has('Masochist') == true||slave.dom <= 20)):
			text = text + "\nDuring the procedure $name twitches and climaxes, unable to hold back $his excitement."
			slave.lust = -rand_range(8,15)
			if rand_range(1,10) > 7 || slave.effects.has('entranced') == true:
				slave.add_trait(globals.origins.trait('Masochist'))
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
	
	get_node("punishroom/Popup").set_hidden(true)
	
	if get_node("publiccheckbox").is_pressed() == true && globals.slaves.size() > 1 && !buttonname in ['date','gift','praise','sex']:
		text = text + "Other servants watch your actions closely."
		for i in globals.slaves:
			if i.traits.has('Loner') == false && i.away.duration < 1:
				i.obed += max(rand_range(5,15)-i.conf/10,0)
			if button.is_in_group('sexpunish') == true:
				i.lust = rand_range(5,10)
	
	slave.attention = 0
	
	get_tree().get_current_scene().popup(slave.dictionary(text))
	_on_actions_visibility_changed()
	get_tree().get_current_scene().rebuild_slave_list()
	get_parent()._on_slave_tab_visibility_changed()


func _on_getridof_pressed():
	get_tree().get_current_scene().yesnopopup(slave.dictionary("[color=red]Let $name leave? You can't cancel this action.[/color]"),'getridof')


func _on_hairstyle_item_selected( ID ):
	var hairstyles = ['straight','ponytail', 'twintails', 'braid', 'two braids', 'bun']
	slave.hairstyle = hairstyles[ID]
	get_parent()._on_slave_tab_visibility_changed()

func _on_punishroom_pressed():
	get_node("punishroom/Popup").popup()

func _on_cancel_pressed():
	get_node("punishroom/Popup").set_hidden(true)

func _on_useitem_pressed():
	get_tree().get_current_scene()._on_inventory_pressed("slave")


#########################
func _on_castspell_pressed():
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
	spellnode.call(spellselected.effect)
	slave.attention = 0
	get_node("selectspellpanel").set_hidden(true)
	get_parent()._on_slave_tab_visibility_changed()
	get_tree().get_current_scene().rebuild_slave_list()



func _on_talk_pressed():
	var state = true
	var sprite = []
	var buttons = []
	var nakedspritesdict = get_parent().get_node("sexual").nakedspritesdict
	if slave.unique == 'Cali' && globals.state.sidequests.cali in [12,13,22]:
		globals.events.calitalk0()
		return
	if slave.unique in ['Cali','Tisha','Emily', 'Chloe']:
		if slave.obed >= 80 && slave.stress < 50:
			sprite = [[nakedspritesdict[slave.unique].clothcons, 'pos1', 'opac']]
		else:
			sprite = [[nakedspritesdict[slave.unique].clothrape, 'pos1', 'opac']]
	var text = 'You ask $name about $his life. \n'
	if slave.obed < 50:
		text = text + "— I don't wanna talk with you after all you've done!\n"
	elif slave.traits.has('Sex-crazed') == true:
		text = text + "— I don't care about my life, or anything, can we just fuck here, Master?"
	else:
		if slave.loyal < 25:
			text = text + globals.player.dictionaryplayer('— Yes, I will obey your orders, $master. \n')
			if slave.brand != 'none':
				text = text + "It's not like I have much of an option anyway. \n$name gives you a trapped look. "
		elif slave.loyal < 60:
			text = text + globals.player.dictionaryplayer("—It wasn't easy at first, but I think warmly of you, $master. \n")
			if slave.brand != 'none':
				text = text + "Even though I'm just your little slave now. \n"
		else:
			text = text + globals.player.dictionaryplayer("— I'll try my best for you, $master. Despite what others might think, you are invaluable to me!\n")
		if slave.stress > 50:
			text = text + "— It has been tough for me recently... Could you consider giving me a small break, please?\n"
		if slave.lust >= 60 && slave.sexuals.unlocked == true && slave.sexuals.actions.has('pussy'):
			text = text + "— I actually would love to fuck right now. \n"
		elif slave.lust >= 60 && slave.sexuals.unlocked == true:
			text = text + "— Uhm... would you like to give me some private attention? — $name gives you a deep lusting look. \n"
	if slave.name == "Tamamo" && slave.race.find("Fox") >= 0:
		text += "— One tail is not what I used to, but at least it's just as fluffy as you'd expect. "
	if slave.xp >= 100 && slave.levelupreqs.has('code') == false:
		buttons.append({text = slave.dictionary("Investigate $name's potential"), function = 'levelreqs'})
	elif slave.levelupreqs.has('code'):
		text += "\n\n[color=yellow]Your investigation shown, that " + slave.dictionary(slave.levelupreqs.speech) + '[/color]'
		if slave.levelupreqs.activate == 'fromtalk':
			buttons.append({text = slave.levelupreqs.button, function = 'levelup', args = slave.levelupreqs.effect})
	
	get_tree().get_current_scene().dialogue(state, self, slave.dictionary(text), buttons, sprite)


func levelreqs():
	globals.jobs.getrequest(slave)
	_on_talk_pressed()
	get_parent()._on_slave_tab_visibility_changed()

func levelup(command):
	globals.jobs.call(command, slave)
	globals.get_tree().get_current_scene().close_dialogue()
	get_parent()._on_slave_tab_visibility_changed()

#Piercing

var piercingdict = {
earlobes = {name = 'earlobes', options = ['earrings', 'stud'], requirement = null, id = 1},
eyebrow = {name = 'eyebrow', options = ['stud'], requirement = null, id = 2},
nose = {name = 'nose', options = ['stud', 'ring'], requirement = null, id = 3},
lips = {name = 'lips', options = ['stud', 'ring'], requirement = null, id = 4},
tongue = {name = 'tongue', options = ['stud'], requirement = null, id = 5},
navel = {name = 'navel', options = ['stud'], requirement = null, id = 6},
nipples = {name = 'nipples', options = ['ring', 'stud', 'chain'], requirement = 'lewdness', id = 7},
clit = {name = 'clit', options = ['ring', 'stud'], requirement = 'lewdness, pussy', id = 8},
labia = {name = 'labia', options = ['ring', 'stud'], requirement = 'lewdness, pussy', id = 9},
penis = {name = 'penis', options = ['ring', 'stud'], requirement = 'lewdness, penis', id = 10},
}

func _on_piercing_pressed():
	get_node("piercingpanel").set_hidden(false)
	for i in get_node("piercingpanel/ScrollContainer/VBoxContainer").get_children():
		if i != get_node("piercingpanel/ScrollContainer/VBoxContainer/piercingline"):
			i.set_hidden(true)
			i.queue_free()
	if slave.sexuals.unlocked == true:
		get_node("piercingpanel/piercestate").set_text(slave.dictionary('$name does not seems to mind you pierce $his private places.'))
	else:
		get_node("piercingpanel/piercestate").set_text(slave.dictionary('$name refuses to let you pierice $his private places'))
	
	for i in piercingdict:
		if slave.piercing.has(i) == false:
			slave.piercing[i] = null
	
	var array = []
	for i in piercingdict.values():
		array.append(i)
	array.sort_custom(self, 'idsort')
	
	
	for ii in array:
		if ii.requirement == null || (slave.sexuals.unlocked == true&& ii.requirement == 'lewdness') || (slave.penis.number >= 1 && slave.sexuals.unlocked == true && ii.id == 10) || (slave.pussy.has == true && slave.sexuals.unlocked == true && (ii.id == 8 || ii.id == 9)):
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
	get_node("piercingpanel").set_hidden(true)


#tattoo

var tattoosdescript = { #this goes like : start + tattoo theme + end + tattoo description: I.e On $his face you see a notable nature themed tattoo, depicting flowers and vines
face = {start = "On $his cheek you see a notable ", end = " themed tattoo, depicting"},
chest = {start = "$His chest is decorated with a", end = " tattoo, portraying"},
waist = {start = "On lower part of $his back, you spot a ", end = " tattooed image of "},
arms = {start = "$His arm has a skillfully created ", end = " image of "},
legs = {start = "$His ankle holds a piece of ", end = " art, representing"},
ass = {start = "$His butt has a large ", end = " themed image showing "},
}

var tattoooptions = {
none = {name = 'none', descript = "", applydescript = "Select a theme for future tattoo"},
nature = {name = 'nature', descript = " flowers and vines", function = "naturetattoo", applydescript = "Nature thematic tattoo will increase $name's beauty. "},
tribal = {name = 'tribal',descript = " totemic markings and symbols", function = "tribaltattoo", applydescript = "Tribal thematic tattoo will increase $name's scouting performance. "},
degrading = {name = 'derogatory', descript = " rude words and lewd drawings", function = "degradingtattoo",  applydescript = "Derogatory tattoo will promote $name's lust and enforce obedience. "},
animalistic = {name = 'beastly', descript = " realistic beasts and insects", function = "animaltattoo", applydescript = "Animalistic tattoo will boost $name's energy regeneration. "},
magic = {name = "energy", descript = " empowering patterns and runes", function = "manatattoo", applydescript = "Magic tattoo will increase $name's Magic Affinity. "},
}

var tattoolevels = {
nature = {
1 : {bonusdescript = "+5 Beauty", effect = 'nature1'},
2 : {bonusdescript = "+10 Beauty", effect = 'nature2'},
3 : {bonusdescript = "+15 Beauty", effect = 'nature3'},
highest = "+15 Beauty",
},
tribal = {
1 : {bonusdescript = "+3 Awareness", effect = 'tribal1'},
2 : {bonusdescript = "+6 Awareness", effect = 'tribal2'},
3 : {bonusdescript = "+9 Awareness", effect = 'tribal3'},
highest = "+9 Awareness",
},
degrading = {
1 : {bonusdescript = "+5 Lust and Obedience per day", effect = 'degrading1'},
2 : {bonusdescript = "+10 Lust and Obedience per day", effect = 'degrading2'},
3 : {bonusdescript = "+15 Lust and Obedience per day", effect = 'degrading3'},
4 : {bonusdescript = "+20 Lust and Obedience per day", effect = 'degrading4'},
highest = "+20 Lust and Obedience per day",
},
animalistic = {
1 : {bonusdescript = "+8 Energy per day", effect = 'animalistic1'},
2 : {bonusdescript = "+16 Energy per day", effect = 'animalistic2'},
3 : {bonusdescript = "+24 Energy per day", effect = 'animalistic3'},
highest = "+24 Energy per day",
},
magic = {
1 : {bonusdescript = "+0 Magic Affinity", effect = 'magic1'},
2 : {bonusdescript = "+1 Magic Affinity", effect = 'magic2'},
3 : {bonusdescript = "+1 Magic Affinity", effect = 'magic3'},
4 : {bonusdescript = "+1 Magic Affinity", effect = 'magic4'},
5 : {bonusdescript = "+2 Magic Affinity", effect = 'magic5'},
highest = '+2 Magic Affinity',
},
}

var tattoodict = {
none = {value = 0, code = 'none'},
nature = {value = 1, code = 'nature'},
tribal = {value = 2, code = 'tribal'},
degrading = {value = 3, code = 'degrading'},
animalistic = {value = 4, code = 'animalistic'},
magic = {value = 5, code = 'magic'},
}

var selectedpart = ''
var slavetattoos = {}
var tattootheme = 'none'

func _on_applybutton_pressed():
	slave.tattooshow[selectedpart] = !get_node("tattoopanel/invisible").is_pressed()
	get_parent()._on_slave_tab_visibility_changed()
	if get_node("tattoopanel/tattoooptions").is_disabled():
		return
	elif tattootheme == 'none':
		return
	elif globals.itemdict.magicessenceing.amount < 1 || globals.itemdict.supply.amount < 1:
		get_tree().get_current_scene().infotext("[color=red]Not enough resources[/color]")
		return
	else:
		globals.itemdict.magicessenceing.amount -= 1
		globals.itemdict.supply.amount -= 1
	counttattoos()
	slave.tattoo[selectedpart] = tattootheme
	var tattooDict = {currentlevel = slavetattoos[slave.tattoo[selectedpart]]}
	if tattoolevels[tattootheme].has(tattooDict.currentlevel-1) && tattoolevels[tattootheme].has(tattooDict.currentlevel):
		slave.add_effect(globals.effectdict[tattoolevels[tattootheme][tattooDict.currentlevel-1].effect],true)
	if tattoolevels[tattootheme].has(tattooDict.currentlevel):
		slave.add_effect(globals.effectdict[tattoolevels[tattootheme][tattooDict.currentlevel].effect])
	for i in get_node("tattoopanel/VBoxContainer").get_children():
		if i.get_name() == selectedpart:
			choosetattooarea(i)
	get_parent()._on_slave_tab_visibility_changed()

func _on_tattoo_pressed():
	get_node("tattoopanel").popup()
	tattootheme = 'none'
	selectedpart = ''
	counttattoos()
	get_node("tattoopanel/tattoooptions").set_hidden(true)
	get_node("tattoopanel/RichTextLabel").set_bbcode("Select body part to work on")
	for i in get_node("tattoopanel/VBoxContainer").get_children():
		i.set_pressed(false)
		if i.get_name() in ['legs','arms']:
			if i.get_name() == 'legs' && slave.legs in ['webbed','fur_covered','normal','scales']:
				i.set_disabled(false)
			elif i.get_name() == 'arms' && slave.arms in ['webbed','fur_covered','normal','scales']:
				i.set_disabled(false)
			else:
				i.set_disabled(true)

func counttattoos():
	slavetattoos = {none = 0,nature = 0, tribal = 0, degrading = 0, animalistic = 0, magic = 0}
	for i in slave.tattoo:
		slavetattoos[slave.tattoo[i]] += 1

func choosetattooarea(button):
	var area = button.get_name()
	var text = ''
	selectedpart = str(area)
	for i in get_node("tattoopanel/VBoxContainer").get_children():
		if i == button:
			i.set_pressed(true)
		else:
			i.set_pressed(false)
	get_node("tattoopanel/tattoooptions").set_hidden(false)
	get_node("tattoopanel/tattoooptions").select(tattoodict[slave.tattoo[area]].value)
	if get_node("tattoopanel/tattoooptions").get_selected() == 0:
		text += "$name currently has no tattoos on $his " + area + ". "
		get_node("tattoopanel/tattoooptions").set_disabled(false)
	else:
		get_node("tattoopanel/tattoooptions").set_disabled(true)
		text += "$name has a [color=aqua]" + tattoooptions[slave.tattoo[area]].name + '[/color] tattoo on $his ' + area + '. '
		text += "\n[color=aqua]Apply to change visibility[/color]"
	get_node("tattoopanel/RichTextLabel").set_bbcode(slave.dictionary(text))

func _on_tattooclose_pressed():
	get_node("tattoopanel").set_hidden(true)


func _on_tattoooptions_item_selected( ID ):
	for i in tattoodict.values():
		if i.value == get_node("tattoopanel/tattoooptions").get_selected():
			tattootheme = i.code
	var text = slave.dictionary(tattoooptions[tattootheme].applydescript)
	if tattootheme != 'none':
		text += "\n\n"
		if slavetattoos[tattootheme] > 0:
			text += "Current Level: " + str(slavetattoos[tattootheme])
			if tattoolevels[tattootheme].has(slavetattoos[tattootheme]):
				text += "\nCurrent Bonus: " + tattoolevels[tattootheme][slavetattoos[tattootheme]].bonusdescript
			else:
				text += "\nCurrent Bonus: " + tattoolevels[tattootheme].highest
		if tattoolevels[tattootheme].has(slavetattoos[tattootheme]+1):
			text += "\nNext Bonus: " + tattoolevels[tattootheme][slavetattoos[tattootheme]+1].bonusdescript
		else:
			text += "\n[color=yellow]No additional effects. [/color]"
	get_node("tattoopanel/RichTextLabel").set_bbcode(text)














