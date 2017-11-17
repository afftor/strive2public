
extends Node

var test = File.new()
var testslaverace = globals.allracesarray
var testslaveage = 'random'
var testslavegender = 'random'
var testslaveorigin = ['slave','poor','commoner','rich','noble']
var currentslave = 0 setget currentslave_set
var selectedslave = -1
var texture = null
onready var slavepanel = get_node("MainScreen/slave_tab")

signal animfinished

func currentslave_set(value):
	currentslave = value
	get_node("itemnode").slave = globals.slaves[currentslave]
	get_node("spellnode").slave = globals.slaves[currentslave]

func _input(event):
	var anythingvisible = false
	for i in get_tree().get_nodes_in_group("blockmaininput"):
		if i.is_visible() == true:
			anythingvisible = true
			break
	if event.is_echo() == true || event.is_pressed() == false || anythingvisible || get_node("screenchange/AnimationPlayer").is_playing():
		if event.is_action_pressed("escape") == true && get_node("tutorialnode").is_visible() == true:
			get_node("tutorialnode").close()
		return
	if event.is_action_pressed("escape") == true && get_node("Navigation/menu").is_visible() == true:
		if get_node("FinishDayPanel").is_hidden() == false:
			get_node("FinishDayPanel").set_hidden(true)
			return
		if get_node("menucontrol").is_hidden() == true:
			_on_menu_pressed()
		else:
			if get_node("menucontrol/menupanel/SavePanel").is_hidden() == false:
				get_node("menucontrol/menupanel/SavePanel").set_hidden(true)
			_on_closemenu_pressed()
	
	if event.is_action_pressed("F") && get_node("Navigation/end").is_visible():
		_on_end_pressed()
	elif event.is_action_pressed("Q") && get_node("buttonpanel").is_visible():
		mansion()
	elif event.is_action_pressed("W") && get_node("buttonpanel").is_visible():
		jail()
	elif event.is_action_pressed("E") && get_node("buttonpanel").is_visible():
		libraryopen()
	elif event.is_action_pressed("A") && get_node("buttonpanel").is_visible() && !get_node("buttonpanel/VBoxContainer/alchemy").is_disabled():
		alchemy()
	elif event.is_action_pressed("S") && get_node("buttonpanel").is_visible() && !get_node("buttonpanel/VBoxContainer/laboratory").is_disabled():
		laboratory()
	elif event.is_action_pressed("Z") && get_node("buttonpanel").is_visible() && !get_node("buttonpanel/VBoxContainer/farm").is_disabled():
		farm()
	elif event.is_action_pressed("X") && get_node("buttonpanel").is_visible() && !get_node("buttonpanel/VBoxContainer/portals").is_disabled():
		portals()
	elif event.is_action_pressed("C") && get_node("buttonpanel").is_visible():
		leave()
	elif event.is_action_pressed("B") && get_node("buttonpanel").is_visible():
		_on_inventory_pressed()
	elif event.is_action_pressed("R") && get_node("buttonpanel").is_visible():
		_on_personal_pressed()
	elif event.is_action_pressed("V") && get_node("buttonpanel").is_visible():
		_on_combatgroup_pressed()
	elif event.is_action_pressed("L") && get_node("buttonpanel").is_visible():
		_on_questlog_pressed()


func _ready():
	get_node("music").set_meta('currentsong', 'none')
	set_process(true)
	if OS.get_executable_path() == 'C:\\Users\\1\\Desktop\\godot\\Godot_v2.1.3-stable_win64.exe':
		globals.developmode = true
		get_node("startcombat").set_hidden(false)
		get_node("new slave button").set_hidden(false)
		get_node("debug").set_hidden(false)
	_on_mansion_pressed()
	set_process_input(true)
	rebuildrepeatablequests()
	globals.resources.panel = get_node("ResourcePanel")
	if globals.player.name == '':
		#_on_leavenode_mouse_enter()
		globals.player = globals.newslave('Human', 'teen', 'male')
		globals.player.relatives.father = 0
		globals.player.relatives.mother = 0
		globals.player.ability.append('escape')
		globals.player.ability.append('acidspit')
		globals.player.abilityactive.append('escape')
		globals.player.abilityactive.append('acidspit')
		globals.state.supporter = true
#		for i in globals.charactergallery.values():
#			i.unlocked = true
#			i.nakedunlocked = true
#			for k in i.scenes:
#				k.unlocked = true
		_on_new_slave_button_pressed()
	rebuild_slave_list()
	get_node("itemnode").main = get_tree().get_current_scene()
	get_node("spellnode").main = get_tree().get_current_scene()
	get_node("birthpanel/raise/childpanel/child").connect('pressed', self, 'babyage', ['child'])
	get_node("birthpanel/raise/childpanel/teen").connect('pressed', self, 'babyage', ['teen'])
	get_node("birthpanel/raise/childpanel/adult").connect('pressed', self, 'babyage', ['adult'])
	#exploration
	get_node("explorationnode").buttoncontainer = get_node("outside/outsidebuttoncontainer")
	get_node("explorationnode").button = get_node("outside/outsidebuttoncontainer/buttontemplate")
	get_node("explorationnode").main = self
	get_node("explorationnode").outside = get_node('outside')
	globals.events.outside = get_node("outside")
	globals.resources.update()
	
	for i in get_tree().get_nodes_in_group("invcategories"):
		i.connect("pressed",self,"selectcategory",[i])
	
	for i in get_tree().get_nodes_in_group("mansionbuttons"):
		i.connect("pressed",self,i.get_name())
	
	for i in get_tree().get_nodes_in_group("spellbookcategory"):
		i.connect("pressed",self,'spellbookcategory',[i])
	
	if globals.state.tutorialcomplete == false && globals.resources.day == 1:
		get_node("tutorialnode").starttutorial()
	
	if globals.showalisegreet == true:
		alisegreet()
	if globals.gameloaded == false && globals.developmode == false:
		_on_buttonpanel_mouse_enter()
		get_node("buttonpanel/leavenode").set_hidden(true)
	elif globals.gameloaded == true:
		infotext("[color=green]Game Loaded.[/color]")



func _on_new_slave_button_pressed():
	globals.resources.day = 2
	for i in globals.state.tutorial:
		globals.state.tutorial[i] = true
	music_set('mansion')
	globals.state.capturedgroup.append(globals.newslave(testslaverace[rand_range(0,testslaverace.size())], testslaveage, testslavegender, testslaveorigin[rand_range(0,testslaveorigin.size())]))
	var slave = globals.newslave(testslaverace[rand_range(0,testslaverace.size())], testslaveage, testslavegender, testslaveorigin[rand_range(0,testslaveorigin.size())])
	slave.obed += 200
	slave.loyal += 100
	slave.xp += 9990
	slave.sexuals.affection = 200
	slave.consent = true
	#slave.sexuals.unlocked = true
	#for i in get_node("MainScreen/slave_tab/sexual").sexbuttons:
	#	slave.sexuals.actions[i] = 0
	slave.lust = 100
	#slave.tattoo.face = 'nature'
	slave.attention = 70
	slave.skillpoints = 100
	for i in ['conf','cour','charm','wit']:
		slave[i] = 100
	#slave.sexuals.unlocks.append('group')
	#slave.sexuals.unlocks.append('swing')
	slave.ability.append('debilitate')
	for i in globals.state.portals.values():
		i.enabled = true
	for i in globals.spelldict.values():
		i.learned = true
	for i in globals.itemdict.values():
		i.unlocked = true
		if !i.type in ['gear','dummy']:
			i.amount += 10
	globals.slaves = slave
	slave.stats.health_cur = 5
	globals.state.reputation.wimborn = 40
	globals.state.sidequests.maple = 1
	globals.player.ability.append("mindread")
	globals.player.abilityactive.append("mindread")
	globals.player.ability.append('heal')
	#globals.player.stats.maf_cur = 3
	globals.state.branding = 2
	globals.resources.gold += 100000
	globals.resources.food += 1000
	globals.resources.mana += 5
	globals.player.energy += 100
	globals.player.xp += 50
	globals.resources.upgradepoints += 100
	for i in ['armorchain','weaponclaymore','clothpet','clothninja','clothkimono']:
		var tmpitem = get_node("itemnode").createunstackable(i)
		globals.state.unstackables[str(tmpitem.id)] = tmpitem
	globals.state.sidequests.brothel = 1
	globals.state.sidequests.cali = 0
	#globals.state.decisions.append('')
	globals.state.rank = 3
	globals.state.mainquest = 0
	globals.state.farm = 3
	globals.state.mansionupgrades.mansionlab = 1
	globals.state.mansionupgrades.mansionalchemy = 1
	globals.state.mansionupgrades.mansionparlor = 1
	globals.state.backpack.stackables.bandage = 1
	for i in globals.characters.characters:
		slave = globals.characters.create(i)
		slave.loyal = 100
		slave.lust = 100
		globals.slaves = slave

func mansion():
	_on_mansion_pressed()

func jail():
	_on_jailbutton_pressed()

func libraryopen():
	_on_library_pressed()

func alchemy():
	_on_alchemy_pressed()

func laboratory():
	get_node("MainScreen/mansion/labpanel")._on_lab_pressed()

func farm():
	_on_farm_pressed()

func portals():
	_on_portals_pressed()

func leave():
	get_node("outside")._on_leave_pressed()

func _on_combatgroup_pressed():
	get_node("groupselectnode").show()



func getridof():
	var slave = get_tree().get_current_scene().currentslave
	if get_node("dialogue").is_visible():
		popup(globals.slaves[slave].dictionary("You've released $name and $he left your household. "))
		close_dialogue()
	globals.slaves.remove(slave)
	rebuild_slave_list()
	if get_node("MainScreen").is_visible():
		_on_nobutton_pressed()
		_on_mansion_pressed()

var showprisoners = false
var listinstance = load("res://files/listline.tscn")

func rebuild_slave_list():
	var node 
	var size = 0
	var slave
	var clear = find_node('slave_list').get_children()
	var slavelist = get_node("charlistcontrol/CharList/scroll_list/slave_list")
	var prison = 0
	var prisonlabel = get_node("charlistcontrol/CharList/scroll_list/slave_list/prisonlabel")
	for i in clear:
		if i != prisonlabel:
			i.queue_free()
			i.set_hidden(true)
	while globals.slaves.size() > size:
		slave = globals.slaves[size]
		if slave.sleep != 'jail' && slave.sleep != 'farm' && slave.away.duration == 0:
			node = listinstance.instance()
			node.set_meta('id', slave.id)
			node.set_meta('pos', size)
			slavelist.add_child(node)
			var text = slave.name_long()
			if slave.xp >= 100:
				text = text + "(+)"
			node.find_node('name').set_text(text)
			node.get_node('slavename/name').connect('pressed', self, 'openslavetab', [slave])
			node.find_node('health').set_normal_texture(slave.health_icon())
			node.find_node('healthvalue').set_text(str(round(slave.health)))
			node.find_node('obedience').set_normal_texture(slave.obed_icon())
			node.find_node('stress').set_normal_texture(slave.stress_icon())
			if slave.imageportait != null && File.new().file_exists(slave.imageportait) == true:
				node.find_node('portait').set_hidden(false)
				node.find_node('portait').set_texture(load(slave.imageportait))
			else:
				node.find_node('portait').set_hidden(true)
		elif slave.sleep == 'jail':
			prison += 1
		size += 1
	if prison >= 1:
		prisonlabel.set_hidden(false)
		slavelist.move_child(prisonlabel, get_node("charlistcontrol/CharList/scroll_list/slave_list").get_children().size()-1)
	else:
		prisonlabel.set_hidden(true)
	
	if showprisoners == false && prison >= 1:
		var label = Label.new()
		label.set_text("Your jail holds "+str(prison)+ " prisoner(s). ")
		slavelist.add_child(label)
	else:
		size = 0
		for i in globals.slaves:
			slave = i
			if slave.sleep == 'jail' && slave.away.duration == 0:
				node = load("res://files/listline.tscn").instance()
				node.set_meta('id', slave.id)
				node.set_meta('pos', size)
				slavelist.add_child(node)
				node.find_node('name').set_text(slave.name_long())
				node.get_node('slavename/name').connect('pressed', self, 'openslavetab', [slave])
				node.find_node('health').set_normal_texture(slave.health_icon())
				node.find_node('healthvalue').set_text(str(round(slave.health)))
				node.find_node('obedience').set_normal_texture(slave.obed_icon())
				node.find_node('stress').set_normal_texture(slave.stress_icon())
				if slave.imageportait != null && File.new().file_exists(slave.imageportait) == true:
					node.find_node('portait').set_hidden(false)
					node.find_node('portait').set_texture(load(slave.imageportait))
				else:
					node.find_node('portait').set_hidden(true)
			size += 1
	for slave in globals.slaves:
		if slave.sleep == 'farm':
			var label = Label.new()
			label.set_text(slave.name_long() + ' is assigned to your farm.')
			get_node("charlistcontrol/CharList/scroll_list/slave_list").add_child(label)
	
	
	
	for i in globals.slaves:
		slave = i
		if slave.away.duration != 0 && slave.away.at != 'hidden':
				var label = Label.new()
				label.set('font', load('res://mainfont.tres'))
				if slave.away.at == 'in labor':
					label.set_text(slave.name_long() + ' will be resting after labor for '+ str(slave.away.duration))
				elif slave.away.at == 'training':
					label.set_text(slave.name_long() + ' will be undergoing training for '+ str(slave.away.duration))
				elif slave.away.at == 'nurture':
					label.set_text(slave.name_long() + ' will be undergoing nurturing for '+ str(slave.away.duration))
				elif slave.away.at == 'growing':
					label.set_text(slave.name_long() + ' will keep maturing for '+ str(slave.away.duration))
				elif slave.away.at == 'lab':
					label.set_text(slave.name_long() + ' will be undergoing modification for '+ str(slave.away.duration))
				elif slave.away.at == 'rest':
					label.set_text(slave.name_long() + ' will be taking a rest for '+ str(slave.away.duration))
				else:
					label.set_text(slave.name_long() + ' will be unavailable for '+ str(slave.away.duration))
				if slave.away.duration == 1:
					label.set_text(label.get_text() + ' day.')
				else:
					label.set_text(label.get_text() + ' days.')
				get_node("charlistcontrol/CharList/scroll_list/slave_list").add_child(label)
	
	get_node("charlistcontrol/CharList/res_number").set_bbcode('[center]Residents: ' + str(globals.slaves.size())+'[/center]')
	get_node("ResourcePanel/population").set_text(str(globals.slavecount()))
	_on_orderbutton_pressed()

func openslavetab(slave):
	currentslave = globals.slaves.find(slave)
	get_node("MainScreen/slave_tab").set_hidden(true)
	get_node("MainScreen/slave_tab").set_hidden(false)

func _on_prisonbutton_pressed():
	showprisoners = !showprisoners
	rebuild_slave_list()

var enddayprocess = false

