
extends Node

onready var main = get_tree().get_current_scene()
onready var buttoncontainer = get_node("outsidebuttoncontainer")
onready var button = get_node("outsidebuttoncontainer/buttontemplate")
onready var questtext = globals.questtext
onready var mansion = get_parent()
var location = ''
var questgiveawayslave

func _ready():
	set_process_input(true)
	if globals.guildslaves.wimborn.size() < 2:
		var rand = round(rand_range(4,6))
		newslaveinguild(rand, 'wimborn')
	if globals.guildslaves.gorn.size() < 2:
		var rand = round(rand_range(4,6))
		newslaveinguild(rand, 'gorn')
	if globals.guildslaves.frostford.size() < 2:
		var rand = round(rand_range(4,6))
		newslaveinguild(rand, 'frostford')
	if globals.guildslaves.umbra.size() < 4:
		var rand = round(rand_range(4,6))
		newslaveinguild(rand, 'umbra')
	#get_node("playergroupdetails/TabContainer").connect("visibility_changed", self, "_on_TabContainer_tab_changed")


func _input(event):
	if main.get_node("screenchange/AnimationPlayer").is_playing() == true && main.get_node("screenchange").is_visible():
		return
	var anythingvisible = false
	for i in get_tree().get_nodes_in_group("blockoutsideinput"):
		if i.is_visible() == true:
			anythingvisible = true
			break
	if anythingvisible == true:
		return
	if event.type == 1:
		var dict = {49 : 1, 50 : 2, 51 : 3, 52 : 4,53 : 5,54 : 6,55 : 7,56 : 8,}
		if event.scancode in [KEY_1,KEY_2,KEY_3,KEY_4,KEY_5,KEY_6,KEY_7,KEY_8]:
			var key = dict[event.scancode]
			if event.is_action_pressed(str(key)) == true && get_node("outsidebuttoncontainer").get_children().size() >= key+1 && self.is_visible() == true && get_parent().get_node("dialogue").is_hidden() == true:
				get_parent().get_node("chooseslavepopup").set_hidden(true)
				get_node("outsidebuttoncontainer").get_child(key).emit_signal("pressed")
			elif event.is_action_pressed(str(key)) == true && get_parent().get_node("dialogue").is_hidden() == false && get_parent().get_node("dialogue/popupbuttoncenter/popupbuttons").get_children().size() >= key+1:
				if get_parent().get_node("dialogue/popupbuttoncenter/popupbuttons").get_child(key).is_disabled() == false:
					get_parent().get_node("dialogue/popupbuttoncenter/popupbuttons").get_child(key).emit_signal("pressed")
			elif event.is_action_pressed(str(key)) == true && get_parent().get_node("tutorialnode/response").is_hidden() == false && get_parent().get_node("tutorialnode/response/ScrollContainer/VBoxContainer").get_children().size() >= key+1:
				if get_parent().get_node("tutorialnode/response/ScrollContainer/VBoxContainer").get_child(key).is_disabled() == false:
					get_parent().get_node("tutorialnode/response/ScrollContainer/VBoxContainer").get_child(key).emit_signal("pressed")
			elif event.is_action_pressed(str(key)) == true && get_parent().get_node("dailyevents").is_hidden() == false && get_parent().get_node("dailyevents/buttonpanel/ScrollContainer/VBoxContainer").get_children().size() >= key+1:
				if get_parent().get_node("dailyevents/buttonpanel/ScrollContainer/VBoxContainer").get_child(key).is_disabled() == false:
					get_parent().get_node("dailyevents/buttonpanel/ScrollContainer/VBoxContainer").get_child(key).emit_signal("pressed")
			elif event.is_action_pressed(str(key)) == true && get_parent().get_node("scene").is_hidden() == false && get_parent().get_node("scene/popupbuttoncenter/popupbuttons").get_children().size() >= key+1:
				if get_parent().get_node("scene/popupbuttoncenter/popupbuttons").get_child(key).is_disabled() == false:
					get_parent().get_node("scene/popupbuttoncenter/popupbuttons").get_child(key).emit_signal("pressed")
		if event.is_action_pressed("B") && get_node("playergrouppanel/details").is_visible():
			_on_details_pressed()


func clearbuttons():
	for i in buttoncontainer.get_children():
		if i != button:
			i.set_hidden(true)
			i.queue_free()

func buildbuttons(array, target = self):
	clearbuttons()
	var counter = 0
	for i in array:
		var newbutton = button.duplicate()
		buttoncontainer.add_child(newbutton)
		newbutton.set_text(i.name)
		newbutton.get_node("Label").set_text(str(counter+1))
		newbutton.set_hidden(false)
		if i.has('args'):
			newbutton.connect('pressed', target, i.function, [i.args])
		else:
			newbutton.connect('pressed', target, i.function)
		if i.has('disabled'):
			newbutton.set_disabled(true)
		if i.has('tooltip'):
			newbutton.set_tooltip(i.tooltip)
		if i.has('textcolor'):
			newbutton.set('custom_colors/font_color', Color(0.2,0.6,0.2))
		counter += 1

func addbutton(i, target = self):
	var newbutton = button.duplicate()
	buttoncontainer.add_child(newbutton)
	newbutton.set_text(i.name)
	newbutton.get_node("Label").set_text(str(buttoncontainer.get_children().size()-1))
	newbutton.set_hidden(false)
	if i.has('args'):
		newbutton.connect('pressed', target, i.function, [i.args])
	else:
		newbutton.connect('pressed', target, i.function)
	if i.has('disabled'):
		newbutton.set_disabled(true)
	if i.has('tooltip'):
		newbutton.set_tooltip(i.tooltip)
	if i.has('textcolor'):
		newbutton.set('custom_colors/font_color', Color(0.2,0.6,0.2))

func _on_leave_pressed():
	if globals.state.calculateweight().overload == true:
		get_parent().infotext("Your backpack is too heavy to leave",'red')
		return
	gooutside()
	get_parent().get_node("explorationnode").currentzone = get_parent().get_node("explorationnode").zones[globals.state.location]
	get_parent().get_node("explorationnode").zoneenter(globals.state.location)
	#gooutside()

func playergrouppanel():
	var charpanel
	var array = []
	for i in get_node("playergrouppanel/VBoxContainer").get_children():
		if i != get_node("playergrouppanel/VBoxContainer/Panel"):
			i.set_hidden(true)
			i.queue_free()
	array.append(globals.player)
	for i in globals.state.playergroup:
		array.append(globals.state.findslave(i))
	for slave in array:
		charpanel = get_node("playergrouppanel/VBoxContainer/Panel").duplicate()
		if slave.imageportait != null:
			if File.new().file_exists(slave.imageportait) == true:
				charpanel.get_node("portait").set_texture(load(slave.imageportait))
			else:
				slave.imageportait = null
		get_node("playergrouppanel/VBoxContainer").add_child(charpanel)
		charpanel.set_hidden(false)
		charpanel.set_meta("slave", slave)
		charpanel.get_node("name").set_text(slave.name_short())
		charpanel.get_node("stress").set_hidden(false)
		#charpanel.get_node("button").connect("pressed",self,'utilitypanel',[charpanel])
		charpanel.get_node("stress").set_text("SR:" + str(round(slave.stress)))
		charpanel.get_node("health").set_text('HP:' +str(round(slave.health)) + '/' + str(slave.stats.health_max))
		charpanel.get_node("energy").set_text('EN:'+str(round(slave.energy)) + '/' + str(slave.stats.energy_max))
		#charpanel.get_node("utilitypanel").connect("popup_hide", globals, 'hidetooltip')


func utilitypanel(panel):
	panel.get_node("utilitypanel").popup()
	panel.get_node('utilitypanel').set_pos(Vector2(panel.get_global_pos().x,panel.get_global_pos().y - 70))
	for i in panel.get_node("utilitypanel/HBoxContainer").get_children():
		if i.get_name() != 'Button':
			i.set_hidden(true)
			i.queue_free()
	var newbutton
	for i in ['bandage','teleportseal']:
		newbutton = panel.get_node("utilitypanel/HBoxContainer/Button").duplicate()
		panel.get_node("utilitypanel/HBoxContainer/").add_child(newbutton)
		newbutton.set_hidden(false)
		if globals.state.backpack.stackables.has(i) && globals.state.backpack.stackables[i] >= 1:
			newbutton.set_disabled(false)
			newbutton.get_node('amount').set_text(str(globals.state.backpack.stackables[i]))
		else:
			newbutton.set_disabled(true)
			newbutton.get_node("amount").set_text('0')
		newbutton.get_node('icon').set_texture(globals.itemdict[i].icon)
		newbutton.connect("pressed", self, 'useitem', [globals.itemdict[i], panel.get_meta('slave')])
		var text = '[center]' + globals.itemdict[i].name + '[/center]\n' + globals.itemdict[i].description
		if i == 'teleportseal' && globals.player == panel.get_meta('slave'):
			text += "\n\n[color=#ff4949]Your captured slaves will be freed and your party will take time to return home on their own. [/color]"
		newbutton.connect("mouse_enter", globals, 'showtooltip', [text])
		newbutton.connect("mouse_exit", globals, 'hidetooltip')
	for i in ['heal','invigorate']:
		if globals.player == panel.get_meta('slave') && i == 'invigorate':
			return
		newbutton = panel.get_node("utilitypanel/HBoxContainer/Button").duplicate()
		panel.get_node("utilitypanel/HBoxContainer/").add_child(newbutton)
		newbutton.set_hidden(false)
		newbutton.get_node('amount').set_text(str(globals.spelldict[i].manacost))
		newbutton.get_node('icon').set_texture(load("res://files/buttons/cast.png"))
		if globals.spelldict[i].learned == true && globals.resources.mana >= globals.spelldict[i].manacost:
			newbutton.get_node('amount').set('custom_colors/font_color', Color(0,1,0))
		else:
			newbutton.set_disabled(true)
			newbutton.get_node('amount').set('custom_colors/font_color', Color(1,0,0))
		newbutton.connect("pressed", self, 'usespell', [globals.spelldict[i], panel.get_meta('slave')])
		var text = '[center]' + globals.spelldict[i].name + '[/center]' + '\n' + globals.spelldict[i].description + '\nMana cost: ' + str(globals.spelldict[i].manacost)
		newbutton.connect("mouse_enter", globals, 'showtooltip', [text])
		newbutton.connect("mouse_exit", globals, 'hidetooltip')



func town():
	main.get_node("explorationnode").zoneenter('wimborn')

func wimborn():
	gooutside()
	main.music_set('wimborn')
	get_node("charactersprite").set_hidden(true)
	var array = [{name = "Visit the Mage's Order",function = 'mageorder'},{name = "Visit Slaver's Guild", function = 'slaveguild'},{name = "Visit Market District",function = 'market'},{name = "Visit Red Lantern District", function = 'backstreets'},{name = "Leave Town",function = 'outskirts'}]
	if globals.state.location == 'wimborn':
		array.append({name = "Return to Mansion",function = 'mansion'})
	buildbuttons(array)

func mansion():
	main._on_mansion_pressed()

func gooutside():
	get_parent().get_node("hideui").set_hidden(false)
	get_node("playergrouppanel/VBoxContainer").set_hidden(false)
	if OS.get_name() != "HTML5" && globals.rules.fadinganimation == true:
		yield(main, 'animfinished')
	main.checkplayergroup()
	main.get_node("Navigation").set_hidden(true)
	main.get_node('MainScreen').set_hidden(true)
	main.get_node("charlistcontrol").set_hidden(true)
	set_hidden(false)
	playergrouppanel()
	if globals.state.tutorial.outside == false:
		main.get_node("tutorialnode").outside()

func outskirts():
	main.get_node("explorationnode").zoneenter('wimbornoutskirts')


############## SLAVE GUILD


func newslaveinguild(number, town = 'wimborn'):
	while number > 0:
		var racearray
		var race
		var origin
		var originpool 
		if town == 'wimborn':
			racearray = [[globals.wimbornraces[rand_range(0,globals.wimbornraces.size())],1],['Drow', 1],['Dark Elf', 1.5],['Elf', 2],['Human', 6]]
		elif town == 'gorn':
			racearray = [[globals.gornraces[rand_range(0,globals.gornraces.size())],1],['Centaur', 1],['Human', 2],['Goblin', 2],['Orc', 5]]
		elif town == 'frostford':
			racearray = [[globals.frostfordraces[rand_range(0,globals.frostfordraces.size())],1],['Human', 1.5],['Halfkin Wolf', 3],['Beastkin Wolf', 5]]
		elif town == 'umbra':
			racearray = [[globals.allracesarray[rand_range(0,globals.allracesarray.size())],1]]
		if globals.rules.slaverguildallraces == true && globals.state.sandbox == true:
			originpool = ['slave','poor','commoner','rich','noble']
			origin = originpool[rand_range(0,originpool.size())]
			race = globals.allracesarray[rand_range(0,globals.allracesarray.size())]
		else:
			race = globals.weightedrandom(racearray)
			if town == 'umbra':
				originpool = [['noble', 1],{value = 'rich', weight = 2},{value = 'commoner', weight = 3},{value = 'poor', weight = 3},{value = 'slave',weight = 1}]
			else:
				originpool = [{value = 'rich', weight = 1},{value = 'commoner', weight = 3},{value = 'poor', weight = 6},{value = 'slave',weight = 6}]
			origin = globals.weightedrandom(originpool)
		var newslave = globals.newslave(race, 'random', 'random', origin)
		if town == 'umbra':
			newslave.obed = rand_range(0,80)
			if rand_range(0,100) >= 30:
				newslave.add_effect(globals.effectdict.captured)
		else:
			newslave.obed += 95
		newslave.fromguild = true
		globals.guildslaves[town].append(newslave)
		number -= 1


func setcharacter(text):
	if get_parent().spritedict.has(text):
		get_node("charactersprite").set_opacity(1)
		get_node("charactersprite").set_texture(get_parent().spritedict[text])

