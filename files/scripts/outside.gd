
extends Node

onready var maintext = get_node("outsidetextbox")
onready var main = get_tree().get_current_scene()
onready var buttoncontainer = get_node("outsidebuttoncontainer")
onready var button = get_node("outsidebuttoncontainer/buttontemplate")
onready var questtext = globals.questtext
var location = ''
var questgiveawayslave

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
		newbutton.set_text(str(counter+1) +'. ' +  i.name)
		newbutton.set_hidden(false)
		if i.has('args'):
			newbutton.connect('pressed', target, i.function, [i.args])
			if i.has('disabled'):
				newbutton.set_disabled(true)
			if i.has('tooltip'):
				newbutton.set_tooltip(i.tooltip)
		else:
			newbutton.connect('pressed', target, i.function)
		counter += 1

func _on_leave_pressed():
	if globals.state.location == 'wimborn':
		town()
	else:
		gooutside()
		get_parent().get_node("explorationnode").zoneenter(globals.state.location)

func playergrouppanel():
	var charpanel
	if main.get_node("Navigation").is_visible() == true:
		main.get_node("Navigation").set_hidden(false)
	for i in get_node("playergrouppanel/VBoxContainer").get_children():
		if i != get_node("playergrouppanel/VBoxContainer/Panel"):
			i.set_hidden(true)
			i.queue_free()
	charpanel = get_node("playergrouppanel/VBoxContainer/Panel").duplicate()
	get_node("playergrouppanel/VBoxContainer").add_child(charpanel)
	charpanel.set_hidden(false)
	if globals.player.imageportait != null:
		if File.new().file_exists(globals.player.imageportait) == true:
			charpanel.get_node("portait").set_texture(load(globals.player.imageportait))
		else:
			globals.player.imageportait = null
	charpanel.get_node("name").set_text(globals.player.name_short())
	charpanel.get_node("health").set_text('HP:' +str(round(globals.player.health)) + '/' + str(globals.player.stats.health_max))
	charpanel.get_node("energy").set_text('EN:'+str(round(globals.player.energy)) + '/' + str(globals.player.stats.energy_max))
	for i in globals.state.playergroup:
		var slave = globals.state.findslave(i)
		charpanel = get_node("playergrouppanel/VBoxContainer/Panel").duplicate()
		if slave.imageportait != null:
			if File.new().file_exists(slave.imageportait) == true:
				charpanel.get_node("portait").set_texture(load(slave.imageportait))
			else:
				slave.imageportait = null
		get_node("playergrouppanel/VBoxContainer").add_child(charpanel)
		charpanel.set_hidden(false)
		charpanel.get_node("name").set_text(slave.name_short())
		charpanel.get_node("stress").set_hidden(false)
		charpanel.get_node("stress").set_text("SR:" + str(round(slave.stress)))
		charpanel.get_node("health").set_text('HP:' +str(round(slave.health)) + '/' + str(slave.stats.health_max))
		charpanel.get_node("energy").set_text('EN:'+str(round(slave.energy)) + '/' + str(slave.stats.energy_max))


func town():
	gooutside()
	main.background_set('wimborn')
	if OS.get_name() != "HTML5" && globals.rules.fadinganimation == true:
		yield(main, 'animfinished')
	get_node("playergrouppanel/VBoxContainer").set_hidden(false)
	get_node("charactersprite").set_hidden(true)
	location = 'wimborn'
	get_node("exploreprogress/locationname").set_text("Wimborn")
	maintext.set_bbcode("The Wimborn is a lively place at nearly all hours, as the cries of hawkers and shopkeepers vie with the songs of work crews for attention. Along the major roads, most of the buildings have been painted in a riot of colors to break up the monotony of grey-blue brick and plaster covered stone, with many of the storefronts sporting colorful awnings and signs to attract potential customers. Away from the bright colors and raucous noise of the market streets things tend to be restrained, the buildings more grey, and cries more a cause for worry.\n\nThe city is divided into a number of districts, but only a few areas are of interest to you at the moment. To the north are the Market District, and past that Auld Erellon which is the home of the Mage’s Guild and other government bodies. To the west is Red-Lantern and Riverside, where most of the city’s brothels and whorehouses might be found. To the south is the Guild District, where there is always some foreman looking for cheap but reliable labor.")
	var array = [{name = "Visit the Mage's Order",function = 'mageorder'},{name = "Visit Slaver's Guild", function = 'slaveguild'},{name = "Visit Market District",function = 'market'},{name = "Visit Red Lantern District", function = 'backstreets'},{name = "Outskirts",function = 'outskirts'},{name = "Return to Mansion",function = 'mansion'}]
	buildbuttons(array)

func mansion():
	main._on_mansion_pressed()

func gooutside():
	get_parent().get_node("hideui").set_hidden(false)
	if OS.get_name() != "HTML5" && globals.rules.fadinganimation == true:
		yield(main, 'animfinished')
	main.music_set('wimborn')
	main.checkplayergroup()
	get_parent().get_node("Navigation").set_hidden(true)
	main.get_node("buttonpanel").set_hidden(true)
	#get_parent().hide_everything()
	main.get_node('MainScreen').set_hidden(true)
	main.get_node("charlistcontrol").set_hidden(true)
	set_hidden(false)
	playergrouppanel()
	if globals.state.tutorial.outside == false:
		main.get_node("tutorialnode").outside()

func outskirts():
	main.get_node("explorationnode").zoneenter('wimbornoutskirts')


############## SLAVE GUILD
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
				get_node("outsidebuttoncontainer").get_child(key).emit_signal("pressed")
			elif event.is_action_pressed(str(key)) == true && get_parent().get_node("dialogue").is_hidden() == false && get_parent().get_node("dialogue/popupbuttoncenter/popupbuttons").get_children().size() >= key+1:
				get_parent().get_node("dialogue/popupbuttoncenter/popupbuttons").get_child(key).emit_signal("pressed")

func newslaveinguild(number, town = 'wimborn'):
	while number > 0:
		#wimborn
		var racearray
		var race
		var origin
		var originpool 
		if town == 'wimborn':
			racearray = [[globals.wimbornraces[rand_range(0,globals.wimbornraces.size())],15],['Drow', 20],['Dark Elf', 30],['Elf', 40],['Human', 100]]
		elif town == 'gorn':
			racearray = [[globals.gornraces[rand_range(0,globals.gornraces.size())],15],['Centaur', 10],['Human', 30],['Goblin', 50],['Orc', 100]]
		elif town == 'frostford':
			racearray = [[globals.frostfordraces[rand_range(0,globals.frostfordraces.size())],20],['Human', 40],['Halfkin Wolf', 60],['Beastkin Wolf', 100]]
		if globals.rules.slaverguildallraces == true && globals.state.sandbox == true:
			originpool = ['slave','poor','commoner','rich','noble']
			origin = originpool[rand_range(0,originpool.size())]
			race = globals.allracesarray[rand_range(0,globals.allracesarray.size())]
		else:
			var rand = rand_range(0,100)
			for i in racearray:
				if i[1] > rand:
					race = i[0]
					break
			rand = rand_range(0,100)
			originpool = [['rich',5],['commoner',20],['poor',60],['slave',100]]
			for i in originpool:
				if i[1] > rand:
					origin = i[0]
					break
		var newslave = globals.slavegen.newslave(race, 'random', 'random', origin)
		newslave.obed += 95
		globals.guildslaves[town].append(newslave)
		number -= 1


func setcharacter(text):
	get_node("charactersprite").set_texture(get_parent().spritedict[text])
	#get_node("charactersprite").set_as_toplevel(true)