func _on_end_pressed():
	var text = ''
	var temp = ''
	var poorcondition = false
	var slave
	var count
	var chef
	var jailer
	var headgirl
	var labassist
	var farmmanager
	var workdict
	var text0 = get_node("FinishDayPanel/FinishDayScreen/Global Report")
	var text1 = get_node("FinishDayPanel/FinishDayScreen/Job Report")
	var text2 = get_node("FinishDayPanel/FinishDayScreen/Secondary Report")
	var start_gold = globals.resources.gold
	var start_food = globals.resources.food
	var start_mana = globals.resources.mana
	var deads_array = []
	var gold_consumption = 0
	var lacksupply = false
	var results = 'normal'
	enddayprocess = true
	_on_mansion_pressed()
	for i in range(globals.slaves.size()):
		if globals.slaves[i].away.duration == 0:
			if globals.slaves[i].work == 'cooking':
				chef = globals.slaves[i]
			elif globals.slaves[i].work == 'jailer':
				jailer = globals.slaves[i]
			elif globals.slaves[i].work == 'headgirl':
				headgirl = globals.slaves[i]
			elif globals.slaves[i].work == 'labassist':
				labassist = globals.slaves[i]
			elif globals.slaves[i].work == 'farmmanager':
				farmmanager = globals.slaves[i]
	
	globals.resources.day += 1
	text0.set_bbcode('')
	text1.set_bbcode('')
	text2.set_bbcode('')
	count = 0
	
	if globals.player.preg.duration >= 1:
		globals.player.preg.duration += 1
		if globals.player.preg.duration == 5:
			text0.set_bbcode(text0.get_bbcode() + "[color=yellow]You feel morning sickness. It seems you are pregnant. [/color]\n")
	
	for slave in globals.slaves:
		if slave.away.duration == 0:
			if slave.bodyshape == 'shortstack':
				globals.state.condition = -0.65
			elif slave.race in globals.monsterraces:
				globals.state.condition = -1.8
			elif slave.race.find('Beastkin') >= 0:
				globals.state.condition = -1.3
			else:
				globals.state.condition = -1.0
	
	for slave in globals.slaves:
		slave.metrics.ownership += 1
		var handcuffs = false
		for i in slave.gear.values():
				if !i in ['underwearplain','clothcommon'] && i != null:
					var tempitem = globals.state.unstackables[i]
					if tempitem.code in ['acchandcuffs']:
						handcuffs = true
		text = ''
		if slave.away.duration == 0:
			if slave.sleep != 'jail' && slave.sleep != 'farm':
				if slave.work in ['rest','forage','hunt','cooking','library','nurse','maid','storewimborn','artistwimborn','assistwimborn','whorewimborn','escortwimborn','fucktoywimborn', 'lumberer', 'ffprostitution','guardian', 'research', 'slavecatcher','fucktoy']:
					if slave.work != 'rest' && slave.energy < 30:
						text = "$name had no energy to fulfill $his duty and had to take a rest. \n"
						slave.health += 10
						slave.stress -= 20
					else:
						workdict = globals.jobs.call(slave.work, slave)
						if workdict.has('dead') && workdict.dead == true:
							deads_array.append({number = count, reason = workdict.text})
							continue
						if slave.traits.find("Clumsy") >= 0 && get_node("MainScreen/slave_tab").jobdict[slave.work].tags.find("physical"):
							if workdict.has('gold'):
								workdict.gold *= 0.7
							if workdict.has('food'):
								workdict.food *= 0.7
						for i in globals.state.reputation:
							if globals.state.reputation[i] < -10 && rand_range(0,100) < 33 && get_node("MainScreen/slave_tab").jobdict[slave.work].tags.find(i) >= 0:
								slave.obed -= max(abs(globals.state.reputation[i])*2 - slave.loyal/6,0)
								slave.loyal -= rand_range(1,3)
								text += "[color=red]$name has been influenced by local townfolk, which is hostile towards you. [/color]\n"
							elif globals.state.reputation[i] > 10 && rand_range(0,100) < 20:
								slave.obed += abs(globals.state.reputation[i])
								slave.loyal += rand_range(1,3)
								text += "[color=green]$name has been influenced by local townfolk, which is loyal towards you. [/color]\n"
						text = workdict.text
						if slave.spec == 'housekeeper' && slave.work in ['rest','chef','library','nurse','maid','headgirl','farmmanager','labassist','jailer']:
							globals.state.condition += (5.5 + (slave.sagi+slave.send)*6)/2
							text2.set_bbcode(text2.get_bbcode() + slave.dictionary("$name has managed to clean the mansion a bit while being around. \n"))
						if workdict.has("gold"):
							globals.resources.gold += workdict.gold
							slave.metrics.goldearn += workdict.gold
						if workdict.has("food"):
							globals.resources.food += workdict.food
							slave.metrics.foodearn += workdict.food
			text1.set_bbcode(text1.get_bbcode()+slave.dictionary(text))
			######## Counting food
			if globals.resources.food >= 5:
				slave.loyal += rand_range(0,1)
				slave.stress += rand_range(-5,-10)
				if slave.race == 'Fairy':
					slave.stress += rand_range(-10,-15)
				slave.health += rand_range(2,5)
				slave.obed += slave.loyal/5 - (slave.cour+slave.conf)/10
				if chef != null:
					var consumption = -10 + (chef.sagi + (chef.wit/20)/2)
					if chef.race == 'Scylla':
						consumption = consumption + 1
					globals.resources.food += consumption
				else:
					globals.resources.food -= 10
					
			else:
				slave.stress += 20
				slave.health -= rand_range(slave.stats.health_max/6,slave.stats.health_max/4)
				slave.obed += -max(35 - slave.loyal/3,10)
				if slave.health < 1:
					text = slave.dictionary('[color=red]$name has died of starvation.[/color]\n')
					deads_array.append({number = count, reason = text})
			if slave.obed < 25 && slave.cour >= 50 && slave.rules.silence == false && slave.traits.find('Mute') < 0 && slave.sleep != 'jail' && slave.sleep != 'farm' && slave.brand != 'advanced'&& rand_range(0,1) > 0.5:
				text0.set_bbcode(text0.get_bbcode()+slave.dictionary('$name dares to openly show $his disrespect towards you and instigates other servants. \n'))
				for ii in globals.slaves:
					if ii != slave && ii.loyal < 30 && ii.traits.find('Loner') < 0:
						ii.obed += -(slave.charm/3)
			if slave.obed < 50 && slave.loyal < 25 && slave.sleep != 'jail'&& slave.sleep != 'farm'&& slave.brand != 'advanced':
				if rand_range(0,3) < 1 && globals.resources.gold > 34:
					text0.set_bbcode(text0.get_bbcode()+slave.dictionary('You notice that some of your food is gone.\n'))
					globals.resources.food -= -rand_range(35,70)
				elif rand_range(0,3) < 1 && globals.resources.gold > 19:
					text0.set_bbcode(text0.get_bbcode()+slave.dictionary('You notice that some of your gold is missing.\n'))
					globals.resources.gold -= rand_range(20,40)
			if slave.obed < 25 && slave.sleep != 'jail' && slave.sleep != 'farm' && slave.tags.has('noescape') == false:
				var escape = 0
				var stay = 0
				if slave.brand == 'none':
					escape = slave.cour/3+slave.wit/3+slave.stress/2
					stay = slave.loyal*2+slave.obed
				else:
					escape = slave.cour/4+slave.stress/4
					stay = slave.loyal*2+slave.obed+slave.wit/5
				
				if globals.state.mansionupgrades.mansionkennels == 1:
					escape *= 0.8
				if escape > stay:
					if handcuffs == false:
						var temptext = slave.dictionary('[color=red]$name has escaped during the night![/color]\n')
						deads_array.append({number = count, reason = temptext})
					else:
						text0.set_bbcode(text0.get_bbcode()+slave.dictionary('[color=red]$name attempted to escape during the night but being handcuffed slowed them down and they were quickly discovered![/color]\n'))
			#sleep conditions
			slave.lust = round(rand_range(3,8))
			if slave.sleep == 'communal' && globals.count_sleepers()['communal'] > globals.state.mansionupgrades.mansioncommunal:
				slave.stress += rand_range(5,15)
				slave.health -= rand_range(1,5)
				text2.set_bbcode(text2.get_bbcode() + slave.dictionary('$name suffers from communal room being overcrowded.\n'))
			elif slave.sleep == 'communal':
				slave.stress += -rand_range(5,10)
				slave.health += rand_range(1,3)
				slave.energy += rand_range(20,30)+ slave.stats.end_cur*6
			elif slave.sleep == 'personal':
				slave.stress += rand_range(-10,-15)
				slave.health += rand_range(2,6)
				slave.energy += rand_range(40,50)+ slave.stats.end_cur*6
				text2.set_bbcode(text2.get_bbcode() + slave.dictionary('$name sleeps in a private room, which helps $him heal faster and provides some stress relief.\n'))
				if slave.lust >= 50 && slave.rules.masturbation == false && slave.tags.find('nosex') < 0:
					slave.lust = rand_range(-10,-15)
					text2.set_bbcode(text2.get_bbcode() + slave.dictionary('In an attempt to calm $his lust, $he spent some time busying $himself in feverish masturbation, making use of $his private room.\n'))
			elif slave.sleep == 'your':
				slave.loyal += rand_range(1,4)
				slave.energy += rand_range(25,45)+ slave.stats.end_cur*6
				slave.sexuals.affection += round(rand_range(1,2))
				if slave.loyal > 30:
					slave.stress -= slave.loyal/7
				if slave.lust > 40 && slave.sexuals.unlocked == true && slave.pussy.virgin == false && slave.tags.find('nosex') < 0:
					text2.set_bbcode(text2.get_bbcode() + slave.dictionary('$name went down on you being unable to calm $his lust.\n'))
					slave.lust = -rand_range(10,15)
					slave.metrics.sex += 1
					globals.resources.mana += 2
					globals.impregnation(slave, globals.player)
				else:
					text2.set_bbcode(text2.get_bbcode() + slave.dictionary('$name keeps you company at night and you grew closer.\n'))
			elif slave.sleep == 'jail':
				slave.metrics.jail += 1
				slave.obed += 25 - slave.conf/6
				slave.energy += rand_range(20,30) + slave.stats.end_cur*6
				if slave.stress > 30:
					slave.stress -= rand_range(5,10)
				else:
					if globals.state.mansionupgrades.jailtreatment == 0:
						slave.stress += slave.conf/10
			if slave.lust >= 90 && slave.rules.masturbation == true && slave.traits.find('Sex-crazed') < 0 && (rand_range(0,10)>7 || slave.effects.has('stimulated')):
				slave.add_trait('Sex-crazed')
				text0.set_bbcode(text0.get_bbcode() + slave.dictionary("[color=yellow]Left greatly excited and prohibited from masturbating, $name desperate state led $him to become insanely obsessed with sex.[/color]\n"))
			#Races
#			if slave.race == 'Elf':
#				slave.dom = -200
#				slave.dom = slave.conf
			elif slave.race == 'Orc':
				slave.health += 15
			elif slave.race == 'Slime':
				slave.toxicity = -200
			#Traits
			if slave.traits.find("Uncivilized") >= 0:
				for i in globals.slaves:
					if i.spec == 'tamer' && (i.work == slave.work || i.work in ['rest','headgirl','jailer']):
						slave.obed += 30
						slave.loyal += 5
						if rand_range(0,100) < 10:
							slave.trait_remove("Uncivilized")
							text0.set_bbcode(text0.get_bbcode() + i.dictionary("[color=green]$name managed to lift ") + slave.dictionary("$name out of $his wild behavior and turn into a socially functioning person.[/color]\n "))
			if slave.traits.find("Clingy") >= 0 && slave.attention > 75 && rand_range(0,2) > 1:
				slave.obed -= rand_range(10,30)
				slave.loyal -= rand_range(1,5)
				text0.set_bbcode(text0.get_bbcode() + slave.dictionary("[color=yellow]$name is annoyed by you paying no attention to $him. [/color]\n"))
			if slave.traits.find('Pliable') >= 0:
				if slave.sexuals.affection >= 90:
					slave.trait_remove('Pliable')
					slave.add_trait('Devoted')
					text0.set_bbcode(text0.get_bbcode() + slave.dictionary('[color=green]$name has become Devoted. $His willpower strengthened.[/color]\n'))
				elif slave.sexuals.actions.size() >= 12:
					slave.trait_remove('Pliable')
					slave.add_trait('Slutty')
					text0.set_bbcode(text0.get_bbcode() + slave.dictionary('[color=green]$name has become Slutty. $His willpower strengthened.[/color]\n'))
			#Rules and clothes effect
			if slave.rules.contraception == true:
				if globals.resources.gold >= 5:
					globals.resources.gold -= 5
					slave.preg.fertility = max(slave.preg.fertility - rand_range(10,15), 0)
					gold_consumption += 5
				else:
					text0.set_bbcode(text0.get_bbcode()+slave.dictionary("[color=red]You could't afford to provide $name with contraceptives.[/color]\n"))
			if slave.rules.aphrodisiac == true:
				var value
				if slave.spec != 'housekeeper':
					value = 8
				else:
					value = 4
				if globals.resources.gold >= value:
					globals.resources.gold -= value
					slave.lust = rand_range(10,15)
					gold_consumption += value
				else:
					text0.set_bbcode(text0.get_bbcode()+slave.dictionary("[color=red]You could't supply $name's food with aphrodisiac.[/color]\n"))
			if slave.rules.silence == true:
				if slave.cour > 40:
					slave.cour += -rand_range(3,5)
				slave.obed += rand_range(5,10)
			if slave.rules.pet == true:
				if slave.conf > 25:
					slave.conf -= rand_range(5,10)
				if slave.charm > 25:
					slave.charm += -rand_range(4,8)
				slave.obed += rand_range(8,15)
			if slave.rules.nudity == true:
				if slave.conf > 50:
					slave.conf -= rand_range(2,4)
			
			
			if slave.punish.expect == true:
				slave.punish.strength = -1
				slave.obed += 15-slave.cour/10
				if slave.punish.strength <= 0:
					slave.punish.expect = false
			if slave.praise > 0:
				slave.praise -= 1
				slave.obed += rand_range(5,10)
			for i in slave.gear.values():
				if !i in ['underwearplain','clothcommon'] && i != null:
					var tempitem = globals.state.unstackables[i]
					for k in tempitem.effects:
						if k.type == 'onendday':
							text2.set_bbcode(text2.get_bbcode() + slave.dictionary(get_node("itemnode").call(k.effect, slave)))
			if slave.toxicity > 0:
				if slave.toxicity > 35 && rand_range(0,10) > 6.5:
					slave.stress += rand_range(10,15)
					slave.health -= rand_range(10,15)
					text2.set_bbcode(text2.get_bbcode() + slave.dictionary("$name suffers from magical toxicity.\n"))
				if slave.toxicity > 60 && rand_range(0,10) > 7.5:
					get_node("spellnode").slave = slave
					text0.set_bbcode(text0.get_bbcode()+get_node("spellnode").mutate(slave.toxicity/30, true) + "\n\n")
				slave.toxicity = -rand_range(1,5)
			if slave.gear.armor == null && slave.gear.costume == null:
				slave.obed += rand_range(10,20)
				if slave.traits.find('Pervert') >= 0 && slave.traits.find('Sex-crazed') < 0 && slave.conf > 40:
					slave.stress += rand_range(10,15)
					text2.set_bbcode(text2.get_bbcode() + slave.dictionary("Your denial of upper clothing to $name causes $him to take you more seriously, but $he certainly is stressed out having to walk around almost naked.\n"))
				else:
					text2.set_bbcode(text2.get_bbcode() + slave.dictionary("Your denial of upper clothing to $name causes $him to take you more seriously, however, it does not seem that $he's feels too bothered about being almost naked.\n"))
			if slave.gear.underwear == null:
				slave.lust = rand_range(5,10)
				if slave.traits.find('Pervert') < 0 && slave.traits.find('Sex-crazed') < 0:
					slave.obed -= rand_range(10,20)
					text2.set_bbcode(text2.get_bbcode() + slave.dictionary("Wearing no underwear causes $name to become more open to dirty behavior, although $he does not seem to be very happy about it.\n"))
				else:
					text2.set_bbcode(text2.get_bbcode() + slave.dictionary("Wearing no underwear causes $name to become more open to dirty behavior, but $he seems to accept it surprisingly well.\n"))
			if slave.stress > 80 && slave.sleep != 'jail' && slave.sleep != 'farm' && slave.away.duration < 1:
				text0.set_bbcode(text0.get_bbcode() + slave.dictionary("$name complained "+globals.fastif(headgirl == null, "to you, ", "to your headgirl, ")+"that $he's having it too hard and hoped to get some rest.\n"))
			if slave.stress >= 100 && slave.cour+slave.conf+slave.wit+slave.charm > 50:
				text0.set_bbcode(text0.get_bbcode() + slave.dictionary("[color=red]$name had a severe mental breakdown due to high stress.[/color] \n"))
				slave.cour += -rand_range(5,slave.cour/4)
				slave.conf += -rand_range(5,slave.conf/4)
				slave.wit += -rand_range(5,slave.wit/4)
				slave.charm += -rand_range(5,slave.charm/4)
				if slave.effects.has('captured') == true:
					slave.add_effect(globals.effectdict.captured, true)
				slave.health -= rand_range(0,slave.stats.health_max/6)
			if slave.skillpoints == -1:
				slave.skillpoints = 0
			if slave.attention < 150 && slave.sleep != 'your':
				slave.attention += rand_range(5,7)
			if slave.preg.duration > 0:
				slave.preg.duration += 1
				if slave.health < 20 && rand_range(0,100) > slave.health*2:
					text0.set_bbcode(text0.get_bbcode()+slave.dictionary('[color=red]Due to poor health condition, $name had a miscarriage and lost $his child.[/color]\n'))
					slave.preg.baby = null
					slave.preg.duration = 0
					slave.stress += rand_range(35,50)
				if slave.race == 'Goblin':
					if slave.preg.duration > 5:
						slave.tits.lactation = true
						if headgirl != null:
							if slave.preg.duration == 6:
								text0.set_bbcode(text0.get_bbcode() + headgirl.dictionary('[color=yellow]$name reports, that ') + slave.dictionary('$name appears to be pregnant. [/color]\n'))
							elif slave.preg.duration == 12:
								text0.set_bbcode(text0.get_bbcode() + headgirl.dictionary('[color=yellow]$name reports, that ') + slave.dictionary('$name will likely give birth soon. [/color]\n'))
				else:
					if slave.preg.duration > 10:
						slave.tits.lactation = true
						if headgirl != null:
							if slave.preg.duration == 11:
								text0.set_bbcode(text0.get_bbcode() + headgirl.dictionary('[color=yellow]$name reports, that ') + slave.dictionary('$name appears to be pregnant. [/color]\n'))
							elif slave.preg.duration == 23:
								text0.set_bbcode(text0.get_bbcode() + headgirl.dictionary('[color=yellow]$name reports, that ') + slave.dictionary('$name will likely give birth soon. [/color]\n'))
				if rand_range(0,100) < 40:
					slave.stress += rand_range(15,20)
			if slave.away.duration == 0 && !slave.sleep in ['jail','farm']:
				var slaveluxury = slave.calculateluxury()
				var luxurycheck = slave.countluxuty()
				var luxury = luxurycheck.luxury
				gold_consumption += luxurycheck.goldspent
				if luxurycheck.nosupply == true:
					lacksupply = true
				if luxury < slaveluxury && slave.metrics.ownership - slave.metrics.jail > 7 :
					slave.loyal -= (slaveluxury - luxury)/2.5
					slave.obed -= (slaveluxury - luxury)
					text0.set_bbcode(text0.get_bbcode() + slave.dictionary("[color=red]$name appears to be rather unhappy about quality of $his life and demands better living conditions from you. [/color]\n"))
		elif slave.away.duration > 0:
			slave.away.duration -= 1
			if slave.away.duration == 0 && slave.away.at == 'lab' && slave.health < 5:
				var temptext = "$name has not survived the laboratory operation due to poor health."
				deads_array.append({number = count, reason = temptext})
			elif slave.away.duration == 0:
				slave.away.at = ''
				text0.set_bbcode(text0.get_bbcode() + slave.dictionary("$name returned to the mansion and went back to $his duty. \n"))
		for i in slave.effects.values():
			if i.has('duration') && i.code != 'captured':
				if slave.race != 'Dark Elf' || rand_range(0,1) > 0.5: 
					i.duration -= 1
				if i.duration <= 0:
					slave.add_effect(i, true)
			elif i.has('duration'):
				i.duration -= 1
				if slave.sleep == 'jail' && globals.state.mansionupgrades.jailincenses == 1 && rand_range(0,100) >= 50:
					i.duration -= 1
				if slave.brand != 'none':
					i.duration -= 1
				if i.duration <= 0:
					if i.code == 'captured':
						text0.set_bbcode(text0.get_bbcode() + slave.dictionary('$name grew accustomed to your ownership.\n'))
					slave.add_effect(i, true)
		count+=1
	if headgirl != null && globals.state.headgirlbehavior != 'none':
		headgirl.conf += rand_range(1,4)
		var headgirlconf = headgirl.conf
		if headgirl.spec == 'executor':
			headgirlconf = 100
		for i in globals.slaves:
			if i != headgirl && i.traits.find('Loner') < 0 && i.away.duration < 1 && i.sleep != 'jail' && i.sleep != 'farm':
				headgirl.xp += 3
				if i.obed < 65 && globals.state.headgirlbehavior == 'strict':
					var obedbase = i.obed
					i.obed += (-(i.cour/15) + headgirlconf/3)
					i.stress += rand_range(5,10)
					if i.obed <= obedbase:
						text0.set_bbcode(text0.get_bbcode() + i.dictionary('$name was acting frivolously. ') + headgirl.dictionary('$name tried to put ') + i.dictionary("$him in place, but failed to make any impact.\n\n"))
					else:
						text0.set_bbcode(text0.get_bbcode() + i.dictionary('$name was acting frivolously, but ') + headgirl.dictionary('$name managed to make ') + i.dictionary("$him submit to your authority and slightly improve $his behavior.\n\n"))
				elif globals.state.headgirlbehavior == 'kind':
					if rand_range(0,100) < headgirl.charm:
						i.loyal += rand_range(1,3)
					i.stress += -(headgirl.charm/6)
	if jailer != null:
		jailer.conf += rand_range(1,4)
		var jailerconf = jailer.conf
		if jailer.spec == 'executor':
			jailerconf = 100
		for slave in globals.slaves:
			if slave.sleep == 'jail':
				jailer.xp += 5
				slave.health += round(jailer.wit/10)
				slave.obed += round(jailer.charm/8)
				if slave.effects.has('captured') == true && jailerconf-30 >= rand_range(0,100):
					slave.effects.captured.duration -= 1
	if farmmanager != null:
		var farmconf = farmmanager.conf
		if farmmanager.spec == 'executor':
			farmconf = 100
		for slave in globals.slaves:
			if slave.sleep == 'farm':
				var production = 0
				if slave.work == 'cow' && slave.tits.size != 'masculine':
					production = rand_range(0,15) + 18*globals.sizearray.find(slave.tits.size)
					if slave.tits.developed == true:
						production = production + production * (0.33 * slave.tits.extrapairs)
					if slave.race == 'Taurus':
						production = production*1.2
				elif slave.work == 'hen':
					production = rand_range(50,100)
					if slave.pussy.has == true:
						production = production + 50
					if slave.race == 'Harpy':
						production = production*1.2
				production = production * (0.4 + farmmanager.wit * 0.004 + farmconf * 0.002)
				if globals.state.mansionupgrades.farmtreatment == 0:
					slave.stress += 50 - (0.25*farmmanager.charm)
				if slave.farmoutcome == false:
					globals.resources.food += production
					slave.metrics.foodearn += round(production)
					text1.set_bbcode(text1.get_bbcode()+slave.dictionary('$name produced ') + str(round(production))+ ' units worth of food.\n')
				else:
					globals.resources.gold += round(production/2)
					slave.metrics.goldearn += round(production/2)
					text1.set_bbcode(text1.get_bbcode()+slave.dictionary('$name produced valueables worth of ') + str(round(production/2))+ ' gold.\n')
	#####          Dirtiness
	if globals.state.condition <= 40:
		for slave in globals.slaves:
			if slave.away.duration != 0:
				continue
			if globals.state.condition >= 30 && rand_range(0,10) >= 7:
				slave.stress += rand_range(5,15)
				slave.obed += -rand_range(15,20)
				text0.set_bbcode(text0.get_bbcode() + slave.dictionary("[color=yellow]$name was distressed by mansion's poor condition. [/color]\n"))
			elif globals.state.condition >= 15 && rand_range(0,10) >= 5:
				slave.stress += rand_range(10,25)
				slave.obed += -rand_range(15,35)
				text0.set_bbcode(text0.get_bbcode() + slave.dictionary("[color=yellow]$name was distressed by mansion's poor condition. [/color]\n"))
			elif rand_range(0,10) >= 4:
				slave.stress += rand_range(25,30)
				slave.health -= rand_range(5,10)
				text0.set_bbcode(text0.get_bbcode() + slave.dictionary("[color=red]Mansion's terrible condition causes $name a lot of stress and impacted $his health. [/color]\n"))
	#####          Outside Events
	for i in globals.guildslaves:
		for slave in globals.guildslaves[i]:
			count = 0
			if rand_range(0,100) < 20:
				globals.guildslaves[i].remove(count)
			count += 1
		if globals.guildslaves[i].size() < 4:
			get_node("outside").newslaveinguild(1, i)
		if globals.guildslaves[i].size() < 6 && rand_range(0,100) > 25:
			get_node("outside").newslaveinguild(1, i)
	
	
	if globals.state.sebastianorder.duration > 0:
		globals.state.sebastianorder.duration -= 1
		if globals.state.sebastianorder.duration == 0:
			text0.set_bbcode(text0.get_bbcode() + "[color=green]Sebastian should have your order ready by this time. [/color]\n")
	globals.state.groupsex = true
	
	if globals.state.mansionupgrades.foodpreservation == 0 && globals.resources.food >= globals.resources.foodcaparray[globals.state.mansionupgrades.foodcapacity]*0.80:
		globals.resources.food -= globals.resources.food*0.03
		text0.set_bbcode(text0.get_bbcode() + '[color=yellow]Some of your food reserves have spoiled.[/color]\n')
	
	if globals.resources.food >= 5:
		if chef != null: 
			globals.resources.food -= (10 - (chef.sagi + (chef.wit/20)/2))
		else:
			globals.resources.food -= 10
	else:
		if globals.resources.gold < 5:
			get_node("gameover").set_hidden(false)
			get_node("gameover/Panel/text").set_bbcode("[center]With no food and money your mansion falls in chaos. \nGame over.[/center]")
		else:
			globals.resources.gold -= 20
			text0.set_bbcode(text0.get_bbcode()+ "[color=red]You have no food in the mansion and left dining at town, paying 20 gold in process.[/color]\n")
	
	for i in globals.state.repeatables:
		for ii in globals.state.repeatables[i]:
			temp = ii.difficulty
			var removed = false
			if ii.time >= 0 && ii.taken == true:
				ii.time -= 1
			elif rand_range(0,10) < 0 && ii.taken == false:
				removed = true
				globals.state.repeatables[i].remove(globals.state.repeatables[i].find(ii))
			if ii.time < 0:
				removed = true
				text0.set_bbcode(text0.get_bbcode() + '[color=red]You have failed to complete your quest at ' + ii.location.capitalize() +'.[/color]\n')
				globals.state.repeatables[i].remove(globals.state.repeatables[i].find(ii))
	
	if int(globals.resources.day)%5 == 0.0:
		rebuildrepeatablequests()
	
	if globals.player.xp >= 100:
		globals.player.xp -= 100
		globals.player.value += 1
		globals.player.skillpoints += 1
		text0.set_bbcode(text0.get_bbcode() + '[color=green]You have leveled up and earned an additional skillpoint. [/color]\n')
	
	if globals.player.preg.duration > 10:
		globals.player.energy += 60
	else:
		globals.player.energy += 100
	globals.player.health += 50
	
	#####         Results
	if start_gold < globals.resources.gold:
		results = 'good'
		text = 'Your residents earned [color=yellow]' + str(globals.resources.gold - start_gold) + '[/color] gold by the end of day. \n'
	elif start_gold == globals.resources.gold:
		results = 'med'
		text = "By the end of day your gold reserve didn't change. "
	else:
		results = 'bad'
		text = "By the end of day your gold reserve shrunk by [color=yellow]" + str(start_gold - globals.resources.gold) + "[/color] pieces. "
	if start_food > globals.resources.food:
		text = text + 'Your food storage shrank by [color=aqua]' + str(start_food - globals.resources.food) + '[/color] units of food.\n'
	else:
		text = text + 'Your food storage grew by [color=aqua]' + str(globals.resources.food - start_food) + '[/color] units of food.\n'
	text0.set_bbcode(text0.get_bbcode() + text)
	if deads_array.size() > 0:
		results = 'worst'
		deads_array.invert()
		for i in deads_array:
			globals.slaves.remove(i.number)
			text0.set_bbcode(text0.get_bbcode() + i.reason + '\n')
	text0.set_bbcode(text0.get_bbcode()+ "[color=yellow]" +str(round(gold_consumption))+'[/color] gold was used for various tasks.\n'  )
	get_node("FinishDayPanel/FinishDayScreen").set_current_tab(0)
	aliseresults = results
	if lacksupply == true:
		text0.set_bbcode(text0.get_bbcode()+"[color=red]You have expended your supplies and some of the actions couldn't be finished. [/color]\n")
	enddayprocess = false
	dailyevent = false
	nextdayevents()

