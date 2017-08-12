
extends Node

var itemdict = {}
var spelldict = {}
var effectdict = {}
var guildslaves = {wimborn = [], gorn = [], frostford = []}
var gameversion = 4461
var state = progress.new()
var developmode = false

var resources = resource.new()
var slavegen = load("res://files/scripts/slavegen.gd").new()
var assets = load("res://files/scripts/assets.gd").new()
var races = load("res://files/scripts/races.gd").new()
var origins = load("res://files/scripts/origins.gd").new()
var description = load("res://files/scripts/description.gd").new()
var dictionary = load("res://files/scripts/dictionary.gd").new()
var sexscenes = load("res://files/scripts/sexscenes.gd").new()
var glossary = load("res://files/scripts/glossary.gd").new()
var repeatables = load("res://files/scripts/repeatable_quests.gd").new()
var abilities = load("res://files/scripts/abilities.gd").new()
var effects = load("res://files/scripts/effects.gd").new()
var events = load("res://files/scripts/events.gd").new()
var dailyevents = load("res://files/scripts/dailyevents.gd").new()
var jobs = load("res://files/scripts/jobs&specs.gd").new()
var questtext = events.textnode
var slaves = [] setget slaves_set
var starting_pc_races = ['Human', 'Elf', 'Dark Elf', 'Orc', 'Demon', 'Beastkin Cat', 'Beastkin Wolf', 'Beastkin Fox', 'Halfkin Cat', 'Halfkin Wolf', 'Halfkin Fox', 'Taurus']
var wimbornraces = ['Human', 'Elf', 'Dark Elf', 'Demon', 'Beastkin Cat', 'Beastkin Wolf','Beastkin Tanuki','Beastkin Bunny', 'Halfkin Cat', 'Halfkin Wolf', 'Halfkin Tanuki','Halfkin Bunny','Taurus','Fairy']
var gornraces = ['Human', 'Orc', 'Goblin', 'Gnome', 'Taurus', 'Centaur','Beastkin Cat', 'Beastkin Tanuki','Beastkin Bunny', 'Halfkin Cat','Halfkin Bunny','Halfkin Bunny', 'Harpy']
var frostfordraces = ['Human','Elf','Drow','Beastkin Cat', 'Beastkin Wolf', 'Beastkin Fox', 'Beastkin Tanuki','Beastkin Bunny', 'Halfkin Cat', 'Halfkin Wolf', 'Halfkin Fox','Halfkin Bunny','Halfkin Bunny', 'Nereid']
var allracesarray = ['Human', 'Elf', 'Dark Elf', 'Orc', 'Drow','Beastkin Cat', 'Beastkin Wolf', 'Beastkin Fox','Beastkin Tanuki','Beastkin Bunny', 'Halfkin Cat', 'Halfkin Wolf', 'Halfkin Fox','Halfkin Tanuki','Halfkin Bunny','Taurus', 'Demon', 'Seraph', 'Gnome','Goblin','Centaur','Lamia','Arachna','Scylla', 'Slime', 'Harpy','Dryad','Fairy','Nereid','Dragonkin']
var banditraces = ['Human', 'Elf', 'Dark Elf', 'Demon', 'Beastkin Cat', 'Beastkin Wolf','Beastkin Tanuki','Beastkin Bunny', 'Halfkin Cat', 'Halfkin Wolf','Taurus','Orc','Goblin']
var monsterraces = ['Centaur','Lamia','Arachna','Scylla', 'Slime', 'Harpy','Nereid']
var specarray = ['geisha','ranger','executor','bodyguard','assassin','housekeeper','trapper','nympho','merchant','tamer']
var player = slave.new()
var partner
var clothes = load("res://files/scripts/clothes.gd").costumelist()
var underwear = load("res://files/scripts/clothes.gd").underwearlist()