func slaveguild(guild = 'wimborn'):
	mindread = false
	var text = ''
	sellslavelocation = guild
	if guild == 'wimborn':
		slavearray = globals.guildslaves.wimborn
		if get_node("charactersprite").is_visible() == false || get_node("charactersprite").get_texture() != globals.spritedict.fairy:
			main.background_set('slaverguild')
			if OS.get_name() != "HTML5" && globals.rules.fadinganimation == true:
				yield(main, 'animfinished')
			if globals.state.sidequests.maple < 7:
				setcharacter('fairy')
				get_node("AnimationPlayer").play("spritemovefairy")
		clearselection()
		if globals.state.slaveguildvisited == 0:
			text += "The first time you enter through the doors of the town's central building, you are mildly surprised to find it it very clean and bright inside. Arriving at the reception, a small cheerful fairy girl emerges from nearby to assist you. Her friendly and somewhat whimsical looks make you realize she must be one of the main receptionists hired to drag in potential clients. \n\n[color=yellow]— Welcome $sir! I do not believe I have see you here before, is this your first time? I'm Maple. You seem to be a respectable person! If you will allow me, I shall help you get familiar with our establishment!\n\n— From our facilities here we can provide our clients with many affordable and obedient staff members. Yes, the possession of another person is allowed as long as you have the rights. Despite overall humanity progression, it is still very far from providing sufficient food and living conditions for everyone. By selling themselves into others custody, many find a way to survive, cover their debts or help their family. \n\n— Sometimes we deal with, so called, 'prisoners of war', to help them to adapt to life in our care. Don't you find this is way more humane giving them a new chance, instead of outright slaughtering them?\n\n— This is where we come in. place and ensure, that your deal is secured. Slaves give up a huge part of their freedom. We take care to teach them to act appropriately, so you may be sure their initial behaviour will be acceptable.  To strengthen your ownership we will gladly help brand your purchase.\n\n— After slave becomes your property, you are free to employ them as you see fit, but keep in mind, that inhumane treatment may cause you quite a few problems. We strongly advise against unnecessary deaths and mutilations, nor we do support people harshly abusing their privileges over others. \n\n— Lastly, if you have possession of someone, you no longer have a need for and wish to part with, we can surely offer you something!\n\n— I hope, my explanation was helpful, $sir! Let me know if there's something else I can assist you with![/color]"
			globals.state.slaveguildvisited = 1
			globals.charactergallery.maple.unlocked = true
		else:
			text += "You enter through the guild’s doors, and are greeted once again by the busy sights and sounds of customers, slaves, and workers shuffling around at blistering speeds. You give a polite bow to one of the receptionists and grab a pen to sign in. In few moments Maple appears before you.\n\n[color=yellow]— Ah, my pleasure, $name, how can I help you today?[/color] "
		var array = [{name = 'See slaves for sale', function = 'slaveguildslaves'}, {name = 'Offer your servants',function = 'slaveguildsells'}, {name = 'See custom requests', function = 'slaveguildquests'},{name = 'Services for Slaves',function = 'slaveservice'},{name = 'Leave', function = 'town'}]
		if globals.state.mainquest == 3:
			array.insert(3, {name = "Ask about fairies", function = 'slaveguildfairy'})
		if globals.state.sidequests.maple in [1,3] && globals.state.reputation.wimborn >= 40:
			array.insert(3, {name = "Flirt with Maple", function = 'slaveguildfairy', args = 1})
		if globals.state.sidequests.maple == 6:
			array.insert(3, {name = "Take Maple into custody", function = 'slaveguildfairy', args = 5})
		if globals.state.sidequests.maple in [2,3,4,5,6]:
			text += "\n\nMaple gives you a playful, warm look."
		elif globals.state.sidequests.maple == 7:
			text = "You enter through the guild’s doors, and are greeted once again by the busy sights and sounds of customers, slaves, and workers shuffling around at blistering speeds. You give a polite bow to one of the receptionists and grab a pen to sign in."
		mansion.maintext = globals.player.dictionary(text)
		buildbuttons(array)
	elif guild == 'gorn':
		clearselection()
		get_node("charactersprite").set_hidden(false)
		get_node("AnimationPlayer").play("show")
		setcharacter('goblin')
		slavearray = globals.guildslaves.gorn
		mansion.maintext = globals.player.dictionaryplayer("Huge part of supposed guild takes a makeshift platform and tents on the outside with few half-empty cages. In the middle, you can see a presentation podium which is easily observable from main street. Despite Gorn being very different from common, primarily human-populated towns, it still directly follows Mage's Order directives — race diversity and casual slavery are very omnipresent. \n\nAs you walk in, one of the goblin receptionists quickly recognizes you as an Order member and hastily grabs your attention, sensing a profitable customer.\n\n— $sir interested in some heat-tolerant 'orkers? *chuckles* Or you are in preference of short girls? We quite often get those as well, for every taste and color!")
		var array = [{name = 'See slaves for sale',function = 'slaveguildslaves'}, {name = 'Offer your servants',function = 'slaveguildsells'}, {name = 'See custom requests', function = 'slaveguildquests'},{name = 'Services for Slaves',function = 'slaveservice'}, {name = 'Leave',function = 'togorn'}]
		if globals.state.sidequests.emily in [14,15]:
			array.insert(1, {name = 'Search for Tisha', function = 'tishaquest'})
		buildbuttons(array)
	elif guild == 'frostford':
		clearselection()
		slavearray = globals.guildslaves.frostford
		text = "A humble local guild building is bright and warm inside. Just as the whole of Frostford, this place is serene in its mood compared to what you are used to. "
		if globals.state.mainquest >= 2:
			text += "Realizing you belong to the Mage's Order, attendant politely greets you and asks how he could assist you. "
		mansion.maintext = globals.player.dictionaryplayer(text)
		var array = [{name = 'See slaves for sale',function = 'slaveguildslaves'},{name = 'Offer your servants',function = 'slaveguildsells'}, {name = 'See custom requests', function = 'slaveguildquests'}, {name = 'Services for Slaves',function = 'slaveservice'}, {name = 'Leave', function = 'tofrostford'}]
		buildbuttons(array)
	get_node("playergrouppanel/VBoxContainer").set_hidden(true)
	if globals.spelldict.mindread.learned == false:
		get_node("slavebuypanel/mindreadbutton").set_hidden(true)
	else:
		get_node("slavebuypanel/mindreadbutton").set_hidden(false)

func slaveguildfairy(stage = 0):
	var text = ''
	var sprites
	var state = true
	var buttons = []
	if stage == 0:
		text = questtext.GuildFairyMainQuest
		globals.state.mainquest = 3.1
		globals.state.sidequests.maple = 1
		slaveguild()
		mansion.maintext = globals.player.dictionary(text)
		return
	elif stage == 1:
		if globals.player.penis == 'none':
			main.popup("This option requires player character to have a penis. ")
			return
		if globals.state.sidequests.maple == 1:
			sprites = [['fairy','pos1']]
			text = questtext.MapleFlirt
			globals.state.sidequests.maple = 2
			globals.state.upcomingevents.append({code = 'mapletimepass', duration = 3})
			globals.charactergallery.maple.scenes[0].unlocked = true
		elif globals.state.sidequests.maple == 3:
			sprites = [['fairynaked','pos1']]
			text = questtext.MapleFlirt2
			globals.state.sidequests.maple = 4
			globals.charactergallery.maple.nakedunlocked = true
			globals.charactergallery.maple.scenes[1].unlocked = true
		slaveguild()
	elif stage == 3:
		if globals.state.sidequests.maple == 4:
			if globals.resources.gold >= 7000:
				buttons.append({text = 'Purchase Contract',function = 'slaveguildfairy', args = 4})
			else:
				buttons.append({text = 'Purchase Contract',function = 'slaveguildfairy', args = 4, disabled = true})
			text = questtext.MapleAudience
			globals.state.sidequests.maple = 5
		elif globals.state.sidequests.maple == 5:
			text = questtext.MapleAudienceRepeat
			if globals.resources.gold >= 7000:
				buttons.append({text = 'Purchase Contract',function = 'slaveguildfairy', args = 4})
			else:
				buttons.append({text = 'Purchase Contract',function = 'slaveguildfairy', args = 4, disabled = true})
	elif stage == 4:
		text = questtext.MapleAudiencePurchase
		globals.state.sidequests.maple = 6
		globals.resources.gold -= 7000
	elif stage == 5:
		sprites = [['fairy','pos1']]
		text = questtext.MapleTake
		globals.state.sidequests.maple = 7
		globals.slaves = globals.characters.create("Maple")
		town()
		slaveguild()
	main.dialogue(state, self, globals.player.dictionary(text), buttons, sprites)

func togorn():
	get_node("playergrouppanel/VBoxContainer").set_hidden(false)
	main.get_node("explorationnode").zoneenter('gorn')

func tofrostford():
	get_node("playergrouppanel/VBoxContainer").set_hidden(false)
	main.get_node("explorationnode").zoneenter('frostford')

var selectedslave
var selectedslaveprice
var slavearray
var mindread = false
var sellslavelocation

func slaveguildslaves():
	get_node("slavebuypanel").set_hidden(false)
	var slavelist = get_node("slavebuypanel/slavebuypanel/ScrollContainer/VBoxContainer")
	var slavebutton = get_node("slavebuypanel/slavebuypanel/ScrollContainer/VBoxContainer/slavebutton")
	for i in slavelist.get_children():
		if i != slavebutton:
			i.set_hidden(true)
			i.queue_free()
	for slave in slavearray:
		var newbutton = slavebutton.duplicate()
		slavelist.add_child(newbutton)
		newbutton.set_hidden(false)
		newbutton.get_node('name').set_text(slave.dictionary('$name, ')+ slave.race + ', '+ slave.sex)
		newbutton.get_node('age').set_text(slave.age.capitalize())
		newbutton.get_node('origins').set_text(slave.dictionary('Grade: '+slave.origins))
		var price = max(slave.buyprice()*0.8,50)
		if globals.state.reputation.has(location) && globals.state.reputation[location] <= -10 && location != 'umbra':
			price *= (abs(globals.state.reputation[location])/20.0)
		price = round(price)
		newbutton.set_meta('slave', slave)
		newbutton.get_node('price').set_text(str(price)+ ' gold')
		newbutton.set_meta('price', price)
		newbutton.connect('pressed',self,'selectslavebuy',[slave])
	mansion.maintext = 'You get a simple catalogue with currently present slaves available for purchase.'
	get_node("slavebuypanel/statspanel").set_hidden(true)
	clearbuttons()

func selectslavebuy(slave):
	var price = 0
	selectedslave = slave
	for i in get_node("slavebuypanel/slavebuypanel/ScrollContainer/VBoxContainer").get_children():
		if i != get_node("slavebuypanel/slavebuypanel/ScrollContainer/VBoxContainer/slavebutton") && i.get_meta('slave') == slave:
			i.set_pressed(true)
			price = i.get_meta('price')
		else:
			i.set_pressed(false)
	var text = ''
	if slave.effects.has('captured') == true:
		text += "During the examination $name only returned bold, angry look, showing $his [color=#ff4949]rebellious[/color] attitude. \n\n"
	elif slave.obed < 40:
		text += "$name reacts to commands [color=#ff4949]poorly[/color] and does not seem to hold any enthusiasm about $his position. Perhaps $he will need an additional training...\n\n"
	if slave.vagvirgin == true && slave.vagina != 'none':
		text += "After a gesture, $name reveals to you $his [color=aqua]virgin[/color] pussy. \n\n"
	text += "As you finish inspection, you are being reminded, that you can purchase $him for mere [color=yellow]"+str(price)+ " gold[/color].[/color] "
	mansion.maintext = slave.descriptionsmall() + '\n\n[color=#ff5df8]'+ slave.dictionary(text)
	if globals.resources.gold < price:
		get_node("slavebuypanel/purchasebutton").set_disabled(true)
	else:
		get_node("slavebuypanel/purchasebutton").set_disabled(false)
	if globals.spelldict.mindread.learned == true && globals.resources.mana >= 5 && mindread == false:
		get_node("slavebuypanel/mindreadbutton").set_disabled(false)
	else:
		get_node("slavebuypanel/mindreadbutton").set_disabled(true)
	get_node("slavebuypanel/statspanel").slave = slave
	get_node("slavebuypanel/statspanel").set_hidden(false)
	selectedslaveprice = price
	if mindread == true:
		get_node("slavebuypanel/statspanel").mode = 'slaveadv'
	else:
		get_node("slavebuypanel/statspanel").mode = 'slavebase'
	get_node("slavebuypanel/statspanel").show()


func _on_mindreadbutton_pressed():
	globals.resources.mana -= 5
	mindread = true
	
	selectslavebuy(selectedslave)


func selectslavesell(slave = null, type = 'guild'):
	if type == 'guild':
		selectedslaveprice = slave.sellprice()
	elif type == 'sebastian':
		selectedslaveprice = round(slave.sellprice(true)*0.7)
	elif type == 'umbra':
		selectedslaveprice = slave.sellprice(true)
	selectedslave = slave
	var text = ''
	text = 'After some time, you get an offer to sell this servant for [color=yellow]' + str(selectedslaveprice) + ' gold[/color]. '
	if selectedslave.fromguild == true:
		text += slave.dictionary("\n\n[color=#ff4949]You won't get any upgrade points from selling this slave as $he has been recently registered in the census.[/color]")
	elif type != 'guild' || (selectedslave.obed >= 90 && selectedslave.fromguild == false && selectedslave.effects.has('captured') == false):
		text += slave.dictionary("\n\n[color=aqua]You will get upgrade points from selling this slave here depending on $his grade.[/color]")
	else:
		text += slave.dictionary("\n\n[color=#ff4949]You won't get any upgrade points from selling this slave currently $he's too rebellious.[/color]")
	#get_node("slavesellpanel/slavedescription").set_bbcode(text)
	mansion.maintext = text
	get_node("slavesellpanel/slavesellbutton").set_disabled(false)
	
	for i in get_node("slavesellpanel/ScrollContainer/VBoxContainer").get_children():
		if i != get_node("slavesellpanel/ScrollContainer/VBoxContainer/slavebutton") && i.get_meta('slave') == slave:
			i.set_pressed(true)
		else:
			i.set_pressed(false)



func _on_slavelistcancel_pressed():
	get_node("slavebuypanel").set_hidden(true)
	clearselection()
	if location != 'umbra':
		slaveguild(location)
	else:
		get_parent().get_node("explorationnode").zoneenter('umbra')

func _on_purchasebutton_pressed():
	globals.resources.gold -= selectedslaveprice
	globals.slaves = selectedslave
	slavearray.remove(slavearray.find(selectedslave))
	main.popup('You pay ' + str(selectedslaveprice) + selectedslave.dictionary(" gold for $name. With that, guild's helper brands $him for you and $he's sent to your mansion. "))
	selectedslave.brand = 'basic'
	slaveguildslaves()
	mansion.maintext = globals.player.dictionary("A finest choice, $sir. Anyone else caught your attention?")
	clearselection('buy')



func _on_slavesellbutton_pressed():
	var upgradefromslave = false
	var text = ''
	globals.resources.gold += selectedslaveprice
	if selectedslave.obed >= 90 && selectedslave.fromguild == false && selectedslave.effects.has('captured') == false:
		upgradefromslave = true
		globals.resources.upgradepoints += globals.originsarray.find(selectedslave.origins)+1
	elif sellslavelocation in ['sebastian','umbra'] && selectedslave.fromguild == false:
		upgradefromslave = true
		globals.resources.upgradepoints += globals.originsarray.find(selectedslave.origins)+1
		if selectedslave.fromguild == false && (selectedslave.obed < 90 || selectedslave.effects.has('captured') == true):
			var reputationloss = [['wimborn',1],['gorn',1],['frostford',1],['amberguard',1]]
			if selectedslave.race in ['Elf','Dark Elf','Drow']:
				reputationloss[3][1] += 12
			elif selectedslave.race.find('Beastkin') >= 0 ||  selectedslave.race.find('Halfkin') >= 0:
				reputationloss[2][1] += 8
			elif selectedslave.race in ['Orc','Goblin','Centaur']:
				reputationloss[2][1] += 10
			globals.state.reputation[globals.weightedrandom(reputationloss)] -= 4
			text += "[color=yellow]Your reputation has suffered from this deal. [/color]\n"
	if globals.guildslaves.has(location):
		globals.guildslaves[location].append(selectedslave)
	selectedslave.removefrommansion()
	selectedslave.fromguild = true
	text += selectedslave.dictionary('You sell $name for ') + str(selectedslaveprice) + selectedslave.dictionary(" gold. ")
	if sellslavelocation != 'sebastian':
		text += selectedslave.dictionary("$He's taken away and put on sale for other customers. ")
	main.rebuild_slave_list()
	slaveguildsells()
	clearselection('sell')
	mansion.maintext = text


func slaveguildsells():
	sellslavelist('guild')