func slaveguild(guild = 'wimborn'):
	if guild == 'wimborn':
		slavearray = globals.guildslaves.wimborn
		if get_node("charactersprite").is_visible() == false || get_node("charactersprite").get_texture() != load("res://files/images/fairy.png"):
			main.background_set('slaverguild')
			if OS.get_name() != "HTML5" && globals.rules.fadinganimation == true:
				yield(main, 'animfinished')
			setcharacter('fairy')
			get_node("AnimationPlayer").play("spritemovefairy")
		clearselection()
		if globals.state.slaveguildvisited == 0:
			maintext.set_bbcode(globals.player.dictionary("The first time you enter through the doors of the town's central building, you are mildly surprised to find it it very clean and bright inside. Arriving at the reception, a small cheerful fairy girl emerges from nearby to assist you. Her friendly and somewhat whimsical looks make you realize she must be one of the main receptionists hired to drag in potential clients. \n\n[color=yellow]— Welcome $sir! I do not believe I have see you here before, is this your first time?. You seem to be a respectable person! If you will allow me, I shall help you get familiar with our establishment!\n\n— From our facilities here we can provide our clients with many affordable and obedient staff members. Yes, the possession of another person is allowed as long as you have the rights. Despite overall humanity progression, it is still very far from providing sufficient food and living conditions for everyone. By selling themselves into others custody, many find a way to survive, cover their debts or help their family. \n\n— Sometimes we deal with, so called, 'prisoners of war', to help them to adapt to life in our care. Don't you find this is way more humane giving them a new chance, instead of outright slaughtering them?\n\n— This is where we come in. place and ensure, that your deal is secured. Slaves give up a huge part of their freedom. We take care to teach them to act appropriately, so you may be sure their initial behaviour will be acceptable.  To strengthen your ownership we will gladly help brand your purchase.\n\n— After slave becomes your property, you are free to employ them as you see fit, but keep in mind, that inhumane treatment may cause you quite a few problems. We strongly advise against unnecessary deaths and mutilations, nor we do support people harshly abusing their privileges over others. \n\n— Lastly, if you have possession of someone, you no longer have a need for and wish to part with, we can surely offer you something!\n\n— I hope, my explanation was helpful, $sir! Let me know if there's something else I can assist you with![/color]"))
			globals.state.slaveguildvisited = 1
		else:
			maintext.set_bbcode(globals.player.dictionary("You enter through the guild’s doors, and are greeted once again by the busy sights and sounds of customers, slaves, and workers shuffling around at blistering speeds. You give a polite bow to one of the receptionists and grab a pen to sign in. In few moments your short acquaintance appears before you.\n\n[color=yellow]— Ah, my pleasure, $name, how can I help you today?[/color] "))
		var array = [{name = 'See slaves for sale', function = 'slaveguildslaves'}, {name = 'Offer your servants',function = 'slaveguildsells'}, {name = 'See custom requests', function = 'slaveguildquests'},{name = 'Services for Slaves',function = 'slaveservice'},{name = 'Leave', function = 'town'}]
		if globals.state.mainquest == 3:
			array.insert(3, {name = "Ask about fairies", function = 'slaveguildfairy'})
		buildbuttons(array)
	elif guild == 'gorn':
		clearselection()
		slavearray = globals.guildslaves.gorn
		maintext.set_bbcode(globals.player.dictionaryplayer("Huge part of supposed guild takes a makeshift platform and tents on the outside with few half-empty cages. In the middle, you can see a presentation podium which is easily observable from main street. Despite Gorn being very different from common, primarily human-populated towns, it still directly follows Mage's Order directives — race diversity and casual slavery are very omnipresent. \n\nAs you walk in, one of the goblin receptionists quickly recognizes you as an Order member and hastily grabs your attention, sensing a profitable customer.\n\n— $sir interested in some heat-tolerant 'orkers? *chuckles* Or you are in preference of short girls? We quite often get those as well, for every taste and color!"))
		var array = [{name = 'See slaves for sale',function = 'slaveguildslaves'}, {name = 'See custom requests',function = 'slaveguildquests'}, {name = 'Leave',function = 'togorn'}]
		if globals.state.sidequests.emily in [14,15]:
			array.insert(1, {name = 'Search for Tisha', function = 'tishaquest'})
		buildbuttons(array)
	elif guild == 'frostford':
		clearselection()
		slavearray = globals.guildslaves.frostford
		maintext.set_bbcode(globals.player.dictionaryplayer("A humble local guild building is bright and warm inside. Just as the whole of Frostford, this place is serene in its mood compared to what you are used to. Realizing you belong to the Mage's Order, attendant politely greets you and asks how he could assist you. "))
		var array = [{name = 'See slaves for sale',function = 'slaveguildslaves'}, {name = 'See custom requests',function = 'slaveguildquests'}, {name = 'Leave', function = 'tofrostford'}]
		buildbuttons(array)
	get_node("playergrouppanel/VBoxContainer").set_hidden(true)
	if globals.spelldict.mindread.learned == false:
		get_node("slavebuypanel/mindreadbutton").set_hidden(true)
	else:
		get_node("slavebuypanel/mindreadbutton").set_hidden(false)

func slaveguildfairy():
	globals.state.mainquest = 3.1
	slaveguild()
	maintext.set_bbcode(questtext.GuildFairyMainQuest)

func togorn():
	get_node("playergrouppanel/VBoxContainer").set_hidden(false)
	main.get_node("explorationnode").zoneenter('gorn')

func tofrostford():
	get_node("playergrouppanel/VBoxContainer").set_hidden(false)
	main.get_node("explorationnode").zoneenter('frostford')

var selectedslave
var selectedslaveprice
var slavearray

func slaveguildslaves():
	get_node("slavebuypanel").set_hidden(false)
	var slavelist = get_node("slavebuypanel/slavebuypanel/ScrollContainer/VBoxContainer")
	var slavebutton =  get_node("slavebuypanel/slavebuypanel/ScrollContainer/VBoxContainer/slavebutton")
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
		newbutton.get_node('price').set_text(str(round(max(slave.calculateprice()*0.8,50)))+ ' gold')
		newbutton.set_name(slave.name)
		newbutton.connect('pressed',self,'selectslavebuy',[slave])
	maintext.set_bbcode('')
	clearbuttons()

func selectslavebuy(slave):
	selectedslaveprice = max(round(slave.calculateprice()*0.8),50)
	selectedslave = slave
	var text = ''
	if slave.origins == 'slave':
		text = "Former slaves are pretty affordable and really easy to deal with! I bet you'll like this one! "
	if slave.pussy.virgin == true && text != '':
		text = text + "And also, $he's still a virgin! What would you think about becoming $his first?"
	elif slave.pussy.virgin == true:
		text = text + "This $child is still a virgin. "
	if text == '':
		text = "Healthy and really Obedient! "
	text = text +"\n\n— [color=yellow]"+str(selectedslaveprice)+ " gold[/color], and $he's all yours.[/color] "
	get_node("slavebuypanel/slavedescription").set_bbcode(slave.description_small() + '\n\n[color=#ff00bf]— '+ slave.dictionary(text))
	for i in get_node("slavebuypanel/slavebuypanel//ScrollContainer/VBoxContainer").get_children():
		if i.get_name() != slave.name && i.is_pressed() == true:
			i.set_pressed(false)
	if globals.resources.gold < selectedslaveprice:
		get_node("slavebuypanel/purchasebutton").set_disabled(true)
	else:
		get_node("slavebuypanel/purchasebutton").set_disabled(false)
	if globals.spelldict.mindread.learned == true && globals.spelldict.mindread.manacost <= globals.resources.mana:
		get_node("slavebuypanel/mindreadbutton").set_disabled(false)
	else:
		get_node("slavebuypanel/mindreadbutton").set_disabled(true)

func _on_mindreadbutton_pressed():
	main.get_node("spellnode").slave = selectedslave
	main.get_node("spellnode").mindreadeffect()


func selectslavesell(slave):
	selectedslaveprice = (round(max(slave.calculateprice()*0.45,10)))
	selectedslave = slave
	var text = ''
	if selectedslaveprice >= 300:
		text = "— Wow, that's one handy exemplar. My superiors say, they are ready to pay [color=yellow]"+str(selectedslaveprice) + selectedslave.dictionary(" gold[/color] for $him. ")
	elif selectedslaveprice >= 150:
		text = "— Looks decent, we'll pay you [color=yellow]"+str(selectedslaveprice)+ " gold[/color] for this one."
	elif selectedslaveprice >= 50:
		text = "— Not bad, we can afford to spend [color=yellow]"+str(selectedslaveprice)+ selectedslave.dictionary(" gold[/color] for $him.")
	else:
		text = "— This one... is not of terribly great value to us, however we are still ready to pay you [color=yellow]"+ str(selectedslaveprice)+ selectedslave.dictionary(" gold[/color] for $him.")
	get_node("slavesellpanel/slavedescription").set_bbcode(text)
	get_node("slavesellpanel/slavesellbutton").set_disabled(false)
	for i in get_node("slavesellpanel/ScrollContainer/VBoxContainer").get_children():
		if i.get_name() != slave.name && i.is_pressed() == true:
			i.set_pressed(false)



func _on_slavelistcancel_pressed():
	get_node("slavebuypanel").set_hidden(true)
	clearselection()
	slaveguild(location)
	if location == 'wimborn':
		get_node("outsidetextbox").set_bbcode("[color=yellow]— Anything else you are interested in? [/color]")

func _on_purchasebutton_pressed():
	globals.resources.gold -= selectedslaveprice
	globals.slaves = selectedslave
	slavearray.remove(slavearray.find(selectedslave))
	main.popup('You pay ' + str(selectedslaveprice) + selectedslave.dictionary(" gold for $name. With that, guild's helper brands $him for you and $he's sent to your mansion. "))
	selectedslave.brand = 'basic'
	slaveguildslaves()
	get_node("slavebuypanel/slavedescription").set_bbcode(globals.player.dictionary("A finest choice, $sir. Anyone else caught your attention?"))
	clearselection('buy')



func _on_slavesellbutton_pressed():
	globals.resources.gold += selectedslaveprice
	globals.guildslaves[location].append(selectedslave)
	globals.slaves.remove(globals.slaves.find(selectedslave))
	main.popup(selectedslave.dictionary('You sell $name for ') + str(selectedslaveprice) + selectedslave.dictionary(" gold. $He's taken away and put on sale for other customers. "))
	main.rebuild_slave_list()
	slaveguildsells()
	clearselection('sell')