var musicdict = {
combat1 = load("res://files/music/Corruption.ogg"),
combat2 = load("res://files/music/Crossing_the_Chasm.ogg"),
combat3 = load("res://files/music/Evil_Incoming.ogg"),
mansion1 = load("res://files/music/Bittersweet.ogg"),
mansion2 = load("res://files/music/Chill_China_Love.ogg"),
mansion3 = load("res://files/music/Chill_Cool_NIght.ogg"),
mansion4 = load("res://files/music/Chill_Deep.ogg"),
mansion5 = load("res://files/music/Chill_Openness.ogg"),
wimborn = load("res://files/music/Latinish.ogg"),
gorn = load("res://files/music/Mystery_Bazaar.ogg"),
explore = load("res://files/music/Journey_of_Solitude.ogg"),
maintheme = load("res://files/music/Heights.ogg"),
}
var backgrounds = {
mansion = load("res://files/backgrounds/mansion.png"),
jail = load("res://files/backgrounds/jail.png"),
alchemy = load("res://files/backgrounds/alchemy.jpg"),
wimborn = load("res://files/backgrounds/town.png"),
mageorder = load("res://files/backgrounds/mageorder.png"),
slaverguild = load("res://files/backgrounds/slaveguild.png"),
market = load("res://files/backgrounds/market.jpg"),
brothel = load("res://files/backgrounds/brothel.jpg"),
library = load("res://files/backgrounds/library.jpg"),
forest = load("res://files/backgrounds/forest.jpg"),
shaliq = load("res://files/backgrounds/shaliq.jpg"),
crossroads = load("res://files/backgrounds/crossroads.jpg"),
grove = load("res://files/backgrounds/grove.jpg"),
highlands = load("res://files/backgrounds/highlands.jpg"),
marsh = load("res://files/backgrounds/marsh.jpg"),
meadows = load("res://files/backgrounds/meadows.jpg"),
sea = load("res://files/backgrounds/sea.jpg"),
lab1 = load("res://files/backgrounds/laboratory1.jpg"),
lab2 = load("res://files/backgrounds/laboratory2.jpg"),
gorn = load("res://files/backgrounds/gorn.jpg"),
frostford = load("res://files/backgrounds/frostford.jpg"),
mountains = load("res://files/backgrounds/mountains.jpg"),
borealforest = load("res://files/backgrounds/borealforest.jpg"),
amberguard = load("res://files/backgrounds/amberguard.jpg"),
amberroad = load("res://files/backgrounds/amberroad.png"),
undercity = load("res://files/backgrounds/undercity.jpg"),
tunnels = load("res://files/backgrounds/tunnels.jpg"),
}
var mansionupgradesdict = {
farmcapacity = {
name = "Capacity", 
code = 'farmcapacity',
description = "Adds new stables to the farm, increasing number of residents that can be assigned at a time.", 
levels = 3,
cost = 500,
pointscost = 3,
valuename = "Allowed cattle: ",
valuenumber = ['2','5','8','12'],
},
farmhatchery = {
name = "Hatchery", 
code = 'farmhatchery',
description = "Provides the farm with new equipment, allowing the use of slaves and snails for egg laying.", 
levels = 1,
pointscost = 10,
cost = 1000,
},
farmtreatment = {
name = "Improved Treatment", 
code = 'farmtreatment',
description = "Equips the farm with relaxation furniture and devices which are gentler on your cattle negating the demoralization of residents on the farm.", 
levels = 1,
pointscost = 20,
cost = 2500,
},

foodcapacity = {
name = "Food Storage Capacity",
code = 'foodcapacity',
description = "Adds additional space to the food storage area allowing you to keep more food at a time.", 
levels = 5,
cost = [250,500,1000,1500,2500],
pointscost = 5,
valuename = "Maximum food: ",
valuenumber = ['500', '750', '1000', '1500', '2000', '3000'],
},
foodpreservation = {
name = "Food Storage Preservation",
code = 'foodpreservation',
description = "Equips your food storage area with a cooling system which helps prevent food spoilage when storage is nearly full.", 
levels = 1,
pointscost = 15,
cost = 1500,
},

jailcapacity = {
name = "Capacity",
code = 'jailcapacity',
description = "Adds additional cells to your jail, increasing maximum number of prisoners it can hold at a time.", 
levels = 8,
cost = 200,
pointscost = 3,
valuename = "Jail Cells: ",
},
jailtreatment = {
name = "Better Furnishing",
code = 'jailtreatment',
description = "Equips your jail with better furnishings and health care, preventing prisoners from accumulating stress.", 
levels = 1,
pointscost = 15,
cost = 750,
},
jailincenses = {
name = "Soothing Incences",
code = 'jailincenses',
description = "Equips your jail with burners for a special incenses which helps calm and adjust prisoners' attitude.", 
levels = 1,
pointscost = 20,
cost = 1500,
},

mansioncommunal = {
name = "Communal Room Beds",
code = 'mansioncommunal',
description = "Adds new beds to communal room, providing space for additional residents to sleep. ", 
levels = 20,
cost = 100,
pointscost = 1,
valuename = "Total beds: ",
},
mansionpersonal = {
name = "New Personal Room",
code = 'mansionpersonal',
description = "Set up one of the free rooms for living. Personal rooms provide sense of [color=yellow]Luxury[/color] to their hosts. ", 
levels = 10,
cost = 300,
pointscost = 3,
valuename = "Total rooms: ",
},
mansionbed = {
name = "Master's Bed Enlargement",
code = 'mansionbed',
description = "Enlarges your bed allowing you to host more people with you at night.. Sleeping in your room provides a sense of [color=yellow]Luxury[/color] to your partners.", 
levels = 3,
cost = 300,
pointscost = 3,
valuename = "Allowed partners: ",
},
mansionluxury = {
name = "Mansion Furnishment",
code = 'mansionluxury',
description = "Decorates the mansion with better furniture and additional pieces of art. This provides a boost to the [color=yellow]Luxury[/color] provided to servants sleeping in personal rooms and your bed.", 
levels = 2,
pointscost = 15,
cost = [1000,2000],
},
mansionalchemy = {
name = "Alchemy Room",
code = 'mansionalchemy',
description = "Equips a spare room with alchemical tools and paraphernalia allowing you to brew basic potions.", 
description2 = "Upgrades your Alchemy Room with additional equipment enabling you to brew a larger variety of potions.",
levels = 2,
pointscost = 5,
cost = [500,1000],
},
mansionlibrary = {
name = "Library",
code = 'mansionlibrary',
description = "Purchases new books and furniture for your library providing access to new books, articles and information as well as improving residents’ studies.", 
levels = 3,
pointscost = 3,
cost = [500,1000,1500],
},
mansionlab = {
name = "Laboratory",
code = 'mansionlab',
description = "Equips a spare room within the mansion with advanced devices and tools allowing you to conduct experiments and operations on both yourself and your slaves.", 
description2 = "Upgrades your laboratory with the latest equipment and tools, unlocking new operations.", 
levels = 2,
pointscost = 10,
cost = [1000,3000],
},
mansionkennels = {
name = "Kennels",
code = 'mansionkennels',
description = "Builds a kennel on the mansion’s grounds providing space to keep hounds. Having hounds on the property reduces the chances of slaves escaping during the night, and for those so inclined unlocks the beastality action. ", 
levels = 1,
pointscost = 15,
cost = 1500,
},
mansionnursery = {
name = "Nursery Room",
code = 'mansionnursery',
description = "Upgrades and equips a room within the mansion to provide care for newborn babies and young children for a limited period.", 
levels = 1,
pointscost = 15,
cost = 2000,
},

}


var noimage = load("res://files/buttons/noimagesmall.png")

func _init():
	randomize()
	loadsettings()
	effectdict = effects.effectlist 
	#logger.filename = ('log')
	if rules.custommouse == false:
		Input.set_custom_mouse_cursor(null)

func loadsettings():
	var settings = File.new()
	if settings.file_exists("user://settings.ini") == false:
		settings.open("user://settings.ini", File.WRITE)
		settings.store_line(var2str(rules))
		settings.close()
	settings.open("user://settings.ini", File.READ)
	var temp = str2var(settings.get_as_text())
	for i in rules:
		if temp.has(i):
			rules[i] = temp[i]
	#rules = str2var(settings.get_line())
	settings.close()

func overwritesettings():
	var settings = File.new()
	settings.open("user://settings.ini", File.WRITE)
	settings.store_line(var2str(rules))
	settings.close()

func clearstate():
	state = progress.new()
	slaves.clear()
	events = load("res://files/scripts/events.gd").new()
	resources.reset()

func slaves_set(slave):
	slave.stats.health_max = 35 + slave.stats.end_cur*20
	slave.health = 100
	slave.originstrue = slave.origins
	slave.gear.costume = 'clothcommon'
	slave.gear.underwear = 'underwearplain'
	slaves.append(slave)
	if get_tree().get_current_scene().find_node('CharList'):
		get_tree().get_current_scene().rebuild_slave_list()
	if get_tree().get_current_scene().find_node('ResourcePanel'):
		get_tree().get_current_scene().find_node('population').set_text(str(slavecount())) 
	if globals.get_tree().get_current_scene().has_node("infotext"):
		globals.get_tree().get_current_scene().infotext("[color=green]New person acquired: " + slave.name_long() + "[/color]")

func slavecount():
	var number = 0
	for i in slaves:
		if i.away.at != 'hidden':
			number += 1
	return number

var rules = {
futa = true,
futaballs = false,
furry = true,
furrynipples = true,
male_chance = 15,
futa_chance = 10,
children = false,
noadults = false,
slaverguildallraces = false,
custommouse = true,
fontsize = 14,
musicvol = 2,
receiving = true,
fullscreen = false,
oldresize = false,
fadinganimation = true,
permadeath = false,
autoattack = true,
gameloaded = false,
enddayalise = 0,
}