func sellslavelist(type = 'guild'):
	var text = 'Select a person you wish to sell. '
	if type == 'guild':
		text += "You will receive Mansion Upgrade points if slave haven't been registered before and is not rebellious."
	mansion.maintext = text
	get_node("slavesellpanel").set_hidden(false)
	clearbuttons()
	var slavelist = get_node("slavesellpanel/ScrollContainer/VBoxContainer")
	var slavebutton = get_node("slavesellpanel/ScrollContainer/VBoxContainer/slavebutton")
	for i in slavelist.get_children():
		if i != slavebutton:
			i.set_hidden(true)
			i.queue_free()
	for slave in globals.slaves:
		if slave.away.duration == 0:
			var newbutton = slavebutton.duplicate()
			slavelist.add_child(newbutton)
			newbutton.set_hidden(false)
			newbutton.get_node('name').set_text(slave.dictionary('$name, ')+ slave.race + ', '+ slave.sex + ', ' + slave.age + ', ' + slave.work)
			if type == 'guild':
				newbutton.get_node('price').set_text(str(slave.sellprice()) + ' gold')
			elif type == 'sebastian':
				newbutton.get_node('price').set_text(str(round(slave.sellprice(true)*0.7))+ ' gold')
			elif type == 'umbra':
				newbutton.get_node('price').set_text(str(slave.sellprice(true))+ ' gold')
			if type in ['sebastian','umbra']:
				mansion.maintext = "[color=aqua]Selling slaves here will still provide upgrade points even if they are rebellious, but will lower your reputation. [/color]"
			newbutton.set_meta('slave', slave)
			newbutton.connect('pressed',self,'selectslavesell',[slave, type])


func _on_slavesellcancel_pressed():
	get_node("slavesellpanel").set_hidden(true)
	clearselection()
	if sellslavelocation in ['gorn','wimborn','frostford']:
		slaveguild(sellslavelocation)
	elif sellslavelocation == 'sebastian':
		sebastian()
	elif sellslavelocation == 'umbra':
		get_parent().get_node("explorationnode").zoneenter('umbra')

func clearselection(temp = ''):
	selectedslave = ''
	selectedslaveprice = 0
	mansion.maintext = ''
	if temp == 'buy':
		mansion.maintext = '[color=yellow]Your newly purchased slave has been sent to your mansion. [/color]'
	elif temp == 'sell':
		mansion.maintext = "[color=yellow]You receive a nice purse of gold for your freshly selled servant. [/color]"
	get_node("slavebuypanel/purchasebutton").set_disabled(true)
	get_node("slavesellpanel/slavesellbutton").set_disabled(true)
	for i in get_node("slavebuypanel/slavebuypanel/ScrollContainer/VBoxContainer").get_children():
		i.set_pressed(false)
	for i in get_node("slavesellpanel/ScrollContainer/VBoxContainer").get_children():
		i.set_pressed(false)

var selectedquest
var offeredslave

func slaveguildquests():
	selectedquest = null
	var text
	clearbuttons()
	get_node("slaveguildquestpanel/questaccept").set_disabled(true)
	get_node("slaveguildquestpanel/questcancel").set_hidden(true)
	mansion.maintext = ''
	text = "You walk to the Slaver Guild's request board.\n\n[color=yellow]Completing repeatable missions will earn you Mansion Upgrade points. [/color]"
	get_node("slaveguildquestpanel").set_hidden(false)
	var list = get_node("slaveguildquestpanel/ScrollContainer/VBoxContainer")
	var button = get_node("slaveguildquestpanel/ScrollContainer/VBoxContainer/questbutton")
	var questarray = []
	for i in list.get_children():
		if i != button:
			i.set_hidden(true)
			i.queue_free()
	if location == 'wimborn':
		questarray = globals.state.repeatables.wimbornslaveguild
	elif location == 'gorn':
		questarray = globals.state.repeatables.gornslaveguild
	elif location == 'frostford':
		questarray = globals.state.repeatables.frostfordslaveguild
	for i in questarray:
		if i.taken == true:
			var fontcolor
			if i.difficulty == 'easy':
				fontcolor = Color(0,1,0,1)
			elif i.difficulty == 'medium':
				fontcolor = Color(1,1,0,1)
			elif i.difficulty == 'hard':
				fontcolor = Color(1,0,0,1)
			var newbutton = button.duplicate()
			list.add_child(newbutton)
			newbutton.set_hidden(false)
			newbutton.get_node("name").set_bbcode(i.shortdescription + ' — Taken')
			newbutton.get_node("reward").set_text(str(i.reward) + ' gold')
			newbutton.get_node("difficulty").set_text(i.difficulty.capitalize())
			newbutton.get_node("difficulty").set('custom_colors/font_color', fontcolor)
			newbutton.connect("pressed",self,'questbuttonpressed',[i])
			text = "[color=yellow]— Are you ready to fulfil your task? Your reward will be waiting. [/color]"
			mansion.maintext = text
			return
	for i in questarray:
		var fontcolor
		if i.difficulty == 'easy':
			fontcolor = Color(0,1,0,1)
		elif i.difficulty == 'medium':
			fontcolor = Color(1,1,0,1)
		elif i.difficulty == 'hard':
			fontcolor = Color(1,0,0,1)
		var newbutton = button.duplicate()
		list.add_child(newbutton)
		newbutton.set_hidden(false)
		newbutton.get_node("name").set_bbcode(i.shortdescription)
		newbutton.get_node("reward").set_text(str(i.reward) + ' gold')
		newbutton.get_node("difficulty").set_text(i.difficulty.capitalize())
		newbutton.get_node("difficulty").set('custom_colors/font_color', fontcolor)
		newbutton.connect("pressed",self,'questbuttonpressed',[i])
	mansion.maintext = text

func _on_questhide_pressed():
	get_node("slaveguildquestpanel").set_hidden(true)
	slaveguild(location)

func questbuttonpressed(quest):
	mansion.maintext = slavequesttext(quest)

func _on_questcancel_pressed():
	main.yesnopopup("Cancel this quest?", 'removequest', self)


func removequest():
	for i in globals.state.repeatables:
		for ii in globals.state.repeatables[i]:
			if ii == selectedquest:
				globals.state.repeatables[i].remove(globals.state.repeatables[i].find(ii))
	main.get_node("menucontrol/yesnopopup").set_hidden(true)
	slaveguildquests()

func _on_questaccept_pressed():
	if selectedquest.taken == false:
		selectedquest.taken = true
		slaveguildquests()
		mansion.maintext = "You sign under the request and take a copy of it."
	else:
		if get_node("slaveguildquestpanel/questaccept").get_text() == 'Turn in':
			main.popup(offeredslave.dictionary('You hand away $name and receive your reward. \n[color=yellow]You have gained ' + str(selectedquest.reward/10) + ' XP.[/color]\n\n[color=green]Your reputation with ' + location.capitalize() + " has increased.[/color]"))
			globals.slaves.remove(globals.slaves.find(offeredslave))
			selectedquest.taken = false
			globals.player.xp += selectedquest.reward/10
			globals.resources.gold += selectedquest.reward
			if selectedquest.difficulty == 'easy':
				globals.state.reputation[location] += 3
				globals.resources.upgradepoints += 3
			elif selectedquest.difficulty == 'medium':
				globals.state.reputation[location] += 5
				globals.resources.upgradepoints += 6
			elif selectedquest.difficulty == 'hard':
				globals.state.reputation[location] += 8
				globals.resources.upgradepoints += 9
			for i in globals.state.repeatables:
				for ii in globals.state.repeatables[i]:
					if ii == selectedquest:
						globals.state.repeatables[i].remove(globals.state.repeatables[i].find(ii))
			slaveguildquests()
		else:
			main.selectslavelist(false, 'slaveforquestselected', self)

func slaveforquestselected(slave):
	var quest = selectedquest
	var slavefits = true
	var text = ''
	for i in quest.reqs:
		var ref = slave
		if i[0].find('.') >= 0:
			var temp = i[0].split('.')
			for i in temp:
				ref = ref[i]
		else:
			ref = slave[i[0]]
		var ref2 = i[2]
		if i[0] == 'hairlength':
			ref = globals.hairlengtharray.find(slave.hairlength)
		if i[0] == 'titssize':
			ref = globals.sizearray.find(slave.titssize)
		if i[0] == 'sexuals.unlocks':
			ref = slave.sexuals.unlocks.size()
		if i[0] == 'origins':
			ref = globals.originsarray.find(slave.origins)
			ref2 = globals.originsarray.find(ref2)
		if i[1] == 'gte':
			if ref < ref2:
				slavefits = false
				text = text + '[color=#ff4949]' + repeatablesdict[i[0]] + '[/color]\n'
			else:
				text = text + '[color=green]' + repeatablesdict[i[0]] + '[/color]\n'
		elif i[1] == 'eq':
			if ref != ref2:
				slavefits = false
				text = text + '[color=#ff4949]' + repeatablesdict[i[0]] + '[/color]\n'
			else:
				text = text + '[color=green]' + repeatablesdict[i[0]] + '[/color]\n'
		elif i[1] == 'lte':
			if ref > ref2:
				slavefits = false
				text = text + '[color=#ff4949]' + repeatablesdict[i[0]] + '[/color]\n'
			else:
				text = text + '[color=green]' + repeatablesdict[i[0]] + '[/color]\n'
	if slavefits == true:
		mansion.maintext = "There seems to be no problems with neeeded requirements.\n" + text
		get_node("slaveguildquestpanel/questaccept").set_text("Turn in")
		offeredslave = slave
	else:
		mansion.maintext = slave.dictionary("You have not completed all the requirements. \n") + text
		offeredslave = null



var repeatablesdict = {
sex = 'Sex',obed = 'Obedience', cour = 'Courage',conf = 'Confidence',wit = 'Wit', charm = 'Charm', 
'beauty':'Beauty',lewdness = 'Lewdness', asser = 'Role Preference', 
'sexuals.unlocks' : "Unlocked Sex Categories",
'sstr' : 'Strength', 'sagi' : 'Agility', 'smaf' : 'Magic Affinity', 'send' : 'Endurance',
loyal = 'Loyalty', race = 'Race', age = 'Age', hairlength = 'Hair Length', origins = 'Origins',
bodyshape = 'Type', haircolor = 'Hair Color', 'titssize' : 'Breasts Size',
}

func slavequesttext(quest):
	var text = ''
	var sex = ''
	var race = ''
	var text2 = ''
	var operators = {eq = ' only;\n', gte = ' or higher;\n', lte = ' or lower;\n', neq = ' not;\n'}
	get_node("slaveguildquestpanel/questaccept").set_disabled(false)
	selectedquest = quest
	for i in get_node("slaveguildquestpanel/ScrollContainer/VBoxContainer").get_children():
		if i.get_node('name').get_bbcode() != quest.shortdescription:
			i.set_pressed(false) 
	for i in quest.reqs:
		if i[0].find('skills') >= 0:
			text2 = text2 + repeatablesdict[i[0]] + ' — '+ globals.player.skill_level(i[2]) + operators[i[1]]
		elif i[0] in ['sex','age','bodyshape','haircolor','race']:
			text2 = text2 + repeatablesdict[i[0]] + ' — '+ str(i[2]) + ';\n'
		elif i[0] == 'hairlength':
			text2 = text2 + 'Hair length — ' + str(globals.hairlengtharray[i[2]]) + ';\n'
		elif i[0] == 'titssize':
			text2 = text2 + 'Breast size — ' + str(globals.sizearray[i[2]]) + operators[i[1]]
		elif i[0] == 'origins':
			text2 = text2 + 'Origins — ' + str(i[2]) + operators[i[1]]
		else:
			text2 = text2 + repeatablesdict[i[0]] + ' — '+ str(i[2]) + operators[i[1]]
		if i[0] == 'sex':
			sex = i[2]
		elif i[0] == 'race':
			race = i[2]
	
	if quest.description.find('$sex')>= 0:
		quest.description = quest.description.replace("$sex",sex)
	if quest.description.find('$race')>= 0:
		quest.description = quest.description.replace("$race",race)
	if quest.taken == true:
		get_node("slaveguildquestpanel/questcancel").set_hidden(false)
		get_node("slaveguildquestpanel/questaccept").set_text('Offer slave')
	else:
		get_node("slaveguildquestpanel/questcancel").set_hidden(true)
		get_node("slaveguildquestpanel/questaccept").set_text('Accept')
	text = quest.description
	text = text + '\n\nRequired Slave Specifics:\n' + text2 + '\n[color=yellow]Reward: ' + str(quest.reward) + ' gold.[/color] [color=aqua]Time Limit: ' + str(quest.time) + ' days.[/color]'
	
	
	
	return text

var slaveserviceselected
var serviceoperation

func slaveservice():
	clearbuttons()
	mansion.maintext = ''
	get_node("slaveservicepanel/hairlengthbutton").set_hidden(true)
	get_node("slaveservicepanel").set_hidden(false)
	serviceselected()

func serviceselected(slave = null):
	var list = get_node("slaveservicepanel/ScrollContainer/VBoxContainer")
	var button = get_node("slaveservicepanel/ScrollContainer/VBoxContainer/Button")
	var newbutton
	var array = []
	get_node("slaveservicepanel/speccontainer").set_hidden(true)
	for i in list.get_children():
		if i != button:
			i.set_hidden(true)
			i.queue_free()
	if slave == null:
		slaveserviceselected = null
		get_node("slaveservicepanel/selectslavebutton").set_text('Select Slave')
		get_node("slaveservicepanel/serviceconfirm").set_disabled(true)
		mansion.maintext = 'Slave service allows you to perform many special, important operations with your servants. Select servant, then choose desired action. \n\n[color=yellow]This will cost money and likely withdraw servant for a time. Choose operation for further information.[/color]'
	else:
		slaveserviceselected = slave
		get_node("slaveservicepanel/selectslavebutton").set_text('Deselect')
		for i in operationdict.values():
			array.append(i)
		array.sort_custom(globals, 'sortbynumber')
		for i in array:
			globals.currentslave = slaveserviceselected
			if globals.evaluate(i.reqs) == true:
				var price = i.price
				newbutton = button.duplicate()
				list.add_child(newbutton)
				newbutton.set_hidden(false)
				newbutton.set_text(i.name)
				newbutton.set_meta('operation', i.code)
				if i.code == 'uprise':
					price = 100 * (globals.originsarray.find(slave.origins)+1)
				newbutton.get_node("price").set_text(str(price))
				newbutton.connect("pressed",self,'operationselected',[i.code])

func _on_selectslavebutton_pressed():
	if get_node("slaveservicepanel/selectslavebutton").get_text() == 'Select Slave':
		main.selectslavelist(true, 'serviceselected', self)
	else:
		serviceoperation = null
		serviceselected()