func slaveguildsells():
	maintext.set_bbcode('')
	clearbuttons()
	get_node("slavesellpanel").set_hidden(false)
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
			newbutton.get_node('price').set_text(str(max(round(slave.calculateprice()*0.45),10))+ ' gold')
			newbutton.set_name(slave.name)
			newbutton.connect('pressed',self,'selectslavesell',[slave])


func _on_slavesellcancel_pressed():
	get_node("slavesellpanel").set_hidden(true)
	clearselection()
	slaveguild(location)
	if location == 'wimborn':
		get_node("outsidetextbox").set_bbcode("[color=yellow]— Anything else you are interested in? [/color]")


func clearselection(temp = ''):
	selectedslave = ''
	selectedslaveprice = 0
	maintext.set_bbcode('')
	get_node("slavebuypanel/slavedescription").set_bbcode('[color=yellow]— We have the finest choice of fresh obedient merchandise. Who would you like to see?[/color]')
	get_node("slavesellpanel/slavedescription").set_bbcode("[color=yellow]— Oh, you have someone, you would like to part with? That's fine, but don't expect us to pay you full price. We are just humble retailers after all. If you want better price, you should find a buyer yourself. [/color]")
	if temp == 'buy':
		get_node("slavebuypanel/slavedescription").set_bbcode('[color=yellow]— A fine purchase! Would you like to see another one?[/color]')
	elif temp == 'sell':
		get_node("slavesellpanel/slavedescription").set_bbcode("[color=yellow]— It's been pleasure! Do you have any more uneeded personas to trade?[/color]")
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
	maintext.set_bbcode('')
	text = '[color=yellow]— Looking for some part time job? Sure, take a look at the request board![/color]'
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
			get_node("slaveguildquestpanel/questdescription").set_bbcode(text)
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
	get_node("slaveguildquestpanel/questdescription").set_bbcode(text)

func _on_questhide_pressed():
	get_node("slaveguildquestpanel").set_hidden(true)
	slaveguild(location)
	if location == 'wimborn':
		get_node("outsidetextbox").set_bbcode("[color=yellow]— Anything else you are interested in? [/color]")


func questbuttonpressed(quest):
	get_node("slaveguildquestpanel/questdescription").set_bbcode(slavequesttext(quest))

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
		get_node("slaveguildquestpanel/questdescription").set_bbcode("[color=yellow]— Alright, got you! Make sure to get it in time. [/color]")
	else:
		if get_node("slaveguildquestpanel/questaccept").get_text() == 'Turn in':
			main.popup(offeredslave.dictionary('You hand away $name and receive your reward. \n[color=yellow]You have gained ' + str(selectedquest.reward/10) + ' XP.[/color]\n\n[color=green]Your reputation with ' + location.capitalize() + " has increased.[/color]"))
			if offeredslave.work == 'companion':
				globals.state.companion = -1
			elif offeredslave.work == 'labassit':
				globals.state.labassit = -1
			globals.slaves.remove(globals.slaves.find(offeredslave))
			selectedquest.taken = false
			globals.player.level.xp += selectedquest.reward/10
			globals.resources.gold += selectedquest.reward
			if selectedquest.difficulty == 'easy':
				globals.state.reputation[location] += 3
			elif selectedquest.difficulty == 'medium':
				globals.state.reputation[location] += 5
			elif selectedquest.difficulty == 'hard':
				globals.state.reputation[location] += 8
			for i in globals.state.repeatables:
				for ii in globals.state.repeatables[i]:
					if ii == selectedquest:
						globals.state.repeatables[i].remove(globals.state.repeatables[i].find(ii))
			slaveguildquests()
		else:
			main.selectslavelist(true, 'slaveforquestselected', self)

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
		if i[0] == 'hairlength':
			ref = globals.hairlengtharray.find(slave.hairlength)
		if i[0] == 'tits.size':
			ref = globals.sizearray.find(slave.tits.size)
		if i[0] == 'sexuals.unlocks':
			ref = slave.sexuals.unlocks.size()
		if i[1] == 'gte':
			if ref < i[2]:
				slavefits = false
				text = text + '[color=red]' + repeatablesdict[i[0]] + '[/color]\n'
			else:
				text = text + '[color=green]' + repeatablesdict[i[0]] + '[/color]\n'
		elif i[1] == 'eq':
			if ref != i[2]:
				slavefits = false
				text = text + '[color=red]' + repeatablesdict[i[0]] + '[/color]\n'
			else:
				text = text + '[color=green]' + repeatablesdict[i[0]] + '[/color]\n'
		elif i[1] == 'lte':
			if ref > i[2]:
				slavefits = false
				text = text + '[color=red]' + repeatablesdict[i[0]] + '[/color]\n'
			else:
				text = text + '[color=green]' + repeatablesdict[i[0]] + '[/color]\n'
	if slavefits == true:
		get_node("slaveguildquestpanel/questdescription").set_bbcode("— Alright, looks like this is exactly what we need!\n" + text)
		get_node("slaveguildquestpanel/questaccept").set_text("Turn in")
		offeredslave = slave
	else:
		get_node("slaveguildquestpanel/questdescription").set_bbcode(slave.dictionary("— Sorry, $he does not fit the requirements. \n") + text)
		offeredslave = null