var aliseresults
var checkforevents = false

func nextdayevents():
	var player = globals.player
	if player.preg.duration > 30 && player.preg.baby != null:
		childbirth(player)
		get_node("FinishDayPanel").set_hidden(true)
		return
	for i in globals.slaves:
		if i.preg.baby != null && (i.preg.duration > 30 || (i.race == 'Goblin' && i.preg.duration > 16)):
			if i.race == 'Goblin':
				i.away.duration = 2
			else:
				i.away.duration = 3
			i.away.at = 'in labor'
			childbirth(i)
			get_node("FinishDayPanel").set_hidden(true)
			return
	for i in globals.state.upcomingevents:
		if i.duration > 0:
			i.duration -= 1
		if i.duration <= 0:
			var text = globals.events.call(i.code)
			if text != null:
				get_node("FinishDayPanel/FinishDayScreen/Global Report").set_bbcode(get_node("FinishDayPanel/FinishDayScreen/Global Report").get_bbcode() + text)
			globals.state.upcomingevents.erase(i)
			checkforevents = true
			return
	globals.state.dailyeventcountdown -= 1
	if globals.state.dailyeventcountdown <= 0:
		var event
		event = launchrandomevent()
		if event != null:
			globals.state.dailyeventcountdown = rand_range(5,10)
			get_node("dailyevents").set_hidden(false)
			get_node("dailyevents").currentevent = event
			get_node("dailyevents").call(event)
			dailyevent = true
			return
	startnewday()

var dailyevent = false

func launchrandomevent():
	var rval
	var slavelist = []
	for i in globals.slaves:
		if i.away.duration == 0 && i.sleep != 'jail' && i.sleep != 'farm' && i.attention >= 50:
			slavelist.append(i)
	while slavelist.size() > 0:
		var number = floor(rand_range(0,slavelist.size()))
		if slavelist[number].attention < rand_range(30,150):
			get_node("dailyevents").slave = slavelist[number]
			rval = get_node("dailyevents").getrandomevent(slavelist[number])
			slavelist[number].attention = 0
			break
		else:
			slavelist.remove(number)
	return rval


var alisesprite = {
good = ['happy1','happy2',"wink1",'wink2','side'],
med = ["neutral",'side'],
bad = ["neutral",'side'],
worst = ["neutral"]
}
var alisetext = {
good = ['Nice job! Income is currently on the rise!', 'Great work, $name, We are currently getting wealthier!', 'Things are doing well, $name!', 'If we keep gaining like this, could I get a vacation one day?', 'Another great day, high-five!', 'Remarkable work! Income outlook at this time is positive.', 'A well known artist once stated, "Making money is art and working is art and business is the best art."', 'They say money talks... what does yours say?', 'We are doing great!  Please keep this up $name!'],
med = ['We might need to start making money soon.', 'Things are steady... but should be better financially', "Well we aren't losing money... but we aren't really gaining any either", 'We have added next to nothing to our coffers.  We need a stronger income.', 'I believe it is about time we gain some money.', 'Time waits for no man, neither does good commerce.'],
bad = ['We are losing money $name!', 'Things are not going too well.', 'We should do something about this cash loss.', 'Oh dear! We are bleeding gold.', 'This funding loss needs to be addressed.', 'You must be scaring the gold away, it is disappearing!', 'A financial analysis of assets states a net loss by my calculations.', '$name, do something about this funding leak before you end up poor!', 'Did I miss a memo as to why there is a loss in funds?'],
worst = ["Well... looks like we lost one of our workers. Don't let that to discourage you though!", "So we lost a worker... Let's move on and fix issues for the future.", 'This is an unfortunate situation', "The outlook is unfavorable, let's change that!", "It's just one bad day out of how many other days.", "Don't get discouraged, learn from these failures and fix the issues.", 'I am very sorry about your bad day, let us proceed to fix this.']
}

func alisebuild(state):
	get_node("FinishDayPanel/alise").set_hidden(false)
	if globals.resources.gold > 5000 && state in ['bad','med']:
		state = 'good'
	
	var truesprite = alisesprite[state][rand_range(0,alisesprite[state].size())]
	var showtext = globals.player.dictionary(alisetext[state][rand_range(0,alisetext[state].size())])
	if state == 'good':
		showtext = '[color=#19ec1c]' + showtext + '[/color]'
	elif state == 'med':
		showtext = '[color=yellow]' + showtext + '[/color]'
	elif state in ['bad','worst']:
		showtext = '[color=red]' + showtext + '[/color]'
	get_node("FinishDayPanel/alise/speech/RichTextLabel").set_bbcode(showtext)
	get_node("tutorialnode").buildbody(get_node("FinishDayPanel/alise"), truesprite)

func alisehide():
	get_node("FinishDayPanel/alise").set_hidden(true)

func _process(delta):
	if get_node("dialogue").is_hidden() == true && get_node("popupmessage").is_hidden() == true && checkforevents == true:
		nextdayevents()
		checkforevents = false
	for i in get_tree().get_nodes_in_group("messages"):
		if i.get_opacity() != 0:
			i.set_opacity(i.get_opacity() - delta)

var thread = Thread.new()

func startnewday():
	rebuild_slave_list()
	get_node("FinishDayPanel").set_hidden(false)
	if thread.is_active():
		thread.wait_to_finish()
	thread.start(globals,"save_game",'user://saves/autosave')
	
	#globals.save_game('autosave')
	if globals.rules.enddayalise == 0:
		alisebuild(aliseresults)
	elif globals.rules.enddayalise == 1 && dailyevent == true:
		alisebuild(aliseresults)
	else:
		alisehide()
	_on_mansion_pressed()
#	if globals.state.supporter == false && int(globals.resources.day)%100 == 0:
#		get_node("sellout").set_hidden(false)





func rebuildrepeatablequests():
	var rand
	var town
	var count
	var array = []
	for i in globals.state.repeatables:
		array = []
		count = 0
		for ii in globals.state.repeatables[i]:
			if ii.taken == false:
				array.append(count)
			count += 1
		array.invert()
		for ii in array:
			globals.state.repeatables[i].remove(ii)
		rand = rand_range(0,2)
		if i == 'wimbornslaveguild':
			town = 'wimborn'
		elif i == 'gornslaveguild':
			town = 'gorn'
		elif i == 'frostfordslaveguild':
			town = 'frostford'
		while rand > 0:
			globals.repeatables.generatequest(town, 'easy')
			rand -= 1
		rand = rand_range(0,2)
		while rand > 0:
			globals.repeatables.generatequest(town, 'medium')
			rand -= 1



func _on_FinishDayCloseButton_pressed():
	get_node("FinishDayPanel").set_hidden(true)

#####GUI ELEMENTS

func popup(text):
	get_node("popupmessage").popup()
	get_node("popupmessage/popupmessagetext").set_bbcode(globals.player.dictionaryplayer(text))


func _on_popupmessagetext_meta_clicked( meta ):
	if meta == 'patreon':
		OS.shell_open('https://www.patreon.com/maverik')

var spritedict = globals.spritedict
onready var nodedict = {pos1 = get_node("dialogue/charactersprite1"), pos2 = get_node("dialogue/charactersprite2")}

func dialogue(showclose, destination, dialogtext, dialogbuttons = null, sprites = null): #for arrays: 0 - boolean to show close button or not. 1 - node to return connection back. 2 - text to show 3+ - arrays of buttons and functions in those
	var text = get_node("dialogue/dialoguetext")
	var buttons = get_node("dialogue/popupbuttoncenter/popupbuttons")
	var closebutton
	var newbutton
	var counter = 1
	get_node("dialogue").set_hidden(false)
	text.set_bbcode('')
	for i in buttons.get_children():
		if i != get_node("dialogue/popupbuttoncenter/popupbuttons/Button"):
			i.set_hidden(true)
			i.queue_free()
	if dialogtext == "":
		dialogtext = var2str(dialogtext)
	if showclose == true:
		closebutton = true
	else:
		closebutton = false
	text.set_bbcode(globals.player.dictionaryplayer(dialogtext))
	if dialogbuttons != null:
		counter = 1
		for i in dialogbuttons:
			call("dialoguebuttons", dialogbuttons[counter-1], destination, counter)
			counter += 1
	if closebutton == true:
		newbutton = get_node("dialogue/popupbuttoncenter/popupbuttons/Button").duplicate()
		newbutton.set_hidden(false)
		newbutton.set_text('Close')
		newbutton.connect('pressed',self,'close_dialogue')
		newbutton.get_node("Label").set_text(str(counter))
		buttons.add_child(newbutton)
	
	var sprite1 = false
	var sprite2 = false
	
	if sprites != null && globals.rules.spritesindialogues == true:
		for i in sprites:
			if !spritedict.has(i[0]) && load(i[0]) == null:
				continue
			else:
				if spritedict.has(i[0]):
					if i.size() > 2 && (i[2] != 'opac' || spritedict[i[0]] != nodedict[i[1]].get_texture()):
						get_node("AnimationPlayer").play(i[2])
					nodedict[i[1]].set_texture(spritedict[i[0]])
				else:
					if i.size() > 2 && (i[2] != 'opac' || load(i[0]) != nodedict[i[1]].get_texture()):
						get_node("AnimationPlayer").play(i[2])
					nodedict[i[1]].set_texture(load(i[0]))
				if i[1] == 'pos1': sprite1 = true
				if i[1] == 'pos2': sprite2 = true
	if sprite1 == false: nodedict.pos1.set_texture(null)
	if sprite2 == false: nodedict.pos2.set_texture(null)