func operationselected(operation):
	serviceoperation = operation
	var slave = slaveserviceselected
	var text = ''
	var price = operationdict[operation].price
	for i in get_node("slaveservicepanel/ScrollContainer/VBoxContainer").get_children():
		if i.is_pressed() == true && i.get_meta("operation") != operation:
			i.set_pressed(false)
	get_node("slaveservicepanel/speccontainer").set_hidden(true)
	for i in get_node("slaveservicepanel/speccontainer/VBoxContainer").get_children():
		if i != get_node("slaveservicepanel/speccontainer/VBoxContainer/Button"):
			i.set_hidden(true)
			i.queue_free()
	text = slaveserviceselected.dictionary(operationdict[operation].description) 
	
	if operation == 'nurture':
		text += '\nRequired time: 5 days.'
	elif operation == 'uprise':
		price = 100 * (globals.originsarray.find(slave.origins)+1)
		text += slave.dictionary("\n\n$name's grade will become [color=aqua]") + globals.originsarray[globals.originsarray.find(slave.origins)+1].capitalize() + "[/color]. Required time: " + str(globals.originsarray.find(slave.origins)+2) + " days."
	elif operation == 'subjugate':
		text += slave.dictionary("\n\n$name's grade will become [color=aqua]") + globals.originsarray[globals.originsarray.find(slave.origins)-1].capitalize() + "[/color]. Required time: 1 day"
	elif operation == 'spec':
		var array = []
		for i in globals.jobs.specs.values():
			array.append(i)
		array.sort_custom(globals, 'sortbyname')
		get_node("slaveservicepanel/speccontainer").set_hidden(false)
		
		for i in array:
			var newbutton = get_node("slaveservicepanel/speccontainer/VBoxContainer/Button").duplicate()
			get_node("slaveservicepanel/speccontainer/VBoxContainer").add_child(newbutton)
			newbutton.set_hidden(false)
			newbutton.set_text(i.name)
			newbutton.set_meta("spec", i)
			newbutton.connect("pressed",self,'specchosen',[newbutton])
			
	
	text += '\n\n[color=yellow]Price: '+ str(price) + ' gold[/color]'
	
	if globals.resources.gold >= price && operation != 'spec':
		get_node("slaveservicepanel/serviceconfirm").set_disabled(false)
	else:
		get_node("slaveservicepanel/serviceconfirm").set_disabled(true)
	if operation == 'haircut':
		get_node("slaveservicepanel/hairlengthbutton").set_hidden(false)
		get_node("slaveservicepanel/hairlengthbutton").clear()
		for i in globals.hairlengtharray:
			if globals.hairlengtharray.find(slaveserviceselected.hairlength) > globals.hairlengtharray.find(i):
				get_node("slaveservicepanel/hairlengthbutton").add_item(i.capitalize()+' length')
	else:
		get_node("slaveservicepanel/hairlengthbutton").set_hidden(true)
	mansion.maintext = text


func _on_serviceconfirm_pressed():
	var slave = slaveserviceselected
	var operation = operationdict[serviceoperation]
	var text = slave.dictionary(operation.confirm)
	if operation.code == 'abortion':
		slave.preg.baby = null
		slave.preg.duration = 0
		slave.stress += rand_range(35,70)
		slave.health -= 20
		globals.resources.gold -= operation.price
	elif operation.code == 'sterilize':
		slave.preg.has_womb = false
		slave.stress += rand_range(30,50)
		slave.health -= 15
		globals.resources.gold -= operation.price
	elif operation.code == 'nurture':
		slave.trait_remove('Regressed')
		slave.away.duration = 5
		slave.away.at = 'nurture'
		globals.resources.gold -= operation.price
	elif operation.code == 'haircut':
		var hairlength = get_node("slaveservicepanel/hairlengthbutton").get_item_text(get_node("slaveservicepanel/hairlengthbutton").get_selected())
		hairlength = hairlength.replace(' length', '')
		hairlength = globals.decapitalize(hairlength)
		slave.hairlength = hairlength
		globals.resources.gold -= operation.price
	elif operation.code == 'subjugate':
		slave.origins = globals.originsarray[globals.originsarray.find(slave.origins)-1]
		slave.away.duration = 1
		globals.resources.gold -= operation.price
	elif operation.code == 'uprise':
		globals.resources.gold -= operation.price * (globals.originsarray.find(slave.origins)+1)
		slave.origins = globals.originsarray[globals.originsarray.find(slave.origins)+1]
		if slave.levelupreqs.has('code') && slave.levelupreqs.code == 'improvegrade':
			slave.levelup()
		slave.away.duration = 1 + globals.originsarray.find(slave.origins)
	elif operation.code == 'spec':
		if slave.levelupreqs.has('code') && slave.levelupreqs.code == 'specialization':
			slave.levelup()
		globals.resources.gold -= 500
		if slave.effects.has('bodyguardeffect'): slave.add_effect(globals.effectdict.bodyguardeffect, true)
		slave.spec = get_node("slaveservicepanel/serviceconfirm").get_meta('spec').code
		if slave.spec == 'bodyguard': slave.add_effect(globals.effectdict.bodyguardeffect)
		slave.away.duration = 5
	slaveserviceselected = null
	serviceoperation = null
	slaveservice()
	main.popup(text)

func _on_slaveservicecancel_pressed():
	get_node("slaveservicepanel").set_hidden(true)
	slaveguild(location)

func specchosen(button):
	for i in get_tree().get_nodes_in_group('specsbutton'):
		if i != button:
			i.set_pressed(false)
	var spec = button.get_meta('spec') 
	var text = "[center]" + spec.name + '[/center]\n' + spec.descript + "\nBonus: [color=aqua]" + spec.descriptbonus + "[/color]\n\nRequirements: [color=yellow]" + spec.descriptreqs + "[/color]\n\nCost: 500 gold.\nDuration: 5 days."
	mansion.maintext = text
	globals.currentslave = slaveserviceselected
	if globals.resources.gold >= 500 && globals.evaluate(spec.reqs) == true:
		get_node("slaveservicepanel/serviceconfirm").set_disabled(false)
		get_node("slaveservicepanel/serviceconfirm").set_meta('spec', spec)
	else:
		get_node("slaveservicepanel/serviceconfirm").set_disabled(true)

var operationdict = {
haircut = {
code = 'haircut',
name = 'Cut Hair',
number = 1,
reqs = "slave.hairlength != 'ear'",
description = "[color=yellow]Simplest procedure to trim your servant's hair. [/color]",
price = 25,
confirm = "You leave $name in the custody of guild's barber. Later $he returns with shorter hair."
},
abortion = {
code = 'abortion',
name = 'Commit Abortion',
number = 2,
reqs = "slave.preg.duration >= 5",
description = "[color=yellow]Stops pregnancy. [/color] ",
price = 75,
confirm = "You leave $name in the custody of guild's specialists. As $his pregnancy ends, you can notice how $name looks considerably more stressed."
},
sterilize = {
code = 'sterilize',
name = 'Sterilize',
number = 2,
reqs = "slave.preg.has_womb == true && globals.currentslave.preg.duration == 0",
description = "[color=yellow]Prevents new pregnancies. [/color]\n\n[color=#ff4949]This operation is difficult to reverse![/color]",
price = 125,
confirm = "After the operation $name becomes sterile. $He won't be able to carry any more children. "
},
nurture = {
code = 'nurture',
name = 'Nurture',
number = 3,
reqs = "slave.traits.find('Regressed') >= 0",
description = "[color=yellow]This option will neutralize Regressed trait.[/color]",
price = 150,
confirm = "You leave $name in the custody of guild trainers, who will train $him among other slaves and prepare for your domain."
},
uprise = {
code = 'uprise',
name = 'Elevate',
number = 4,
reqs = "slave.origins != 'noble'",
description = "[color=yellow]This option will raise servant's grade, but also will make them more demanding. [/color]",
price = 100,
confirm = "You leave $name in the custody of guild trainers, who will help $him raising $his self-esteem. ",
},
subjugate = {
code = 'subjugate',
name = 'Demote',
number = 5,
reqs = "slave.origins != 'slave'",
description = "[color=yellow]This option will lower servant's grade. [/color]",
price = 50,
confirm = "You leave $name in the custody of guild trainers, who will accustom $him to the less luxurious life. ",
},
spec = {
code = "spec",
name = "Specialization",
number = 6,
reqs = 'true',
description = "[color=yellow]Teach servant a new specialization. Only one specialization can be learned per servant. [/color]",
price = 500,
confirm = "You leave $name in the custody of guild trainers, who will teach $him a new specialization."
}
}

###############MAGE GUILD

func mageorder():
	main.background_set('mageorder')
	if OS.get_name() != "HTML5" && globals.rules.fadinganimation == true:
		yield(main, 'animfinished')
	var array = []
	if globals.state.mainquest in [40,41]:
		globals.events.orderfinale()
		return
	mansion.maintext = "This massive building takes a large part of the street. The Wimborn's Mage's Order is the centerpiece of your career achievments. Here you'll be able to buy necessary equipment and learn spells, assuming you are part of it of course."
	if globals.state.mainquest <= 1:
		array.append({name = 'Seek Audience', function = 'mageorderquest1'})
	elif globals.state.mainquest == 2:
		array.append({name = 'Consult on further promotions',function = 'mageorderquest1'})
	elif globals.state.mainquest >= 3 && globals.state.mainquestcomplete != true:
		array.append({name = 'Find Melissa', function = 'mageorderquest1'})
	if globals.state.rank >= 1:
		array.append({name = 'Purchase New Spells',function = 'mageservices'})
	
	if globals.state.sidequests.emily == 12:
		array.append({name = "Visit Tisha's workplace", function = "tishaquest"})
	if globals.state.mainquest == 27:
		array.append({name = "Teleport to Capital", function = 'capitalteleport'})
	if globals.state.sidequests.maple in [4,5]:
		array.append({name = "Audience Slaver Guild Host", function = 'slaveguildfairy', args = 3})
	array.append({name = 'Return to city',function = 'town'})
	buildbuttons(array)

func capitalteleport():
	var buttons = []
	var text = ''
	var state = true
	var sprites = null
	if globals.state.mainquest == 27:
		text = questtext.MainQuestFrostfordMainOrder
		globals.state.mainquest = 28
	
	main.dialogue(state, self, text, buttons, sprites, 'mainorder')
	mageorder()


func mageorderquest1(slave = null):
	var buttons = []
	var text = ''
	var state = true
	var sprites = null
	questgiveawayslave = slave
	if globals.state.mainquest == 0:
		sprites = [['chancellor','pos1','opac']]
		globals.state.mainquest = 1
		text = ("After some time you find a chancellor: a senior member responsible for accepting new applicants. You give a small knock to announce your presence, and the old man looks up from his paperwork with a sneer. You begin to introduce yourself, but he raises a hand to stop you.\n\n— Yes, yes, I already know who you are. You’ve been a hot topic these past few days, a trend that shall die soon, I’m sure. Allow me to hazard a guess, now that you’ve inherited that senile fool’s mansion, you’re here to apply for membership, correct? Well, I’ll have you know that I have no intention of shaming this institution, nor disgracing myself, by admitting a nameless imbecile such as yourself. Leave now, there are more important matters for me to attend to.\n\nHe returns to his work and waves his hand to shoo you away, but you came here for a purpose, and refuse to leave without seeing it fulfilled. You argue the case for your membership for several minutes; the chancellor growing visibly more frustrated with your presence every second you remain. Before long, he’s had enough of your filibustering and slams a hand on his desk.\n\n— Bah! If you so desperately want to gain membership, then so be it! If you can fulfil a simple request I've not had time to deal with, I shall consider your membership. Now, listen carefully, I will not repeat myself!\n\n— I’ve been looking for a secretary; one who is attractive, knows how to serve, and human. I would go to the Slave Guild for this, but my duties here rarely permit me the time. Bring me a girl who meets my criteria, and I shall accept your membership. Now leave, before I force you to.\n\n[color=green]Your main quest has been updated. [/color]")
	elif globals.state.mainquest == 1:
		if questgiveawayslave == null:
			sprites = [['chancellor','pos1','opac']]
			text = "— Ah, you’ve returned, how very ‘wonderful’ of you. The arrangement has not been forgotten, provide me with what I want, and I’ll provide you with what you want."
			buttons.append(['Select Slave', 'selectslaveforquest', 'mageorderquest1'])
		else:
			slave = questgiveawayslave
			if slave.obed >= 90 && slave.race == 'Human' && slave.beauty >= 40 && slave.sex == 'female':
				sprites = [['chancellor','pos1']]
				text = "— Looks about right. Ready to part with her?"
				buttons.append(['Give away ' + slave.name, 'givecompanion'])
				buttons.append(['Select Slave', 'selectslaveforquest', 'mageorderquest1'])
			else:
				sprites = [['chancellor','pos1']]
				text = questgiveawayslave.dictionary("— Who do you take me for? $He does not meet the requirements.")
				buttons.append(['Select Slave', 'selectslaveforquest', 'mageorderquest1'])
	elif globals.state.mainquest == 2:
		sprites = [['melissafriendly','pos1','opac']]
		globals.charactergallery.melissa.unlocked = true
		text = ("After a brief talk, the girl at the reception desk leads to you a room where you find an exquisitely dressed woman.\n\n— Oh, a new face here. I'm Melissa. I am pleased to know that there's a new person in our glorious establishment; and an active one too. Fresh blood is exactly what we need here in the Order.\n\n— First thing, it's great that you helped out our grumpy fellow with new staff. Let me compensate you for that. No worries, you earned it, and it should help your sustain and our cause. \n\n[color=green]Melissa passes you 250 gold. [/color]\n\n— Promotions are not very useful in terms of privileges for the commonfolk we have around, but for you it will grant access to some of the great knowledge and technology we have. I'd like to offer you a partnership. You help me, and I will push you up the stairs. How does that sound?")
		buttons.append(['Agree','mageorderquest2'])
	elif str(globals.state.mainquest) in ['3','3.1']:
		sprites = [['melissafriendly','pos1','opac']]
		if questgiveawayslave == null:
			text = '— You are back. Did you find the fairy?'
			buttons.append(['Select Slave', 'selectslaveforquest', 'mageorderquest1'])
		else:
			slave = questgiveawayslave
			if slave.race == 'Fairy':
				sprites = [['melissafriendly','pos1']]
				text = "— Looks about right. Ready to part with her?"
				buttons.append(['Give away ' + slave.name, 'givecompanion'])
				buttons.append(['Select Slave', 'selectslaveforquest', 'mageorderquest1'])
			else:
				sprites = [['melissafriendly','pos1']]
				text = globals.player.dictionary("— Oh, this is not a Fairy, $name. Come back when you find a fairy.")
				buttons.append(['Select Slave', 'selectslaveforquest', 'mageorderquest1'])
	elif globals.state.mainquest == 4:
		sprites = [['melissaworried','pos1','opac']]
		globals.state.mainquest = 5
		text = "You find Melissa in her cabinet looking unusually grim.\n\n— Oh, it's you $name. I'm in a spot of trouble here. Two days ago I was supposed to receive  some important medication, but it has yet to arrive. I want you to go to the city market, find man named Sebastian, and figure out what happened to my delivery! Do that quickly and...\n\n— Well, do that, and we'll see about what you came for.\n\n[color=green]Your main quest has been updated. [/color]"
	elif globals.state.mainquest == 5:
		text = ("You decide it is unwise to see Melissa without her delivery right now.")
	elif globals.state.mainquest == 6 && globals.itemdict.youthingpot.amount > 0:
		globals.state.mainquest = 7
		globals.itemdict.youthingpot.amount -= 1
		globals.state.rank = 3
		sprites = [['melissafriendly','pos1','opac']]
		text = ("— You got it?” she inquires, “Splendid!\n\nAs you pass her the potion, she quickly puts it inside the desk.\n\n— Yeah, I've done the paperwork. Here's your new badge; you'll need it. You remind me of myself, back when I joined  the guild...\n\n— I was actually sold into slavery to one of the mages in my youth. Not gonna complain about my position back then much. *giggles* Eventually, I asked him to teach me, as I wanted to be something more than just another plaything. He agreed. I guess I wasn’t a disappointment, as in the end I inherited his manor in this city and have made it this far.\n\n— Anyway, come see me later. I still have business to take care of today.\n\n[color=yellow]You are now a Journeyman in the Mage guild.[/color]")
	elif globals.state.mainquest == 6:
		text = ("You decide it is unwise to see Melissa without her delivery right now.")
	elif globals.state.mainquest == 7:
		globals.state.mainquest = 8
		sprites = [['melissafriendly','pos1','opac']]
		text = "— I hope you’ve noticed that you can now set up your own laboratory. If you have not, you really should.  Not only can you modify your servants to fit your tastes, but you can also make them more efficient. By law, you have all rights to do so."
		if globals.state.mansionupgrades.mansionlab < 1:
			text = text + "\n\n— Anyway, go set it up. You’ll need it  for your next task."
		else:
			text = text + "\n\n— You already have it? As I expected from someone as capable as you. Now, onto real business."
			globals.state.mainquest = 9
		if globals.state.mainquest == 9:
			buttons.append(["Continue", 'mageorderquest1'])
	elif globals.state.mainquest == 8 && globals.state.mansionupgrades.mansionlab < 1:
		text = ("You decide it's unwise to return to Melissa until you set up your laboratory.")
	elif (globals.state.mainquest == 8 || globals.state.mainquest == 9) && globals.state.mansionupgrades.mansionlab >= 1:
		text = ("— So, about something new. Do you know about the farms? If not, Sebastian could probably tell you a few things. But anyway, the Taurus race in fact has a higher than average milk output. Not only that, but you'll be able to increase production even further by enhancing them with more and bigger... assets. This is your mission for now. Provide for me a taurus girl, ideally suited for milking, with multiple giant breasts.\n\n— I will leave the search for such a girl to you; consider it a part of a mission. While you are at it, I'll prepare your next promotion.")
		globals.state.mainquest = 10
		sprites = [['melissafriendly','pos1','opac']]
	elif globals.state.mainquest == 10:
		if questgiveawayslave == null:
			sprites = [['melissafriendly','pos1','opac']]
			text = "— You are back. Did you finish preparing the girl?"
			buttons.append(['Select Slave', 'selectslaveforquest', 'mageorderquest1'])
		else:
			slave = questgiveawayslave
			if slave.race == 'Taurus' && slave.titssize == 'huge' && slave.lactation == true:
				text = "— Great work! Can I have her?"
				sprites = [['melissafriendly','pos1']]
				buttons.append(['Give away ' + slave.name, 'givecompanion'])
				buttons.append(['Select Slave', 'selectslaveforquest', 'mageorderquest1'])
			else:
				sprites = [['melissafriendly','pos1']]
				text = questgiveawayslave.dictionary("— I'm afraid this is not what I asked for.")
				buttons.append(['Select Slave', 'selectslaveforquest', 'mageorderquest1'])
	elif globals.state.mainquest == 11:
		sprites = [['melissafriendly','pos1']]
		text = questtext.MainQuestGornStart
		globals.state.mainquest = 12
	elif globals.state.mainquest in [12,13,14,15]:
		text = "You decide it's unwise to return to Melissa until you finish your business in Gorn."
	elif globals.state.mainquest == 16:
		sprites = [['melissafriendly','pos1','opac']]
		text = questtext.MainQuestGornMelissaReturn
		state = false
		globals.resources.upgradepoints += 5
		buttons.append(['Close', "orderhade"])
		globals.state.mainquest = 17
	elif globals.state.mainquest == 25:
		globals.state.mainquest = 26
		globals.resources.upgradepoints += 5
		sprites = [['melissafriendly','pos1','opac']]
		text = questtext.MainQuestUndercityReturn
	elif globals.state.mainquest == 26:
		globals.state.mainquest = 27
		sprites = [['melissafriendly','pos1','opac']]
		text = questtext.MainQuestFrostfordMelissa
	elif globals.state.mainquest >= 27 && globals.state.mainquest <= 35:
		text = "You decide there's nothing you can gain from visiting Melissa right now. "
	elif globals.state.mainquest == 36:
		text = questtext.MainQuestFinaleOrder
		globals.state.mainquest = 37
		globals.resources.upgradepoints += 10
		sprites = [['melissafriendly','pos1','opac']]
	elif globals.state.mainquest == 37:
		text = "You decide there's nothing you can gain from visiting Melissa right now. "
	main.dialogue(state, self, text, buttons, sprites)
	mageorder()