class resource:
	var day = 1 setget day_set
	var gold = 0 setget gold_set
	var mana = 0 setget mana_set
	var energy = 0 setget energy_set
	var food = 0 setget food_set
	var upgradepoints = 0 setget upgradepoints_set
	var panel
	var array = ['day','gold','mana','energy','food']
	
	var foodcaparray = [500, 750, 1000, 1500, 2000, 3000]
	
	func update():
		for i in array:
			self[i] += 0
	
	func reset():
		day = 1
		gold = 0
		mana = 0
		energy = 0
		food = 0
	
	func gold_set(value):
		value = round(value)
		var difference = gold - value
		var text = ""
		gold = value
		if gold < 0:
			gold = 0
		if panel != null:
			panel.get_node('gold').set_text(str(gold))
		
		
		if difference != 0:
			if difference < 0:
				text = "[color=green]Obtained " + str(abs(difference)) +  " gold[/color]"
			else:
				text = "[color=red]Lost " + str(abs(difference)) +  " gold[/color]"
		
		if globals.get_tree().get_current_scene().has_node("infotext"):
			globals.get_tree().get_current_scene().infotext(text)
	
	func day_set(value):
		day = value
		if day < 0:
			day = 0
		if panel != null:
			panel.get_node('day').set_text(str(day))
	
	func food_set(value):
		value = round(value)
		var difference = round(food - value)
		var text = ""
		food = value
		if food < 0:
			food = 0
		elif food >= foodcaparray[globals.state.mansionupgrades.foodcapacity]:
			food = foodcaparray[globals.state.mansionupgrades.foodcapacity]
		if panel != null:
			panel.get_node('food').set_text(str(food))
		if difference != 0:
			if difference < 0:
				text = "[color=green]Obtained " + str(abs(difference)) +  " food[/color]"
			else:
				text = "[color=red]Lost " + str(abs(difference)) +  " food[/color]"
		if globals.get_tree().get_current_scene().has_node("infotext"):
			globals.get_tree().get_current_scene().infotext(text)
	
	func mana_set(value):
		value = round(value)
		var difference = mana - value
		var text = ""
		mana = value
		if mana < 0:
			mana = 0
		
		if panel != null:
			panel.get_node('mana').set_text(str(mana))
		if globals.get_tree().get_current_scene().has_node("infotext"):
			globals.get_tree().get_current_scene().infotext(text)
		
		if difference != 0:
			if difference < 0:
				text = "[color=green]Obtained " + str(abs(difference)) +  " mana[/color]"
			else:
				text = "[color=aqua]Used " + str(abs(difference)) +  " mana[/color]"
		
		if globals.get_tree().get_current_scene().has_node("infotext"):
			globals.get_tree().get_current_scene().infotext(text)
		
		
	
	func upgradepoints_set(value):
		var difference = upgradepoints - value
		var text = ""
		upgradepoints = value
		
		if difference != 0:
			text = "[color=green]Obtained " + str(abs(difference)) +  " Mansion Upgrade Points[/color]"
		
		if globals.get_tree().get_current_scene().has_node("infotext"):
			globals.get_tree().get_current_scene().infotext(text)
	
	func energy_set(value):
		if panel != null:
			panel.get_node("energy").set_text(str(round(globals.player.energy)))

class progress:
	var tutorialcomplete = false
	var supporter = false
	var location = 'wimborn'
	var nopoplimit = false
	var condition = 85 setget cond_set
	var conditionmod = 1.3
	var farm = 0 
	var apiary = 0
	var branding = 0
	var slaveguildvisited = 0
	var itemlist = {}
	var spelllist = {}
	var mainquest = 0
	var rank = 0
	var password = ''
	var sidequests = {emily = 0, brothel = 0, cali = 0, dolin = 0, ayda = 0, ivran = '', yris = 0, zoe = 0}
	var repeatables = {wimbornslaveguild = [], frostfordslaveguild = [], gornslaveguild = []}
	var babylist = []
	var companion = -1
	var headgirlbehavior = 'none'
	var portals = {wimborn = {'enabled' : false, 'code' : 'wimborn'}, gorn = {'enabled':false, 'code' : 'gorn'}, frostford = {'enabled':false, 'code' : 'frostford'}, shaliq = {'enabled':false, 'code':'shaliq'}, amberguard = {'enabled':false, 'code':'amberguard'}}
	var sebastianorder = {race = 'none', taken = false, duration = 0}
	var sebastianslave
	var sandbox = false
	var snails = 0
	var groupsex = true
	var playergroup = []
	var timedevents = {}
	var customcursor = "res://files/buttons/kursor1.png"
	var upcomingevents = []
	var reputation = {wimborn = 0, frostford = 0, gorn = 0} setget reputation_set
	var dailyeventcountdown = 0
	var dailyeventprevious = 0
	var currentversion = 4450
	var unstackables = {}
	var supplykeep = 10
	var tutorial = {basics = false, slave = false, alchemy = false, jail = false, lab = false, farm = false, outside = false, combat = false}
	var itemcounter = 0
	var alisecloth = 'normal'
	var decisions = []
	var lorefound = []
	var mansionupgrades = {
	farmcapacity = 0,
	farmhatchery = 0,
	farmtreatment = 0,
	foodcapacity = 0,
	foodpreservation = 0,
	jailcapacity = 1,
	jailtreatment = 0,
	jailincenses = 0,
	mansioncommunal = 4,
	mansionpersonal = 1,
	mansionbed = 0,
	mansionluxury = 0,
	mansionalchemy = 0,
	mansionlibrary = 0,
	mansionlab = 0,
	mansionkennels = 0,
	mansionnursery = 0,
	}
	
	var ghostrep = {wimborn = 0, frostford = 0, gorn = 0}
	
	func reputation_set(value):
		var text = ''
		for i in value:
			if ghostrep[i] != value[i]:
				if ghostrep[i] > value[i]:
					text += "[color=red]Reputation with " + i.capitalize() + " has worsened![/color]"
				else:
					text += "[color=green]Reputation with " + i.capitalize() + " has increased![/color]"
				ghostrep[i] = value[i]
		if globals.get_tree().get_current_scene().has_node("infotext"):
			globals.get_tree().get_current_scene().infotext(text)

	
	func cond_set(value):
		condition += value*conditionmod
		if condition > 100:
			condition = 100
		elif condition < 0:
			condition = 0
	
	func findbaby(id):
		var rval
		for i in babylist:
			if i.id == id:
				rval = i
		return rval
	
	func findslave(id):
		var rval
		for i in range(0, globals.slaves.size()):
			if globals.slaves[i].id == id:
				rval = globals.slaves[i]
		return rval