func dialoguebuttons(array, destination, counter):
	var newbutton = get_node("dialogue/popupbuttoncenter/popupbuttons/Button").duplicate()
	newbutton.get_node("Label").set_text(str(counter))
	newbutton.set_hidden(false)
	if typeof(array) == TYPE_DICTIONARY:
		newbutton.set_text(array.text)
		if array.has('args'):
			newbutton.connect("pressed", destination, array.function, [array.args])
		else:
			newbutton.connect("pressed", destination, array.function)
		if array.has('disabled') && array.disabled == true:
			newbutton.set_disabled(true)
		if array.has('tooltip'):
			newbutton.set_tooltip(array.tooltip)
	else:
		newbutton.set_text(array[0])
		if array.size() < 3:
			newbutton.connect('pressed',destination,array[1])
		else:
			newbutton.connect('pressed',destination,array[1],[array[2]])
	get_node("dialogue/popupbuttoncenter/popupbuttons").add_child(newbutton)

func close_dialogue():
	get_node("dialogue").set_hidden(true)
	for i in nodedict.values():
		i.set_texture(null)

func _on_menu_pressed():
	get_node("music").set_paused(true)
	get_node("menucontrol").popup()

func _on_closemenu_pressed():
	get_node("music").set_paused(false)
	get_node("menucontrol").set_hidden(true)

func _on_closegamebuttonm_pressed():
	yesnopopup("Are you leaving us?", "quit")


func quit():
	get_tree().quit()

func _on_savebutton_pressed():
	get_node("menucontrol/menupanel/SavePanel").set_hidden(false)

func _on_optionsbutton_pressed():
	get_node("options").set_hidden(false)
	get_node("menucontrol").set_hidden(true)


func _on_mainmenubutton_pressed():
	yesnopopup('Exit to main menu? Make sure to save', 'mainmenu')

func mainmenu():
	get_tree().change_scene("res://files/mainmenu.scn")


func _on_cancelsaveload_pressed():
	get_node("menucontrol/menupanel/SavePanel").set_hidden(true)

var yesbutton = {target = null, function = null}

func yesnopopup(text, yesfunc, target = self):
	if yesbutton.target != null && get_node("menucontrol/yesnopopup/HBoxContainer/yesbutton").is_connected("pressed",yesbutton.target, yesbutton.function):
		get_node("menucontrol/yesnopopup/HBoxContainer/yesbutton").disconnect("pressed",yesbutton.target,yesbutton.function)
	get_node("menucontrol/yesnopopup/HBoxContainer/yesbutton").connect('pressed',target,yesfunc,[],4)
	yesbutton.target = target
	yesbutton.function = yesfunc
	get_node("menucontrol/yesnopopup/Label").set_bbcode(text)
	get_node("menucontrol/yesnopopup").popup()


func _on_yesbutton_pressed():
	get_node("menucontrol/yesnopopup").set_hidden(true)


func _on_nobutton_pressed():
	get_node("menucontrol/yesnopopup").set_hidden(true)

##### Saveload

var filename = 'autosave'

func _on_SavePanel_visibility_changed():
	if get_node("menucontrol/menupanel/SavePanel").is_visible() == false:
		return
	var node
	for i in get_node("menucontrol/menupanel/SavePanel/ScrollContainer/savelist").get_children():
		if i != get_node("menucontrol/menupanel/SavePanel/ScrollContainer/savelist/Button"):
			i.set_hidden(true)
			i.queue_free()
	get_node("menucontrol/menupanel/SavePanel/saveline").set_text(filename.replacen("user://saves/",''))
	var dir = Directory.new()
	if dir.dir_exists("user://saves") == false:
		dir.make_dir("user://saves")
	var savefiles = globals.dir_contents()
	for i in globals.savelist:
		if savefiles.find(i) < 0:
			globals.savelist.erase(i)
	for i in savefiles:
		node = get_node("menucontrol/menupanel/SavePanel/ScrollContainer/savelist/Button").duplicate()
		node.set_hidden(false)
		if globals.savelist.has(i):
			node.get_node("date").set_text(globals.savelist[i].date)
			node.get_node("name").set_text(i.replacen("user://saves/",''))
			node.get_node("info").set_text(globals.savelist[i].name)
		else:
			node.get_node("name").set_text(i.replacen("user://saves/",''))
			node.get_node("info").set_text("This save has no info about it.")
		get_node("menucontrol/menupanel/SavePanel/ScrollContainer/savelist").add_child(node)
		#node.set_text(i.replacen("user://saves/",''))
		node.set_meta("name", i)
		node.connect('pressed', self, 'loadchosen', [node])



func loadchosen(node):
	filename = node.get_meta('name')
	_on_SavePanel_visibility_changed()

func _on_deletebutton_pressed():
	var dir = Directory.new()
	if dir.file_exists(filename):
		yesnopopup('Delete this file?', 'deletefile')
	else:
		popup('No file with such name') 

func deletefile():
	var dir = Directory.new()
	if dir.dir_exists("user://saves") == false:
		dir.make_dir("user://saves")
	dir.remove(filename)
	_on_nobutton_pressed()
	_on_SavePanel_visibility_changed()


func _on_loadbutton_pressed():
	if Directory.new().file_exists(filename):
		yesnopopup('Load this file?', 'loadfile')
	else:
		popup_set('No file with such name') 

func loadfile():
	if thread.is_active():
		thread.wait_to_finish()
	globals.load_game(filename)
	_on_SavePanel_visibility_changed()
	get_node("menucontrol").set_hidden(true)
	get_node("music").set_paused(false)
	

func _on_saveline_text_changed( text ):
	filename = "user://saves/" + text

func _on_savefilebutton_pressed():
	var dir = Directory.new()
	if dir.file_exists(filename) == true:
		yesnopopup('This file already exists. Overwrite?', 'savefile')
	else:
		savefile()

func savefile():
	globals.save_game(filename)
	_on_SavePanel_visibility_changed()
	_on_nobutton_pressed()
	get_node("menucontrol/menupanel/SavePanel").set_hidden(true)
	get_node("menucontrol").set_hidden(true)
	get_node("music").set_paused(false)


func _on_saveloadfolder_pressed():
	var temp = OS.get_data_dir()
	OS.shell_open('file://'+temp + '/saves')


func hide_everything():
	get_node("MainScreen/mansion/jailpanel").set_hidden(true)
	get_node("MainScreen/slave_tab").set_hidden(true)
	get_node("MainScreen/mansion/alchemypanel").set_hidden(true)
	get_node("MainScreen/mansion/mansioninfo").set_hidden(true)
	get_node("MainScreen/mansion/labpanel").set_hidden(true)
	get_node("MainScreen/mansion/labpanel/labmodpanel").set_hidden(true)
	get_node("MainScreen/mansion/librarypanel").set_hidden(true)
	get_node("MainScreen/mansion/farmpanel").set_hidden(true)
	get_node("MainScreen/mansion/selfinspect").set_hidden(true)
	get_node("MainScreen/mansion/portalspanel").set_hidden(true)
	get_node("MainScreen/mansion/upgradespanel").set_hidden(true)
	get_node("paperdoll").set_hidden(true)
	globals.hidetooltip()
	#rebuild_slave_list()

var backgrounddict = globals.backgrounds


func background_set(text):
	var player = get_node("screenchange/AnimationPlayer")
	if player.is_playing() == true:
		return
	if OS.get_name() != "HTML5" && globals.rules.fadinganimation == true:
		if get_node("TextureFrame").get_texture() == backgrounddict[text]:
			player.play("wait")
			yield(player, 'finished')
			emit_signal('animfinished')
			return
		player.play("fadetoblack")
		yield(player, "finished")
		emit_signal('animfinished')
	texture = backgrounddict[text]
	get_node("TextureFrame").set_texture(texture)
	if OS.get_name() != "HTML5" && globals.rules.fadinganimation == true:
		player.play("removeblack")
		#get_node("screenchange").set_hidden(true)

var musicdict = globals.musicdict

func music_set(text):
	var music = get_node("music")
	if music.is_paused() == true && globals.rules.musicvol > 0:
		music.set_paused(false)
	if globals.rules.musicvol == 0 || music.get_meta("currentsong") == text:
		return
	var path = ''
	var array = []
	music.set_autoplay(true)
	if text == 'combat':
		array = ['combat1','combat2','combat3']
		path = musicdict[array[rand_range(0,array.size())]]
	elif text == 'mansion':
		music.set_autoplay(false)
		array = ['mansion1','mansion2','mansion3','mansion4','mansion5']
		path = musicdict[array[rand_range(0,array.size())]]
	else:
		path = musicdict[text]
	music.set_meta('currentsong', text)
	music.set_stream(path)
	music.play(0)
	music.set_volume(globals.rules.musicvol)


func _on_music_finished():
	if get_node("music").get_meta("currentsong") == 'mansion':
		get_node("music").set_meta("currentsong", 'over')
		music_set("mansion")



func _on_mansionbutton_pressed():
	_on_mansion_pressed()
	_on_buttonpanel_mouse_enter()

func _on_mansion_pressed():
	var textnode = get_node("MainScreen/mansion/mansioninfo")
	var text = ''
	background_set('mansion')
	if OS.get_name() != "HTML5" && globals.rules.fadinganimation == true:
		yield(self, 'animfinished')
	hide_everything()
	get_node("buttonpanel").set_hidden(false)
	get_node("outside/slavesellpanel").set_hidden(true)
	get_node("outside/slavebuypanel").set_hidden(true)
	get_node("outside/slaveguildquestpanel").set_hidden(true)
	get_node("outside/slaveservicepanel").set_hidden(true)
	get_node("outside").set_hidden(true)
	get_node("hideui").set_hidden(true)
	get_node("charlistcontrol").set_hidden(false)
	get_node("MainScreen").set_hidden(false)
	get_node("Navigation").set_hidden(false)
	var portals = false
	for i in globals.state.portals.values():
		if i.enabled == true:
			portals = true
	get_node("buttonpanel/VBoxContainer/portals").set_disabled(!portals)
	textnode.set_hidden(false)
	var sleepers = globals.count_sleepers()
	text = 'You are at your mansion, which is located near [color=aqua]'+ globals.state.location.capitalize()+'[/color].\n\n' 
	text += 'You have '
	if sleepers.communal > globals.state.mansionupgrades.mansioncommunal:
		text += '[color=red]'
	elif sleepers.communal == globals.state.mansionupgrades.mansioncommunal:
		text += '[color=yellow]'
	else:
		text += '[color=green]'
	text += str(globals.state.mansionupgrades.mansioncommunal) + '[/color] beds in communal room\n'
	text += 'You have ' + globals.fastif(sleepers.personal >= globals.state.mansionupgrades.mansionpersonal, '[color=red]', '[color=green]') + str(globals.state.mansionupgrades.mansionpersonal) + '[/color] ' + globals.fastif(globals.state.mansionupgrades.mansionpersonal > 1, 'personal rooms', 'personal room')+ ' available for living\nYour bed can fit ' +globals.fastif(sleepers['your_bed'] >= globals.state.mansionupgrades.mansionbed, '[color=red]', '[color=green]') + str(globals.state.mansionupgrades.mansionbed) + '[/color] ' +  globals.fastif(globals.state.mansionupgrades.mansionpersonal > 1, 'persons', 'person')+' besides you.\n\nYour jail can hold up to ' +globals.fastif(sleepers.jail >= globals.state.mansionupgrades.jailcapacity, '[color=red]', '[color=green]') + str(globals.state.mansionupgrades.jailcapacity) +'[/color] prisoners. \n\n'
	if globals.state.condition <= 20:
		text += 'Mansion is [color=red]in a complete mess[/color].\n\n'
	elif globals.state.condition <= 40:
		text += 'Mansion is [color=#FFA500]very dirty[/color].\n\n'
	elif globals.state.condition <= 60:
		text += 'Mansion is [color=yellow]quite unclean[/color].\n\n'
	elif globals.state.condition <= 80:
		text += 'Mansion is [color=lime]passably clean[/color].\n\n'
	else:
		text += 'Mansion is [color=green]immaculate[/color].\n\n'
	if globals.state.playergroup.size() <= 0:
		text = text + 'Nobody is assigned to follow you.\n\n'
	else:
		for i in globals.state.playergroup:
			var slave = globals.state.findslave(i)
			if slave != null:
				text = text + slave.dictionary('$name is assigned to your group.\n')
			else:
				globals.state.playergroup.erase(i)
	textnode.set_bbcode(text)
	var headgirl = false
	for i in globals.slaves:
		if i.work == 'headgirl':
			headgirl = true
			text = text + i.dictionary('$name is your headgirl.')
	if (globals.slaves.size() >= 8 && headgirl == true) || globals.developmode == true:
		get_node("charlistcontrol/headgirl").set_hidden(false)
		get_node("MainScreen/mansion/slavelist").set_hidden(false)
	else:
		get_node("charlistcontrol/headgirl").set_hidden(true)
		get_node("MainScreen/mansion/slavelist").set_hidden(true)
	if globals.state.farm >= 3:
		get_node("buttonpanel/VBoxContainer/farm").set_disabled(false)
	else:
		get_node("buttonpanel/VBoxContainer/farm").set_disabled(true)
	if globals.state.mansionupgrades.mansionlab > 0:
		get_node("buttonpanel/VBoxContainer/laboratory").set_disabled(false)
	else:
		get_node("buttonpanel/VBoxContainer/laboratory").set_disabled(true)
	music_set('mansion')
	if globals.state.sidequests.emily == 3:
		globals.events.emilymansion()
	if globals.state.capturedgroup.size() > 0:
		var array = []
		var nojailcells = false
		for i in globals.state.capturedgroup:
			array.append(i)
		for i in array:
			globals.slaves = i
			if globals.count_sleepers().jail < globals.state.mansionupgrades.jailcapacity:
				i.sleep = 'jail'
			else:
				nojailcells = true
			globals.state.capturedgroup.erase(i)
		text = "You have assigned your captives to the mansion. " + globals.fastif(nojailcells, '[color=yellow]You are out of free jail cells and some captives were assigned to living room.[/color]', '')
		popup(text)
	rebuild_slave_list()

#jail settings

func _on_jailbutton_pressed():
	background_set('jail')
	if OS.get_name() != "HTML5" && globals.rules.fadinganimation == true:
		yield(self, 'animfinished')
	hide_everything()
	get_node("MainScreen/mansion/jailpanel").set_hidden(false)
	if globals.state.tutorial.jail == false:
		get_node("tutorialnode").jail()

func _on_jailpanel_visibility_changed():
	var temp = ''
	var text = ''
	var count = 0
	var prisoners = []
	var jailer
	
	for i in get_node("MainScreen/mansion/jailpanel/ScrollContainer/prisonerlist").get_children():
		i.set_hidden(true)
		i.queue_free()
	
	if get_node("MainScreen/mansion/jailpanel").is_visible() == false:
		return
	for i in globals.slaves:
		if i.sleep == 'jail':
			temp = temp + i.name
			prisoners.append(i)
			var button = Button.new()
			var node = get_node("MainScreen/mansion/jailpanel/ScrollContainer/prisonerlist")
			node.add_child(button)
			button.set_text(i.name_long())
			button.set_name(str(count))
			button.connect('pressed', self, 'prisonertab', [count])
		if i.work == 'jailer':
			jailer = i
		count += 1
	if temp == '':
		text = 'You have no prisoners at this moment.'
	else:
		text = 'You have '+str(prisoners.size()) + '/'+str(globals.state.mansionupgrades.jailcapacity) + ' prisoners.'
	if globals.state.mansionupgrades.jailincenses:
		text += "\n[color=green]Your jail is decently furnished and tiled. [/color]"
	if globals.state.mansionupgrades.jailincenses:
		text += "\n[color=green]You can smell soft burning incenses in the air.[/color]"
	if jailer == null:
		text = text + '\nYou have no assigned jailer.'
	else:
		text = text + jailer.dictionary('\n$name is assigned as jailer.') 
	
	
	get_node("MainScreen/mansion/jailpanel/jailtext").set_bbcode(text)

func _on_jailsettingspanel_visibility_changed(inputslave = null):
	var jailer = inputslave
	for i in globals.slaves:
		if i.work == 'jailer':
			jailer = i
	var text = ''
	if jailer == null:
		text = 'You have no assigned jailer. '
		get_node("MainScreen/mansion/jailpanel/jailsettings/jailsettingspanel/jailerchange").set_text('Change')
	else:
		text = 'Your current jailer is - ' + jailer.name_long()
		jailer.work = 'jailer'
		get_node("MainScreen/mansion/jailpanel/jailsettings/jailsettingspanel/jailerchange").set_text('Unassign')
	get_node("MainScreen/mansion/jailpanel/jailsettings/jailsettingspanel/currentjailertext").set_bbcode(text)
	if globals.slaves.size() < 1:
		get_node("MainScreen/mansion/jailpanel/jailsettings/jailsettingspanel/jailerchange").set_disabled(true)
	else:
		get_node("MainScreen/mansion/jailpanel/jailsettings/jailsettingspanel/jailerchange").set_disabled(false)
	_on_jailpanel_visibility_changed()

func prisonertab(number):
	hide_everything()
	self.currentslave = number
	get_node("MainScreen/slave_tab").tab = 'prison'
	get_node("MainScreen/slave_tab").set_hidden(false)
	get_node("MainScreen/slave_tab").set_current_tab(0)

func _on_jailerchange_pressed():
	if get_node("MainScreen/mansion/jailpanel/jailsettings/jailsettingspanel/jailerchange").get_text() != 'Unassign':
		selectslavelist(false, '_on_jailsettingspanel_visibility_changed', self, 'globals.currentslave.loyal >= 20 && globals.currentslave.conf >= 50')
	else:
		for i in globals.slaves:
			if i.work == 'jailer':
				i.work = 'rest'
		_on_jailsettingspanel_visibility_changed()


func _on_jailsettings_pressed():
	get_node("MainScreen/mansion/jailpanel/jailsettings/jailsettingspanel").set_hidden(false)

func _on_jailerclose_pressed():
	get_node("MainScreen/mansion/jailpanel/jailsettings/jailsettingspanel").set_hidden(true)

var potselected