func orderhade():
	var text = globals.questtext.MainQuestGornMelissaAfter
	var buttons = []
	var sprites = null
	main.dialogue(true, self, text, buttons, sprites)

func selectslaveforquest(function):
	main.selectslavelist(true, function, self)

func givecompanion():
	var buttons = []
	var text = ''
	var slave = questgiveawayslave
	var sprites = null
	if globals.state.mainquest == 1:
		if slave != null:
			globals.state.mainquest = 2
			text = ("— Now that you are a member of the guild, I trust you’ll keep in mind that with status comes responsibility, and that you will not besmirch the guild’s name with your actions. As a neophyte, we have a variety of simple spells you may pay to learn. And, to repay an old debt to the fool you’re succeeding, I’ll teach you something basic for free. Mind Read is fairly simple and straightforward, allowing you limited insight into the subject’s thoughts and feelings. Much more informative than simply reading one’s expression and body language, but somewhat draining.\n\n[color=green]You are now a Neophyte in Mage guild.[/color]\n\n[color=green]You've learned a new spell: Mind Read. [/color]\n\n[color=green]Your main quest has been updated. [/color]")
			main.currentslave = globals.slaves.find(slave)
			globals.spelldict.mindread.learned = true
			if globals.abilities.abilitydict.has('mindread') == true:
				globals.player.ability.append('mindread')
			globals.state.branding = 1
			globals.state.rank = 1
			globals.resources.upgradepoints += 5
			main.getridof()
	elif str(globals.state.mainquest) in ['3','3.1']:
		if slave != null:
			globals.state.mainquest = 4
			sprites = [['melissafriendly','pos1']]
			text = "— Oh, what a cutie! You are just as capable as I expected. Can't wait to play with her in private, but business first.\n\nWith that, your companion is taken away and you are then taught Refined Branding. \n\n[color=green]You have been paid 500 gold. \n\nYour main quest has been updated. [/color]\n[color=yellow]You have gained an extra level.[/color]"
			main.currentslave = globals.slaves.find(slave)
			globals.resources.gold += 500
			globals.state.rank = 2
			globals.state.branding = 2
			globals.player.levelup()
			globals.resources.upgradepoints += 5
			main.getridof()
	elif globals.state.mainquest == 10:
		globals.state.mainquest = 11
		sprites = [['melissafriendly','pos1']]
		text = ("— Splendid! You really are not held back by puny morals. I hope this will provide you with some useful information regarding the utilization of your servants. Now, if you’ll excuse me...\n\nWith that, your companion is taken away and you are promoted.[color=green] You are now an Adept in the Mage's Order.\n\nReceived 750 gold. [/color]\n[color=yellow]You have gained an extra level.[/color]")
		globals.state.rank = 3
		globals.resources.gold += 750
		main.currentslave = globals.slaves.find(slave)
		globals.player.levelup()
		globals.resources.upgradepoints += 5
		main.getridof()
	questgiveawayslave = null
	main.dialogue(true, self, text, buttons, sprites)


func mageorderquest2():
	var text = ''
	var buttons = null
	var sprites = null
	if globals.state.mainquest == 2:
		sprites = [['melissafriendly','pos1']]
		globals.state.mainquest = 3
		globals.resources.gold += 250
		text = "— Marvelous! So here's the first thing we have on our hands. You likely know of the Brands and their utility. But those are the result of crude and very old work; surely anyone would want something much more efficient. For that, we have invented an upgrade to the old brands. They are generally referred to as 'Refined Brands' and are not very well known by the masses. The idea is pretty simple; to make the brand and branded person follow complex rules instead of just submissive basics. I can't overstate how amazingly useful it is, but those old fools at the council don't seem to bother.\n\n— The main issue is the magic essence, which is pretty hard to gather in large amounts as it is produced by fairies. Yeah, those shortstacks with childish behavior. Getting your hands on one seems to be getting harder and harder by the day. I want you to find me one, and in exchange I'll promote you, and share with you the knowledge of how to place a Refined Brand on a slave.\n\n— You will likely find fairies in the Far Eerie Woods or elven grove. It's a devilish looking place beyond the elven parts of the forest. That place is likely affected by a taint or some magical phenomenon that nobody can quite figure out. All of the creatures there seem to lose  their sentience and become hostile to outsiders. Fairies are not generally like that, so I figured you may be able to tame one if you get her out of there. If not, she'd still be useful to us. Now, if you’ll excuse me, I still have some affairs to attend to today. Be careful, honey.\n\n[color=green]Your main quest has been updated. [/color]"
	main.dialogue(true, self, text, buttons, sprites)



func _on_close_pressed():
	get_node("mageorderservices").set_hidden(true)


func mageservices():
	get_node("mageorderservices").set_hidden(false)
	var spelllist = get_node("mageorderservices/ScrollContainer/spelllist")
	var spellbutton = get_node("mageorderservices/ScrollContainer/spelllist/spellbutton")
	for i in spelllist.get_children():
		if i != spellbutton:
			i.set_hidden(true)
			i.queue_free()
	for i in globals.spelldict.values():
		if globals.state.rank >= i.req:
			var newbutton = spellbutton.duplicate()
			spelllist.add_child(newbutton)
			newbutton.set_text(i.name)
			newbutton.set_name(i.code)
			newbutton.set_hidden(false)
			newbutton.connect('pressed',self,'spellbuttonpressed', [i])
			if i.learned == true:
				newbutton.set_disabled(true)
				newbutton.set_text(newbutton.get_text() + ' — learned')
	get_node("mageorderservices/learnspellbutton").set_disabled(true)

var spellselected

func spellbuttonpressed(spell):
	spellselected = spell
	for i in get_node("mageorderservices/ScrollContainer/spelllist").get_children():
		if i.is_pressed == true && i.get_name() != spell.code:
			i.set_pressed(false)
	get_node("mageorderservices/spelldescription").set_bbcode(spell.description + '\n\nPrice: ' + str(spell.price))
	if spell.price > globals.resources.gold:
		get_node("mageorderservices/learnspellbutton").set_disabled(true)
	else:
		get_node("mageorderservices/learnspellbutton").set_disabled(false)

func _on_learnspellbutton_pressed():
	var spell = spellselected
	if spell == null:
		return
	globals.resources.gold -= spell.price
	main.popup('You have learned new spell: ' + spell.name)
	spell.learned = true
	if globals.abilities.abilitydict.has(spell.code) == true:
		globals.player.ability.append(spell.code)
	mageservices()


func _on_upgradelibrary_pressed():
	if globals.state.library == 0:
		globals.state.library = 1
		globals.resources.gold -= 500
	elif globals.state.library == 1:
		globals.state.library = 2
		globals.resources.gold -= 1000
	elif globals.state.library == 2:
		globals.state.library = 3
		globals.resources.gold -= 1500
	main.popup('You have purchased fresh set of books for your library. ')
	_on_mageorderservices_visibility_changed()


func _on_upgradealchemy_pressed():
	if globals.state.alchemy == 0:
		var array = ['aphrodisiac','hairgrowthpot','amnesiapot','lactationpot','miscariagepot','stimulantpot','deterrentpot']
		for i in array:
			globals.itemdict[i].unlocked = true
		globals.state.alchemy = 1
		globals.resources.gold -= 500
		main.popup('You have purchased basic set of alchemy tools. ')
	elif globals.state.alchemy == 1:
		var array = ['oblivionpot','oblivionpot','minoruspot','majoruspot','aphroditebrew']
		for i in array:
			globals.itemdict[i].unlocked = true
		globals.state.alchemy = 2
		globals.resources.gold -= 1000
		main.popup('You have purchased advanced set of alchemy tools and unlocked new potion recipes. ')
	_on_mageorderservices_visibility_changed()

func _on_upgradelaboratory_pressed():
	if globals.state.laboratory == 0:
		globals.state.laboratory = 1
		globals.resources.gold -= 1000
		main.popup('You have purchased basic equipment for your laboratory. ')
	elif globals.state.laboratory == 1:
		globals.state.laboratory = 2
		globals.resources.gold -= 3000
		main.popup('You have purchased advanced equipment for your laboratory. ')
	_on_mageorderservices_visibility_changed()

func tishaquest():
	if globals.state.sidequests.emily == 12:
		globals.events.tishadorms()
	elif globals.state.sidequests.emily == 13:
		globals.events.tishabackstreets()
	elif globals.state.sidequests.emily in [14,15]:
		globals.events.tishagornguild()

#################### Markets

var shops = {
wimbornmarket = {code = 'wimbornmarket', sprite = 'merchant', name = "Wimborn's Market", items =  ['teleportwimborn','food','supply','bandage','rope','teleportseal', 'basicsolutioning','hairdye', 'aphrodisiac' ,'beautypot', 'magicessenceing', 'natureessenceing','armorleather','armorchain','weapondagger','weaponsword','clothsundress','clothmaid','clothbutler','underwearlacy','underwearboxers', 'acctravelbag'], selling = true},
shaliqshop = {code = 'shaliqshop', name = "Village's Trader", items = ['teleportseal','lockpick','hairdye','beautypot','armorleather','clothmiko','clothkimono','armorninja', 'acctravelbag'], selling = true},
gornmarket = {code = 'gornmarket', name = "Gorn's Market", items = ['teleportgorn','food', 'supply','bandage','rope','teleportseal','magicessenceing',"armorleather",'armorchain','weaponclaymore','clothbedlah','accslavecollar','acchandcuffs'], selling = true},
frostfordmarket = {code = 'frostfordmarket', name = "Frostford's Market", items = ['teleportfrostford', 'supply','bandage','rope','teleportseal', 'basicsolutioning','bestialessenceing','clothpet', 'weaponsword','accgoldring', 'acctravelbag'], selling = true},
aydashop = {code = 'aydashop', name = "Ayda's Assortments", items = ['regressionpot', 'beautypot', 'hairdye', 'basicsolutioning','bestialessenceing','taintedessenceing','fluidsubstanceing'], selling = false},
amberguardmarket = {code = 'amberguardmarket', name = "Amberguard's Market", items = ['teleportamberguard','beautypot','bestialessenceing','magicessenceing','fluidsubstanceing','armorelvenchain','armorrobe'], selling = true},
sebastian = {code = 'sebastian', name = "Sebastian", items = ['teleportumbra'], selling = false},
blackmarket = {code = 'blackmarket', name = 'Black Market', items = ['lockpick','accslavecollar','acchandcuffs','armorleather','armorchain','weaponsword'], selling = true}
}

func market():
	var array = [{name = 'Market stalls', function = 'shopinitiate', args = 'wimbornmarket'}, {name = 'Return', function = 'town'}]
	get_node("charactersprite").set_hidden(true)
	main.background_set('market')
	if OS.get_name() != "HTML5" && globals.rules.fadinganimation == true:
		yield(main, 'animfinished')
	var text = "Densely populated area filled with stalls, small buildings and people allowing you to find anything for your daily life. "
	if globals.state.rank >= 3 && globals.state.sidequests.cali == 0:
		text +=  "\n\n[color=yellow]You spot some commotion ongoing near one of the stalls.[/color]"
		array.insert(1, {name = 'Check the commotion', function = "caliqueststart"})
	for slave in globals.slaves:
		if slave.work == 'store':
			text += slave.dictionary('\nYou can see $name helping around one of the shops.')
		elif slave.work == 'entertainer':
			text += slave.dictionary('\nYou spot $name giving minor performance at one of the corners. ')
	mansion.maintext = text
	if globals.state.mainquest == 5:
		array.insert(1, {name = 'Look for Sebastian', function = 'sebastian'})
	elif globals.state.mainquest >= 7:
		array.insert(1, {name = 'Visit Sebastian', function = 'sebastian'})
	buildbuttons(array)



var currentshop
var selecteditem
var mode

func shopinitiate(shopname):
	currentshop = shops[shopname]
	selecteditem = null
	get_node("shoppanel/Panel/title").set_text(currentshop.name)
	get_node("shoppanel").set_hidden(false)
	get_node("shoppanel/itempanel").set_hidden(true)
	get_node("shoppanel/Panel/buybutton").set_pressed(false)
	get_node("shoppanel/Panel/sellbutton").set_pressed(false)
	if currentshop.has('sprite'):
		setcharacter(currentshop.sprite)
		get_node("AnimationPlayer").play("show")
	if currentshop.selling == true:
		get_node("shoppanel/Panel/sellbutton").set_hidden(false)
	else:
		get_node("shoppanel/Panel/sellbutton").set_hidden(true)