class slave:
	var name
	var surname = ''
	var nickname = ''
	var unique = null
	var id = 0
	var race = ''
	var age = ''
	var mindage = ''
	var sex = ''
	var spec = null
	var imageportait = ''
	var imagefull = ''
	var haircolor = ''
	var hairlength = ''
	var hairstyle = ''
	var eyecolor = ''
	var eyeshape = ''
	var eyesclera = ''
	var arms = ''
	var legs = ''
	var bodyshape = ''
	var height = ''
	var skincov = ''
	var furcolor = ''
	var skin = ''
	var ears = ''
	var tail = ''
	var wings = ''
	var horns = ''
	var face = {beauty = 0, appeal = 0}
	var tits = {size = '', lactation = false, extrapairs = 0, developed = false,}
	var pussy = {virgin = true, has = true}
	var ass = ''
	var balls = ''
	var penis = {}
	var preg = {}
	var rules = {'silence':false, 'pet':false, 'contraception':false, 'aphrodisiac':false, 'masturbation':false, 'nudity':false, 'betterfood':false, 'personalbath':false,'cosmetics':false,'pocketmoney':false}
	var traits = {}
	var skills = {}
	var relatives = {}
	var gear = {costume = null, underwear = null, armor = null, weapon = null, accessory = null}
	var genes = {}
	var effects = {}
	var brand = ''
	var work = ''
	var farmoutcome = false
	var ability = []
	var abilityactive = []
	var customdesc = ''
	var piercing = {}
	var level = {}
	var sleep = ''
	var punish = {expect = false, strength = 0}
	var praise = 0
	var away = {duration = 0, at = ''}
	var cattle = {is_cattle = false, work = '', used_for = 'food'}
	var mods = {}
	var tags = []
	var origins = ''
	var originstrue = ''
	var memory = ''
	var attention = 0
	var sexuals = {actions = {}, unlocked = false, affection = 0, kinks = {}, unlocks = [], lastaction = ''}
	var kinks = []
	var forcedsex = false
	var metrics = {ownership = 0, jail = 0, mods = 0, brothel = 0, sex = 0, partners = [], randompartners = 0, item = 0, spell = 0, orgy = 0, threesome = 0, win = 0, capture = 0, goldearn = 0, foodearn = 0, manaearn = 0, birth = 0, preg = 0, vag = 0, anal = 0, oral = 0, roughsex = 0, roughsexlike = 0, orgasm = 0}
	var fromguild = false
	var stats = {
		str_cur = 0,
		str_max = 0,
		str_mod = 0,
		str_base = 0,
		agi_cur = 0, 
		agi_max = 0, 
		agi_mod = 0,
		agi_base = 0,
		maf_cur = 0,
		maf_max = 0,
		maf_mod = 0,
		maf_base = 0,
		end_base = 0,
		end_cur = 0,
		end_mod = 0,
		end_max = 0,
		cour_max = 0,
		cour_base = 0,
		conf_max = 0,
		conf_base = 0,
		wit_max = 0,
		wit_base = 0,
		charm_max = 0,
		charm_base = 0,
		obed_cur = 0.0,
		obed_max = 0,
		obed_min = 0,
		obed_mod = 0,
		stress_cur = 0.0,
		stress_max = 0,
		stress_min = 0,
		stress_mod = 0,
		dom_cur = 0.0,
		dom_max = 0,
		dom_min = 0,
		tox_cur = 0.0,
		tox_max = 0,
		tox_min = 0,
		lust_cur = 0,
		lust_max = 100,
		lust_min = 0,
		lust_mod = 0,
		health_cur = 0,
		health_max = 100,
		health_base = 0,
		energy_cur = 0,
		energy_max = 0,
		energy_mod = 0,
		armor_cur = 0,
		armor_max = 0,
		armor_base = 0,
		loyal_cur = 0.0,
		loyal_mod = 0,
		loyal_max = 0,
		loyal_min = 0,
	}
	var health setget health_set,health_get
	var obed setget obed_set,obed_get
	var stress setget stress_set,stress_get
	var loyal setget loyal_set,loyal_get
	var cour setget cour_set,cour_get
	var conf setget conf_set,conf_get
	var wit setget wit_set,wit_get
	var charm setget charm_set,charm_get
	var lust setget lust_set,lust_get
	var dom setget dom_set,dom_get
	var toxicity setget tox_set,tox_get
	var energy setget energy_set,energy_get
	var sstr setget str_set,str_get
	var sagi setget agi_set,agi_get
	var smaf setget maf_set,maf_get
	var send setget end_set,end_get
	
	func add_trait(trait, remove = false):
		var conflictexists = false
		var text = ""
		var traitexists = false
		for i in traits.values():
			if i.name == trait.name:
				traitexists = true
			for ii in i.conflict:
				if trait.name == ii:
					print('conflicting trait detected')
					conflictexists = true
		if traitexists || conflictexists:
			print("Can't apply: trait exists or conflicting with another trait")
		else:
			traits[trait.name] = trait
			if globals.get_tree().get_current_scene().has_node("infotext") && globals.slaves.find(self) >= 0 && away.at != 'hidden':
				text += self.dictionary("[color=yellow]$name acquired new trait: " + trait.name + "[/color] ")
				globals.get_tree().get_current_scene().infotext(text)
			if trait['effect'].empty() != true:
				add_effect(trait['effect'])
	
	func trait_remove(trait):
		var text = ''
		trait = globals.origins.trait(trait)
		if !traits.has(trait.name):
			return
		traits.erase(trait.name)
		if trait['effect'].empty() != true:
			add_effect(trait['effect'], true)
		text += self.dictionary("[color=yellow]$name lost trait: " + trait.name + "[/color] ")
		if globals.get_tree().get_current_scene().has_node("infotext") && globals.slaves.find(self) >= 0 && away.at != 'hidden':
			globals.get_tree().get_current_scene().infotext(text)
	
	
	func cleartraits():
		spec = null
		for i in traits.values():
			trait_remove(i.name)
		for i in ['str_base','agi_base', 'maf_base', 'end_base','str_cur','agi_cur', 'maf_cur', 'end_cur']:
			stats[i] = 0
	
	func add_effect(effect, remove = false):
		if effects.has(effect.code):
			if remove == true:
				effects.erase(effect.code)
				for i in effect:
					if stats.has(i):
						stats[i] = stats[i] + -effect[i]
					if i == 'face.beauty':
						face.beauty = face.beauty + -effect[i]
		elif remove != true:
			effects[effect.code] = effect
			for i in effect:
				if stats.has(i):
					stats[i] = stats[i] + effect[i]
				elif i == 'face.beauty':
					face.beauty = face.beauty + effect[i]
	
	
	func health_set(value):
		stats.health_max = 35 + stats.end_cur*20
		stats.health_cur = min(stats.health_cur + value, stats.health_max) 
	
	func obed_set(value):
		var difference = stats.obed_cur - value
		var string = ""
		var text = ""
		if difference > 0:
			difference = abs(difference)
			if abs(difference) < 20:
				string = "(-)"
			elif abs(difference) < 40:
				string = "(--)"
			else:
				string = "(---)"
			stats.obed_cur -= difference
			text = self.dictionary("[color=red]$name's obedience has decreased " + string + " [/color]")
		else:
			difference = abs(difference)
			if abs(difference) < 20:
				string = "(+)"
			elif abs(difference) < 40:
				string = "(++)"
			else:
				string = "(+++)"
			text = self.dictionary("[color=green]$name's obedience has grown " + string + " [/color]")
			stats.obed_cur += difference*(1 + stats.obed_mod/100)
		
		stats.obed_cur = max(min(stats.obed_cur, stats.obed_max),stats.obed_min)
		if stats.obed_cur < 50 && spec == 'executor':
			stats.obed_cur = 50
		if globals.get_tree().get_current_scene().has_node("infotext") && globals.slaves.find(self) >= 0 && away.at != 'hidden':
			globals.get_tree().get_current_scene().infotext(text)
	
	func loyal_set(value):
		var difference = stats.loyal_cur - value
		var string = ""
		var text = ""
		if difference > 0:
			difference = abs(difference)
			if abs(difference) < 5:
				string = "(-)"
			elif abs(difference) < 10:
				string = "(--)"
			else:
				string = "(---)"
			stats.loyal_cur -= difference
			text = self.dictionary("[color=red]$name's loyalty decreased " + string + " [/color]")
		elif difference < 0:
			difference = abs(difference)
			if abs(difference) < 5:
				string = "(+)"
			elif abs(difference) < 10:
				string = "(++)"
			else:
				string = "(+++)"
			text = self.dictionary("[color=green]$name's loyalty grown " + string + " [/color]")
			stats.loyal_cur += difference*(1 + stats.loyal_mod/100) 
		
		
		stats.loyal_cur = max(min(stats.loyal_cur, stats.loyal_max),stats.loyal_min)
		if globals.get_tree().get_current_scene().has_node("infotext") && globals.slaves.find(self) >= 0 && away.at != 'hidden':
			globals.get_tree().get_current_scene().infotext(text)
	
	func stress_set(value):
		
		var difference = stats.stress_cur - value
		var string = ""
		var text = ""
		if difference < 0:
			difference = abs(difference)
			if abs(difference) < 15:
				string = "(+)"
			elif abs(difference) < 30:
				string = "(++)"
			else:
				string = "(+++)"
			stats.stress_cur += difference*(1 + stats.stress_mod/100)
			text = self.dictionary("[color=red]$name's stress has grown " + string + " [/color]")
		else:
			difference = abs(difference)
			if abs(difference) < 15:
				string = "(-)"
			elif abs(difference) < 30:
				string = "(--)"
			else:
				string = "(---)"
			text = self.dictionary("[color=green]$name's stress has reduced " + string + " [/color]")
			stats.stress_cur -= difference*(1 + stats.stress_mod/100)
		
		stats.stress_cur = max(min(stats.stress_cur, 150),stats.stress_min)
		if globals.get_tree().get_current_scene().has_node("infotext") && globals.slaves.find(self) >= 0 && away.at != 'hidden':
			globals.get_tree().get_current_scene().infotext(text)
		
		
	
	func tox_set(value):
		stats.tox_cur = max(min(stats.tox_cur + value, stats.tox_max),stats.tox_min)
	
	func energy_set(value):
		value = round(value)
		stats.energy_cur = max(min(stats.energy_cur + value*(1 + stats.energy_mod/100), stats.energy_max),0)
		if self == globals.player:
			globals.resources.energy = 0
	
	var originvalue = {'slave' : 55, 'poor' : 65, 'commoner' : 75, 'rich' : 85, 'atypical' : 85, 'noble' : 100}
	
	func cour_set(value):
		stats.cour_base = max(min(value, min(stats.cour_max, originvalue[origins])),0)
	
	func conf_set(value):
		stats.conf_base = max(min(value, min(stats.conf_max, originvalue[origins])),0)
	
	func wit_set(value):
		stats.wit_base = max(min(value, min(stats.wit_max, originvalue[origins])),0)
	
	func charm_set(value):
		stats.charm_base = max(min(value, min(stats.charm_max, originvalue[origins])),0)
	
	func lust_set(value):
		if value > 0:
			stats.lust_cur = max(min(stats.lust_cur + value*(1 + stats.lust_mod/100),stats.lust_max),stats.lust_min)
		else:
			stats.lust_cur = max(min(stats.lust_cur + value,stats.lust_max),stats.lust_min)
	
	func dom_set(value):
		stats.dom_cur = min(max(value, stats.dom_min), stats.dom_max)
	
	func str_set(value):
		stats.str_cur = min(value, stats.str_max)
	
	func agi_set(value):
		stats.agi_cur = min(value, stats.agi_max)
	
	func maf_set(value):
		stats.maf_cur = min(value, stats.maf_max)
	
	func end_set(value):
		stats.end_cur = min(value, stats.end_max)
	
	
	func loyal_get():
		return stats.loyal_cur
	
	func health_get():
		return stats.health_cur
	
	func obed_get():
		return stats.obed_cur
	
	func stress_get():
		return stats.stress_cur
	
	func cour_get():
		return floor(stats.cour_base)
	
	func conf_get():
		return floor(stats.conf_base)
	
	func wit_get():
		return floor(stats.wit_base)
	
	func charm_get():
		return floor(stats.charm_base)
	
	func lust_get():
		return stats.lust_cur
	
	func dom_get():
		return stats.dom_cur
	
	func tox_get():
		return stats.tox_cur
	
	func energy_get():
		return stats.energy_cur
	
	func str_get():
		return stats.str_cur + stats.str_mod
	
	func agi_get():
		return stats.agi_cur + stats.agi_mod
	
	func maf_get():
		return stats.maf_cur + stats.maf_mod
	
	func end_get():
		return stats.end_cur + stats.end_mod
	
	func health_icon():
		var health
		if float(stats.health_cur)/stats.health_max > 0.75: 
			health = load("res://files/buttons/icons/health/2.png")#'res://files/buttons/health_high.png')
		elif float(stats.health_cur)/stats.health_max > 0.4:
			health = load("res://files/buttons/icons/health/1.png")#'res://files/buttons/health_med.png')
		else:
			health = load("res://files/buttons/icons/health/3.png")#'res://files/buttons/health_low.png')
		return health
	
	func obed_icon():
		var obed
		if float(stats.obed_cur)/stats.obed_max > 0.75: 
			obed = load("res://files/buttons/icons/obedience/2.png")#'res://files/buttons/obed_high.png')
		elif float(stats.obed_cur)/stats.obed_cur > 0.4:
			obed = load("res://files/buttons/icons/obedience/1.png")#'res://files/buttons/obed_med.png')
		else:
			obed = load("res://files/buttons/icons/obedience/3.png")#'res://files/buttons/obed_low.png')
		return obed
	
	func stress_icon():
		var stress
		if stats.stress_cur >= 70: 
			stress = load("res://files/buttons/icons/stress/3.png")#'res://files/buttons/stress_high.png')
		elif stats.stress_cur > 35:
			stress = load("res://files/buttons/icons/stress/1.png")#'res://files/buttons/stress_med.png')
		else:
			stress = load("res://files/buttons/icons/stress/2.png")#'res://files/buttons/stress_low.png')
		return stress
	
	
	func name_long():
		if nickname == '':
			if surname != "":
				return name + ' ' + surname
			else:
				return name
		else:
			return nickname
	
	func name_short():
		if nickname == '':
			return name
		else:
			return nickname
	
	func race_short():
		if race.find("Beastkin") >= 0:
			return race.replace("Beastkin ", 'B.')
		elif race.find("Halfkin") >= 0:
			return race.replace("Halfkin ", "H.")
		else:
			return race
	
	func dictionary(text):
		var string = text
		string = string.replace('$name', name_short())
		string = string.replace('$surname', surname)
		string = string.replace('$penis', globals.fastif(penis.size == 'none', 'strapon', '$his cock'))
		string = string.replace('$child', globals.fastif(sex == 'male', 'boy', 'girl'))
		string = string.replace('$sex', sex)
		string = string.replace('$He', globals.fastif(sex == 'male', 'He', 'She'))
		string = string.replace('$he', globals.fastif(sex == 'male', 'he', 'she'))
		string = string.replace('$His', globals.fastif(sex == 'male', 'His', 'Her'))
		string = string.replace('$his', globals.fastif(sex == 'male', 'his', 'her'))
		string = string.replace('$him', globals.fastif(sex == 'male', 'him', 'her'))
		string = string.replace('$son', globals.fastif(sex == 'male', 'son', 'daughter'))
		string = string.replace('$sibling', globals.fastif(sex == 'male', 'brother', 'sister'))
		string = string.replace('$sir', globals.fastif(sex == 'male', 'Sir', "Ma'am"))
		string = string.replace('$race', globals.decapitalize(race).replace('_', ' '))
		string = string.replace('$master', globals.fastif(globals.player.sex == 'male', 'Master', "Mistress"))
		string = string.replace('$haircolor', haircolor)
		string = string.replace('$eyecolor', eyecolor)
		return string
	
	func dictionaryplayer(text):
		var string = text
		string = string.replace('[Playername]', globals.player.name_short())
		string = string.replace('$name', name_short())
		string = string.replace('$penis', globals.fastif(penis.size == 'none', 'strapon', '$his cock'))
		string = string.replace('$child', globals.fastif(sex == 'male', 'boy', 'girl'))
		string = string.replace('$sex', sex)
		string = string.replace('$He', 'You')
		string = string.replace('$he', 'you')
		string = string.replace('$His', 'Your')
		string = string.replace('$his', 'your')
		string = string.replace('$him', 'your')
		string = string.replace('$child', globals.fastif(sex == 'male', 'son', 'daughter'))
		string = string.replace('$sibling', globals.fastif(sex == 'male', 'brother', 'sister'))
		string = string.replace('$sir', globals.fastif(sex == 'male', 'Sir', "Ma'am"))
		string = string.replace('$master', globals.fastif(sex == 'male', 'Master', "Mistress"))
		string = string.replace('$haircolor', haircolor)
		string = string.replace('$eyecolor', eyecolor)
		return string
	
	func dictionaryplayerplus(text):
		var string = text
		string = string.replace(' has', ' have')
		string = string.replace(' Has', ' have')
		string = string.replace('You is', 'You are')
		string = string.replace("You's", "You're")
		string = string.replace('appears', 'appear')
		return string
	
	func description_full(forself = false):
		var text = ''
		if forself == true:
			text = globals.description.getSlaveDescription(self, true)
		else:
			text = globals.description.getSlaveDescription(self)
		return text
	
	func description_small(captured = false):
		var text = ''
		text = globals.description.getSlaveDescription(self, false, false, captured)
		return text
	
	func countluxuty():
		var luxury = 0
		var goldspent = 0
		var foodspent = 0
		var nosupply = false
		var value = 0
		if sleep == 'personal':
			luxury += 10+(5*globals.state.mansionupgrades.mansionluxury)
		elif sleep == 'your':
			luxury += 5+(5*globals.state.mansionupgrades.mansionluxury)
		if rules.betterfood == true && globals.resources.food >= 5:
			globals.resources.food -= 5
			foodspent += 5
			luxury += 5
		if rules.personalbath == true:
			if spec != 'housekeeper':
				value = 2
			else:
				value = 1
			if globals.itemdict.supply.amount >= value:
				luxury += 5
				globals.itemdict.supply.amount -= value
			else:
				nosupply == true
		if rules.pocketmoney == true:
			if spec != 'housekeeper':
				value = 10
			else:
				value = 5
			if globals.resources.gold >= value:
				luxury += value
				goldspent += value
				globals.resources.gold -= value
		if rules.cosmetics == true:
			if globals.itemdict.supply.amount > 1:
				luxury += 5
				globals.itemdict.supply.amount -= 1
			else:
				nosupply = true
		for i in gear.values(): 
			if !i in ['underwearplain','clothcommon'] && i != null:
				var tempitem = globals.state.unstackables[i]
				if tempitem.code in ['underwearlacy','underwearboxers']:
					luxury += 5
				elif tempitem.code in ["accgoldring"]:
					luxury += 10
		
		var luxurydict = {luxury = luxury, goldspent = goldspent, foodspent = foodspent, nosupply = nosupply}
		return luxurydict
	
	func calculateluxury():
		var luxurydict = {slave = 0,poor = 5,commoner = 15,rich = 25,noble = 40}
		var luxury = luxurydict[origins]
		if traits.has("Ascetic"):
			luxury = luxury/2
		return luxury
	
	func calculateprice():
		var price = 0
		price = face.beauty*4
		for i in [self.sstr, self.sagi, self.smaf, self.send]:
			if i > 0:
				var counter = i
				while counter > 0:
					price += 20
					counter -= 1