func _on_alchemy_pressed():
	background_set('alchemy')
	if OS.get_name() != "HTML5" && globals.rules.fadinganimation == true:
		yield(self, 'animfinished')
	hide_everything()
	get_node("MainScreen/mansion/alchemypanel").set_hidden(false)
	if globals.state.tutorial.alchemy == false:
		get_node("tutorialnode").alchemy()
	if globals.state.sidequests.chloe == 8 && globals.state.mansionupgrades.mansionalchemy >= 1:
		globals.events.chloealchemy()
	potselected = ''
	var potlist = get_node("MainScreen/mansion/alchemypanel/ScrollContainer/selectpotionlist")
	var potline = get_node("MainScreen/mansion/alchemypanel/ScrollContainer/selectpotionlist/selectpotionline")
	var maintext = get_node("MainScreen/mansion/alchemypanel/alchemytext")
	if globals.state.mansionupgrades.mansionalchemy == 0:
		maintext.set_bbcode("Your alchemy room lacks sufficient tools to craft your own potions. You have to unlock it from [color=yellow]Mansion Upgrades[/color] first.")
		for i in get_node("MainScreen/mansion/alchemypanel").get_children():
			i.set_hidden(true)
		maintext.set_hidden(false)
		return
	else:
		get_node("MainScreen/mansion/alchemypanel/alchemytext").set_bbcode("This is your alchemy room. Chemistry equipment is ready to use and shelves contain your fresh ingredients.")
		get_node("MainScreen/mansion/alchemypanel/potdescription").set_bbcode('')
		for i in get_node("MainScreen/mansion/alchemypanel").get_children():
			i.set_hidden(false)
	for i in potlist.get_children():
		if i != potline:
			i.set_hidden(true)
			i.queue_free()
	var array = []
	for i in globals.itemdict.values():
		array.append(i)
	array.sort_custom(get_node("itemnode"),'sortitems')
	for i in array:
		if i.recipe != '' && i.unlocked == true:
			var newpotline = potline.duplicate()
			potlist.add_child(newpotline)
			if i.icon != null:
				newpotline.get_node("potbutton/icon").set_texture(i.icon)
			newpotline.set_hidden(false)
			newpotline.get_node("potnumber").set_text(str(i.amount))
			newpotline.get_node("potbutton").set_text(i.name)
			newpotline.get_node("potbutton").connect('pressed', self, 'brewlistpressed', [i])
			newpotline.set_name(i.name)
	alchemyclear()

func alchemyclear():
	get_node("MainScreen/mansion/alchemypanel/Label").set_hidden(true)
	get_node("MainScreen/mansion/alchemypanel/Label1").set_hidden(true)
	for i in get_node("MainScreen/mansion/alchemypanel/VBoxContainer").get_children():
		if i.get_name() != 'Panel':
			i.set_hidden(true)
			i.queue_free()

func brewlistpressed(potion):
	potselected = potion
	var counter = get_node("MainScreen/mansion/alchemypanel/brewcounter").get_value()
	var text = ''
	var recipedict = {}
	var brewable = true
	recipedict = get_node('itemnode')[potion.recipe]
	var array = []
	for i in recipedict:
		array.append(i)
	array.sort_custom(get_node("itemnode"),'sortbytype')
	alchemyclear()
	get_node("MainScreen/mansion/alchemypanel/Label").set_hidden(false)
	get_node("MainScreen/mansion/alchemypanel/Label1").set_hidden(false)
	for i in array:
		var item = globals.itemdict[i]
		var newpanel = get_node("MainScreen/mansion/alchemypanel/VBoxContainer/Panel").duplicate()
		get_node("MainScreen/mansion/alchemypanel/VBoxContainer/").add_child(newpanel)
		newpanel.set_hidden(false)
		newpanel.get_node("icon").set_texture(item.icon)
		newpanel.get_node("icon").connect("mouse_enter",globals, 'showtooltip', [item.description])
		newpanel.get_node("icon").connect("mouse_exit",globals, 'hidetooltip')
		newpanel.get_node('name').set_text(item.name)
		newpanel.get_node("number").set_text(str(recipedict[i]*counter))
		newpanel.get_node("totalnumber").set_text(str(item.amount))
		if item.amount < recipedict[i]*counter:
			newpanel.get_node("totalnumber").set('custom_colors/font_color', Color(1,0,0))
			brewable = false
#		if item.type == 'potion':
#			text = text +'[color=yellow]' + item.name + '[/color] - ' + str(recipedict[i]*counter) + '/'
#		else:
#			text = text + item.name + ' - ' + str(recipedict[i]*counter) + '/'
			
	text = text + '\n[center][color=aqua]'+ potselected.name + '[/color][/center]\n' + '' + potselected.description + '\n'		
	for i in get_tree().get_nodes_in_group('alchemypot'):
		if i.get_text() != potion.name && i.is_pressed() == true:
			i.set_pressed(false)
	get_node("MainScreen/mansion/alchemypanel/potdescription").set_bbcode(text)
	if counter == 0:
		brewable = false
	if brewable == false:
		get_node("MainScreen/mansion/alchemypanel/brewbutton").set_disabled(true)
	else:
		get_node("MainScreen/mansion/alchemypanel/brewbutton").set_disabled(false)


func _on_brewbutton_pressed():
	var counter = get_node("MainScreen/mansion/alchemypanel/brewcounter").get_value()
	while counter > 0:
		counter -= 1
		get_node("itemnode").recipemake(potselected)
	brewlistpressed(potselected)
	_on_alchemypanel_visibility_changed()
	get_node("MainScreen/mansion/alchemypanel/brewbutton").set_disabled(true)

func _on_brewcounter_value_changed( value ):
	if typeof(potselected) != 4:
		brewlistpressed(potselected)

func chloealchemy():
	globals.events.chloealchemy()

var loredict = globals.dictionary.loredict

func _on_library_pressed():
	background_set('library')
	if OS.get_name() != "HTML5" && globals.rules.fadinganimation == true:
		yield(self, 'animfinished')
	hide_everything()
	get_node("MainScreen/mansion/librarypanel").set_hidden(false)
	var text = ''
	if globals.state.mansionupgrades.mansionlibrary == 0:
		text = "Tucked away in a large room off the main passage in the mansion is the library. Bookshelves line every wall leaving only spaces for long narrow windows and the door. The shelves are mostly empty a few scarce books from your days studying you've brought with you. "
	else:
		text = "Tucked away in a large room off the main passage in the mansion is the library. Bookshelves line every wall leaving only spaces for long narrow windows and the door. Your collection of books grew bigger since your earlier days, and you are fairly proud of it."
	var list = get_node("MainScreen/mansion/librarypanel/ScrollContainer/VBoxContainer")
	for i in list.get_children():
		if i != get_node("MainScreen/mansion/librarypanel/ScrollContainer/VBoxContainer/bookbutton"):
			i.set_hidden(true)
			i.queue_free()
	
	var array = []
		
#	array.append([0, loredict['slavery']])
#	array.append([1, loredict['magesorder']])
#	if globals.state.library >= 1:
#		array.append([2,loredict['branding']])
#		array.append([3,loredict['worldhistory']])
#	if globals.state.library >= 2:
#		array.append([4,loredict['magic']])
	for i in loredict.values():
		if globals.evaluate(i.reqs) == false:
			continue
		var newbutton = get_node("MainScreen/mansion/librarypanel/ScrollContainer/VBoxContainer/bookbutton").duplicate()
		list.add_child(newbutton)
		newbutton.set_hidden(false)
		newbutton.set_text(i.name)
		newbutton.connect('pressed',self,'lorebutton', [i.text])
	
	for slave in globals.slaves:
		if slave.work == 'library':
			text = text + slave.dictionary('\n\nYou can see $name studying here.')
	get_node("MainScreen/mansion/librarypanel/libraryinfo").set_bbcode(text)

func lorebutton(lore):
	get_node("MainScreen/mansion/librarypanel/libraryinfo").set_bbcode(lore)

###########QUEST LOG

func _on_questlog_pressed():
	get_node("questnode").popup()


func _on_questsclosebutton_pressed():
	get_node("questnode").set_hidden(true)

var mainquestdict = {
'0' : "You should try joining Mage Order in town to get access to better stuff and start your career.",
'1' : "Old chancellor at Mage Order wants me to bring him a girl before I can join. She must be: \nFemale;\nHuman; \nAverage look (40) or better; \nHigh obedience; \n\nI can probably take a look at slaver's guild or explore outsides. ",
'2' : "Visit Mage Order again and seek for further promotions.",
'3' : "Melissa from Mage Order wants you to bring them captured Fairy. ",
'3.1' : "Melissa from Mage Order wants you to bring them captured Fairy, I should be able to find them in far forests around Wimborn. ",
'4' : "Return to Melissa for further information.",
'5' : "Melissa told you to find Sebastian at the market and get her 'delivery'.",
'6' : "Acquire alchemical station, brew Elixir of Youth and return it to Melissa.",
'7' : "Visit Melissa for your next task.",
'8' : "Set up a laboratory. You can buy tools at Mage's Order. Then return to Melissa.",
'9' : "Return to Melissa.",
'10': "Bring Melissa a Taurus girl with huge lactating tits. Size can be altered with certain potions. ",
'11': "Visit Melissa for your next mission. ",
'12': "Melissa told you to travel to Gorn and find the Orc named Garthor. ",
'13': "Garthor from Gorn ordered you to capture and bring Dark Elf Ivran who you can find at Gorn's outskirts.",
'14': "Wait for next day until returning to Garthor. ",
'15': "Return to Garthor and decide what should be done with Ivran. ",
'16': "Return back to Melissa for your next task. ",
'17': "Get to the Amberguard through the Deep Elven Grove. ",
'18': "Get to the Tunnel Entrance which lays after the Amber Road. ",
'19': "Search through Amberguard for a way to get into Tunnel Entrance. ",
'20': "Purchase the information from stranger in Amberguard. ",
'21': "Locate Witch's Hut at the Amber Road. ",
'22': "Ask Shuriya in the Hut near Amber Road how to get into tunnels",
'23': "Bring 2 slaves to the Shuriya: an elf and a drow. ",
'24': "Search through Undercity ruins for any remaining documents. ",
'25': "Return to Melissa with your findings. ",
'26': "Visit Melissa for your next assignement. ",
'27': "Visit Capital. ",
'28': "Visit Frostford's City Hall. ",
'28.1': "Investigate suspicious hunting grounds at Frostford's outskirts. ",
'29': "Report back to Theron about your findings. ",
'30': "Decide on the solution for Frostford's issue. ",
'31': "Let Theron know about Zoe's decision.",
'32': "Bring Zoe 500 units of food, 15 Nature Essences and 5 Fluid Substances.",
'33': "Return to Theron.",
'34': "Return to Theron.",
'35':"Return to Theron.",
'36': "You have finished currently available quest line. ",
}
var chloequestdict = {
'3':"Chloe from Shaliq wants you to get 25 mana and visit her to trade it for a spell.",
'5':"Visit Chloe in the Shaliq.",
'6':"Chloe seems to be missing from her hut. You should try looking for her in the woods.",
'7':"Check on Chloe's condition in Shaliq. ",
'8':"Chloe asked you to brew an antidote for her. ",
'9':"Return with potion to [color=green]Chloe in Shaliq[/color].",
}
var caliquestdict = {
'11':"Talk to Cali about her parents",
'12':"Talk to Cali about her parents",
'13':"Talk to Cali",
'14':"Ask around Wimborn for potential clues of Cali's origins",
'15':"Get information from Jason in Wimborn's Bar",
'16':"Pay up rest of the cash to the Jason for information",
'17':"Search Shaliq village in the Wimborn forest for clues",
'18':"Search forest bandits for clues",
'19':"Defeat bandits in camp in Wimborn forest",
'20':"Return to Shaliq for reward",
'21':"Return to Shaliq for reward",
'22':"Talk to Cali",
'23':"Locate slavers camp in Wimborn outskirts",
'24':"Locate slavers camp in Wimborn outskirts",
'25':"Locate bandit responsible for Cali's kidnap",
'26':"Locate Cali's house in Eerie woods"
}
var emilyquestdict = {
'12':"Search for Tisha at the Wimborn's Mage Order",
'13':"Search for suspicious person at the backstreets",
'14':"Your investigation tells you Tisha might be at Gorn.",
'15':"Get Tisha out of Gorn's slaver guild",
}
var yrisquestdict = {
"1":"Accept Yris's challenge at Gorn's bar",
"2":"Find a way to win Yris's challenge at Gorn's bar. Perhaps, some potion might provide an option",
"3":"Talk to Yris at Gorn's Bar",
"4":"Find a way to secure your bet with Yris. Perhaps, some alchemist might shine some light upon your findings. You'll also need 1000 gold and 1 Deterrent potion.",
"5":"Beat Yris at her challenge at Gorn's Bar. You'll also need to bring 1000 gold and Deterrent potion. ",
}
var questtype = {slaverequest = 'Slave Request'}
var selectedrepeatable

func _on_questnode_visibility_changed():
	if get_node("questnode").is_hidden() == true:
		return
	var maintext = get_node("questnode/TabContainer/Main Quest/mainquesttext")
	var sidetext = get_node("questnode/TabContainer/Side Quests/sidequesttext")
	var repeattext = get_node("questnode/TabContainer/Repeatable Quests/repetablequesttext")
	maintext.set_bbcode(mainquestdict[str(globals.state.mainquest)])
	sidetext.set_bbcode('')
	repeattext.set_bbcode('')
	#sidequests
	if globals.state.sidequests.brothel == 1:
		sidetext.set_bbcode(sidetext.get_bbcode() + "—To let your slaves work at prostitution, you'll have to bring [color=green]Elf slave[/color] to the brothel. \n\n")
	if globals.state.farm == 2:
		sidetext.set_bbcode(sidetext.get_bbcode()+ "—Sebastian proposed you to purchase to set up your own human farm for 1000 gold.\n\n")
	if chloequestdict.has(str(globals.state.sidequests.chloe)):
		sidetext.set_bbcode(sidetext.get_bbcode() + "—"+ chloequestdict[str(globals.state.sidequests.chloe)]+"\n\n")
	if caliquestdict.has(str(globals.state.sidequests.cali)):
		sidetext.set_bbcode(sidetext.get_bbcode() + "—"+ caliquestdict[str(globals.state.sidequests.cali)]+"\n\n")
	if emilyquestdict.has(str(globals.state.sidequests.emily)):
		sidetext.set_bbcode(sidetext.get_bbcode() + "—"+ emilyquestdict[str(globals.state.sidequests.emily)]+"\n\n")
	if yrisquestdict.has(str(globals.state.sidequests.yris)):
		sidetext.set_bbcode(sidetext.get_bbcode() + "—"+ yrisquestdict[str(globals.state.sidequests.yris)]+"\n\n")
	#repeatables
	for i in get_node("questnode/TabContainer/Repeatable Quests/ScrollContainer/VBoxContainer").get_children():
		if i != get_node("questnode/TabContainer/Repeatable Quests/ScrollContainer/VBoxContainer/Button"):
			i.set_hidden(true)
			i.queue_free()
	selectedrepeatable = null
	get_node("questnode/TabContainer/Repeatable Quests/questforfeit").set_disabled(true)
	for i in globals.state.repeatables:
		for ii in globals.state.repeatables[i]:
			if ii.taken == true:
				var newbutton = get_node("questnode/TabContainer/Repeatable Quests/ScrollContainer/VBoxContainer/Button").duplicate()
				get_node("questnode/TabContainer/Repeatable Quests/ScrollContainer/VBoxContainer").add_child(newbutton)
				newbutton.set_hidden(false)
				newbutton.set_text(ii.location.capitalize() + ' - ' + questtype[ii.type])
				newbutton.connect("pressed",self,'repeatableselect', [ii])
				newbutton.set_meta('quest', ii)
	
	
	if sidetext.get_bbcode() == '':
		sidetext.set_bbcode('You have no active sidequests.')
	if get_node("questnode/TabContainer/Repeatable Quests/ScrollContainer/VBoxContainer").get_children().size() <= 1:
		repeattext.set_bbcode('You have no active repeatable quests.')
	else:
		repeattext.set_bbcode('Choose repeatable quest to see detailed info.')

func repeatableselect(quest):
	selectedrepeatable = quest
	get_node("questnode/TabContainer/Repeatable Quests/questforfeit").set_disabled(false)
	var text = ''
	for i in get_node("questnode/TabContainer/Repeatable Quests/ScrollContainer/VBoxContainer").get_children():
		if i.has_meta('quest') == true:
			if i.get_meta('quest') != quest && i.is_pressed() == true:
				i.set_pressed(false)
	text = get_node("outside").slavequesttext(quest)
	text = text.replace('Time Limit:', 'Time Remained:')
	get_node("questnode/TabContainer/Repeatable Quests/repetablequesttext").set_bbcode(text)

func _on_questforfeit_pressed():
	if selectedrepeatable != null:
		yesnopopup("Cancel this quest?", 'removequest')

func removequest():
	for i in globals.state.repeatables:
		for ii in globals.state.repeatables[i]:
			if ii == selectedrepeatable:
				globals.state.repeatables[i].remove(globals.state.repeatables[i].find(ii))
	get_node("menucontrol/yesnopopup").set_hidden(true)
	_on_questnode_visibility_changed()

var spellscategory = 'control'
var spellbookimages = {
control = load("res://files/buttons/book/control.png"),
offensive = load("res://files/buttons/book/offensive.png"),
defensive = load("res://files/buttons/book/defensive.png"),
utility = load("res://files/buttons/book/utility.png"),
}

func _on_spellbook_pressed():
	get_node("spellbooknode").popup()
	var spelllist = get_node("spellbooknode/spellbooklist/ScrollContainer/spellist")
	var spellbutton = get_node("spellbooknode/spellbooklist/ScrollContainer/spellist/spellbutton")
	get_node("spellbooknode/spellbooklist").set_texture(spellbookimages[spellscategory])
	for i in spelllist.get_children():
		if i != spellbutton:
			i.set_hidden(true)
			i.queue_free()
	var array = []
	for i in globals.spelldict.values():
		array.append(i)
	array.sort_custom(get_node("spellnode"),'sortspells')
	get_node("spellbooknode/spellbooklist/spelldescription").set_bbcode('')
	for i in array:
		if i.learned == true && i.type == spellscategory:
			var newbutton = spellbutton.duplicate()
			spelllist.add_child(newbutton)
			newbutton.set_text(i.name)
			newbutton.set_hidden(false)
			newbutton.connect('pressed',self,'spellbookselected',[i])
	#get_node("screenchange/AnimationPlayer").play("fadetoblack")