var repeatablesdict = {
sex = 'Sex',obed = 'Obedience', cour = 'Courage',conf = 'Confidence',wit = 'Wit', charm = 'Charm', 
'face.beauty':'Beauty',lewd = 'Lewdness', dom = 'Role Preference', 
'sexuals.unlocks' : "Unlocked Sex Categories",
'sstr' : 'Strength', 'sagi' : 'Agility', 'smaf' : 'Magic Affinity', 'send' : 'Endurance',
loyal = 'Loyalty', race = 'Race', age = 'Age', hairlength = 'Hair Length', origins = 'Origins',
bodyshape = 'Type', haircolor = 'Hair Color', 'tits.size' : 'Breasts Size',
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
		elif i[0] == 'tits.size':
			text2 = text2 + 'Breast size — ' + str(globals.sizearray[i[2]]) + operators[i[1]]
		elif i[0] == 'origins':
			text2 = text2 + 'Origins — ' +globals.fastif(i[1] == 'neq', 'not '+ str(i[2]), str(i[2])) + ';\n'
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
	maintext.set_bbcode('')
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
		get_node("slaveservicepanel/servicedescription").set_bbcode('[color=yellow]— If you need some help with your slaves, we offer a broad selection of useful services! Just let me know what bothers you.[/color]')
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
	get_node("slaveservicepanel/servicedescription").set_bbcode(text)


func _on_serviceconfirm_pressed():
	var slave = slaveserviceselected
	var operation = operationdict[serviceoperation]
	var text = slave.dictionary(operation.confirm)
	if operation.code == 'abortion':
		slave.preg.baby = null
		slave.preg.duration = 0
		slave.stress += rand_range(35,70)
		slave.health = -25
		globals.resources.gold -= operation.price
	elif operation.code == 'sterilize':
		slave.preg.has_womb = false
		slave.stress += rand_range(30,50)
		slave.health = -15
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
		slave.away.duration = 1 + globals.originsarray.find(slave.origins)
	elif operation.code == 'spec':
		globals.resources.gold -= 500
		slave.spec = get_node("slaveservicepanel/serviceconfirm").get_meta('spec').code
		slave.away.duration = 5
	slaveserviceselected = null
	serviceoperation = null
	slaveservice()
	main.popup(text)

func _on_slaveservicecancel_pressed():
	get_node("slaveservicepanel").set_hidden(true)
	slaveguild()
	if location == 'wimborn':
		get_node("outsidetextbox").set_bbcode("[color=yellow]— Anything else you are interested in? [/color]")

func specchosen(button):
	for i in get_tree().get_nodes_in_group('specsbutton'):
		if i != button:
			i.set_pressed(false)
	var spec = button.get_meta('spec') 
	var text = "[center]" + spec.name + '[/center]\n' + spec.descript + "\nBonus: [color=aqua]" + spec.descriptbonus + "[/color]\n\nRequirements: [color=yellow]" + spec.descriptreqs + "[/color]\n\nCost: 500 gold.\nDuration: 5 days."
	get_node("slaveservicepanel/servicedescription").set_bbcode(text)
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
reqs = "globals.currentslave.hairlength != 'ear'",
description = "[color=yellow]— Need a hair trimming? We have barberer just for that![/color]",
price = 25,
confirm = "You leave $name in the custody of guild's barber. Later $he returns with shorter hair."
},
abortion = {
code = 'abortion',
name = 'Commit Abortion',
number = 2,
reqs = "globals.currentslave.preg.duration >= 5",
description = "[color=yellow]— Oh, quite often babies are not very desirable by both slaves and their masters. We can take care of it right here and guarantee no serious health issues afterwards![/color] ",
price = 75,
confirm = "You leave $name in the custody of guild's specialists. As $his pregnancy ends, you can notice how $name looks considerably more stressed."
},
sterilize = {
code = 'sterilize',
name = 'Sterilize',
number = 2,
reqs = "globals.currentslave.preg.has_womb == true && globals.currentslave.preg.duration == 0",
description = "[color=yellow]— Ain't it a good alternative to daily expenses for contraception to just sterilize your $childs to prevent any possible future complications? We guarantee decent health after operation is over![/color]\n\n[color=red]This operation is difficult to reverse![/color]",
price = 125,
confirm = "After the operation $name becomes sterile. $He won't be able to carry any more children. "
},
nurture = {
code = 'nurture',
name = 'Nurture',
number = 3,
reqs = "globals.currentslave.traits.has('Regressed') == true",
description = "[color=yellow]— It seems your $child could use some proper upbringing! In current state we can train $him to become way more suited for your needs![/color]\n\n[color=green]This option will neutralize Regressed trait.[/color]",
price = 150,
confirm = "You leave $name in the custody of guild trainers, who will train $him among other slaves and prepare for your domain."
},
uprise = {
code = 'uprise',
name = 'Elevate',
number = 4,
reqs = "globals.currentslave.origins != 'noble'",
description = "[color=yellow]— Sometimes you wish your old time servant was more capable? With our training technics we can help them to get better, not just as a tool, but as an individual!  [/color]\n\n[color=green]This option will raise slave's grade, but also will make them more demanding. [/color]",
price = 100,
confirm = "You leave $name in the custody of guild trainers, who will help $him raising $his self-esteem. ",
},
subjugate = {
code = 'subjugate',
name = 'Demote',
number = 5,
reqs = "globals.currentslave.origins != 'slave'",
description = "[color=yellow]— Tad bit of discipline and we can make your pet less haughty! Perfect for those arrogant individuals with unreasonable demands. [/color]\n\n[color=red]This option will lower slave's grade. [/color]",
price = 50,
confirm = "You leave $name in the custody of guild trainers, who will accustom $him to the less luxurious life. ",
},
spec = {
code = "spec",
name = "Specialization",
number = 6,
reqs = 'true',
description = "[color=yellow]— Specializations are a great way to make your servants possess new abilities and skills! As long as they meet the requirements at least... \n\nWe surely can change thier specialization as well![/color]",
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
	maintext.set_bbcode("This massive building takes a large part of the street. The Wimborn's Mage's Order is the centerpiece of your career achievments. Here you'll be able to buy necessary equipment and learn spells, assuming you are part of it of course.")
	if globals.state.mainquest <= 1:
		array.append({name = 'Seek Audience', function = 'mageorderquest1'})
	elif globals.state.mainquest == 2:
		array.append({name = 'Consult on further promotions',function = 'mageorderquest1'})
	elif globals.state.mainquest >= 3:
		array.append({name = 'Find Melissa', function = 'mageorderquest1'})
	if globals.state.rank >= 1:
		array.append({name = 'See available services',function = 'mageservices'})
	
	if globals.state.sidequests.emily == 12:
		array.append({name = "Visit Tisha's workplace", function = "tishaquest"})
	
	array.append({name = 'Return to city',function = 'town'})
	buildbuttons(array)

func tishaquest():
	if globals.state.sidequests.emily == 12:
		globals.events.tishadorms()
	elif globals.state.sidequests.emily == 13:
		globals.events.tishabackstreets()
	elif globals.state.sidequests.emily in [14,15]:
		globals.events.tishagornguild()

func mageorderquest1(slave = null):
	var buttons = []
	var text = ''
	var state = true
	var sprites = null
	questgiveawayslave = slave
	if globals.state.mainquest == 0:
		globals.state.mainquest = 1
		text = ("After some time you find a chancellor: a senior member responsible for accepting new applicants. You give a small knock to announce your presence, and the old man looks up from his paperwork with a sneer. You begin to introduce yourself, but he raises a hand to stop you.\n\n— Yes, yes, I already know who you are. You’ve been a hot topic these past few days, a trend that shall die soon, I’m sure. Allow me to hazard a guess, now that you’ve inherited that senile fool’s mansion, you’re here to apply for membership, correct? Well, I’ll have you know that I have no intention of shaming this institution, nor disgracing myself, by admitting a nameless imbecile such as yourself. Leave now, there are more important matters for me to attend to.\n\nHe returns to his work and waves his hand to shoo you away, but you came here for a purpose, and refuse to leave without seeing it fulfilled. You argue the case for your membership for several minutes; the chancellor growing visibly more frustrated with your presence every second you remain. Before long, he’s had enough of your filibustering and slams a hand on his desk.\n\n— Bah! If you so desperately want to gain membership, then so be it! If you can fulfil a simple request I've not had time to deal with, I shall consider your membership. Now, listen carefully, I will not repeat myself!\n\n— I’ve been looking for a secretary; one who is attractive, knows how to serve, and human. I would go to the Slave Guild for this, but my duties here rarely permit me the time. Bring me a girl who meets my criteria, and I shall accept your membership. Now leave, before I force you to.\n\n[color=green]Your main quest has been updated. [/color]")
	elif globals.state.mainquest == 1:
		if questgiveawayslave == null:
			text = "— Ah, you’ve returned, how very ‘wonderful’ of you. The arrangement has not been forgotten, provide me with what I want, and I’ll provide you with what you want."
			buttons.append(['Select Slave', 'selectslaveforquest', 'mageorderquest1'])
		else:
			slave = questgiveawayslave
			if slave.obed >= 90 && slave.race == 'Human' && slave.face.beauty >= 30 && slave.sex == 'female':
				text = "— Looks about right. Ready to part with her?"
				buttons.append(['Give away ' + slave.name, 'givecompanion'])
				buttons.append(['Select Slave', 'selectslaveforquest', 'mageorderquest1'])
			else:
				text = questgiveawayslave.dictionary("— Who do you take me for? $He does not meet the requirements.")
				buttons.append(['Select Slave', 'selectslaveforquest', 'mageorderquest1'])
	elif globals.state.mainquest == 2:
		sprites = [['melissafriendly','pos1','opac']]
		text = ("After a brief talk, the girl at the reception desk leads to you a room where you find an exquisitely dressed woman.\n\n— Oh, a new face here. I'm Melissa. I am pleased to know that there's a new person in our glorious establishment; and an active one too. Fresh blood is exactly what we need here in the Order.\n\n— First thing, it's great that you helped out our grumpy fellow with new staff. Let me compensate you for that. No worries, you earned it, and it should help your sustain and our cause. \n\n[color=green]Melissa passes you 250 gold. [/color]\n\n— Promotions are not very useful in terms of privileges for the commonfolk we have around, but for you it will grant access to some of the great knowledge and technology we have. I'd like to offer you a partnership. You help me, and I will push you up the stairs. How does that sound?")
		globals.resources.gold += 250
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
		if globals.state.laboratory < 1:
			text = text + "\n\n— Anyway, go set it up. You’ll need it  for your next task."
		else:
			text = text + "\n\n— You already have it? As I expected from someone as capable as you. Now, onto real business."
			globals.state.mainquest = 9
		if globals.state.mainquest == 9:
			buttons.append(["Continue", 'mageorderquest1'])
	elif globals.state.mainquest == 8 && globals.state.laboratory < 1:
		text = ("You decide it's unwise to return to Melissa until you set up your laboratory.")
	elif (globals.state.mainquest == 8 || globals.state.mainquest == 9) && globals.state.laboratory >= 1:
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
			if slave.race == 'Taurus' && slave.tits.size == 'huge' && slave.tits.lactation == true:
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
		buttons.append(['Close', "orderhade"])
		globals.state.mainquest = 17
	elif globals.state.mainquest == 25:
		globals.state.mainquest = 26
		sprites = [['melissafriendly','pos1','opac']]
		text = questtext.MainQuestUndercityReturn
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
			text = ("— Now that you are a member of the guild, I trust you’ll keep in mind that with status comes responsibility, and that you will not besmirch the guild’s name with your actions. As a neophyte, we have a variety of simple spells you may pay to learn. And, to repay an old debt to the fool you’re succeeding, I’ll teach you something basic for free. Mind Read is fairly simple and straightforward, allowing you limited insight into the subject’s thoughts and feelings. Much more informative than simply reading one’s expression and body language, but somewhat draining.\n\n[color=green]You are now a Neophyte in Mage guild.[/color]\n\n[color=green]You've learned a new spell: Mind Read. [/color]\n\n[color=green]Your main quest has been updated. [/color]\n[color=yellow]You have gained an extra level.[/color]")
			main.currentslave = globals.slaves.find(slave)
			globals.spelldict.mindread.learned = true
			if globals.abilities.abilitydict.has('mindread') == true:
				globals.player.ability.append('mindread')
			globals.state.branding = 1
			globals.state.rank = 1
			globals.player.level.value += 1
			globals.player.level.skillpoints += 1
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
			globals.player.level.value += 1
			globals.player.level.skillpoints += 1
			main.getridof()
	elif globals.state.mainquest == 10:
		globals.state.mainquest = 11
		sprites = [['melissafriendly','pos1']]
		text = ("— Splendid! You really are not held back by puny morals. I hope this will provide you with some useful information regarding the utilization of your servants. Now, if you’ll excuse me...\n\nWith that, your companion is taken away and you are promoted.[color=green] You are now an Adept in the Mage's Order.\n\nReceived 750 gold. [/color]\n[color=yellow]You have gained an extra level.[/color]")
		globals.state.rank = 3
		globals.resources.gold += 750
		main.currentslave = globals.slaves.find(slave)
		globals.player.level.value += 1
		globals.player.level.skillpoints += 1
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
		text = "— Marvelous! So here's the first thing we have on our hands. You likely know of the Brands and their utility. But those are the result of crude and very old work; surely anyone would want something much more efficient. For that, we have invented an upgrade to the old brands. They are generally referred to as 'Refined Brands' and are not very well known by the masses. The idea is pretty simple; to make the brand and branded person follow complex rules instead of just submissive basics. I can't overstate how amazingly useful it is, but those old fools at the council don't seem to bother.\n\n— The main issue is the magic essence, which is pretty hard to gather in large amounts as it is produced by fairies. Yeah, those shortstacks with childish behavior. Getting your hands on one seems to be getting harder and harder by the day. I want you to find me one, and in exchange I'll promote you, and share with you the knowledge of how to place a Refined Brand on a slave.\n\n— You will likely find fairies in the Far Eerie Woods or elven grove. It's a devilish looking place beyond the elven parts of the forest. That place is likely affected by a taint or some magical phenomenon that nobody can quite figure out. All of the creatures there seem to lose  their sentience and become hostile to outsiders. Fairies are not generally like that, so I figured you may be able to tame one if you get her out of there. If not, she'd still be useful to us. Now, if you’ll excuse me, I still have some affairs to attend to today. Be careful, honey.\n\n[color=green]Your main quest has been updated. [/color]"
	main.dialogue(true, self, text, buttons, sprites)


func mageservices():
	get_node("mageorderservices").set_hidden(false)

func _on_close_pressed():
	get_node("mageorderservices").set_hidden(true)


func _on_mageorderservices_visibility_changed():
	if get_node("mageorderservices").is_visible() == false:
		return
	var text = ''
	text = "Your library can help with studying and provide usful information.\n"
	if globals.state.library == 0:
		text = text + "Current level — 0. Upgrade cost — 500 gold. "
		if globals.resources.gold >= 500:
			get_node("mageorderservices/upgradelibrary").set_disabled(false)
		else:
			get_node("mageorderservices/upgradelibrary").set_disabled(true)
	elif globals.state.library == 1:
		text = text + "Current level — 1. Upgrade cost — 1000 gold. "
		if globals.resources.gold >= 1000:
			get_node("mageorderservices/upgradelibrary").set_disabled(false)
		else:
			get_node("mageorderservices/upgradelibrary").set_disabled(true)
	elif globals.state.library == 2:
		text = text + "Current level — 2. Upgrade cost — 1500 gold. "
		if globals.resources.gold >= 1500:
			get_node("mageorderservices/upgradelibrary").set_disabled(false)
		else:
			get_node("mageorderservices/upgradelibrary").set_disabled(true)
	elif globals.state.library == 3:
		text = text + "Current level — Max. "
		get_node("mageorderservices/upgradelibrary").set_disabled(true)
	get_node("mageorderservices/librarydescription").set_bbcode(text)
	text = "Your alchemy room can be used for brewing specialized potions.\n"
	if globals.state.alchemy == 0:
		text = text + "You have no any sort of alchemical equipment yet. Purchase cost — 500 gold. "
		if globals.resources.gold >= 500:
			get_node("mageorderservices/upgradealchemy").set_disabled(false)
		else:
			get_node("mageorderservices/upgradealchemy").set_disabled(true)
	elif globals.state.alchemy == 1:
		text = text + "You have basic alchemy tools set up. Upgrade cost — 1000 gold. "
		if globals.resources.gold >= 1000:
			get_node("mageorderservices/upgradealchemy").set_disabled(false)
		else:
			get_node("mageorderservices/upgradealchemy").set_disabled(true)
	elif globals.state.alchemy == 2:
		text = text + "You have advanced alchemical laboratory set up. "
		get_node("mageorderservices/upgradealchemy").set_disabled(true)
	get_node("mageorderservices/alchemydescription").set_bbcode(text)
	text = "Laboratory allows you to change and enhance yourself and other living beings.\n"
	if globals.state.laboratory == 0:
		text = text + "You have no laboratory equipment yet. Purchase cost — 1000 gold. "
		if globals.resources.gold >= 1000:
			get_node("mageorderservices/upgradelaboratory").set_disabled(false)
		else:
			get_node("mageorderservices/upgradelaboratory").set_disabled(true)
	elif globals.state.laboratory == 1:
		text = text + "You have basic functional laboratory. Upgrade cost — 3000 gold. "
		if globals.resources.gold >= 3000:
			get_node("mageorderservices/upgradelaboratory").set_disabled(false)
		else:
			get_node("mageorderservices/upgradelaboratory").set_disabled(true)
	elif globals.state.laboratory == 2:
		text = text + "You have advanced laboratory set up. "
		get_node("mageorderservices/upgradelaboratory").set_disabled(true)
	get_node("mageorderservices/laboratorydescription").set_bbcode(text)
	if globals.state.rank < 2:
		get_node("mageorderservices/upgradelaboratory").set_hidden(true)
		get_node("mageorderservices/laboratorydescription").set_hidden(true)
	else:
		get_node("mageorderservices/upgradelaboratory").set_hidden(false)
		get_node("mageorderservices/laboratorydescription").set_hidden(false)
	buildspelllist()

func buildspelllist():
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
	globals.resources.gold -= spell.price
	main.popup('You have learned new spell: ' + spell.name)
	spell.learned = true
	if globals.abilities.abilitydict.has(spell.code) == true:
		globals.player.ability.append(spell.code)
	buildspelllist()


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
#################### Markets
#
func market():
	get_node("charactersprite").set_hidden(true)
	main.background_set('market')
	if OS.get_name() != "HTML5" && globals.rules.fadinganimation == true:
		yield(main, 'animfinished')
	var text = "Densely populated area filled with stalls, small buildings and people allowing you to find anything for your daily life. "
	if globals.state.rank >= 3 && globals.state.sidequests.cali == 0:
		caliqueststart()
		return
	for slave in globals.slaves:
		if slave.work == 'store':
			text += slave.dictionary('\nYou can see $name helping around one of the shops.')
		elif slave.work == 'entertainer':
			text += slave.dictionary('\nYou spot $name giving minor performance at one of the corners. ')
	maintext.set_bbcode(text)
	var array = [{name = 'Market stalls', function = 'shopinitiate', args = 'wimbornmarket'}, {name = 'Carpentry', function = 'carpentry'}, {name = 'Return', function = 'town'}]
	if globals.state.mainquest == 5:
		array.insert(2, {name = 'Look for Sebastian', function = 'sebastian'})
	elif globals.state.mainquest >= 7:
		array.insert(2, {name = 'Visit Sebastian', function = 'sebastian'})
	buildbuttons(array)


func carpentry():
	var sleepers = globals.count_sleepers()
	get_node("carpenter/RichTextLabel4").set_bbcode('You have '+globals.fastif(sleepers.communal >= globals.state.rooms.communal, '[color=red]', '[color=green]') + str(globals.state.rooms.communal) + '[/color] beds in communal room, '+ globals.fastif(sleepers.personal >= globals.state.rooms.personal, '[color=red]', '[color=green]') + str(globals.state.rooms.personal) + '[/color] ' + globals.fastif(globals.state.rooms.personal > 1, 'personal rooms', 'personal room')+ ' available for living and your bed can fit ' +globals.fastif(sleepers['your_bed'] >= globals.state.rooms.bed, '[color=red]', '[color=green]') + str(globals.state.rooms.bed) + '[/color] ' +  globals.fastif(globals.state.rooms.personal > 1, 'persons', 'person')+' besides you. Your jail can hold up to ' +globals.fastif(sleepers.jail >= globals.state.rooms.jail, '[color=red]', '[color=green]') + str(globals.state.rooms.jail) +' [/color] prisoners. ')
	get_node("carpenter").set_hidden(false)
	if globals.resources.gold < 250 || globals.state.rooms.jail >= globals.state.roomscap.jail:
		get_node("carpenter/upgradejail").set_disabled(true)
	else:
		get_node("carpenter/upgradejail").set_disabled(false)
	if globals.resources.gold < 300 || globals.state.rooms.communal >= globals.state.roomscap.communal:
		get_node("carpenter/upgradecommunal").set_disabled(true)
	else:
		get_node("carpenter/upgradecommunal").set_disabled(false)
	if globals.resources.gold < 500 || globals.state.rooms.personal >= globals.state.roomscap.personal:
		get_node("carpenter/upgradepersonal").set_disabled(true)
	else:
		get_node("carpenter/upgradepersonal").set_disabled(false)
	if globals.resources.gold < 250 || globals.state.rooms.bed >= globals.state.roomscap.bed:
		get_node("carpenter/upgradebed").set_disabled(true)
	else:
		get_node("carpenter/upgradebed").set_disabled(false)
	if globals.state.farm == 2:
		get_node("carpenter/upgradefarm").set_hidden(false)
		get_node("carpenter/RichTextLabel5").set_hidden(false)
		if globals.resources.gold >= 650:
			get_node("carpenter/upgradefarm").set_disabled(false)
		else:
			get_node("carpenter/upgradefarm").set_disabled(true)
	else:
		get_node("carpenter/upgradefarm").set_hidden(true)
		get_node("carpenter/RichTextLabel5").set_hidden(true)


func _on_upgradecommunal_pressed():
	globals.state.rooms.communal += 2
	globals.resources.gold -= 300
	carpentry()

func _on_upgradepersonal_pressed():
	globals.state.rooms.personal += 1
	globals.resources.gold -= 500
	carpentry()

func _on_upgradejail_pressed():
	globals.state.rooms.jail += 1
	globals.resources.gold -= 250
	carpentry()

func _on_upgradebed_pressed():
	globals.state.rooms.bed += 1
	globals.resources.gold -= 250
	carpentry()

func _on_upgradefarm_pressed():
	globals.state.farm = 3
	globals.resources.gold -= 650
	carpentry()


func _on_carpenterleave_pressed():
	get_node("carpenter").set_hidden(true)
	market()

var shops = {
wimbornmarket = {code = 'wimbornmarket', name = "Wimborn's Market", items =  ['food','supply','basicsolutioning','hairdye', 'aphrodisiac' ,'beautypot', 'magicessenceing', 'natureessenceing','armorleather','armorchain','weapondagger','weaponsword','clothsundress','clothmaid','clothbutler','underwearlacy','underwearboxers'], selling = true},
shaliqshop = {code = 'shaliqshop', name = "Village's Trader", items = ['hairdye','beautypot','armorleather','clothmiko','clothkimono','clothninja'], selling = true},
gornmarket = {code = 'gornmarket', name = "Gorn's Market", items = ['food', 'supply','magicessenceing',"armorleather",'armorchain','weaponclaymore','clothbedlah','accslavecollar','acchandcuffs'], selling = true},
frostfordmarket = {code = 'frostfordmarket', name = "Frostford's Market", items = ['supply','basicsolutioning','bestialessenceing','clothpet', 'weaponsword','accgoldring'], selling = true},
aydashop = {code = 'aydashop', name = "Gorn's Alchemist", items = ['regressionpot', 'beautypot', 'hairdye', 'basicsolutioning','bestialessenceing','taintedessenceing','fluidsubstanceing'], selling = false},
amberguardmarket = {code = 'amberguardmarket', name = "Amberguard's Market", items = ['beautypot','bestialessenceing','magicessenceing','fluidsubstanceing'], selling = true},
}
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
	get_node("shoppanel/itempanel/buysellbutton/SpinBox").set_val(1)
	mode = 'buy'
	for i in itemlist.get_children():
		if i != itembutton:
			i.set_hidden(true)
			i.queue_free()
	
	get_node("shoppanel/itempanel/buysellbutton").set_text('Buy')
	get_node("shoppanel/itempanel/buysellbutton").set_hidden(true)
	get_node("shoppanel/itempanel/itemdescript").set_bbcode('')
	get_node("shoppanel/itempanel/iconbig").set_hidden(true)
	
	for i in currentshop.items:
		item = globals.itemdict[i]
		newbutton = itembutton.duplicate()
		newbutton.set_hidden(false)
		newbutton.get_node("price").set_text(str(item.cost))
		newbutton.get_node("amount").set_hidden(true)
		newbutton.set_tooltip(item.name)
		if item.icon != null:
			newbutton.get_node("icon").set_texture(item.icon)
		else:
			newbutton.get_node("icon").set_texture(null)
			newbutton.get_node("name").set_text(item.name)
			newbutton.get_node("name").set_hidden(false)
		itemlist.add_child(newbutton)
		newbutton.set_meta('item', item)
		newbutton.connect('pressed',self,'selectshopitem', [newbutton])

func shopsell():
	var item
	var newbutton
	var itemlist = get_node("shoppanel/itempanel/ScrollContainer/GridContainer")
	var itembutton = itemlist.get_node("Button")
	var array = []
	get_node("shoppanel/itempanel").set_hidden(false)
	get_node("shoppanel/Panel/buybutton").set_pressed(false)
	get_node("shoppanel/Panel/sellbutton").set_pressed(true)
	get_node("shoppanel/itempanel/itemdescript").set_bbcode('')
	get_node("shoppanel/itempanel/buysellbutton/SpinBox").set_val(1)
	mode = 'sell'
	for i in itemlist.get_children():
		if i != itembutton:
			i.set_hidden(true)
			i.queue_free()
	
	get_node("shoppanel/itempanel/buysellbutton").set_text('Sell')
	get_node("shoppanel/itempanel/buysellbutton").set_hidden(true)
	get_node("shoppanel/itempanel/iconbig").set_hidden(true)
	for item in globals.itemdict:
		array.append(item)
	
	array.sort_custom(get_parent().get_node("itemnode"),'sortbytype')
	
	
	for tempitem in array:
		var item = globals.itemdict[tempitem]
		if item.amount < 1 || item.type in ['gear','dummy']:
			continue
		newbutton = itembutton.duplicate()
		newbutton.set_hidden(false)
		newbutton.set_tooltip(item.name)
		newbutton.get_node("price").set_text(str(round(item.cost/5)))
		newbutton.get_node("amount").set_hidden(false)
		newbutton.get_node("amount").set_text(str(item.amount))
		if item.icon != null:
			newbutton.get_node("icon").set_texture(item.icon)
		else:
			newbutton.get_node("icon").set_texture(globals.noimage)
		itemlist.add_child(newbutton)
		newbutton.set_meta('item', item)
		newbutton.connect('pressed',self,'selectshopitem', [newbutton])
	for item in globals.state.unstackables.values():
		if item.owner == null:
			var tempitem = globals.itemdict[item.code]
			newbutton = itembutton.duplicate()
			newbutton.set_hidden(false)
			newbutton.set_tooltip(item.name)
			newbutton.get_node("price").set_text(str(round(tempitem.cost/5)))
			if item.icon != null:
				newbutton.get_node("icon").set_texture(item.icon)
			else:
				newbutton.get_node("icon").set_texture(null)
				newbutton.get_node("name").set_text(item.name)
				newbutton.get_node("name").set_hidden(false)
			itemlist.add_child(newbutton)
			newbutton.set_meta('item', tempitem)
			newbutton.set_meta('unstuck', item)
			newbutton.connect('pressed',self,'selectshopitem', [newbutton, item])

func selectshopitem(tempitem, unstuck = null):
	var text = ''
	var item = tempitem.get_meta("item")
	for i in get_node("shoppanel/itempanel/ScrollContainer/GridContainer").get_children():
		if i.is_pressed() == true && i != tempitem:
			i.set_pressed(false)
	tempitem.set_pressed(true)
	get_node("shoppanel/itempanel/iconbig").set_hidden(true)
	selecteditem = tempitem
	text = "[center]" + item.name + "[/center]\n"
	if mode == 'buy':
		text +=  "Price: [color=yellow]" + str(item.cost) + "[/color]"
	else:
		text +=  "Selling Price: [color=yellow]" + str(round(item.cost/5)) + "[/color]"
	if item.type != 'dummy' && item.type != 'gear':
		text += "\nIn Possession: " + str(item.amount)
	text += "\n\n" + item.description
	if item.type == 'gear':
		if item.icon != null:
			get_node("shoppanel/itempanel/iconbig").set_hidden(false)
			if typeof(item.icon) == TYPE_STRING:
				get_node("shoppanel/itempanel/iconbig").set_texture(globals.itemdict[item.code].icon)
			else:
				get_node("shoppanel/itempanel/iconbig").set_texture(item.icon)
		else:
			get_node("shoppanel/itempanel/iconbig").set_hidden(true)
		if item.effect.size() > 0:
			text += "\n\n[color=green]Effects: [/color]"
			for i in item.effect:
				text += '\n' + i.descript
	get_node("shoppanel/itempanel/itemdescript").set_bbcode(text)
	get_node("shoppanel/itempanel/buysellbutton").set_hidden(false)
	if mode == 'buy' && item.cost > globals.resources.gold:
		get_node("shoppanel/itempanel/buysellbutton").set_disabled(true)
	else:
		get_node("shoppanel/itempanel/buysellbutton").set_disabled(false)
	if mode == 'sell' && unstuck == null:
		if item.amount <= 0:
			shopsell()


func _on_buysellbutton_pressed():
	var item = selecteditem.get_meta("item")
	var amount = get_node("shoppanel/itempanel/buysellbutton/SpinBox").get_val()
	if mode == 'buy':
		if amount*item.cost > globals.resources.gold:
			get_parent().infotext("[color=red]Not enough gold[/color]")
			return
		if item.type != 'gear':
			item.amount += amount
		elif item.type == 'gear':
			var counter = amount
			while counter >= 1:
				var tmpitem = get_parent().get_node("itemnode").createunstackable(item.code)
				globals.state.unstackables[str(tmpitem.id)] = tmpitem
				counter -= 1
				get_parent().infotext("[color=green]Obtained: " + item.name + "[/color]")
		if item.code in ['food']:
			get_parent().get_node("itemnode").call(item.effect)
		else:
			globals.resources.gold -= item.cost*amount
		selectshopitem(selecteditem)
	elif mode == 'sell':
		if amount > item.amount && item.type != 'gear':
			get_parent().infotext("[color=red]Not enough items in possession[/color]")
			return
		if item.type != 'gear':
			item.amount -= amount
			globals.resources.gold += round(item.cost/5)*amount
			selecteditem.get_node('amount').set_text(str(item.amount))
		else:
			var tempitem = selecteditem.get_meta("unstuck")
			globals.resources.gold += round(item.cost/5)
			globals.state.unstackables.erase(tempitem.id)
		selectshopitem(selecteditem)


func shopclose():
	get_node("shoppanel").set_hidden(true)

####QUESTS

func caliqueststart(value = ''):
	var buttons = []
	var text = ''
	var sprites
	if typeof(value) != 4:
		globals.state.sidequests.cali = value
	#array.append(false)
	#array.append(self)
	if globals.state.sidequests.cali == 0:
		text = "As you walk by rows of traders you hear some noise and bunch of people gathering around.\n\n[color=yellow]— Let me go, you brute, I didn't do anything! — you hear girl's voice. [/color]\n\nAs you get closer, you notice a small dirty-looking halfkin wolf girl trying to break free from big man holding her.\n\n[color=aqua]— She's a thief! Everyone saw this! Why do they even let your kind roam around? You are no different from wild animals trying to hunt human flocks! [/color]\n\n[color=yellow]— Damn you, fat bastard! [/color]\n\nWith that girl tries to bite on hand holding her, but fails as her holder reacts to that and makes her struggling useless.\n\n[color=aqua]— Call the guards already! I still have stall to look after![/color]"
		buttons.append(["Intervene as a guild member",'caliqueststart', 1])
		buttons.append(["Ignore it",'caliqueststart', 10])
	elif globals.state.sidequests.cali == 1:
		text = ("You approach shop owner and tell him, that it is improper to stereotype on other races and it is guild's free will to welcome every other humanoid race. As he sees your badge, he quickly restrains himself and begs for pardon.\n\n[color=aqua]— She's a thief, Milord! She stolen big chunk of pork from me. Witnesses will confirm it. [/color]\n\nAs you look at the girl, she glares back but don't deny accusation. You notice that she looks pretty scrawny and is probably one of the homeless around town. By the law theft is a considerable offence and will result in flagellation.")
		if globals.resources.gold >= 50:
			buttons.append(["Offer compensation for her", 'caliqueststart', 2])
		buttons.append(["Offer to take her away for personal punishment", 'caliqueststart', 3])
		buttons.append(["Step away and leave it to guards", 'caliqueststart', 100])
		calimake()
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
		text = ("You share some food and ask her about her life.\n\n— Thanks for help... My name is Cali. I was captured from my village few weeks ago by bandits. They was about to sell me here but I managed to escape before they brought me to the guild. I have to get back home to my mother and brother... I hope they are alright.\n\nAfter few moments she says goodbye and prepares to leave.")
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
		sprites = [['calineutral', 'pos1','opac']]
	elif globals.state.sidequests.cali == 7:
		sprites = [['calihappy', 'pos1']]
	else:
		sprites = [['calineutral', 'pos1']]
	main.dialogue(false, self, text, buttons, sprites)

var cali

func calimake():
	var age = ''
	if globals.rules.children == true:
		age = 'child'
	else:
		age = 'teen'
	var calitemp = globals.slavegen.newslave('Halfkin Wolf', age, 'female', 'commoner')
	calitemp.name = 'Cali'
	calitemp.surname = 'Nuisal'
	calitemp.tits.size = 'flat'
	calitemp.ass = 'small'
	calitemp.face.beauty = 36
	calitemp.face.appeal = 20
	calitemp.hairlength = 'shoulder'
	calitemp.height = 'short'
	calitemp.haircolor = 'gray'
	calitemp.eyecolor = 'blue'
	calitemp.eyeshape = 'slit'
	calitemp.hairstyle = 'straight'
	calitemp.skin = 'fair'
	calitemp.imageportait = 'res://files/images/caliportrait.png'
	calitemp.pussy.virgin = true
	calitemp.pussy.first = 'none'
	calitemp.relatives.father = -1
	calitemp.relatives.mother = -1
	calitemp.obed += 65
	calitemp.unique = "Cali"
	calitemp.cleartraits()
	cali = calitemp

func sebastian():
	get_node("AnimationPlayer").play("show")
	get_node("charactersprite").set_hidden(false)
	setcharacter('sebastian')
	var array = [{name = 'Return',function = 'market'}]
	if globals.state.mainquest == 5:
		globals.state.mainquest = 6
		maintext.set_bbcode("After spending some time asking around, you finally find a shady looking warehouse, poorly decorated as some obscure workshop. Inside of it you meet a rather flamboyant man dressed head to toe in several layers of brightly colored clothing. He takes notice of your presence and comes to greet you, giving a flashy bow as he approaches. He speaks with a rather obvious accent, though you can’t quite place it.\n\n— Welcome, friend! Do I know you? We are not quite open to public you see...\n\nYou let him know that you are from Melissa and a part of the Mage's Order, at which he shines.\n\n— Oh, I see, Mister "+globals.player.name+"; a new face in our dependable government! I'm very pleased to meet you. Yes... about Melissa, I wanted to warn her but... It has been very rowdy these last few days... Yes, her elixir...\n\n— Well, sadly, I don't have it. Yes, I know I promised to get it last week, but our alchemist is lost... Not literally. He was experimenting with some new stuff he got his hands on and now he seems to have lost his senses; even spending too much time at the bar too...\n\n— Look, you are no stranger to working with magic, are you? Alchemy shouldn't be too much work either. Since you are in the Order, you must have a sizeable property. Why don't you get an alchemy kit and get milady what she wants? I'll share some formulas with you and you cover this up for me. I can see that you are a capable person.\n\nAfter some consideration, you agree with the offer, deciding that it will be a useful experience for your future researches.\n\n— Milady wants Youthing Elixir. No, I don't know why, and neither should you want to know. The thing allows you to reverse your aging a bit, which makes it very desirable with the ladies. You will need few rare ingredients to cook it, and I'll provide you those.[color=yellow] You should keep in mind though, nearly any magical potion will apply some toxicity to the subject's body, which may produce some nasty effects. I’m telling you this just in case you try to experiment. Try to keep the doses small, as toxicity will dissipate after some time. [/color]\n\n[color=green]Youthing Elixir recipe unlocked.\nMaturing Elixir recipe unlocked.[/color]")
		globals.itemdict.minoruspot.amount += 1
		globals.itemdict.magicessenceing.amount += 2
		globals.itemdict.youthingpot.unlocked = true
		globals.itemdict.maturingpot.unlocked = true
	elif globals.state.mainquest >= 7 && globals.state.farm == 0:
		globals.state.farm = 1
		maintext.set_bbcode("— Hey, "+globals.player.name+"! You took care of that little errand? Great, great! So what are you up to? Me? I'm working with not-so-easy-to-get merchandise. Since you're working with Melissa, I suppose you'd be interested as well! Yes, rare black market ingredients, mythical creatures, and forbidden magical devices; I tend to deal with many of those! Of course the service won't be cheap, as the rarity and legality is the main issue.\n\n— I can offer you one rare slave every couple of days, but I'll warn you: I only deal with rare species. Their obedience and branding is entirely up to you, so don't come back complaining if they bite you in your sleep!\n\nHe gives a mirthful chuckle.\n\n— Otherwise, a plesure doing business with you. I'll let you know when I get something in that might interest you. Speaking of which, I have one proposal which may interest you, as I heard you own a nice isolated place, and tend to keep slaves around to help you.")
	elif globals.state.mainquest >= 7:
		if globals.state.sebastianorder.taken == false:
			maintext.set_bbcode("— Glad to see you well, "+globals.player.name+"! How are you doing? Got a special order?")
		elif globals.state.sebastianorder.taken == true && globals.state.sebastianorder.duration != 0:
			maintext.set_bbcode("— Glad to see you well, "+globals.player.name+"! Your special order is not here yet, but worry not! Everything goes as planned. ")
		else:
			maintext.set_bbcode("— Oh, Come in, " + globals.player.name + "! Your special order has been waiting for you. ")
		if globals.resources.gold >= 100 && globals.state.sebastianorder.taken == false:
			array.insert(0, {name = 'Make a special request',function = 'sebastianorder'})
		elif globals.state.sebastianorder.taken == true && globals.state.sebastianorder.duration == 0:
			array.insert(0, {name = 'See special order', function = 'sebastianorder'})
		elif globals.state.sebastianorder.taken == false:
			maintext.set_bbcode(maintext.get_bbcode()+"[color=red]\nYou don't have enough gold to make request (100 needed)[/color]")
	if globals.state.farm == 1:
		array.insert(0, {name = 'Consult on proposal', function = 'sebastianfarm'})
	elif globals.state.farm == 3:
		array.insert(0, {name = 'Report on farm state', function = 'sebastianfarm'})
	if globals.state.sidequests.cali == 15 && globals.state.sidequests.calibarsex != 'sebastian':
		array.insert(0, {name = 'Ask Sebastian about mercenary', function = 'sebastiancaliquest'})
	buildbuttons(array)

func sebastiancaliquest():
	globals.state.sidequests.calibarsex = 'sebastian'
	main.dialogue(true,self,questtext.CaliBarAskSebastian)
	sebastian()

func sebastianorder():
	if globals.state.sebastianorder.taken == false:
		maintext.set_bbcode("— If you need someone of a specific race, I'll make sure to get one next time you come.  That will cost you 100 gold though. Money up front!")
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
		maintext.set_bbcode("After few moments, Sebastian presents to you a chained " + slave.race + slave.dictionary(" $child, who still looks pretty rebellious.\n\n— Got you what you asked for!\n\nYou slowly inspect $him.") + slave.description_full() + "\n\n-I would like to receive " + str(slave.calculateprice()) + slave.dictionary(" gold for my service. If you don't want $him, it's fine, since I can find another buyer in huge town like this."))
		buildbuttons(array)

func sebastianpay():
	var slave = globals.state.sebastianslave
	if globals.resources.gold >= slave.calculateprice():
		var effect = globals.effectdict.captured
		var dict = {'slave':0.7, 'poor':1,'commoner':1.2,"rich": 2, "noble": 4}
		effect.duration = round((4 + (slave.conf+slave.cour)/20) * dict[slave.origins])
		slave.add_effect(effect)
		slave.sleep = 'jail'
		globals.slaves = slave
		globals.resources.gold -= slave.calculateprice()
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
	globals.state.sebastianslave = globals.slavegen.newslave(globals.state.sebastianorder.race, 'random', 'random', caste[rand_range(0,caste.size())])
	maintext.set_bbcode("— "+race+", huh? Got ya! Come see me in "+ str(globals.state.sebastianorder.duration)+ " days and don't forget the coins! Those are not cheap after all. ")
	get_node("sebastiannode").set_hidden(true)
	var array = [{name = 'Leave', function = 'market'}]
	buildbuttons(array)
	

func _on_sebastiancancel_pressed():
	get_node("sebastiannode").set_hidden(true)
	market()

func sebastianfarm():
	var array = [{name = 'Return', function = 'market'}]
	if globals.state.farm == 1:
		maintext.set_bbcode("— Do you know about farms? No, not the rural kind. You can use girls to make milk. Truthfully speaking, I have some of the necessary gear on my hands. So, if you ever consider starting your own small business, I'll gladly sell it to you.\n\n— You would need some space for that first though. I'd recommend that you visit local builders. Once you’ve done that, come back for a deal.")
		globals.state.farm = 2
	elif globals.state.farm == 3:
		maintext.set_bbcode("— You are done with your preparations? Great, great! Now I'll pass you the rest of necessary equipment for 300 gold.")
		if globals.resources.gold >= 300:
			array.insert(0,{name = 'Purchase farm equipment', function = 'sebastianfarmpurchase'})
	buildbuttons(array)

func sebastianfarmpurchase():
	globals.state.farm = 4
	globals.resources.gold -= 300
	maintext.set_bbcode("— Pleased to have business with you!\n\n[color=yellow]Your mansion has now been fitted with an underground farm.[/color]\n\n— Oh, and by the way, that is not the only method to utilize your servants. Have you heard about giant snails? Their eggs are quite a delicacy, but they are really picky about where they lay them. I’ve heard that you can make them lay some in a human's orifices. — he slyly winks you — It looks like a human’s body temperature makes them attractive nests.")
	var array = [{name = 'Return', function = 'sebastian'}]
	buildbuttons(array)

################ backstreets
func backstreets():
	main.background_set('wimborn')
	maintext.set_bbcode("This part of town is populated by criminals and the poor. Brothel is located here. ")
	var array = [{name = 'Enter Brothel',function = 'brothel'}, {name = 'Return', function = 'town'}]
	if globals.state.sidequests.cali in [14,15,16]:
		array.insert(1,{name = "Visit local bar", function = "calibarquest"})
	if globals.state.sidequests.emily <= 1:
		maintext.set_bbcode(maintext.get_bbcode() + '\n\nYou see an urchin girl trying to draw your attention')
		array.insert(1,{name = 'Respond to the urchin girl', function = 'emily'})
	if globals.state.sidequests.emily == 13:
		array.insert(1,{name = 'Search Backstreets', function = 'tishaquest'})
	buildbuttons(array)

func emily(state = 1):
	var buttons = []
	var text = ''
	var sprites = null
	main.close_dialogue()
	globals.state.sidequests.emily = state
	if state == 1:
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
		var emily = globals.slavegen.newslave('Human', 'teen', 'female', 'poor')
		emily.name = 'Emily'
		emily.surname = 'Hale'
		emily.tits.size = 'small'
		emily.ass = 'small'
		emily.face.beauty = 20
		emily.face.appeal = 20
		emily.hairlength = 'neck'
		emily.height = 'average'
		emily.haircolor = 'brown'
		emily.eyecolor = 'gray'
		emily.hairstyle = 'straight'
		emily.pussy.virgin = true
		emily.pussy.first = 'none'
		emily.unique = 'Emily'
		emily.tags.append('nosex')
		emily.relatives.father = -1
		emily.relatives.mother = 2
		emily.imageportait = "res://files/images/emily/emilyportrait.png"
		emily.obed += 80
		emily.skin = 'pale'
		emily.cleartraits()
		globals.state.upcomingevents.append({code = 'tishaappearance',duration =7})
		globals.slaves = emily
		backstreets()
	elif state == 5:
		backstreets()
	elif state == 0:
		backstreets()


func brothel(slave = null):
	clearbuttons()
	var text = "Doorman greets you and shows you the way around brothel until you meet with the Madam.\n\n— Greetings, what would you like?  "
	for slave in globals.slaves:
		if slave.work == 'prostitution' || slave.work == 'escort' || slave.work == 'fucktoy':
			text = text + slave.dictionary('\nYou can see $name waiting for clients here.')
	maintext.set_bbcode(text)
	main.background_set('brothel')
	var array = [{name = 'Return', function = 'backstreets'}]
	if globals.state.sidequests.brothel == 0:
		array.insert(0,{name = 'Ask about letting your servants work here', function = 'brothelquest'})
	elif globals.state.sidequests.brothel == 1:
		if slave == null:
			array.insert(0,{name = 'Offer slave for quest', function = 'selectslavebrothelquest'})
		else:
			if slave.race in ['Elf','Dark Elf','Drow']:
				maintext.set_bbcode("— An elf, indeed. So, do you wanna trade?")
				array = [{name = 'Give away ' + slave.name,function = 'brothelquest'}, {name = 'Choose another slave', function = 'selectslavebrothelquest'}, {name = 'Leave', function = 'backstreets'}]
				questgiveawayslave = slave
			else:
				maintext.set_bbcode("— I don't think this is an Elf. Please, don't waste my time. ")
				array = [{name = 'Offer slave for quest', function = 'selectslavebrothelquest'},{name = 'Leave',function = 'backstreets'}]
				questgiveawayslave = null
	buildbuttons(array)

func selectslavebrothelquest():
	main.selectslavelist(true, 'brothel', self)

func brothelquest():
	var array = []
	if globals.state.sidequests.brothel == 0:
		maintext.set_bbcode("— Huh, you want to whore your employees? You don't expect me to provide such opportunity for free, do you? How about a deal? You bring me an elf girl and I will consider such option. Elves are really in demand pretty much every season. \n\n[color=green]You obtained new sidequest. [/color] ")
		array = [{name = 'Leave', function = 'backstreets'}]
		globals.state.sidequests.brothel = 1
	elif globals.state.sidequests.brothel == 1:
		globals.slaves.remove(globals.slaves.find(questgiveawayslave))
		maintext.set_bbcode("— Fine, you can send your servants to me and we'll offer them to clients. Keep in mind though we gonna keep some share of earnings for obvious reasons. Now we can't tell how much she'll made but I can give you few hints. Allure and endurance play some role here, but nothing can beat a sexually proactive girl who knows how to please her partner, especially if she has a pretty face.\n\n— Yeah, we'll keep her safe from possible aggression but don't blame on us if she decides to escape. We can't really watch her every movement. Although slaves rarely do that since they are basically outlaws at that point. \n\n[color=green]You have unlocked brothel as a workplace. [/color] ")
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