#			var temp = skills[i].value
#			while temp > 19:
#				temp -= 20
#				price += 20
		if pussy.virgin == true:
			price = price*1.2
		if sex == 'futanari':
			price = price*1.1
		price = price + (-50+self.obed/2)
		for i in traits.values():
			if i.tags.find('detrimental') >= 0:
				price = price*0.80
		if race == 'Elf' || race == 'Dark Elf' || race == 'Orc' || race == 'Goblin'||race == 'Gnome':
			price = price*1.5
		elif race == 'Drow'|| race == 'Demon' || race == 'Seraph':
			price = price*2.5
		elif (race.find('Beastkin') >= 0 || race.find('Halfkin') >= 0) && race.find('Fox') < 0:
			price = price*1.75
		elif race == 'Fairy'|| race == 'Dryad' || race == 'Taurus' || race.find('Fox') >= 0:
			price = price*2
		elif race == 'Slime'||race == 'Lamia' || race == 'Arachna' || race == 'Harpy' || race == 'Scyalla':
			price = price*2.5
		elif race == 'Dragonkin':
			price = price*3.5
		if self.health < 50:
			price = price/2
		if self.toxicity >= 60:
			price = price/2
		if origins == 'slave':
			price = price*0.8
		elif origins == 'poor':
			price = price*1
		elif origins == 'commoner':
			price = price*1.2
		elif origins == 'rich':
			price = price*1.5
		elif origins == 'noble':
			price = price*2
		if traits.has('Uncivilized') == true:
			price = price/1.5
		if price < 0:
			price = 5
		return round(price)
	
	func calculateappeal():
		var value = 0
		value = round(face.beauty/3) 
		face.appeal = value
	
	func fetch(dict):
		for key in dict:
			var tv = dict[key]
			if typeof(tv) == TYPE_DICTIONARY:
				globals.merge(self[key], dict[key])
			elif typeof(tv) == TYPE_INT:
				self[key] = self[key] + dict[key]
			else:
				self[key] = dict[key]
	
	func unlocksexuals():
		for i in sexuals.unlocks:
			var unlock = globals.sexscenes.categories[i]
			for ii in unlock.actions:
				if sexuals.actions.has(ii) == false:
					sexuals.actions[ii] = 0