func spellbookselected(spell):
	var text = ''
	for i in get_tree().get_nodes_in_group("spellbutton"):
		if i.get_text() != spell.name: i.set_pressed(false)
	text = '[center]'+ spell.name + '[/center]\n\n' + spell.description + '\n\nType: ' + spell.type.capitalize() + '\n\nMana: ' + str(spell.manacost)
	if spell.combat == true:
		text += '\n\nCan be used in combat' 
	get_node("spellbooknode/spellbooklist/spelldescription").set_bbcode(text)

func spellbookcategory(button):
	spellscategory = button.get_name()
	_on_spellbook_pressed()

func _on_spellbookclose_pressed():
	get_node("spellbooknode").set_hidden(true)


func _on_debug_pressed():
	get_node("options").set_hidden(false)
	get_node("options")._on_cheats_pressed()

var baby

func childbirth(slave):
	slave.metrics.birth += 1
	get_node("birthpanel").set_hidden(false)
	baby = globals.state.findbaby(slave.preg.baby)
	var text = ''
	slave.preg.duration = 0
	slave.preg.baby = null
	slave.preg.fertility = 5
	if globals.state.mansionupgrades.mansionnursery == 1:
		if globals.player == slave:
			text = slave.dictionary('You gave birth to a ')
		else:
			text = slave.dictionary('$name gave birth to a ')
		text += baby.dictionary('healthy $race $child. ') + globals.description.getBabyDescription(baby)
		if globals.state.rank < 2:
			get_node("birthpanel/raise").set_disabled(true)
			text = text + "\nSadly, you can't allow to raise it, as your guild rank is too low. "
		else:
			text = text + "\nWould you like to send it to another dimension to accelerate its growth? This will cost you 500 gold. "
			if globals.resources.gold >= 500:
				get_node("birthpanel/raise").set_disabled(false)
			else:
				get_node("birthpanel/raise").set_disabled(true)
	else:
		if globals.player == slave:
			text = slave.dictionary("You've had to use town's hospital to give birth to your child. Sadly, you can't keep it without Nursery Room and had to give it away.")
		else:
			text = slave.dictionary("$name had to use town's hospital to give birth to your child. Sadly, you can't keep it without Nursery Room and had to give it away.")
		get_node("birthpanel/raise").set_disabled(true)
	get_node("birthpanel/birthtext").set_bbcode(text)

func _on_giveaway_pressed():
	get_node("birthpanel").set_hidden(true)
	nextdayevents()

func _on_raise_pressed():
	get_node("birthpanel/raise/childpanel").set_hidden(false)
	globals.resources.gold -= 500
	get_node("birthpanel/raise/childpanel/LineEdit").set_text(baby.name)
	if globals.rules.children != true:
		get_node("birthpanel/raise/childpanel/child").set_hidden(true)
	else:
		get_node("birthpanel/raise/childpanel/child").set_hidden(false)

func babyage(age):
	baby.name = get_node("birthpanel/raise/childpanel/LineEdit").get_text()
	if get_node("birthpanel/raise/childpanel/surnamecheckbox").is_pressed() == true:
		baby.surname = globals.player.surname
	if age == 'child':
		baby.age = 'child'
		var sizes = ['flat','small']
		if baby.sex != 'male':
			baby.tits.size = sizes[rand_range(0,sizes.size())]
			baby.ass = sizes[rand_range(0,sizes.size())]
		baby.away.duration = 15
	elif age == 'teen':
		baby.age = 'teen'
		var sizes = ['flat','small','average','big']
		if baby.sex != 'male':
			baby.tits.size = sizes[rand_range(0,sizes.size())]
			baby.ass = sizes[rand_range(0,sizes.size())]
		baby.away.duration = 20
	elif age == 'adult':
		baby.age = 'adult'
		var sizes = ['flat','small','average','big','huge']
		if baby.sex != 'male':
			baby.tits.size = sizes[rand_range(0,sizes.size())]
			baby.ass = sizes[rand_range(0,sizes.size())]
		baby.away.duration = 25
	baby.away.at = 'growing'
	baby.obed += 75
	baby.loyal += 20
	if baby.sex != 'male':
		baby.pussy.virgin = true
		baby.pussy.first = 'none'
	globals.slaves = baby
	baby = ''
	get_node("birthpanel").set_hidden(true)
	get_node("birthpanel/raise/childpanel").set_hidden(true)
	nextdayevents()





#
# Glossarynode
#


func _on_closeglossary_pressed():
	get_node("glossarynode").set_hidden(true)
	get_node("glossarynode/Panel/glossarysearch").set_text("")

func glossarysearch():
	var list = get_node("glossarynode/Panel/Container/VBoxContainer")
	var button = get_node("glossarynode/Panel/Container/VBoxContainer/glossarybutton")
	var searchtext = get_node("glossarynode/Panel/glossarysearch").get_text()
	for i in list.get_children():
		if i != button:
			i.set_hidden(true)
			i.free()
	
	for i in globals.glossary.glossarylist:
		if i.text.findn(searchtext) >= 0 || i.name.findn(searchtext) >= 0 || searchtext == "":
			var newbutton = button.duplicate()
			newbutton.set_hidden(false)
			newbutton.set_text(i.name)
			newbutton.connect('pressed',self,'glossaryselect',[i])
			list.add_child(newbutton)


func _on_glossarysearch_text_changed( text ):
	glossarysearch()


func glossaryselect(element):
	for i in get_node("glossarynode/Panel/Container/VBoxContainer").get_children():
		if i.is_pressed == true && i.get_text() != element.name:
			i.set_pressed(false)
		elif i.get_text() == element.name:
			i.set_pressed(true)
	get_node("glossarynode/Panel/glossarytext").set_bbcode(element.text)

func _on_helpglossary_pressed():
	get_node("tutorialnode").callalise()

func oldglossary():
	get_node("glossarynode").popup()
	get_node("glossarynode/Panel/glossarysearch").set_text("")
	glossarysearch()

func _on_glossarytext_meta_clicked( meta ):
	for i in globals.glossary.glossarylist:
		if i.code == meta:
			meta = i
			break
	get_node("glossarynode/Panel/glossarysearch").set_text(meta)
	glossaryselect(meta)


#### selfinsepct


func _on_selfbutton_pressed():
	hide_everything()
	get_node("MainScreen/mansion/selfinspect").set_hidden(false)
	get_node("MainScreen/mansion/selfinspect/selfstatpanel").set_hidden(true)
	get_node("MainScreen/mansion/selfinspect/selfskillpanel").set_hidden(true)
	get_node("MainScreen/mansion/selfinspect/selflookspanel").set_hidden(true)
	var text = '[center]Personal Achievments[/center]\n'
	var text2 = ''
	var slave = globals.player
	var dict = {
	0: "You do not belong in an Order.",
	1: "Neophyte",
	2: "Apprentice",
	3: "Journeyman",
	4: "Adept",
	5: "Master",
	6: "Grand Archmage"}
	text += 'Combat Abilities: '
	for i in slave.ability:
		var ability = globals.abilities.abilitydict[i]
		if ability.learnable == true:
			text2 += ability.name + ', '
	if text2 == '':
		text += 'none. \n'
	else:
		text2 = text2.substr(0, text2.length() -2)+ '. '
	text += text2 + '\nReputation: '
	for i in globals.state.reputation:
		text += i.capitalize() + " - "+ reputationword(globals.state.reputation[i]) + ", "
	text += "\nYour mage order rank: " + dict[int(globals.state.rank)]
	get_node("MainScreen/mansion/selfinspect/mainstatlabel").set_bbcode(text)
	get_node("MainScreen/mansion/selfinspect/statspanel").slave = globals.player
	get_node("MainScreen/mansion/selfinspect/statspanel").mode = 'full'
	get_node("MainScreen/mansion/selfinspect/statspanel").show()
	if slave.imageportait != null:
		if File.new().file_exists(slave.imageportait) == true:
			get_node("MainScreen/mansion/selfinspect/portraittexture").set_hidden(false)
			get_node("MainScreen/mansion/selfinspect/portraittexture").set_texture(load(slave.imageportait))
		else:
			get_node("MainScreen/mansion/selfinspect/portraittexture").set_hidden(true)
			slave.imageportait = null
	else:
		get_node("MainScreen/mansion/selfinspect/portraittexture").set_hidden(true)
	


func _on_selfinspectclose_pressed():
	get_node("MainScreen/mansion/selfinspect").set_hidden(true)
	_on_mansion_pressed()


func _on_selfgear_pressed():
	get_node("itemnode").slave = globals.player
	get_node("paperdoll").slave = globals.player
	get_node("paperdoll").showup()


func reputationword(value):
	var text = ""
	if value >= 30:
		text = "[color=green]Great[/color]"
	elif value >= 10:
		text = "[color=green]Positive[/color]"
	elif value <= -10:
		text = "[color=red]Bad[/color]"
	elif value <= -30:
		text = "[color=red]Terrible[/color]"
	else:
		text = "Neutral"
	return text


func _on_selfinspectlooks_pressed():
	get_node("MainScreen/mansion/selfinspect/selflookspanel/selfdescript").set_bbcode(globals.player.description_full(true))
	get_node("MainScreen/mansion/selfinspect/selflookspanel").set_hidden(false)

func _on_selfskillclose_pressed():
	get_node("MainScreen/mansion/selfinspect/selflookspanel").set_hidden(true)

func _on_selfabilityupgrade_pressed():
	get_node("MainScreen/mansion/selfinspect/selfabilitypanel/abilitydescript").set_bbcode('')
	get_node("MainScreen/mansion/selfinspect/selfabilitypanel").set_hidden(false)
	get_node("MainScreen/mansion/selfinspect/selfabilitypanel/abilitypurchase").set_disabled(true)
	for i in get_node("MainScreen/mansion/selfinspect/selfabilitypanel/ScrollContainer/VBoxContainer").get_children():
		if i != get_node("MainScreen/mansion/selfinspect/selfabilitypanel/ScrollContainer/VBoxContainer/Button"):
			i.set_hidden(true)
			i.queue_free()
	for i in globals.abilities.abilitydict.values():
		if i.learnable == true && globals.player.ability.find(i.code) < 0 && (i.has('requiredspell') == false || globals.spelldict[i.requiredspell].learned == true):
			var newbutton = get_node("MainScreen/mansion/selfinspect/selfabilitypanel/ScrollContainer/VBoxContainer/Button").duplicate()
			get_node("MainScreen/mansion/selfinspect/selfabilitypanel/ScrollContainer/VBoxContainer").add_child(newbutton)
			newbutton.set_hidden(false)
			newbutton.set_text(i.name)
			newbutton.connect("pressed",self,'selfabilityselect',[i])
			


func selfabilityselect(ability):
	var text = ''
	var slave = globals.player
	var dict = {'sstr': 'Strength', 'sagi' : 'Agility', 'smaf': 'Magic', 'level': 'Level'}
	var confirmbutton = get_node("MainScreen/mansion/selfinspect/selfabilitypanel/abilitypurchase")
	
	for i in get_node("MainScreen/mansion/selfinspect/selfabilitypanel/ScrollContainer/VBoxContainer").get_children():
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
	
	
	
	
	get_node("MainScreen/mansion/selfinspect/selfabilitypanel/abilitydescript").set_bbcode(text)





func _on_abilitypurchase_pressed():
	var abil = get_node("MainScreen/mansion/selfinspect/selfabilitypanel/abilitypurchase").get_meta('abil')
	globals.player.ability.append(abil.code)
	popup('You have learned ' + abil.name+'. ')
	_on_selfabilityupgrade_pressed()
	_on_selfbutton_pressed()


func _on_selfportait_pressed():
	imageselect("portrait",globals.player)


func _on_abilityclose_pressed():
	get_node("MainScreen/mansion/selfinspect/selfabilitypanel").set_hidden(true)


func _on_selfpotion_pressed():
	_on_inventory_pressed('self')

var potionselected 

func potbuttonpressed(potion):
	potionselected = potion
	var description = get_node("MainScreen/mansion/selfinspect/selectpotionpanel/potionusedescription")
	var potlist = get_node("MainScreen/mansion/selfinspect/selectpotionpanel/ScrollContainer/selectpotionlist")
	for i in get_tree().get_nodes_in_group('usables'):
		if i.get_text() != potion.name && i.is_pressed() == true:
			i.set_pressed(false)
	description.set_bbcode(potion.description + '\n\nIn possession: ' + str(potion.amount))


func _on_potioncancelbutton_pressed():
	get_node("MainScreen/mansion/selfinspect/selectpotionpanel").set_hidden(true)
	potionselected = ''

func _on_potionusebutton_pressed():
	var slave = globals.player
	var itemnode = get_tree().get_current_scene().get_node('itemnode')
	itemnode.slave = slave
	if potionselected.code != 'minoruspot' && potionselected.code != 'majoruspot' && potionselected.code != 'hairdye':
		if potionselected.code in ['aphrodisiac', 'regressionpot', 'miscariagepot','amnesiapot','stimulantpot','deterrentpot']:
			popup(slave.dictionary(itemnode.call(potionselected.effect)))
			return
		popup(slave.dictionary(itemnode.call(potionselected.effect)))
		_on_selfbutton_pressed()
		slave.toxicity = potionselected.toxicity
		potionselected.amount -= 1
	else:
		itemnode.call(potionselected.effect)
	get_node("MainScreen/mansion/selfinspect/selectpotionpanel").set_hidden(true)



func _on_selfrelatives_pressed():
	get_node("MainScreen/mansion/selfinspect/relativespanel").set_hidden(false)
	var slave = globals.player
	var mother = slave.relatives.mother
	var father = slave.relatives.father
	var id = slave.id
	var parentslist = get_node("MainScreen/mansion/selfinspect/relativespanel/parentscontainer/parentscontainer")
	var siblingslist = get_node("MainScreen/mansion/selfinspect/relativespanel/siblingscontainer/siblingscontainer")
	var childrenlist = get_node("MainScreen/mansion/selfinspect/relativespanel/childrencontainer/childrencontainer")
	var newlabel
	for i in parentslist.get_children():
		if i != parentslist.get_node('Label'):
			i.set_hidden(true)
			i.queue_free()
	for i in siblingslist.get_children():
		if i != siblingslist.get_node('Label'):
			i.set_hidden(true)
			i.queue_free()
	for i in childrenlist.get_children():
		if i != childrenlist.get_node('Label'):
			i.set_hidden(true)
			i.queue_free()
	############PARENTS
	newlabel = parentslist.get_node("Label").duplicate()
	parentslist.add_child(newlabel)
	newlabel.set_hidden(false)
	if mother == -1:
		newlabel.set_text('Mother - unknown')
	else:
		var found = false
		if typeof(mother) == 2 || typeof(mother) == 3:
			for i in globals.slaves:
				if i.id == slave.relatives.mother && i != slave:
					mother = i
					found = true
					newlabel.set_text(i.dictionary('Mother - $name, $race'))
			if found == false:
				newlabel.set_text('Mother - unknown')
	newlabel = parentslist.get_node("Label").duplicate()
	newlabel.set_hidden(false)
	parentslist.add_child(newlabel)
	if father == -1:
		newlabel.set_text('Father - unknown')
	else:
		var found = false
		if typeof(father) == 2 || typeof(father) == 3:
			for i in globals.slaves:
				if i.id == slave.relatives.father:
					father = i
					found = true
					newlabel.set_text(i.dictionary('Father - $name, $race'))
			if found == false:
				newlabel.set_text('Father - unknown')
	####### Siblings
	for i in globals.slaves:
		var found = false
		if i != slave && i.relatives.mother != -1:
			if (i.relatives.mother == slave.relatives.mother|| i.relatives.mother == slave.relatives.father) :
				found = true
		if i != slave && i.relatives.father != -1:
			if (i.relatives.father == slave.relatives.mother || i.relatives.father == slave.relatives.father) :
				found = true
		if found == true:
			newlabel = siblingslist.get_node("Label").duplicate()
			newlabel.set_hidden(false)
			siblingslist.add_child(newlabel)
			newlabel.set_text(i.dictionary("$name - $sibling, $race"))
	#children
	for i in globals.slaves:
		if i.relatives.mother == slave.id || i.relatives.father == slave.id:
			newlabel = childrenlist.get_node("Label").duplicate()
			newlabel.set_hidden(false)
			childrenlist.add_child(newlabel)
			newlabel.set_text(i.dictionary("$name $sex $race"))


func _on_relativesclose_pressed():
	get_node("MainScreen/mansion/selfinspect/relativespanel").set_hidden(true)





######### Headgirl

func _on_headgirl_pressed():
	var dict = {'none':0,'kind':1,'strict':2}
	get_node("MainScreen/mansion/headgirlsettings").set_hidden(false)
	get_node("MainScreen/mansion/headgirlsettings/headgirlbehavior").select(dict[globals.state.headgirlbehavior])
	_on_headgirlbehavior_item_selected(dict[globals.state.headgirlbehavior])


func _on_headgirlclose_pressed():
	get_node("MainScreen/mansion/headgirlsettings").set_hidden(true)


func _on_headgirlbehavior_item_selected( ID ):
	var text = ''
	if ID == 0:
		globals.state.headgirlbehavior = 'none'
		text += "Headgirl will not interfere with others' business. "
	if ID == 1:
		globals.state.headgirlbehavior = 'kind'
		text += "Headgirl will focus on kind approach and improve stress and loyalty of others."
	if ID == 2:
		globals.state.headgirlbehavior = 'strict'
		text += "Headgirl will focus on putting other servants in line at the cost of thier stress. "
	var headgirl = null
	for i in globals.slaves:
		if i.work == 'headgirl':
			headgirl = i
	if headgirl == null:
		text += "\nCurrently you have no headgirl assigned. "
	else:
		text += headgirl.dictionary("\n$name is your current headgirl. ")
	get_node("MainScreen/mansion/headgirlsettings/headgirldescript").set_bbcode(text)