func shopbuy():
	var item
	var newbutton
	var itemlist = get_node("shoppanel/itempanel/ScrollContainer/GridContainer")
	var itembutton = itemlist.get_node("Button")
	get_node("shoppanel/itempanel").set_hidden(false)
	get_node("shoppanel/Panel/buybutton").set_pressed(true)
	get_node("shoppanel/Panel/sellbutton").set_pressed(false)
	get_node("shoppanel/Panel/sellbuttonbp").set_pressed(false)
	get_node("shoppanel/itempanel/buysellbutton/SpinBox").set_val(1)
	mode = 'buy'
	for i in itemlist.get_children():
		if i != itembutton:
			i.set_hidden(true)
			i.queue_free()
	
	get_node("shoppanel/itempanel/buysellbutton").set_text('Buy')
	get_node("shoppanel/itempanel/buysellbutton").set_hidden(true)
	get_node("shoppanel/itempanel/buysellbackpack").set_hidden(true)
	get_node("shoppanel/itempanel/itemdescript").set_bbcode('')
	get_node("shoppanel/itempanel/iconbig").set_hidden(true)
	
	for i in currentshop.items:
		item = globals.itemdict[i]
		if item.code.find('teleport') >= 0 && item.code != 'teleportseal':
			var temp = item.code.replace('teleport', '')
			if temp == globals.state.location || globals.state.portals[temp].enabled == true:
				continue
		newbutton = itembutton.duplicate()
		newbutton.set_hidden(false)
		newbutton.get_node("price").set_text(str(item.cost))
		newbutton.get_node("amount").set_hidden(true)
		newbutton.set_tooltip(item.name)
		if typeof(item.icon) == TYPE_STRING:
			newbutton.get_node("icon").set_texture(load(item.icon))
		else:
			newbutton.get_node("icon").set_texture(item.icon)
		itemlist.add_child(newbutton)
		newbutton.set_meta('item', item)
		newbutton.connect('pressed',self,'selectshopitem', [newbutton])

func shopsell(backpack = false):
	var item
	var newbutton
	var itemlist = get_node("shoppanel/itempanel/ScrollContainer/GridContainer")
	var itembutton = itemlist.get_node("Button")
	var array = []
	get_node("shoppanel/itempanel").set_hidden(false)
	get_node("shoppanel/Panel/buybutton").set_pressed(false)
	get_node("shoppanel/Panel/sellbutton").set_pressed(!backpack)
	get_node("shoppanel/Panel/sellbuttonbp").set_pressed(backpack)
	get_node("shoppanel/itempanel/itemdescript").set_bbcode('')
	get_node("shoppanel/itempanel/buysellbutton/SpinBox").set_val(1)
	if backpack == true:
		mode = 'sellbackpack'
	else:
		mode = 'sell'
	for i in itemlist.get_children():
		if i != itembutton:
			i.set_hidden(true)
			i.queue_free()
	
	get_node("shoppanel/itempanel/buysellbutton").set_text('Sell')
	get_node("shoppanel/itempanel/buysellbutton").set_hidden(true)
	get_node("shoppanel/itempanel/buysellbackpack").set_hidden(true)
	get_node("shoppanel/itempanel/iconbig").set_hidden(true)
	if backpack == false:
		for item in globals.itemdict:
			array.append(item)
	else:
		for item in globals.state.backpack.stackables:
			array.append(globals.itemdict[item].code)
	
	array.sort_custom(globals.items,'sortbytype')
	
	
	for tempitem in array:
		var item = globals.itemdict[tempitem]
		if item.amount < 1 || item.type in ['gear','dummy']:
			continue
		newbutton = itembutton.duplicate()
		newbutton.set_hidden(false)
		newbutton.set_tooltip(item.name)
		newbutton.get_node("price").set_text(str(round(item.cost/5)))
		newbutton.get_node("amount").set_hidden(false)
		if backpack == true:
			newbutton.get_node("amount").set_text(str(globals.state.backpack.stackables[item.code]))
		else:
			newbutton.get_node("amount").set_text(str(item.amount))
		if item.icon != null:
			newbutton.get_node("icon").set_texture(item.icon)
		else:
			newbutton.get_node("icon").set_texture(globals.noimage)
		itemlist.add_child(newbutton)
		newbutton.set_meta('item', item)
		newbutton.connect('pressed',self,'selectshopitem', [newbutton])
	
	array = globals.state.unstackables.values()
	
	var unstackarray = []
	
	for item in array:
		if backpack == true:
			if str(item.owner) != 'backpack':
				continue
		else:
			if item.owner != null:
				continue
		var groupfound = false
		var counter = -1
		for i in unstackarray:
			counter += 1
			if i[0].type == item.type && i[0].effects == item.effects:
				groupfound = true
				unstackarray[counter].append(item)
				continue
		if groupfound == false:
			unstackarray.append([item])
	
	for item in array:
		if (item.owner == null && backpack == false) || (str(item.owner) == 'backpack' && backpack == true):
			var tempitem = globals.itemdict[item.code]
			newbutton = itembutton.duplicate()
			newbutton.set_hidden(false)
			newbutton.set_tooltip(item.name)
			newbutton.get_node("price").set_text(str(round(tempitem.cost/5)))
			if item.icon != null:
				newbutton.get_node("icon").set_texture(load(item.icon))
			else:
				newbutton.get_node("icon").set_texture(null)
				newbutton.get_node("name").set_text(item.name)
				newbutton.get_node("name").set_hidden(false)
			itemlist.add_child(newbutton)
			newbutton.set_meta('item', tempitem)
			newbutton.set_meta('unstuck', item)
			newbutton.connect('pressed',self,'selectshopitem', [newbutton, item])


func _on_sellbuttonbp_pressed():
	shopsell(true)


func selectshopitem(tempitem, unstuck = null):
	var text = ''
	var item = tempitem.get_meta("item")
	for i in get_node("shoppanel/itempanel/ScrollContainer/GridContainer").get_children():
		if i.is_pressed() == true && i != tempitem:
			i.set_pressed(false)
	tempitem.set_pressed(true)
	get_node("shoppanel/itempanel/iconbig").set_hidden(true)
	selecteditem = tempitem
	if item.type != 'dummy' && item.type != 'gear':
		text += "\nIn Possession: " + str(item.amount)
	text += globals.itemdescription(item) + "\n\n"
	if mode == 'buy':
		text +=  "Price: [color=yellow]" + str(item.cost) + "[/color]"
		get_node("shoppanel/itempanel/buysellbackpack").set_hidden(item.type == 'dummy')
	else:
		text +=  "Selling Price: [color=yellow]" + str(round(item.cost/5)) + "[/color]"
	if item.code.find('teleport') >= 0 && item.code != 'teleportseal':
		get_node("shoppanel/itempanel/buysellbutton/SpinBox").set_hidden(true)
		get_node("shoppanel/itempanel/buysellbutton/SpinBox").set_val(1)
	else:
		get_node("shoppanel/itempanel/buysellbutton/SpinBox").set_hidden(false)
	#if item.type == 'gear':
	if item.icon != null:
		get_node("shoppanel/itempanel/iconbig").set_hidden(false)
		if typeof(item.icon) == TYPE_STRING:
			get_node("shoppanel/itempanel/iconbig").set_texture(load(globals.itemdict[item.code].icon))
		else:
			get_node("shoppanel/itempanel/iconbig").set_texture(item.icon)
	else:
		get_node("shoppanel/itempanel/iconbig").set_hidden(true)
	if item.code in ["supply",'teleportwimborn','teleportgorn','teleportfrostford','teleportamberguard','teleportumbra']:
		get_node("shoppanel/itempanel/iconbig").set_hidden(false)
		get_node("shoppanel/itempanel/iconbig").set_texture(item.icon)
	get_node("shoppanel/itempanel/itemdescript").set_bbcode(text)
	get_node("shoppanel/itempanel/buysellbutton").set_hidden(false)
	if mode == 'buy' && item.cost > globals.resources.gold:
		get_node("shoppanel/itempanel/buysellbutton").set_disabled(true)
		get_node("shoppanel/itempanel/buysellbackpack").set_disabled(true)
	else:
		get_node("shoppanel/itempanel/buysellbutton").set_disabled(false)
		get_node("shoppanel/itempanel/buysellbackpack").set_disabled(false)
	if mode == 'sell' && unstuck == null && item.amount <= 0:
		shopsell()



func _on_buysellbutton_pressed(backpack = false):
	var item = selecteditem.get_meta("item")
	var amount = get_node("shoppanel/itempanel/buysellbutton/SpinBox").get_val()
	if mode == 'buy':
		if amount*item.cost > globals.resources.gold:
			get_parent().infotext("Not enough gold",'red')
			return
		if backpack == true && item.has('weight') && globals.state.calculateweight().currentweight + amount*item.weight > globals.state.calculateweight().maxweight:
			get_parent().infotext("Not enough carry capacity",'red')
			return
		if item.type != 'gear':
			if backpack == false:
				item.amount += amount
			else:
				if globals.state.backpack.stackables.has(item.code):
					globals.state.backpack.stackables[item.code] += amount
				else:
					globals.state.backpack.stackables[item.code] = amount
		elif item.type == 'gear':
			var counter = amount
			while counter >= 1:
				var tmpitem = globals.items.createunstackable(item.code)
				if backpack == false:
					globals.state.unstackables[str(tmpitem.id)] = tmpitem
				else:
					globals.state.unstackables[str(tmpitem.id)] = tmpitem
					tmpitem.owner = 'backpack'
				counter -= 1
				get_parent().infotext("Obtained: " + item.name, 'green')
		if item.code in ['food']:
			globals.items.call(item.effect)
		elif item.code.find('teleport') >= 0 && item.code != 'teleportseal':
			globals.items.call(item.effect, item)
			selecteditem = null
			shopbuy()
			return
		else:
			globals.resources.gold -= item.cost*amount
		selectshopitem(selecteditem)
	elif mode in ['sell','sellbackpack']:
		if item.type != 'gear' && ((mode == 'sell' && amount > item.amount) || mode == 'sellbackpack' && globals.state.backpack.stackables[item.code] < amount ):
			get_parent().infotext("Not enough items in possession",'red')
			return
		if item.type != 'gear':
			if mode == 'sell':
				item.amount -= amount
			else:
				globals.state.backpack.stackables[item.code] -= amount
				if globals.state.backpack.stackables[item.code] <= 0:
					globals.state.backpack.stackables.erase(item.code)
			globals.resources.gold += round(item.cost/5)*amount
			selecteditem.get_node('amount').set_text(str(item.amount))
		else:
			var tempitem = selecteditem.get_meta("unstuck")
			globals.resources.gold += round(item.cost/5)
			globals.state.unstackables.erase(tempitem.id)
		if mode == 'sell':
			selectshopitem(selecteditem)
		else:
			_on_sellbuttonbp_pressed()



func _on_buysellbackpack_pressed():
	_on_buysellbutton_pressed(true)
	


func shopclose():
	get_node("shoppanel").set_hidden(true)
	if currentshop.has('sprite'):
		get_node("AnimationPlayer").play_backwards("show")
		#get_node("charactersprite").set_hidden(true)

####QUESTS
var cali

func caliqueststart(value = ''):
	var buttons = []
	var text = ''
	var sprites
	if typeof(value) != 4:
		globals.state.sidequests.cali = value
	if globals.state.sidequests.cali == 0:
		text = "As you walk by rows of traders you hear some noise and bunch of people gathering around.\n\n[color=yellow]— Let me go, you brute, I didn't do anything! — you hear girl's voice. [/color]\n\nAs you get closer, you notice a small dirty-looking halfkin wolf girl trying to break free from big man holding her.\n\n[color=aqua]— She's a thief! Everyone saw this! Why do they even let your kind roam around? You are no different from wild animals trying to hunt human flocks! [/color]\n\n[color=yellow]— Damn you, fat bastard! [/color]\n\nWith that girl tries to bite on hand holding her, but fails as her holder reacts to that and makes her struggling useless.\n\n[color=aqua]— Call the guards already! I still have stall to look after![/color]"
		buttons.append(["Intervene as a guild member",'caliqueststart', 1])
		buttons.append(["Ignore it",'caliqueststart', 10])
	elif globals.state.sidequests.cali == 1:
		text = ("You approach shop owner and tell him, that it is improper to stereotype on other races and it is guild's free will to welcome every other humanoid race. As he sees your badge, he quickly restrains himself and begs for pardon.\n\n[color=aqua]— She's a thief, Milord! She stolen big chunk of pork from me. Witnesses will confirm it. [/color]\n\nAs you look at the girl, she glares back but don't deny accusation. You notice that she looks pretty scrawny and is probably one of the homeless around town. By the law theft is a considerable offence and will result in flagellation.")
		globals.charactergallery.cali.unlocked = true
		if globals.resources.gold >= 50:
			buttons.append(["Offer compensation for her", 'caliqueststart', 2])
		buttons.append(["Offer to take her away for personal punishment", 'caliqueststart', 3])
		buttons.append(["Step away and leave it to guards", 'caliqueststart', 100])
		cali = globals.characters.create('Cali')
	elif globals.state.sidequests.cali == 2:
		globals.resources.gold -= 50
		text = ("— That is... very noble of you " + globals.fastif(globals.player.sex == 'male', 'Mylord', 'Milady')+ ", but I believe thief should be punished.\n\nOn that you tell him to let you handle the girl and after a moment butcher agrees to drop his charge. You lead the girl away and after some time end up in desolated place.")
		buttons.append(["Talk to her", 'caliqueststart', 4])
		buttons.append(["Let her go", 'caliqueststart',5])
		cali.loyal += 10
	elif globals.state.sidequests.cali == 3:
		text = ("You give scary look and offer to take care of the thief. After a thought, butcher decides that being handled by one of the magi would be more than sufficient punishment and hands girl away. She barely tries to resist realising there's not much room for escape and you lead her away from public.\n\nAfter a while you end up in remotely desolated street.")
		buttons.append(["Go with your words and take girl to jail", 'caliqueststart', 5])
		buttons.append(["Talk to her", 'caliqueststart', 4])
	elif globals.state.sidequests.cali == 4:
		text = ("You share some food and ask her about her life.\n\n— Thanks for help... My name is Cali. I was captured from my village few weeks ago by bandits. They was about to sell me here but I managed to escape before they brought me to the guild. I have to get back home to my mother and father... I hope they are alright.\n\nAfter few moments she says goodbye and prepares to leave.")
		buttons.append(["Offer to take her into your mansion", 'caliqueststart', 6])
		buttons.append(["Offer to help her get home", 'caliqueststart', 7])
		buttons.append(["Leave her on her own", 'caliqueststart', 100])
	elif globals.state.sidequests.cali == 5:
		text = ("You take young girl with you and return to the mansion.")
		buttons.append(["Continue", 'caliqueststart', 100])
		cali.sleep = 'jail'
		globals.slaves = cali
		cali = null
	elif globals.state.sidequests.cali == 6:
		if cali.loyal > 5:
			text = ("You offer Cali to take her into your mansion saying that even if she can't get home it's still better than living on the streets. After some thought she decides to accept your offer.\n\n— I can trust you I guess? You bribed me from trouble after all... Alright, please take care of me.\n\n[color=green]Cali is now your servant. [/color]")
			globals.slaves = cali
			cali = null
			buttons.append(["Continue", 'caliqueststart', 11])
			globals.state.upcomingevents.append({code = 'calievent1', duration = 7})
			globals.state.sidequests.caliparentsdead = false
			globals.state.upcomingevents.append({code = 'caliparentsdie', duration = 28})
		else:
			text = ("You offer Cali to take her into your mansion saying that even if she can't get home it's still better than living on the streets. After some thought she decides to accept your offer.\n\n— Thanks for help, but I don't wanna stay here.\n\nWith that she shortly thanks you again and retreats.")
			buttons.append(["Continue", 'caliqueststart', 100])
			cali = null
	elif globals.state.sidequests.cali == 7:
		text = ("You offer Cali your help and roof over head in exchange for her service while you finding out a way to get her home.\n\n— You would do that for me?!\n\nHer eyes shimmer with hope giving away her innocent nature.\n\n— I will... make sure to repay you in that case. My family is not rich, but I'm sure they would find a way.\n\n[color=green]Cali is now your servant.[/color]")
		cali.loyal += 5
		cali.obed += 25
		globals.slaves = cali
		globals.state.sidequests.caliparentsdead = false
		globals.state.upcomingevents.append({code = 'caliparentsdie', duration = 28})
		cali = null
		buttons.append(["Continue", 'caliqueststart', 12])
	elif globals.state.sidequests.cali >= 10:
		market()
		cali = null
		main.get_node('dialogue').set_hidden(true)
		return
	if globals.state.sidequests.cali == 0:
		sprites = [['caliangry', 'pos1','opac']]
	elif globals.state.sidequests.cali == 1:
		sprites = [['caliangry', 'pos1']]
	elif globals.state.sidequests.cali == 7:
		sprites = [['calihappy', 'pos1']]
	elif globals.state.sidequests.cali == 5:
		sprites = [['calinangry1', 'pos1']]
	else:
		sprites = [['calineutral', 'pos1']]
	main.dialogue(false, self, text, buttons, sprites)