static func count_sleepers():
	var your_bed = 0
	var personal_room = 0
	var jail = 0
	var farm = 0
	var communal = 0
	var rval = {}
	for i in globals.slaves:
		if i.away.at != 'hidden':
			if i.sleep == 'personal':
				personal_room += 1
			elif i.sleep == 'your':
				your_bed += 1
			elif i.sleep == 'jail':
				jail += 1
			elif i.sleep == 'farm':
				farm += 1
			elif i.sleep == 'communal':
				communal += 1
	rval['personal'] = personal_room
	rval['your_bed'] = your_bed
	rval['jail'] = jail
	rval['farm'] = farm
	rval['communal'] = communal
	return rval

func showtooltip(text):
	get_tree().get_current_scene().get_node("tooltip/RichTextLabel").set_bbcode(text)
	#get_tree().get_current_scene().get_node("tooltip").set_size(get_tree().get_current_scene().get_node("tooltip/RichTextLabel").get_size())
	var pos = get_tree().get_current_scene().get_global_mouse_pos()
	pos = Vector2(pos.x+20, pos.y+20)
	get_tree().get_current_scene().get_node("tooltip").set_pos(pos)
	var screen = get_viewport().get_visible_rect()
	var tooltipsize = get_tree().get_current_scene().get_node("tooltip").get_rect()
	if tooltipsize.pos.x + tooltipsize.size.x >= screen.size.x:
		get_tree().get_current_scene().get_node("tooltip").set_pos(Vector2(tooltipsize.pos.x + (screen.size.x - (tooltipsize.pos.x + tooltipsize.size.x)) , tooltipsize.pos.y))
	tooltipsize = get_tree().get_current_scene().get_node("tooltip").get_rect()
	if tooltipsize.pos.y + tooltipsize.size.y >= screen.size.y:
		get_tree().get_current_scene().get_node("tooltip").set_pos(Vector2(tooltipsize.pos.x, tooltipsize.pos.y + (screen.size.y - (tooltipsize.pos.y + tooltipsize.size.y))-10))

	get_tree().get_current_scene().get_node("tooltip").set_hidden(false)
	#if get_tree().get_current_scene().get_node("tooltip/RichTextLabel").