func showracedescript(slave):
	var text = globals.dictionary.getRaceDescription(slave.race)
	dialogue(true, self, text)

func showracedescriptsimple(race):
	var text = globals.dictionary.getRaceDescription(race)
	dialogue(true, self, text)

func _on_orderbutton_pressed():
	for i in get_tree().get_nodes_in_group("sortbutton"):
		if get_node("charlistcontrol/orderbutton").is_pressed() == true:
			i.set_hidden(false)
		else:
			i.set_hidden(true)

####### PORTALS
func _on_portals_pressed():
	_on_mansion_pressed()
	if OS.get_name() != 'HTML5' && globals.rules.fadinganimation == true:
		yield(self, 'animfinished')
	var list = get_node("MainScreen/mansion/portalspanel/ScrollContainer/VBoxContainer")
	var button = get_node("MainScreen/mansion/portalspanel/ScrollContainer/VBoxContainer/portalbutton")
	get_node("MainScreen/mansion/portalspanel").set_hidden(false)
	for i in list.get_children():
		if i != button:
			i.set_hidden(true)
			i.queue_free()
	for i in globals.state.portals.values():
		if i.enabled == true:
			var newbutton = button.duplicate()
			list.add_child(newbutton)
			newbutton.set_text(i.code.capitalize())
			newbutton.set_hidden(false)
			newbutton.connect("pressed",self,'portalbutton', [i])


func portalbutton(i):
	get_node("MainScreen/mansion/portalspanel").set_hidden(true)
	get_node("outside").gooutside()
	get_node("explorationnode").call('zoneenter', i.code)

func _on_portalsclose_pressed():
	get_node("MainScreen/mansion/portalspanel").set_hidden(true)

########FARM
func _on_farmreturn_pressed():
	get_node("MainScreen/mansion/farmpanel").set_hidden(true)

func _on_farm_pressed(inputslave = null):
	var manager = inputslave
	var text = ''
	var residentlimit = [2,5,8,12]
	residentlimit = residentlimit[globals.state.mansionupgrades.farmcapacity]
	for i in globals.slaves:
		if i.work == 'farmmanager':
			manager = i
	if manager != null:
		manager.work = 'farmmanager'
		text = manager.dictionary('Your farm manager is ' + manager.name_long() + '.')
	else:
		text = "[color=yellow]You have no assigned manager. Without manager you won't be able to recieve farm income. [/color]"
	if globals.state.mansionupgrades.farmhatchery > 0:
		text = text + '\n\nYou have ' + str(globals.state.snails) + ' snails.'
	var counter = 0
	var list = get_node("MainScreen/mansion/farmpanel/ScrollContainer/VBoxContainer")
	var button = get_node("MainScreen/mansion/farmpanel/ScrollContainer/VBoxContainer/farmbutton")
	for i in list.get_children():
		if i != button && i != get_node("MainScreen/mansion/farmpanel/ScrollContainer/VBoxContainer/farmadd"):
			i.set_hidden(true)
			i.queue_free()
	for i in globals.slaves:
		if i.sleep == 'farm':
			counter += 1
			var newbutton = button.duplicate()
			newbutton.set_text(i.name_long())
			newbutton.set_hidden(false)
			list.add_child(newbutton)
			newbutton.connect("pressed",self,'farminspect',[i])
	if counter >= residentlimit:
		get_node("MainScreen/mansion/farmpanel/ScrollContainer/VBoxContainer/farmadd").set_disabled(true)
	else:
		get_node("MainScreen/mansion/farmpanel/ScrollContainer/VBoxContainer/farmadd").set_disabled(false)
	if globals.state.mansionupgrades.farmtreatment == 1:
		text += "\n\n[color=green]Your farm won't break down its residents. [/color]"
	else:
		text += "\n\n[color=yellow]Your farm will cause heavy stress to its residents. [/color]"
	text = text + '\n\nYou have ' + str(counter)+ '/' + str(residentlimit) + ' people present in farm. '
	get_node("MainScreen/mansion/farmpanel").set_hidden(false)
	get_node("MainScreen/mansion/farmpanel/farminfo").set_bbcode(text)
	if globals.state.tutorial.farm == false:
		get_node("tutorialnode").farm()

func farminspect(slave):
	get_node("MainScreen/mansion/farmpanel/slavefarminsepct").set_hidden(false)
	if slave.work == 'cow':
		get_node("MainScreen/mansion/farmpanel/slavefarminsepct/slaveassigntext").set_bbcode(slave.dictionary("You walk to the pen with $name. The " +slave.race+ " $child is tightly kept here being milked out of $his mind all day long. $His eyes are devoid of sentience barely reacting at your approach."))
	elif slave.work == 'hen':
		get_node("MainScreen/mansion/farmpanel/slavefarminsepct/slaveassigntext").set_bbcode(slave.dictionary("You walk to the pen with $name. The " +slave.race+ " $child is tightly kept here as a hatchery for giant snail, with a sturdy leather harness covering $his body. $His eyes are devoid of sentience barely reacting at your approach. Crouching down next to $him, you can see the swollen curve of $his stomach, stuffed full of the creature's eggs. As you lay a hand on it, you can feel some movement inside - seems like something hatched quite recently and is making its way to be 'born' from $name's well-used hole."))
	selectedfarmslave = slave
	get_node("MainScreen/mansion/farmpanel/slavefarminsepct/releasefromfarm").set_meta('slave', slave)
	get_node("MainScreen/mansion/farmpanel/slavefarminsepct/sellproduction").set_pressed(slave.farmoutcome)


var selectedfarmslave

func _on_addcow_pressed():
	var slave = selectedfarmslave
	slave.sleep = 'farm'
	slave.work = 'cow'
	popup(slave.dictionary("You put $name into specially designed pen and hook milking cups onto $his nipples, leaving $him shortly after in the custody of farm."))
	_on_closeslavefarm_pressed()
	_on_farm_pressed()
	rebuild_slave_list()


func _on_addhen_pressed():
	var slave = selectedfarmslave
	slave.sleep = 'farm'
	slave.work = 'hen'
	popup(slave.dictionary("You put $name into specially designed pen and fixate $his body, exposing $his orificies to be fully accessible to giant snail, leaving $him shortly after in the custody of farm."))
	_on_closeslavefarm_pressed()
	_on_farm_pressed()
	rebuild_slave_list()


func _on_closeslavefarm_pressed():
	get_node("MainScreen/mansion/farmpanel/slavetofarm").set_hidden(true)


func _on_farmadd_pressed():
	get_node("MainScreen/mansion/farmpanel/slavetofarm").set_hidden(false)
	selectslavelist(false, 'farmassignpanel')

func farmassignpanel(slave):
	selectedfarmslave = slave
	if slave.tits.lactation == true:
		get_node("MainScreen/mansion/farmpanel/slavetofarm/addcow").set_disabled(false)
		get_node("MainScreen/mansion/farmpanel/slavetofarm/addcow").set_tooltip('')
	else:
		get_node("MainScreen/mansion/farmpanel/slavetofarm/addcow").set_tooltip(slave.dictionary('$name is not lactating.'))
		get_node("MainScreen/mansion/farmpanel/slavetofarm/addcow").set_disabled(true)
	var counter = 0
	for i in globals.slaves:
		if i.work == 'hen':
			counter += 1
	if globals.state.mansionupgrades.farmhatchery == 0:
		get_node("MainScreen/mansion/farmpanel/slavetofarm/addhen").set_disabled(true)
		get_node("MainScreen/mansion/farmpanel/slavetofarm/addhen").set_tooltip("You have to unlock Hatchery first.")
	else:
		if counter >= globals.state.snails:
			get_node("MainScreen/mansion/farmpanel/slavetofarm/addhen").set_disabled(true)
			get_node("MainScreen/mansion/farmpanel/slavetofarm/addhen").set_tooltip("You don't have any free snails.")
		else:
			get_node("MainScreen/mansion/farmpanel/slavetofarm/addhen").set_disabled(false)
			get_node("MainScreen/mansion/farmpanel/slavetofarm/addhen").set_tooltip("")
	get_node("MainScreen/mansion/farmpanel/slavetofarm/slaveassigntext").set_bbcode("Selected servant - " + slave.name_long()+ '. \nLactation: ' +globals.fastif(slave.tits.lactation == true, '[color=green]present[/color]', '[color=red]not present[/color]')+ '. \nTits size : '+slave.tits.size)

func _on_releasefromfarm_pressed():
	var slave = get_node("MainScreen/mansion/farmpanel/slavefarminsepct/releasefromfarm").get_meta('slave')
	slave.work = 'rest'
	slave.sleep = 'communal'
	get_node("MainScreen/mansion/farmpanel/slavefarminsepct").set_hidden(true)
	_on_farm_pressed()
	rebuild_slave_list()

func _on_closeslaveinspect_pressed():
	get_node("MainScreen/mansion/farmpanel/slavefarminsepct").set_hidden(true)

func _on_sellproduction_pressed():
	selectedfarmslave.farmoutcome = get_node("MainScreen/mansion/farmpanel/slavefarminsepct/sellproduction").is_pressed()

func _on_over_pressed():
	mainmenu()




func _on_endlog_pressed():
	get_node("FinishDayPanel").set_hidden(false)


var nodetocall
var functiontocall

func selectslavelist(prisoners = false, calledfunction = 'popup', targetnode = self, reqs = 'true', player = false, onlyparty = false):
	nodetocall = targetnode
	functiontocall = calledfunction
	for i in find_node("chooseslavelist").get_children():
		i.set_hidden(true)
		i.free()
	if player == true:
		var slave = globals.player
		var button = load("res://files/ChoseSlaveButton.tscn").instance()
		button.get_node("slaveinfo").set_bbcode(slave.name_long()+', '+slave.race+ ' - You.')
		button.connect("pressed", self, "slaveselected", [button])
		button.set_meta("slave", slave)
		if slave.imageportait != null:
			if File.new().file_exists(slave.imageportait) == true:
				button.get_node("portrait").set_texture(load(slave.imageportait))
		get_node("chooseslavepopup/Panel/ScrollContainer/chooseslavelist").add_child(button)
	for slave in globals.slaves:
		if slave.away.duration == 0:
			if onlyparty == true && globals.state.playergroup.find(slave.id) < 0:
				continue
			globals.currentslave = slave
			if prisoners == false || slave.sleep != 'jail' :
				var button = load("res://files/ChoseSlaveButton.tscn").instance()
				button.get_node("slaveinfo").set_bbcode(slave.name_long()+', '+slave.race+ ', occupation - ' + slave.work + ", grade - " + slave.origins.capitalize())
				button.connect("pressed", self, "slaveselected", [button])
				button.set_meta("slave", slave)
				if slave.imageportait != null:
					if File.new().file_exists(slave.imageportait) == true:
						button.get_node("portrait").set_texture(load(slave.imageportait))
				get_node("chooseslavepopup/Panel/ScrollContainer/chooseslavelist").add_child(button)
				if globals.evaluate(reqs) == false:
					button.set_disabled(true)
					button.set_tooltip(slave.dictionary("$name does not pass the requirements."))
	get_node("chooseslavepopup").popup()
	_on_hideinvalidslaves_pressed()

func slaveselected(button):
	var slave = button.get_meta('slave')
	nodetocall.call(functiontocall, slave)
	get_node("chooseslavepopup").set_hidden(true)


func _on_hideinvalidslaves_pressed():
	for i in get_node("chooseslavepopup/Panel/ScrollContainer/chooseslavelist").get_children():
		if i.is_disabled() == true && get_node("chooseslavepopup/Panel/hideinvalidslaves").is_pressed() == true:
			i.set_hidden(true)
		else:
			i.set_hidden(false)






func _on_startcombat_pressed():
	globals.state.playergroup.append(globals.slaves[0].id)
	var array = []
	array.append(globals.player)
	for i in globals.state.playergroup:
		array.append(globals.state.findslave(i))
	for i in array:
		for j in ['sstr','sagi','smaf','send','wit','cour','conf','charm','health']:
			i[j] = 100
	get_node("outside").gooutside()
	globals.state.backpack.stackables.rope = 3
	get_node("explorationnode").zoneenter("mountains")
	#get_node("combat").start_battle()

func checkplayergroup():
	var removed = []
	var checked = false
	for i in range(0, globals.state.playergroup.size()):
		checked = false
		for ii in globals.slaves:
			if ii.id == globals.state.playergroup[i] && ii.away.duration <= 0 && ii.away.at != 'hidden':
				checked = true
		if checked == false:
			removed.append(i)
	removed.invert()
	for i in removed:
		globals.state.playergroup.remove(i)






func _on_cleanbutton_pressed():
	var text = ''
	get_node("MainScreen/mansion/cleandialog").popup()
	text += "Cleaning can be done by either assigning your slaves to the cleaning task or by hiring one time help from city. \n\nCost: "
	text += '[color=yellow]' + str(min(ceil(globals.resources.day/5.0)*10,100)) + '[/color]'
	if globals.resources.gold >= min(ceil(globals.resources.day/5.0)*10,100) && globals.state.condition < 80:
		get_node("MainScreen/mansion/cleandialog/cleaningbutton").set_disabled(false)
	elif globals.state.condition >= 80:
		text += '\n\nYour mansion requires no cleaning.'
		get_node("MainScreen/mansion/cleandialog/cleaningbutton").set_disabled(true)
	else:
		text += "\n\nYou don't have enough gold."
		get_node("MainScreen/mansion/cleandialog/cleaningbutton").set_disabled(true)

	get_node("MainScreen/mansion/cleandialog/cleaningtext").set_bbcode(text)

func _on_cleaningbutton_pressed():
	globals.state.condition = 100
	globals.resources.gold -= min(ceil(globals.resources.day/7.0)*10,100)
	get_node("MainScreen/mansion/cleandialog").set_hidden(true)
	_on_mansion_pressed()




func _on_defeateddescript_meta_clicked( meta ):
	var slave = get_node("explorationnode/winningpanel/defeateddescript").get_meta('slave')
	showracedescript(slave)





func _on_selloutclose_pressed():
	get_node("sellout").set_hidden(true)


func _on_sellouttext_meta_clicked( meta ):
	OS.shell_open('https://www.patreon.com/maverik')




func _on_popupclosebutton_pressed():
	get_node("popupmessage").set_hidden(true)


func infotext(newtext):
	if (enddayprocess == true && newtext.findn("trait") < 0) || newtext == '' || (get_node("combat").is_visible() && get_node("combat/win").is_hidden()):
		return
	if get_node("infotext").get_children().size() >= 15:
		get_node("infotext").get_child(get_node("infotext").get_children().size() - 14).queue_free()
	var text = '[right]'+ newtext + '[/right]'
	var label = get_node("infotext/Label").duplicate()
	label.set_bbcode(text + " ")
	label.set_opacity(1)
	var timer = Timer.new()
	timer.set_wait_time(4)
	timer.start()
	timer.connect("timeout", self, 'infotextfade', [label])
	timer.set_name("timer")
	label.add_child(timer)
	get_node("infotext").add_child(label)
	label.set_hidden(false)

func infotextfade(label):
	label.add_to_group('messages')
	label.get_node('timer').stop()



func _on_infotextpanel_mouse_enter():
	for i in get_node("infotext").get_children():
		if i != get_node("infotext/Label"):
			i.set_opacity(1)
			if i.is_in_group("messages"):
				i.remove_from_group("messages")


func setname(slave):
	var text = slave.dictionary("Choose new name for $name")
	get_node("entertext").set_hidden(false)
	get_node("entertext").set_meta("action", "rename")
	get_node("entertext").set_meta("slave", slave)
	get_node("entertext/dialoguetext").set_bbcode(text)

func _on_confirmentertext_pressed():
	var text = get_node("entertext/LineEdit").get_text()
	if text == "":
		return
	var slave
	var meta = get_node("entertext").get_meta("action")
	if meta == 'rename':
		slave = get_node("entertext").get_meta("slave")
		slave.name = text
		rebuild_slave_list()
	get_node("entertext").set_hidden(true)

func _on_infotextpanel_mouse_exit():
	for i in get_node("infotext").get_children():
		if i != get_node("infotext/Label"):
			i.set_opacity(1)
			i.add_to_group("messages")

func _on_slavelist_pressed():
	get_node("slavelist").set_hidden(!get_node("slavelist").is_hidden())
	slavelist()


func slavelist():
	for i in get_node("slavelist/ScrollContainer/VBoxContainer").get_children():
		if i != get_node("slavelist/ScrollContainer/VBoxContainer/line"):
			i.set_hidden(true)
			i.queue_free()
	for slave in globals.slaves:
		if slave.away.duration == 0 && !slave.sleep in ['farm']:
			var newline = get_node("slavelist/ScrollContainer/VBoxContainer/line").duplicate()
			newline.set_hidden(false)
			get_node("slavelist/ScrollContainer/VBoxContainer").add_child(newline)
			newline.get_node("line/name/choseslave").connect("pressed",self,'openslave',[slave])
			newline.get_node("line/name/Label").set_text(slave.name_short())
			newline.get_node("line/grade/Label").set_text(slave.origins.capitalize())
			if slave.spec != null:
				newline.get_node("line/spec/Label").set_text(slave.spec.capitalize())
			else:
				newline.get_node("line/spec/Label").set_text("None")
			newline.get_node("line/phys/Label").set_text("S:" + str(slave.sstr) + " A:" + str(slave.sagi) + " M:" + str(slave.smaf) + " E:"+str(slave.send))
			newline.get_node("line/mentals/Label").set_text("R:" + str(slave.cour) + " O:" + str(slave.conf) + " W:" + str(slave.wit) + " H:" + str(slave.charm) )
			newline.get_node("line/mentals").set_custom_minimum_size(newline.get_node("line/mentals/Label").get_minimum_size() + Vector2(10,0))
			newline.get_node("line/race/Label").set_text(slave.race_short())
			newline.get_node("line/race/Label").set_tooltip(slave.race)
			newline.get_node("job").set_text(get_node("MainScreen/slave_tab").jobdict[slave.work].name)
			newline.get_node("job").connect("pressed",self,'selectjob',[slave])
			if slave.sleep == 'jail':
				newline.get_node("job").set_disabled(true)
			newline.get_node("sleep").set_text(globals.sleepdict[slave.sleep].name)
			newline.get_node("sleep").set_meta("slave", slave)
			newline.get_node("sleep").connect("pressed", self, 'sleeppressed', [newline.get_node("sleep")])
			newline.get_node("sleep").connect("item_selected",self, 'sleepselect', [newline.get_node("sleep")])