func sebastian():
	var text = ''
	if get_node("charactersprite").get_texture() != get_parent().spritedict['sebastian'] || get_node("charactersprite").is_hidden() == true :
		get_node("AnimationPlayer").play("show")
		get_node("charactersprite").set_hidden(false)
		setcharacter('sebastian')
	var array = [{name = 'Return',function = 'market'}]
	if globals.state.mainquest == 5:
		globals.state.mainquest = 6
		mansion.maintext = "After spending some time asking around, you finally find a shady looking warehouse, poorly decorated as some obscure workshop. Inside of it you meet a rather flamboyant man dressed head to toe in several layers of brightly colored clothing. He takes notice of your presence and comes to greet you, giving a flashy bow as he approaches. He speaks with a rather obvious accent, though you can’t quite place it.\n\n— Welcome, friend! Do I know you? We are not quite open to public you see...\n\nYou let him know that you are from Melissa and a part of the Mage's Order, at which he shines.\n\n— Oh, I see, Mister "+globals.player.name+"; a new face in our dependable government! I'm very pleased to meet you. Yes... about Melissa, I wanted to warn her but... It has been very rowdy these last few days... Yes, her elixir...\n\n— Well, sadly, I don't have it. Yes, I know I promised to get it last week, but our alchemist is lost... Not literally. He was experimenting with some new stuff he got his hands on and now he seems to have lost his senses; even spending too much time at the bar too...\n\n— Look, you are no stranger to working with magic, are you? Alchemy shouldn't be too much work either. Since you are in the Order, you must have a sizeable property. Why don't you get an alchemy kit and get milady what she wants? I'll share some formulas with you and you cover this up for me. I can see that you are a capable person.\n\nAfter some consideration, you agree with the offer, deciding that it will be a useful experience for your future researches.\n\n— Milady wants Youthing Elixir. No, I don't know why, and neither should you want to know. The thing allows you to reverse your aging a bit, which makes it very desirable with the ladies. You will need few rare ingredients to cook it, and I'll provide you those.[color=yellow] You should keep in mind though, nearly any magical potion will apply some toxicity to the subject's body, which may produce some nasty effects. I’m telling you this just in case you try to experiment. Try to keep the doses small, as toxicity will dissipate after some time. [/color]\n\n[color=green]Youthing Elixir recipe unlocked.\nMaturing Elixir recipe unlocked.[/color]"
		globals.itemdict.minoruspot.amount += 1
		globals.itemdict.magicessenceing.amount += 2
		globals.itemdict.youthingpot.unlocked = true
		globals.itemdict.maturingpot.unlocked = true
	elif globals.state.mainquest >= 7 && globals.state.farm == 0:
		globals.state.farm = 1
		mansion.maintext = "— Hey, "+globals.player.name+"! You took care of that little errand? Great, great! So what are you up to? Me? I'm working with not-so-easy-to-get merchandise. Since you're working with Melissa, I suppose you'd be interested as well! Yes, rare black market ingredients, mythical creatures, and forbidden magical devices; I tend to deal with many of those! Of course the service won't be cheap, as the rarity and legality is the main issue.\n\n— I can offer you one rare slave every couple of days, but I'll warn you: I only deal with rare species. Their obedience and branding is entirely up to you, so don't come back complaining if they bite you in your sleep!\n\nHe gives a mirthful chuckle.\n\n— Otherwise, a plesure doing business with you. I'll let you know when I get something in that might interest you. Speaking of which, I have one proposal which may interest you, as I heard you own a nice isolated place, and tend to keep slaves around to help you."
	elif globals.state.mainquest >= 7:
		if globals.state.sebastianorder.taken == false:
			mansion.maintext = "— Glad to see you well, "+globals.player.name+"! How are you doing? Got a special order?"
		elif globals.state.sebastianorder.taken == true && globals.state.sebastianorder.duration != 0:
			mansion.maintext = "— Glad to see you well, "+globals.player.name+"! Your special order is not here yet, but worry not! Everything goes as planned. "
		else:
			mansion.maintext = "— Oh, Come in, " + globals.player.name + "! Your special order has been waiting for you. "
		if globals.resources.gold >= 100 && globals.state.sebastianorder.taken == false:
			array.insert(0, {name = 'Make a special request',function = 'sebastianorder'})
		elif globals.state.sebastianorder.taken == true && globals.state.sebastianorder.duration == 0:
			array.insert(0, {name = 'See special order', function = 'sebastianorder'})
		elif globals.state.sebastianorder.taken == false:
			mansion.maintext = mansion.maintext +"[color=#ff4949]\nYou don't have enough gold to make request (100 needed)[/color]"
	if globals.state.farm == 1:
		array.insert(0, {name = 'Consult on proposal', function = 'sebastianfarm'})
	elif globals.state.farm == 2:
		array.insert(0, {name = 'Consult on farm purchase', function = 'sebastianfarm'})
	if globals.state.sidequests.cali == 15 && globals.state.sidequests.calibarsex != 'sebastian':
		array.insert(0, {name = 'Ask Sebastian about mercenary', function = 'sebastianquest', args = 0})
	if globals.state.mainquest >= 7:
		if globals.state.sidequests.has('sebastianumbra'):
			if globals.state.sidequests.sebastianumbra == 0:
				array.insert(0, {name = 'Ask Sebastian about his sources', function = 'sebastianquest', args = 1})
			if globals.state.sidequests.sebastianumbra == 1:
				array.insert(0, {name = "Purchase", function = 'sebastianquest', args = 2})
			if globals.state.sidequests.sebastianumbra >= 1:
				array.insert(0, {name = 'Sell slaves', function = 'sebastianquest', args = 3})
	buildbuttons(array)

func sebastianquest(stage = 0):
	if stage == 0:
		globals.state.sidequests.calibarsex = 'sebastian'
		sebastian()
		mansion.maintext = questtext.CaliBarAskSebastian
	elif stage == 1:
		globals.state.sidequests.sebastianumbra = 1
		sebastian()
		mansion.maintext = globals.player.dictionary(questtext.sebastianumbra)
	elif stage == 2:
		shopinitiate('sebastian')
		sebastian()
	elif stage == 3:
		sellslavelist('sebastian')
		sellslavelocation = 'sebastian'
	elif stage == 4:
		globals.state.sidequests.sebastianumbra = 2
		sebastian()
		mansion.maintext = globals.player.dictionary(questtext.sebastianumbra2)
	#sebastian()

func sebastianorder():
	if globals.state.sebastianorder.taken == false:
		mansion.maintext = "— If you need someone of a specific race, I'll make sure to get one next time you come.  That will cost you 100 gold though. Money up front!"
		clearbuttons()
		get_node("sebastiannode").set_hidden(false)
		if globals.rules.furry == false:
			var counter = get_node("sebastiannode/sebastionorder").get_item_count()
			var counter2 = 0
			while counter > counter2:
				if get_node("sebastiannode/sebastionorder").get_item_text(counter).find('Beastkin') >= 0:
					get_node("sebastiannode/sebastionorder").remove_item(counter)
				counter -= 1
	else:
		var slave = globals.state.sebastianslave
		var array = [{name = "Pay", function = "sebastianpay"}, {name = "Refuse", function = "sebastianrefuse"}]
		mansion.maintext = "After few moments, Sebastian presents to you a chained " + slave.race + slave.dictionary(" $child, who still looks pretty rebellious.\n\n— Got you what you asked for!\n\nYou slowly inspect $him.") + slave.descriptionsmall() + "\n\n— I would like to receive " + str(slave.buyprice()) + slave.dictionary(" gold for my service. If you don't want $him, it's fine, since I can find another buyer in huge town like this.")
		buildbuttons(array)

func sebastianpay():
	var slave = globals.state.sebastianslave
	if globals.resources.gold >= slave.buyprice():
		var effect = globals.effectdict.captured
		var dict = {'slave':0.7, 'poor':1,'commoner':1.2,"rich": 2, "noble": 4}
		effect.duration = round((4 + (slave.conf+slave.cour)/20) * dict[slave.origins])
		slave.add_effect(effect)
		slave.sleep = 'jail'
		globals.slaves = slave
		globals.resources.gold -= slave.buyprice()
		globals.state.sebastianorder.taken = false
		main.popup("You purchase your new toy and leave Sebastian. ")
		market()
	else:
		main.popup("You don't have enough money.")

func sebastianrefuse():
	globals.state.sebastianorder.taken = false
	market()

func _on_sebastianconfirm_pressed():
	var race = get_node("sebastiannode/sebastionorder").get_item_text(get_node("sebastiannode/sebastionorder").get_selected())
	globals.state.sebastianorder.race = race
	globals.state.sebastianorder.taken = true
	globals.state.sebastianorder.duration = round(rand_range(3,5))
	globals.resources.gold -= 100
	var caste = ['slave','poor','commoner','rich','noble']
	globals.state.sebastianslave = globals.newslave(globals.state.sebastianorder.race, 'random', 'random', caste[rand_range(0,caste.size())])
	mansion.maintext = "— "+race+", huh? Got ya! Come see me in "+ str(globals.state.sebastianorder.duration)+ " days and don't forget the coins! Those are not cheap after all. "
	get_node("sebastiannode").set_hidden(true)
	var array = [{name = 'Leave', function = 'market'}]
	buildbuttons(array)
	

func _on_sebastiancancel_pressed():
	get_node("sebastiannode").set_hidden(true)
	sebastian()

func sebastianfarm():
	var array = [{name = 'Return', function = 'market'}]
	if globals.state.farm == 1:
		mansion.maintext = "— Do you know about farms? No, not the rural kind. You can use girls to make milk. Truthfully speaking, I have some of the necessary gear on my hands. So, if you ever consider starting your own small business, I'll gladly sell it to you.\n\n— You would need some space for that first though. I actually can help you with all that, for 1000 gold I'll get you builders and all basic equipment you will need to set your farm up. Let me know if you are interested. "
		globals.state.farm = 2
	elif globals.state.farm == 2:
		mansion.maintext = "— You are done with your preparations? Great, great! Now I'll pass you the rest of necessary equipment for 1000 gold."
		if globals.resources.gold >= 1000:
			array.insert(0,{name = 'Purchase farm equipment', function = 'sebastianfarmpurchase'})
	buildbuttons(array)

func sebastianfarmpurchase():
	globals.state.farm = 3
	globals.resources.gold -= 1000
	mansion.maintext = "— Pleased to have business with you!\n\n[color=yellow]Your mansion has now been fitted with an underground farm.[/color]\n\n— Oh, and by the way, that is not the only method to utilize your servants. Have you heard about giant snails? Their eggs are quite a delicacy, but they are really picky about where they lay them. I’ve heard that you can make them lay some in a human's orifices. — he slyly winks you — It looks like a human’s body temperature makes them attractive nests."
	var array = [{name = 'Return', function = 'sebastian'}]
	buildbuttons(array)

################ backstreets
func backstreets():
	var text = "This part of town is populated by criminals and the poor. Brothel is located here. "
	main.background_set('wimborn')
	var array = [{name = 'Enter Brothel',function = 'brothel'}, {name = 'Return', function = 'town'}]
	if globals.state.sidequests.cali in [14,15,16]:
		array.insert(1,{name = "Visit local bar", function = "calibarquest"})
	if globals.state.sidequests.emily <= 1:
		text += '\n\nYou see an urchin girl trying to draw your attention'
		array.insert(1,{name = 'Respond to the urchin girl', function = 'emily'})
	if globals.state.sidequests.emily == 13:
		array.insert(1,{name = 'Search Backstreets', function = 'tishaquest'})
	mansion.maintext = text
	buildbuttons(array)

func emily(state = 1):
	var buttons = []
	var text = ''
	var sprites = null
	globals.state.sidequests.emily = state
	if state == 1:
		globals.charactergallery.emily.unlocked = true
		text = questtext.EmilyMeet
		if globals.resources.food < 10:
			buttons.append({text = 'Give her food', function = 'emily', args = 2, disabled = true, tooltip = "not enough food"})
		else:
			buttons.append(['Give her food', 'emily', 2])
		buttons.append(['Shoo her away', 'emily', 5])
		buttons.append(["Make an excuse and tell her you'll bring some later", 'emily', 0])
		sprites = [['emilynormal','pos1','opac']]
		main.dialogue(false, self, text, buttons, sprites)
	elif state == 2:
		text = questtext.EmilyFeed
		globals.resources.food -= 10
		buttons.append(['Offer to take her as a servant', 'emily', 3])
		buttons.append(["Leave her alone", 'emily', 5])
		sprites = [['emilynormal','pos1']]
		main.dialogue(false, self, text, buttons, sprites)
	elif state == 3:
		text = questtext.EmilyTake
		sprites = [['emilyhappy','pos1']]
		main.dialogue(true, self, text, buttons, sprites)
		var emily = globals.characters.create('Emily')
		globals.state.upcomingevents.append({code = 'tishaappearance',duration =7})
		globals.slaves = emily
		backstreets()
	elif state == 5:
		backstreets()
		main.close_dialogue()
	elif state == 0:
		backstreets()
		main.close_dialogue()


func brothel(slave = null):
	clearbuttons()
	var text = "Doorman greets you and shows you the way around brothel until you meet with the Madam.\n\n— Greetings, what would you like?  "
	for slave in globals.slaves:
		if slave.work == 'prostitution' || slave.work == 'escort' || slave.work == 'fucktoy':
			text = text + slave.dictionary('\nYou can see $name waiting for clients here.')
	mansion.maintext = text
	var array = [{name = 'Return', function = 'backstreets'}]
	if globals.state.sidequests.brothel == 0:
		array.insert(0,{name = 'Request your servants work here', function = 'brothelquest'})
	elif globals.state.sidequests.brothel == 1:
		if slave == null:
			array.insert(0,{name = 'Offer slave for quest', function = 'selectslavebrothelquest'})
		else:
			if slave.race in ['Elf','Dark Elf','Drow']:
				mansion.maintext = "— An elf, indeed. So, do you wanna trade?"
				array = [{name = 'Give away ' + slave.name,function = 'brothelquest'}, {name = 'Choose another slave', function = 'selectslavebrothelquest'}, {name = 'Leave', function = 'backstreets'}]
				questgiveawayslave = slave
			else:
				mansion.maintext = "— I don't think this is an Elf. Please, don't waste my time. "
				array = [{name = 'Offer slave for quest', function = 'selectslavebrothelquest'},{name = 'Leave',function = 'backstreets'}]
				questgiveawayslave = null
	buildbuttons(array)