func hidetooltip():
	get_tree().get_current_scene().get_node("tooltip").set_hidden(true)

static func merge(target, patch):
	for key in patch:
		if target.has(key):
			var tv = target[key]
			if typeof(tv) == TYPE_DICTIONARY:
				merge(tv, patch[key])
			elif typeof(tv) == TYPE_INT || typeof(tv) == TYPE_REAL:
				target[key] = target[key] + patch[key]
			else:
				target[key] = patch[key]
		else:
			target[key] = patch[key]

static func merge_overwrite(target, patch):
	for key in patch:
		if target.has(key):
			var tv = target[key]
			if typeof(tv) == TYPE_DICTIONARY:
				merge(tv, patch[key])
			else:
				target[key] = patch[key]
		else:
			target[key] = patch[key]

static func mergeclass(target, patch):
	for key in patch:
		target[key] = patch[key]

static func mergearrays(target, patch):
	var count = 0
	for key in patch:
		target[count] = patch[count]
		count += 1

static func fastif(formula, result1, result2):
	if formula == true:
		return result1
	else:
		return result2

static func find_trait(array, trait):
	var result = false
	for i in array:
		if i.name == trait:
			result = true
	return result

func getcodefromarray(array, code):
	var rval = false
	for i in array:
		if i.code == code:
			rval = i
	return rval

static func decapitalize(text):
	text = text.to_lower()
	text = text.replace(' ', '_')
	return text

static func sortbyname(first, second):
	if first.name < second.name:
		return true
	else:
		return false

static func sortbycost(first, second):
	if first.cost < second.cost:
		return true
	elif first.cost == second.cost:
		if first.name < second.name:
			return true
		else:
			return false
	else:
		return false

static func sortbynumber(first, second):
	if first.number < second.number:
		return true
	else:
		return false


var hairlengtharray = ['ear','neck','shoulder','waist','hips']
var sizearray = ['masculine','flat','small','average','big','huge']
var heightarray = ['petite','short','average','tall','towering']
var agesarray = ['child','teen','adult']
var genitaliaarray = ['small','average','big']
var originsarray = ['slave','poor','commoner','rich','noble']
var longtails = ['cat','fox','wolf','demon','dragon','scruffy','snake tail','racoon']
var skincovarray = ['none','scales','feathers','full_body_fur', 'plants']
var penistypearray = ['human','canine','feline','equine']
var alltails = ['cat','fox','wolf','bunny','bird','demon','dragon','scruffy','snake tail','racoon']
var allwings = ['feathered_black', 'feathered_white', 'feathered_brown', 'leather_black','leather_red','insect']
var allears = ['human','feathery','pointy','short_furry','long_pointy_furry','fins','long_round_furry', 'long_droopy_furry']
var statsdict = {sstr = 'Strength', sagi = 'Agility', smaf = "Magic Affinity", send = "Endurance", cour = 'Courage', conf = 'Confidence', wit = 'Wit', charm = 'Charm'}
var maxstatdict = {sstr = 'str_max', sagi = 'agi_max', smaf = 'maf_max', send = 'end_max', cour = 'cour_max', conf = 'conf_max', wit = 'wit_max', charm = 'charm_max'}
var statsdescript = dictionary.statdescription
var sleepdict = {communal = {name = 'Communal Room'}, jail = {name = "Jail"}, personal = {name = 'Personal Room'}, your = {name = "Your bed"}}

#saveload system
func save():
	var array = []
	var dict = {}
	for i in spelldict:
		if spelldict[i].learned == true:
			state.spelllist[i] = true
	for i in itemdict:
		if itemdict[i].amount > 0 || itemdict[i].unlocked == true:
			state.itemlist[i] = {}
			state.itemlist[i].amount = itemdict[i].amount
			state.itemlist[i].unlocked = itemdict[i].unlocked
	dict.resources = inst2dict(resources)
	dict.state = inst2dict(state)
	dict.state.currentversion = gameversion
	dict.slaves = []
	dict.babylist = []
	if globals.state.sebastianorder.taken == true:
		dict.sebastianslave = inst2dict(state.sebastianslave)
	for i in slaves:
		dict.slaves.append(inst2dict(i))
	for i in state.babylist:
		dict.babylist.append(inst2dict(i))
	dict.player = inst2dict(player)
	return dict