func sleeppressed(button):
	var slave = button.get_meta('slave')
	var beds = globals.count_sleepers()
	button.clear()
	button.add_item(globals.sleepdict['communal'].name)
	if slave.sleep == 'communal':
		button.set_item_disabled(button.get_item_count()-1, true)
		button.select(button.get_item_count()-1)
	button.add_item(globals.sleepdict['jail'].name)
	if beds.jail >= globals.state.mansionupgrades.jailcapacity:
		button.set_item_disabled(button.get_item_count()-1, true)
	if slave.sleep == 'jail':
		button.set_item_disabled(button.get_item_count()-1, true)
		button.select(button.get_item_count()-1)
	button.add_item(globals.sleepdict['personal'].name)
	if beds.personal >= globals.state.mansionupgrades.mansionpersonal:
		button.set_item_disabled(button.get_item_count()-1, true)
	if slave.sleep == 'personal':
		button.set_item_disabled(button.get_item_count()-1, true)
		button.select(button.get_item_count()-1)
	button.add_item(globals.sleepdict['your'].name)
	if beds.your_bed >= globals.state.mansionupgrades.mansionbed || (slave.loyal + slave.obed < 130 || slave.tags.find('nosex') >= 0):
		button.set_item_disabled(button.get_item_count()-1, true)
	if slave.sleep == 'your':
		button.set_item_disabled(button.get_item_count()-1, true)
		button.select(button.get_item_count()-1)

var sleepdict = {0 : 'communal', 1 : 'jail', 2 : 'personal', 3 : 'your'}

func sleepselect(item, button):
	var slave = button.get_meta('slave')
	slave.sleep = sleepdict[item]
	if slave.sleep == 'jail':
		slave.work = 'rest'
	rebuild_slave_list()
	slavelist()



func selectjob(slave):
	globals.currentslave = slave
	joblist()

func openslave(slave):
	currentslave = globals.slaves.find(slave)
	if get_node("MainScreen/slave_tab").is_visible():
		get_node("MainScreen/slave_tab").set_hidden(true)
	get_node("MainScreen/slave_tab").set_hidden(false)
	get_node("slavelist").set_hidden(true)

func joblist():
	get_node("joblist").joblist()

func _on_listclose_pressed():
	get_node("slavelist").set_hidden(true)




var itemselected
var categoryselected
var inventorymode = 'mainscreen'


func _on_inventory_pressed(mode = 'mainscreen'):
	get_node("inventory").popup()
	inventorymode = mode
	itemselected = null
	selectcategory(get_node("inventory/Panel/everything"))
	get_node("inventory/Panel/everything").set_pressed(true)
	get_node("inventory/Panel/applytoslave").set_hidden(true)
	get_node("inventory/Panel/discard").set_hidden(true)
	get_node("inventory/Panel/iteminfo").set_bbcode("")
	get_node("inventory/Panel/iconbig").set_hidden(true)
	sortitems()

func selectcategory(button):
	categoryselected = button.get_name().to_lower()
	button.set_pressed(true)
	for i in get_tree().get_nodes_in_group("invcategories"):
		if i != button:
			i.set_pressed(false)
	sortitems()

func sortitems():
	var itemgrid = get_node("inventory/Panel/ScrollContainer/GridContainer")
	var button
	var array = []
	var items = false
	if itemselected != null && itemselected.has('id') == false:
		if itemselected.amount <= 0:
			_on_inventory_pressed()
			return
	for i in get_tree().get_nodes_in_group("inventoryitems"):
		i.set_hidden(true)
		i.queue_free()
	for i in globals.itemdict.values():
		array.append(i)
	array.sort_custom(get_node("itemnode"),'sortitems')
	for i in array:
		if i.amount < 1 || i.type in ['gear','dummy']:
			continue
		if categoryselected.findn(i.type) < 0 && categoryselected != 'everything':
			continue
		items = true
		button = get_node("inventory/Panel/ScrollContainer/GridContainer/TextureButton").duplicate()
		button.set_hidden(false)
		button.get_node('number').set_text(str(i.amount))
		if i.icon != null:
			button.get_node("icon").set_texture(i.icon)
		else:
			button.get_node("Label").set_text(i.name)
			button.get_node("Label").set_hidden(false)
			#button.get_node("icon").set_texture(globals.noimage)
		button.connect("pressed",self,"itemselected",[button])
		button.connect("mouse_enter",self,'itemhovered',[button])
		button.connect("mouse_exit",self,'itemunhovered',[button])
		button.set_meta("item", i)
		button.add_to_group('inventoryitems')
		itemgrid.add_child(button)
	for i in globals.state.unstackables.values():
		if i.owner != null && globals.state.findslave(i.owner) == null && i.owner != globals.player.id:
			i.owner = null
		if i.owner == null && (categoryselected == 'everything' || categoryselected == 'gear' ):
			items = true
			button = get_node("inventory/Panel/ScrollContainer/GridContainer/TextureButton").duplicate()
			button.set_hidden(false)
			button.get_node('number').set_hidden(true)
			if i.icon != null:
				button.get_node("icon").set_texture(load(i.icon))
			else:
				button.get_node("Label").set_text(i.name)
				button.get_node("Label").set_hidden(false)
			button.connect("pressed",self,"itemselected",[button])
			button.connect("mouse_enter",self,'itemhovered',[button])
			button.connect("mouse_exit",self,'itemunhovered',[button])
			button.set_meta("item", i)
			button.add_to_group('inventoryitems')
			itemgrid.add_child(button)
	
	
	#get_node("inventory/Panel/iconbig").set_hidden(true)
	get_node("inventory/Panel/noitems").set_hidden(items)


func itemselected(button):
	var text = ''
	var item = button.get_meta("item")
	itemselected = item
	for i in get_tree().get_nodes_in_group("inventoryitems"):
		if i != button:
			i.set_pressed(false)
	if item.type in ['costume','underwear','armor','weapon','accessory']:
		get_node("inventory/Panel/applytoslave").set_text("Equip")
		text = "[center]" + item.name + "[/center]\n\n" +"Type: " + item.type + "\n\n" + get_node("itemnode").itemlist[item.code].description
		if item.icon != null:
			get_node("inventory/Panel/iconbig").set_texture(load(item.icon))
			get_node("inventory/Panel/iconbig").set_hidden(false)
		else:
			get_node("inventory/Panel/iconbig").set_hidden(true)
		if item.effects.size() > 0:
			text += "\n\n[color=green]Effects: [/color]"
		for k in item.effects:
			text += "\n" + k.descript
	else:
		get_node("inventory/Panel/iconbig").set_hidden(true)
		get_node("inventory/Panel/applytoslave").set_text("Use")
		text = "[center]" + item.name + "[/center]\n\n" +"Type: " + item.type + "\nPrice: " + str(item.cost) + "\nIn possession: " + str(item.amount) + "\n\n" + item.description
	get_node("inventory/Panel/iteminfo").set_bbcode(text)
	get_node("inventory/Panel/discard").set_hidden(false)
	if itemselected.type in ['ingredient']:
		get_node("inventory/Panel/applytoslave").set_hidden(true)
	else:
		get_node("inventory/Panel/applytoslave").set_hidden(false)

func itemhovered(button):
	var item = button.get_meta("item")
	var pos
	get_node("inventory/Panel/tooltip/Label").set_text(item.name)
	get_node("inventory/Panel/tooltip").set_hidden(false)
	pos = button.get_global_pos()
	pos.y -= 40
	pos.x -= 62
	
	get_node("inventory/Panel/tooltip").set_global_pos(pos)

func itemunhovered(button):
	get_node("inventory/Panel/tooltip").set_hidden(true)

func _on_applytoslave_pressed():
	if inventorymode == 'mainscreen':
		selectslavelist(true, 'useitem', self, 'true', true )
	elif inventorymode == 'self':
		useitem(globals.player)
		get_node("inventory").set_hidden(true)
	else:
		useitem(get_node("MainScreen/slave_tab").slave)
		get_node("MainScreen/slave_tab")._on_slave_tab_visibility_changed()
		get_node("inventory").set_hidden(true)

func useitem(slave):
	var tempitem
	get_node("itemnode").slave = slave
	if itemselected.code in ['aphrodisiac', 'regressionpot', 'miscariagepot','amnesiapot','stimulantpot','deterrentpot'] && slave == globals.player:
		popup(slave.dictionary(get_node("itemnode").call(itemselected.effect)))
		return
	slave.metrics.item += 1
	if itemselected.type == 'potion':
		if itemselected.code != 'minoruspot' && itemselected.code != 'majoruspot' && itemselected.code != 'hairdye':
			get_tree().get_current_scene().popup(slave.dictionary(get_node("itemnode").call(itemselected.effect)))
			slave.toxicity = itemselected.toxicity
			itemselected.amount -= 1
		else:
			get_node("itemnode").call(itemselected.effect)
			get_node("inventory").set_hidden(true)
	else:
		if itemselected.reqs != null:
			get_node("itemnode").slave = slave
			if get_node("itemnode").checkreqs(itemselected) == false:
				infotext(slave.dictionary("[color=red]$name does not pass the requirements for ") + itemselected.name + '[/color]')
				return
		if slave.gear[itemselected.type] != null && !slave.gear[itemselected.type] in ['clothcommon','underwearplain']:
			tempitem = globals.state.unstackables[slave.gear[itemselected.type]]
			for i in tempitem.effects:
				if i.type == 'onequip':
					get_node("itemnode").call(i.effect, -i.effectvalue)
			tempitem.owner = null
		slave.gear[itemselected.type] = itemselected.id
		itemselected.owner = slave.id
		for i in itemselected.effects:
			if i.type == 'onequip':
				get_tree().get_current_scene().get_node("itemnode").call(i.effect, i.effectvalue)
		itemselected = null
		_on_inventory_pressed()
		return
	sortitems()


func _on_discard_pressed():
	if itemselected.has('id'):
		globals.state.unstackables.erase(itemselected.id)
		_on_inventory_pressed()
	else:
		itemselected.amount -= 1
		sortitems()

func _on_inventoryclose_pressed():
	get_node("inventory").set_hidden(true)

func _on_hideui_pressed():
	if get_node("combat").is_visible() == true:
		infotext("Can't hide UI during combat")
		return
	get_node("outside").set_hidden(get_node("outside").is_visible())
	get_node("ResourcePanel").set_hidden(get_node("ResourcePanel").is_visible())
	if get_node("hideui").get_text() == 'Hide UI':
		get_node("hideui").set_text("Unhide UI")
	else:
		get_node("hideui").set_text("Hide UI")



func _on_wiki_pressed():
	OS.shell_open('http://strive4power.wikia.com/wiki/Strive4power_Wiki')


var panelshown = false

func _on_buttonpanel_mouse_enter():
	get_node("buttonpanel/leavenode").set_hidden(false)
	if panelshown == false:
		get_node("AnimationPlayer").play("panelshow")
		panelshown = true

func _on_leavenode_mouse_enter():
	if panelshown == true:
		get_node("buttonpanel/leavenode").set_hidden(true)
		get_node("AnimationPlayer").play_backwards("panelshow")
		panelshown = false


func _on_personal_pressed():
	_on_selfbutton_pressed()



func alisegreet():
	get_node("tutorialnode").set_hidden(false)
	get_node("tutorialnode").alisegreet()


func _on_ugrades_pressed():
	get_node("MainScreen/mansion/upgradespanel").show()

func _on_upgradesclose_pressed():
	get_node("MainScreen/mansion/upgradespanel").set_hidden(true)

func imageselect(mode = 'portrait', slave = globals.currentslave):
	if OS.get_name() != 'HTML5':
		get_node("imageselect").slave = slave
		get_node("imageselect").mode = mode
		get_node("imageselect").chooseimage()
	else:
		popup("Sorry, this option can't be utilized in HTML5 Version. ")

#Sex & interactions


func _on_sexbutton_pressed():
	sexslaves.clear()
	sexassist.clear()
	sexselect()

var sexarray = ['sex','abuse']
var sexmode = 'sex'

func sexselect():
	var newbutton
	get_node("sexselect").set_hidden(false)
	get_node("sexselect/selectbutton").set_text('Mode: ' + sexmode.capitalize())
	for i in get_node("sexselect/ScrollContainer1/VBoxContainer").get_children() + get_node("sexselect/ScrollContainer/VBoxContainer").get_children():
		if i.get_name() != 'Button':
			i.set_hidden(true)
			i.queue_free()
	for i in globals.slaves:
		if sexmode == 'sex':
			if i.consent == false || i.away.duration > 0 || i.sleep in ['jail','farm']:
				continue
			newbutton = get_node("sexselect/ScrollContainer/VBoxContainer/Button").duplicate()
			get_node("sexselect/ScrollContainer/VBoxContainer").add_child(newbutton)
			newbutton.set_text(i.dictionary('$name'))
			newbutton.set_hidden(false)
			if sexslaves.find(i) >= 0:
				newbutton.set_pressed(true)
			newbutton.connect("pressed",self,'selectsexslave',[newbutton, i])
			if i.lastinteractionday == globals.resources.day:
				newbutton.set_disabled(true)
				newbutton.set_tooltip(i.dictionary('You have already interacted with $name today.'))
		elif sexmode == 'abuse':
			if i.away.duration > 0 || i.sleep in ['farm']:
				continue
			newbutton = get_node("sexselect/ScrollContainer/VBoxContainer/Button").duplicate()
			get_node("sexselect/ScrollContainer/VBoxContainer").add_child(newbutton)
			newbutton.set_text(i.dictionary('$name'))
			newbutton.set_hidden(false)
			if sexslaves.find(i) >= 0:
				newbutton.set_pressed(true)
			elif sexslaves.size() > 0:
				newbutton.set_disabled(true)
			newbutton.connect("pressed",self,'selectsexslave',[newbutton, i])
			if i.consent == false || sexslaves.find(i) >= 0:
				continue
			newbutton = get_node("sexselect/ScrollContainer/VBoxContainer/Button").duplicate()
			get_node("sexselect/ScrollContainer1/VBoxContainer").add_child(newbutton)
			newbutton.set_text(i.dictionary('$name'))
			newbutton.set_hidden(false)
			if sexassist.find(i) >= 0:
				newbutton.set_pressed(true)
			elif sexassist.size() > 0:
				newbutton.set_disabled(true)
			newbutton.connect("pressed",self,'selectassist',[newbutton, i])
			if i.lastinteractionday == globals.resources.day:
				newbutton.set_disabled(true)
				newbutton.set_tooltip(i.dictionary('You have already interacted with $name today.'))
	updatedescription()

func _on_selectbutton_pressed():
	sexmode = sexarray[sexarray.find(sexmode)+1] if sexarray.size() > sexarray.find(sexmode)+1 else sexarray[0]
	_on_sexbutton_pressed()

var sexslaves = []
var sexassist = []

func selectsexslave(button, slave):
	if button.is_pressed():
		sexslaves.append(slave)
		if sexassist.find(slave) >= 0:
			sexassist.erase(slave)
	else:
		sexslaves.erase(slave)
	sexselect()

func selectassist(button, slave):
	if button.is_pressed():
		sexassist.append(slave)
	else:
		sexassist.erase(slave)
	sexselect()

func updatedescription():
	var text = ''
	
	if sexmode == 'sex':
		if sexslaves.size() <= 1:
			text += "[center][color=yellow]Consensual Sex[/color][/center]"
		elif sexslaves.size() in [2,3]:
			text += "[center][color=yellow]Group sex[/color][/center]"
		else:
			text += "[center][color=yellow]Orgy[/color][/center]"
			text += "\n[color=aqua]Aphrodite's Brew[/color] is required to initialize an orgy. "
		text += "\nConsent is required from participants. \nCurrent participants: "
		for i in sexslaves:
			text += i.dictionary('$name') + ", "
		text = text.substr(0, text.length() - 2) + '.\nClick Start to initiate.'
	elif sexmode == 'abuse':
		text += "[center][color=yellow]Rape[/color][/center]"
		text += "\nRequires a target and an optional assistant. Can be initiated with prisoners. \nCurrent target: "
		for i in sexslaves:
			text += i.dictionary('$name') + ". " 
		text += "\nCurrent assistant: "
		for i in sexassist:
			text += i.dictionary('$name') + ". "
		text += '\nClick Start to initiate.'
		get_node("sexselect/startbutton").set_disabled(sexslaves.size() == 1 && sexassist.size() <= 1)
	
	if sexslaves.size() >= 4 && sexmode == 'sex':
		get_node("sexselect/startbutton").set_disabled(globals.itemdict.aphroditebrew.amount < 1)
	elif sexslaves.size() == 0:
		get_node("sexselect/startbutton").set_disabled(true)
	else:
		get_node("sexselect/startbutton").set_disabled(false)
	get_node("sexselect/sextext").set_bbcode(text)


func _on_startbutton_pressed():
	var mode = 'normal'
	if sexmode == 'abuse':
		mode = 'rape'
		get_node("interactions").startsequence([globals.player] + sexassist, mode, sexslaves)
	else:
		get_node("interactions").startsequence([globals.player] + sexslaves + sexassist, mode)
	get_node("Navigation").set_hidden(true)
	get_node("buttonpanel").set_hidden(true)
	get_node('MainScreen').set_hidden(true)
	get_node("charlistcontrol").set_hidden(true)
	get_node("interactions").set_hidden(false)
	get_node("sexselect").set_hidden(true)

func _on_cancelbutton_pressed():
	get_node("sexselect").set_hidden(true)