func selectslavebrothelquest():
	main.selectslavelist(true, 'brothel', self)

func brothelquest():
	var array = []
	if globals.state.sidequests.brothel == 0:
		mansion.maintext = "— Huh, you want to whore your employees? You don't expect me to provide such opportunity for free, do you? How about a deal? You bring me an elf girl and I will consider such option. Elves are really in demand pretty much every season. \n\n[color=green]You obtained new sidequest. [/color] "
		array = [{name = 'Leave', function = 'backstreets'}]
		globals.state.sidequests.brothel = 1
	elif globals.state.sidequests.brothel == 1:
		globals.slaves.remove(globals.slaves.find(questgiveawayslave))
		mansion.maintext = "— Fine, you can send your servants to me and we'll offer them to clients. Keep in mind though we gonna keep some share of earnings for obvious reasons. Now we can't tell how much she'll made but I can give you few hints. Allure and endurance play some role here, but nothing can beat a sexually proactive girl who knows how to please her partner, especially if she has a pretty face.\n\n— Yeah, we'll keep her safe from possible aggression but don't blame on us if she decides to escape. We can't really watch her every movement. Although slaves rarely do that since they are basically outlaws at that point. \n\n[color=green]You have unlocked brothel as a workplace. [/color] "
		array = [{name = 'Leave', function = 'backstreets'}]
		globals.state.sidequests.brothel = 2
	buildbuttons(array)


func _on_slavedescription_meta_clicked( meta ):
	if meta == 'race':
		get_tree().get_current_scene().showracedescript(selectedslave)

func calibarquest():
	globals.events.calibar()



func _on_questlog_pressed():
	get_tree().get_current_scene()._on_questlog_pressed()


var backpackselecteditem
var backpackselectedspell
var partyselectedslave

func _on_details_pressed(empty = null):
	var newbutton
	backpackselecteditem = null
	partyselectedslave = null
	backpackselectedspell = null
	if get_node("playergroupdetails/TabContainer").is_connected('tab_changed',self,'_on_details_pressed') == false:
		get_node("playergroupdetails/TabContainer").connect("tab_changed",self,"_on_details_pressed")
	if get_node("playergroupdetails/Panel/TabContainer").is_connected('tab_changed',self,'_on_details_pressed') == false:
		get_node("playergroupdetails/Panel/TabContainer").connect("tab_changed",self,"_on_details_pressed")
	get_node("playergroupdetails").set_hidden(false)
	get_node("playergroupdetails/Panel/itemdescript").set_bbcode("")
	get_node("playergroupdetails/Panel/discardbutton").set_disabled(true)
	get_node("playergroupdetails/Panel/usebutton").set_disabled(true)
	for i in get_node("playergroupdetails/TabContainer/Captured Slaves/HBoxContainer/").get_children() + get_node("playergroupdetails/Panel/TabContainer/Items/VBoxContainer").get_children() + get_node("playergroupdetails/TabContainer/Party/HBoxContainer").get_children() + get_node("playergroupdetails/Panel/TabContainer/Spells/VBoxContainer").get_children():
		if i.get_name() != 'Button':
			i.set_hidden(true)
			i.queue_free()
	for i in globals.state.capturedgroup:
		newbutton = get_node("playergroupdetails/TabContainer/Captured Slaves/HBoxContainer/Button").duplicate()
		get_node("playergroupdetails/TabContainer/Captured Slaves/HBoxContainer/").add_child(newbutton)
		newbutton.set_hidden(false)
		newbutton.set_meta("slave", i)
		newbutton.get_node("setfree").connect("pressed",self,'freecaptured', [i])
		newbutton.get_node("inspect").connect("pressed",self,'inspectslave', [i])
		newbutton.set_text(i.race + " " + i.sex.capitalize() + " " + i.age.capitalize() + ", Grade: " + i.origins.capitalize())
		newbutton.connect("pressed",self,'selectpartymember',[i])
	
	var slave = globals.player
	newbutton = get_node("playergroupdetails/TabContainer/Party/HBoxContainer/Button").duplicate()
	get_node("playergroupdetails/TabContainer/Party/HBoxContainer/").add_child(newbutton)
	newbutton.set_hidden(false)
	newbutton.set_meta("slave", slave)
	newbutton.set_text(slave.dictionary("$name, HP: ") + str(slave.health) + '/' + str(slave.stats.health_max)  + ", EN: " + str(slave.energy) + '/' + str(slave.stats.energy_max))
	newbutton.connect("pressed",self,'selectpartymember',[slave])
	
	for i in globals.state.playergroup:
		slave = globals.state.findslave(i)
		newbutton = get_node("playergroupdetails/TabContainer/Party/HBoxContainer/Button").duplicate()
		get_node("playergroupdetails/TabContainer/Party/HBoxContainer/").add_child(newbutton)
		newbutton.set_hidden(false)
		newbutton.set_meta("slave", slave)
		newbutton.set_text(slave.dictionary("$name, HP: ") + str(slave.health) + '/' + str(slave.stats.health_max)  + ", EN: " + str(slave.energy) + '/' + str(slave.stats.energy_max))
		newbutton.connect("pressed",self,'selectpartymember',[slave])
	
	for i in globals.state.backpack.stackables:
		var item = globals.itemdict[i]
		newbutton = get_node("playergroupdetails/Panel/TabContainer/Items/VBoxContainer/Button").duplicate()
		get_node("playergroupdetails/Panel/TabContainer/Items/VBoxContainer").add_child(newbutton)
		newbutton.set_hidden(false)
		newbutton.get_node("name").set_text(item.name)
		newbutton.set_meta("item", item)
		newbutton.get_node("amount").set_text(str(globals.state.backpack.stackables[i]))
		if item.icon != null:
			newbutton.get_node("icon").set_texture(item.icon)
		newbutton.connect("pressed",self,'itembackpackselect', [item])
	calculateweight()
	
	for i in ['heal','mindread','invigorate','guidance']:
		var spell = globals.spelldict[i]
		if spell.learned == false:
			continue
		newbutton = get_node("playergroupdetails/Panel/TabContainer/Spells/VBoxContainer/Button").duplicate()
		get_node("playergroupdetails/Panel/TabContainer/Spells/VBoxContainer").add_child(newbutton)
		newbutton.set_hidden(false)
		newbutton.get_node("name").set_text(spell.name)
		newbutton.get_node("cost").set_text(str(spell.manacost))
		newbutton.set_meta('spell', spell)
		newbutton.connect("pressed",self,'spellbackpackselect',[spell])
	
	if !get_parent().get_node("explorationnode").currentzone.code in ['wimborn','gorn','frostford', 'amberguard'] || globals.resources.gold <= 25:
		get_node("playergroupdetails/return").set_disabled(true)
	else:
		get_node("playergroupdetails/return").set_disabled(false)
	if get_parent().get_node("explorationnode").currentzone.code in ['wimborn','gorn','frostford'] && globals.state.capturedgroup.size() > 0:
		get_node("playergroupdetails/quicksell").set_disabled(false)
	else:
		get_node("playergroupdetails/quicksell").set_disabled(true)
	if get_node("playergroupdetails/Panel/TabContainer").get_current_tab() == 1:
		get_node("playergroupdetails/Panel/discardbutton").set_hidden(true)
	else:
		get_node("playergroupdetails/Panel/discardbutton").set_hidden(false)


func selectpartymember(slave):
	partyselectedslave = slave
	for i in get_node("playergroupdetails/TabContainer/Party/HBoxContainer").get_children() + get_node("playergroupdetails/TabContainer/Captured Slaves/HBoxContainer").get_children():
		if i.get_name() == 'Button' || i.get_meta('slave') != slave:
			i.set_pressed(false)
		else:
			i.set_pressed(true)
	if backpackselecteditem != null:
		itembackpackselect(backpackselecteditem)
	elif backpackselectedspell != null:
		spellbackpackselect(backpackselectedspell)

func itembackpackselect(item):
	backpackselecteditem = item
	for i in get_node("playergroupdetails/Panel/TabContainer/Items/VBoxContainer").get_children():
		i.set_pressed(false) if i.get_name() == 'Button' || i.get_meta("item") != item else i.set_pressed(true)
	get_node("playergroupdetails/Panel/discardbutton").set_disabled(false)
	if item.code in ['bandage','teleportseal'] && partyselectedslave != null:
		get_node("playergroupdetails/Panel/usebutton").set_disabled(false)
	else:
		get_node("playergroupdetails/Panel/usebutton").set_disabled(true)
	var text ='[center]' + item.name + '[/center]\n' + item.description + '\n\nWeight: ' + str(item.weight)
	if item.code == 'teleportseal' && partyselectedslave == globals.player:
		text += '\n\n[color=#ff4949]Your captured slaves will be freed and your party will take time to return home on their own. [/color]'
	get_node("playergroupdetails/Panel/itemdescript").set_bbcode(text)

func spellbackpackselect(spell):
	backpackselectedspell = spell
	for i in get_node("playergroupdetails/Panel/TabContainer/Spells/VBoxContainer").get_children():
		i.set_pressed(false) if i.get_name() == 'Button' || i.get_meta("spell") != spell else i.set_pressed(true)
	get_node("playergroupdetails/Panel/discardbutton").set_disabled(false)
	if globals.resources.mana >= spell.manacost && partyselectedslave != null:
		get_node("playergroupdetails/Panel/usebutton").set_disabled(false)
	elif spell.code == 'mindread' && partyselectedslave == globals.player:
		get_node("playergroupdetails/Panel/usebutton").set_disabled(true)
	else:
		get_node("playergroupdetails/Panel/usebutton").set_disabled(true)
	if spell.code == 'guidance':
		get_node("playergroupdetails/Panel/usebutton").set_disabled(get_parent().exploration.inencounter)
	var text ='[center]' + spell.name + '[/center]\n' + spell.description + '\n\nMana Cost: ' + str(spell.manacost)
	get_node("playergroupdetails/Panel/itemdescript").set_bbcode(text)


func useitem(item, slave):
	globals.state.backpack.stackables[item.code] -= 1
	if globals.state.backpack.stackables[item.code] < 1:
		globals.state.backpack.stackables.erase(item.code)
	if item.code == 'bandage':
		if slave.effects.has('bandaged') == false:
			get_parent().infotext(slave.dictionary("Bandage used on $name."),'green')
			slave.health += slave.stats.health_max/2.5
			slave.add_effect(globals.effectdict.bandaged)
		else:
			get_parent().infotext(slave.dictionary("Bandage used on $name with reduced efficiency."),'green')
			slave.health += slave.stats.health_max/5
	elif item.code == 'teleportseal':
		if slave == globals.player:
			get_parent().popup("After activating Teleportation Seal, you appear inside of your mansion, leaving your party behind. Hopefully they will find a way back in near time. ")
			for i in globals.state.playergroup:
				globals.state.findslave(i).away.duration = round(rand_range(1,3))
			mansion()
		elif globals.slaves.find(slave) >= 0:
			get_parent().popup(slave.dictionary("After activating Teleportation Seal, $name slowly dissipates in bright sparkles."))
			globals.state.playergroup.erase(slave.id)
		else:
			if globals.count_sleepers().jail < globals.state.mansionupgrades.jailcapacity:
				slave.sleep = 'jail'
			globals.slaves = slave
			globals.state.capturedgroup.erase(slave)
	playergrouppanel()
	_on_details_pressed()


func usespell(spell, slave):
	get_tree().get_current_scene().get_node('spellnode').slave = slave
	if spell.code == 'heal':
		get_tree().get_current_scene().get_node('spellnode').healeffect()
	elif spell.code == 'invigorate':
		get_tree().get_current_scene().get_node('spellnode').invigorateeffect()
	elif spell.code == 'mindread' && slave != globals.player:
		get_tree().get_current_scene().get_node('spellnode').mindreadeffect()
	elif spell.code == 'guidance':
		get_tree().get_current_scene().get_node('spellnode').guidanceeffect()
	_on_details_pressed()
	playergrouppanel()


func _on_usebutton_pressed():
	if get_node("playergroupdetails/Panel/TabContainer").get_current_tab() == 0:
		useitem(backpackselecteditem, partyselectedslave)
	else:
		usespell(backpackselectedspell, partyselectedslave)

func _on_discardbutton_pressed():
	var item = backpackselecteditem
	globals.state.backpack.stackables[item.code] -= 1
	get_tree().get_current_scene().infotext('Discarded '+item.name,'red')
	if globals.state.backpack.stackables[item.code] <= 0:
		globals.state.backpack.stackables.erase(item.code)
	_on_details_pressed()

var captureeselected

func selectcaptured(slave):
	captureeselected = slave
	get_node("playergroupdetails/capturedslave").popup()
	get_node("playergroupdetails/capturedslave/RichTextLabel").set_bbcode(slave.description(true))
	get_node("playergroupdetails/capturedslave/capturedteleport").set_disabled(!(globals.state.backpack.stackables.has("teleportseal") && globals.state.backpack.stackables.teleportseal >= 1))
	
	get_node("playergroupdetails/capturedslave/capturedmindread").set_disabled(globals.resources.mana < globals.spelldict.mindread.manacost)

func calculateweight():
	var weight = globals.state.calculateweight()
	get_node("playergroupdetails/TextureProgress/Label").set_text("Weight: " + str(weight.currentweight) + '/' + str(weight.maxweight))
	get_node("playergroupdetails/TextureProgress").set_val((weight.currentweight*10/max(weight.maxweight,1)*10))
	


func _on_closegroup_pressed():
	get_node("playergroupdetails").set_hidden(true)


func _on_capturedclose_pressed():
	get_node("playergroupdetails/capturedslave").set_hidden(true)

func inspectslave(slave):
	get_tree().get_current_scene().popup(slave.descriptionsmall())

func freecaptured(slave):
	partyselectedslave = slave
	get_tree().get_current_scene().yesnopopup("Free this slave?", 'freetrue',self)

func freetrue():
	get_node("playergroupdetails/capturedslave").set_hidden(true)
	globals.state.capturedgroup.erase(partyselectedslave)
	get_tree().get_current_scene().infotext('You have released '+ partyselectedslave.name + 'yellow')
	_on_details_pressed()

func _on_capturedmindread_pressed():
	get_node("playergroupdetails/capturedslave").set_hidden(true)
	get_tree().get_current_scene().get_node("spellnode").slave = captureeselected
	get_tree().get_current_scene().get_node("spellnode").mindreadeffect()



func _on_quicksell_pressed():
	var text = ''
	var gold = 0
	var array = []
	for i in globals.state.capturedgroup:
		array.append(i)
	for i in array:
		gold += i.sellprice()/2
		globals.state.capturedgroup.erase(i)
	main.popup('You furtively delivered your captives to the local slaver guild. This earned you [color=yellow]' + str(gold) + '[/color] gold. ')
	globals.resources.gold += gold
	_on_details_pressed()

func _on_return_pressed():
	globals.resources.gold -= 25
	mansion()
	get_node("playergroupdetails").set_hidden(true)