func save_game(var savename):
	var savegame = File.new()
	var dir = Directory.new()
	if dir.dir_exists("user://saves") == false:
		dir.make_dir("user://saves")
	savegame.open("user://saves/"+savename, File.WRITE)
	var nodedata = save()
	savegame.store_line(nodedata.to_json())
	savegame.close()

func load_game(filename):
	var savegame = File.new()
	var newslave
	if !savegame.file_exists("user://saves/"+filename):
		return #Error!  We don't have a save to load
	clearstate()
	var currentline = {} 
	savegame.open("user://saves/"+filename, File.READ)
	currentline.parse_json(savegame.get_as_text())
	get_tree().change_scene("res://files/Mansion.scn")
	resources = dict2inst(currentline.resources)
	player = dict2inst(currentline.player)
	state = dict2inst(currentline.state)
	var statetemp = progress.new()
	for i in statetemp.reputation:
		if state.reputation.has(i) == false:
			state.reputation[i] = statetemp.reputation[i]
	for i in state.itemlist:
		itemdict[i].amount = state.itemlist[i].amount
		itemdict[i].unlocked = state.itemlist[i].unlocked
	state.itemlist = {}
	for i in state.spelllist:
		spelldict[i].learned = true
	state.spelllist = {}
	if globals.state.sebastianorder.taken == true:
		state.sebastianslave = slave.new()
		state.sebastianslave = dict2inst(currentline.sebastianslave)
	state.babylist.clear()
	for i in currentline.slaves:
		newslave = slave.new()
		newslave = dict2inst(i)
		slaves.append(newslave)
	for i in currentline.babylist:
		newslave = slave.new()
		newslave = dict2inst(i)
		state.babylist.append(newslave)
	savegame.close()
	if state.customcursor == null:
		Input.set_custom_mouse_cursor(null)
	else:
		state.customcursor = "res://files/buttons/kursor1.png"
	
	
	rules.gameloaded =true
	if state.currentversion != gameversion:
		print("Using old save, attempting repair")
		repairsave()
	

func repairsave():
	#repairing player
	if !player.sexuals.has('unlocks'):
		player.sexuals.unlocks = []
	#repairing quests
	var array = []
	for i in globals.state.upcomingevents:
		array.append(i.code)
	if globals.state.sidequests.emily in [9,10,11] && array.find("tishadisappear"):
		globals.state.upcomingevents.append({code = 'tishadisappear', duration = round(rand_range(9,14))})
	if globals.state.sidequests.has('ivran') == false:
		globals.state.sidequests.ivran = ''
	if globals.state.sidequests.has('ayda') == false:
		globals.state.sidequests.ayda = 0
	if globals.state.sidequests.has("yris") == false:
		globals.state.sidequests.yris = 0
	#repairing slaves
	var tempslaves = []
	tempslaves.append(player)
	if state.sebastianslave != null && globals.state.sebastianorder.taken:
		tempslaves.append(state.sebastianslave)
	for i in slaves:
		tempslaves.append(i)
	for i in state.babylist:
		tempslaves.append(i)
	for i in tempslaves:
		if !i.sexuals.has('unlocks'):
			i.sexuals.unlocks = []
		if !i.sexuals.actions.has("massage"):
			i.sexuals.actions.massage = 0
			i.sexuals.actions.kiss = 0
		i.unlocksexuals()
		if i.metrics.has("vag") == false:
			i.metrics.jail = 0
			i.metrics.birth = 0
			i.metrics.preg = 0
			i.metrics.anal = 0
			i.metrics.oral = 0
			i.metrics.vag = 0
			i.metrics.roughsex = 0
			i.metrics.roughsexlike = 0
			i.metrics.capture = 0
			i.metrics.orgasm = 0
			i.metrics.mods = 0
			i.metrics.randompartners = 0
		i.skills = {}
		if i.origins == 'atypical':
			i.origins = 'commoner'
		if i.origins == 'royal':
			i.origins = 'noble'
		i.rules = {'silence':false, 'pet':false, 'contraception':false, 'aphrodisiac':false, 'masturbation':false, 'nudity':false, 'betterfood':false, 'personalbath':false,'cosmetics':false,'pocketmoney':false} 
		if i.gear.has('clothes'):
			i.gear = {costume = 'clothcommon', underwear = 'underwearplain', armor = null, weapon = null, accessory = null}
		if i.stats.has('str_mod') == false:
			for k in ['str_mod','agi_mod','maf_mod','end_mod']:
				i.stats[k] = 0
	#repairing items
	if globals.player.ability.find('escape') < 0:
		globals.player.ability.append('escape')
		globals.player.abilityactive.append('escape')
		if globals.spelldict.heal.learned == true && globals.player.ability.find('heal') < 0:
			globals.player.ability.append('heal')
	if state.alchemy >= 2:
		itemdict.aphroditebrew.unlocked = true
	if state.currentversion <= 44:
		showalisegreet = true
	if state.currentversion < 4450:
		state.portals = progress.new().portals
		state.portals.wimborn.enabled = true
		state.portals.frostford.enabled = true
		state.portals.gorn.enabled = true
		state.sidequests.zoe = 0
		state.portals[state.location].enabled = false
	if state.currentversion < 4460:
		state.mansionupgrades.jailcapacity = state.rooms.jail
		state.mansionupgrades.mansioncommunal = state.rooms.communal
		state.mansionupgrades.mansionpersonal = state.rooms.personal
		state.mansionupgrades.mansionbed = state.rooms.bed
		state.mansionupgrades.mansionalchemy = state.alchemy
		state.mansionupgrades.mansionlibrary = state.library
		state.mansionupgrades.mansionlab = state.laboratory
		if state.currentversion < 4461:
			var alchemy1 = ['aphrodisiac','hairgrowthpot','amnesiapot','lactationpot','miscariagepot','stimulantpot','deterrentpot']
			var alchemy2 = ['oblivionpot','oblivionpot','minoruspot','majoruspot','aphroditebrew']
			if state.mansionupgrades.mansionalchemy == 1:
				for i in alchemy1:
					globals.itemdict[i].unlocked = true
			if state.mansionupgrades.mansionalchemy == 2:
				for i in alchemy2:
					globals.itemdict[i].unlocked = true
	state.currentversion = gameversion

var showalisegreet = false

func dir_contents(target = "user://saves"):
	var dir = Directory.new()
	var array = []
	if dir.open(target) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while (file_name != ""):
			if !dir.current_is_dir():
				array.append(file_name)
			file_name = dir.get_next()
		return array
	else:
		print("An error occurred when trying to access the path.")

var currentslave
var currentsexslave

func evaluate(input):
	var script = GDScript.new()
	script.set_source_code("var slave\nfunc eval():\n\treturn " + input)
	script.reload()
	var obj = Reference.new()
	obj.set_script(script)
	obj.slave = currentslave
	return obj.eval()

