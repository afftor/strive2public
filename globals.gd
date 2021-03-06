
extends Node

var spelldict = {}
var effectdict = {}
var guildslaves = {wimborn = [], gorn = [], frostford = [], umbra = []}
var gameversion = 5400
var state = progress.new()
var developmode = false
var gameloaded = false

var resources = resource.new()
var slavegen = load("res://files/scripts/slavegen.gd").new()
var assets = load("res://files/scripts/assets.gd").new()
var constructor = load("res://files/scripts/characters/constructor.gd").new()
var origins = load("res://files/scripts/origins.gd").new()
var description = load("res://files/scripts/characters/description.gd").new()
var dictionary = load("res://files/scripts/dictionary.gd").new()
var sexscenes = load("res://files/scripts/sexscenes.gd").new()
var glossary = load("res://files/scripts/glossary.gd").new()
var repeatables = load("res://files/scripts/repeatable_quests.gd").new()
var abilities = load("res://files/scripts/abilities.gd").new()
var effects = load("res://files/scripts/effects.gd").new()
var events = load("res://files/scripts/events.gd").new()
var items = load("res://files/scripts/items.gd").new()
var itemdict = items.itemlist
var questtext = events.textnode
var racefile = load("res://files/scripts/characters/races.gd").new()
var races = racefile.races
var names = racefile.names
var dailyevents = load("res://files/scripts/dailyevents.gd").new()
var jobs = load("res://files/scripts/jobs&specs.gd").new()
var mansionupgrades = load("res://files/scripts/mansionupgrades.gd").new()
var gallery = load("res://files/scripts/gallery.gd").new()
var slavedialogues = load("res://files/scripts/slavedialogues.gd").new()
var characters = gallery
var patronlist = load("res://files/scripts/patronlists.gd").new()


var modsfile = load("res://mods/init.gd").new()
var main

var slaves = [] setget slaves_set
var starting_pc_races = ['Human', 'Elf', 'Dark Elf', 'Orc', 'Demon', 'Beastkin Cat', 'Beastkin Wolf', 'Beastkin Fox', 'Halfkin Cat', 'Halfkin Wolf', 'Halfkin Fox', 'Taurus']
var wimbornraces = ['Human', 'Elf', 'Dark Elf', 'Demon', 'Beastkin Cat', 'Beastkin Wolf','Beastkin Tanuki','Beastkin Bunny', 'Halfkin Cat', 'Halfkin Wolf', 'Halfkin Tanuki','Halfkin Bunny','Taurus','Fairy']
var gornraces = ['Human', 'Orc', 'Goblin', 'Gnome', 'Taurus', 'Centaur','Beastkin Cat', 'Beastkin Tanuki','Beastkin Bunny', 'Halfkin Cat','Halfkin Bunny','Halfkin Bunny', 'Harpy']
var frostfordraces = ['Human','Elf','Drow','Beastkin Cat', 'Beastkin Wolf', 'Beastkin Fox', 'Beastkin Tanuki','Beastkin Bunny', 'Halfkin Cat', 'Halfkin Wolf', 'Halfkin Fox','Halfkin Bunny','Halfkin Bunny', 'Nereid']
var allracesarray = ['Human', 'Elf', 'Dark Elf', 'Orc', 'Drow','Beastkin Cat', 'Beastkin Wolf', 'Beastkin Fox','Beastkin Tanuki','Beastkin Bunny', 'Halfkin Cat', 'Halfkin Wolf', 'Halfkin Fox','Halfkin Tanuki','Halfkin Bunny','Taurus', 'Demon', 'Seraph', 'Gnome','Goblin','Centaur','Lamia','Arachna','Scylla', 'Slime', 'Harpy','Dryad','Fairy','Nereid','Dragonkin']
var banditraces = ['Human', 'Elf', 'Dark Elf', 'Demon', 'Cat', 'Wolf','Bunny','Taurus','Orc','Goblin']
var monsterraces = ['Centaur','Lamia','Arachna','Scylla', 'Slime', 'Harpy','Nereid']
var specarray = ['geisha','ranger','executor','bodyguard','assassin','housekeeper','trapper','nympho','merchant','tamer']
var player = slave.new()
var partner
#var clothes = load("res://files/scripts/clothes.gd").costumelist()
#var underwear = load("res://files/scripts/clothes.gd").underwearlist()

var spritedict = gallery.sprites
var musicdict = {
combat1 = load("res://files/music/battle1.ogg"),
combat2 = load("res://files/music/battle2.ogg"),
mansion1 = load("res://files/music/mansion1.ogg"),
mansion2 = load("res://files/music/mansion2.ogg"),
mansion3 = load("res://files/music/mansion3.ogg"),
mansion4 = load("res://files/music/mansion4.ogg"),
wimborn = load("res://files/music/wimborn.ogg"),
gorn = load("res://files/music/gorn.ogg"),
frostford = load("res://files/music/frostford.ogg"),
explore = load("res://files/music/exploration.ogg"),
maintheme = load("res://files/music/opening.ogg"),
ending = load("res://files/music/ending.ogg"),
dungeon = load("res://files/music/dungeon.ogg"),
}
var sounddict = {
stab = load("res://files/sounds/stab.ogg")}
var backgrounds = {
mansion = load("res://files/backgrounds/mansion.png"),
jail = load("res://files/backgrounds/jail.png"),
alchemy0 = load("res://files/backgrounds/alchemy0.png"),
alchemy1 = load("res://files/backgrounds/alchemy1.png"),
alchemy2 = load("res://files/backgrounds/alchemy2.png"),
wimborn = load("res://files/backgrounds/town.png"),
mageorder = load("res://files/backgrounds/mageorder.png"),
slaverguild = load("res://files/backgrounds/slaveguild.png"),
market = load("res://files/backgrounds/market.jpg"),
library1 = load("res://files/backgrounds/library1.png"),
library2 = load("res://files/backgrounds/library2.png"),
forest = load("res://files/backgrounds/forest.jpg"),
shaliq = load("res://files/backgrounds/shaliq.jpg"),
crossroads = load("res://files/backgrounds/crossroads.png"),
grove = load("res://files/backgrounds/grove.jpg"),
highlands = load("res://files/backgrounds/highlands.jpg"),
marsh = load("res://files/backgrounds/marsh.jpg"),
meadows = load("res://files/backgrounds/meadows.png"),
sea = load("res://files/backgrounds/sea.jpg"),
lab = load("res://files/backgrounds/laboratory.png"),
gorn = load("res://files/backgrounds/gorn.png"),
frostford = load("res://files/backgrounds/frostford.png"),
mountains = load("res://files/backgrounds/mountains.jpg"),
borealforest = load("res://files/backgrounds/borealforest.jpg"),
amberguard = load("res://files/backgrounds/amberguard.png"),
amberroad = load("res://files/backgrounds/amberroad.png"),
undercity = load("res://files/backgrounds/undercity.png"),
tunnels = load("res://files/backgrounds/tunnels.png"),
mainorder = load("res://files/backgrounds/mainorder.png"),
mainorderfinale = load("res://files/backgrounds/mainorderfinale.png"),
}
var scenes = {
finale = load("res://files/images/scene/finale.png"),
finale2 = load("res://files/images/scene/finale2.png"),
emilyshower = load("res://files/images/sexscenes/emilyshower.png"),
emilyshowerrape = load("res://files/images/sexscenes/emilyshowerrape.png"),
tishabj = load("res://files/images/sexscenes/tishabj.png"),
tishafinale = load("res://files/images/sexscenes/tishafinale.png"),
tishatable = load("res://files/images/sexscenes/tishatable.png"),
}
var mansionupgradesdict = mansionupgrades.dict


var noimage = load("res://files/buttons/noimagesmall.png")

func _init():
	randomize()
	loadsettings()
	effectdict = effects.effectlist 
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
	settings.close()
	var data = {chars = charactergallery, folders = setfolders}
	
	if settings.file_exists("user://progressdata") == false:
		overwritesettings()
	
	settings.open_encrypted_with_pass("user://progressdata", File.READ, 'tehpass')
	var storedsettings = settings.get_var()
	temp = storedsettings.chars
	
	for char in charactergallery:
		if temp.has(char):
			for part in charactergallery[char]:
				if part in ['unlocked', 'nakedunlocked'] && temp[char].has(part):
					charactergallery[char][part] = temp[char][part]
				elif part == 'scenes':
					for scene in range(temp[char][part].size()):
						charactergallery[char][part][scene].unlocked = temp[char][part][scene].unlocked
	if storedsettings.has('folders') == false:
		overwritesettings()
		settings.open_encrypted_with_pass("user://progressdata", File.READ, 'tehpass')
		storedsettings = settings.get_var()
	temp = storedsettings.folders
	for i in temp:
		setfolders[i] = temp[i]
	if storedsettings.has('savelist') == false:
		overwritesettings()
		settings.open_encrypted_with_pass("user://progressdata", File.READ, 'tehpass')
		storedsettings = settings.get_var()
	temp = storedsettings.savelist
	for i in temp:
		savelist[i] = temp[i]
	settings.close()

var charactergallery = gallery.charactergallery
var setfolders = {portraits = 'user://portraits/', fullbody = 'user://bodies/'} setget savefolders
var savelist = {}

func savefolders(value):
	overwritesettings()

func overwritesettings():
	var settings = File.new()
	settings.open("user://settings.ini", File.WRITE)
	settings.store_line(var2str(rules))
	settings.close()
	settings.open_encrypted_with_pass("user://progressdata", File.WRITE, 'tehpass')
	var data = {chars = charactergallery, folders = setfolders, savelist = savelist}
	settings.store_var(data)
	settings.close()

func clearstate():
	state = progress.new()
	slaves.clear()
	events = load("res://files/scripts/events.gd").new()
	items = load("res://files/scripts/items.gd").new()
	itemdict = items.itemlist
	resources.reset()

func newslave(race, age, sex, origins = 'slave'):
	return constructor.newslave(race, age, sex, origins)

func slaves_set(slave):
	slave.originstrue = slave.origins
	slave.health = max(slave.health, 5)
	slave.ability.append("protect")
	slave.abilityactive.append("protect")
	slaves.append(slave)
	if get_tree().get_current_scene().find_node('CharList'):
		get_tree().get_current_scene().rebuild_slave_list()
	if get_tree().get_current_scene().find_node('ResourcePanel'):
		get_tree().get_current_scene().find_node('population').set_text(str(slavecount())) 
	if globals.get_tree().get_current_scene().has_node("infotext"):
		globals.get_tree().get_current_scene().infotext("New person acquired: " + slave.name_long(),'green')

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
musicvol = 1,
receiving = true,
fullscreen = false,
oldresize = true,
fadinganimation = true,
permadeath = false,
autoattack = true,
enddayalise = 1,
spritesindialogues = true,
screenwidth = 1080,
screenheight = 600,
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
		var color
		var difference = gold - value
		var text = ""
		gold = value
		if gold < 0:
			gold = 0
		if panel != null:
			panel.get_node('gold').set_text(str(gold))
		
		
		if difference != 0:
			if difference < 0:
				text = "Obtained " + str(abs(difference)) +  " gold"
				color = 'green'
			else:
				color = 'red'
				text = "Lost " + str(abs(difference)) +  " gold"
		
		if globals.get_tree().get_current_scene().has_node("infotext"):
			globals.get_tree().get_current_scene().infotext(text,color)
	
	func day_set(value):
		day = value
		if day < 0:
			day = 0
		if panel != null:
			panel.get_node('day').set_text(str(day))
	
	func food_set(value):
		value = round(value)
		var color
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
				text = "Obtained " + str(abs(difference)) +  " food"
				color = 'green'
			else:
				text = "Lost " + str(abs(difference)) +  " food"
				color = 'red'
		if globals.get_tree().get_current_scene().has_node("infotext"):
			globals.get_tree().get_current_scene().infotext(text,color)
	
	func mana_set(value):
		value = round(value)
		var color
		var difference = mana - value
		var text = ""
		mana = value
		if mana < 0:
			mana = 0
		
		if panel != null:
			panel.get_node('mana').set_text(str(mana))
		
		if difference != 0:
			if difference < 0:
				text = "Obtained " + str(abs(difference)) +  " mana"
			else:
				text = "Used " + str(abs(difference)) +  " mana"
		
		if globals.get_tree().get_current_scene().has_node("infotext"):
			globals.get_tree().get_current_scene().infotext(text,color)
		
		
	
	func upgradepoints_set(value):
		var difference = upgradepoints - value
		if difference < 0:
			for i in globals.slaves:
				if i.traits.has("Gifted"):
					value *= 1.2
		var text = ""
		upgradepoints = value
		
		
		if difference < 0:
			text = "Obtained " + str(abs(difference)) +  " Mansion Upgrade Points"
		
		
		if globals.get_tree().get_current_scene().has_node("infotext"):
			globals.get_tree().get_current_scene().infotext(text,'green')
	
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
	var umbrafirstvisit = true
	var itemlist = {}
	var spelllist = {}
	var mainquest = 0
	var mainquestcomplete = false
	var rank = 0
	var password = ''
	var sidequests = {emily = 0, brothel = 0, cali = 0, chloe = 0, ayda = 0, ivran = '', yris = 0, zoe = 0, ayneris = 0, sebastianumbra = 0, maple = 0}
	var repeatables = {wimbornslaveguild = [], frostfordslaveguild = [], gornslaveguild = []}
	var babylist = []
	var companion = -1
	var headgirlbehavior = 'none'
	var portals = {wimborn = {'enabled' : false, 'code' : 'wimborn'}, gorn = {'enabled':false, 'code' : 'gorn'}, frostford = {'enabled':false, 'code' : 'frostford'}, shaliq = {'enabled':false, 'code':'shaliq'}, amberguard = {'enabled':false, 'code':'amberguard'}, umbra = {'enabled':false, 'code':'umbra'}}
	var sebastianorder = {race = 'none', taken = false, duration = 0}
	var sebastianslave
	var sandbox = false
	var snails = 0
	var groupsex = true
	var playergroup = []
	var timedevents = {}
	var customcursor = "res://files/buttons/kursor1.png"
	var upcomingevents = []
	var reputation = {wimborn = 0, frostford = 0, gorn = 0, amberguard = 0} setget reputation_set
	var dailyeventcountdown = 0
	var dailyeventprevious = 0
	var currentversion = 5000
	var unstackables = {}
	var supplykeep = 10
	var foodbuy = 200
	var supplybuy = false
	var tutorial = {basics = false, slave = false, alchemy = false, jail = false, lab = false, farm = false, outside = false, combat = false}
	var itemcounter = 0
	var alisecloth = 'normal'
	var decisions = []
	var lorefound = []
	var descriptsettings = {full = true, basic = true, appearance = true, genitals = true, piercing = true, tattoo = true, mods = true}
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
	mansionparlor = 0,
	}
	var capturedgroup = []
	var ghostrep = {wimborn = 0, frostford = 0, gorn = 0, amberguard = 0}
	var backpack = {stackables = {}, unstackables = []}
	var restday = 0
	var defaultmasternoun = "Master"
	var sexactions = 1
	
	func calculateweight():
		var slave
		var tempitem
		var currentweight = 0
		var maxweight = 10 + globals.player.sstr*4
		var array = [globals.player]
		for i in globals.state.playergroup:
			slave = globals.state.findslave(i)
			array.append(slave)
			maxweight += slave.sstr*5 + 3
		for i in globals.state.backpack.stackables:
			if globals.itemdict[i].has('weight'):
				currentweight += globals.itemdict[i].weight * globals.state.backpack.stackables[i]
		
		for i in globals.state.unstackables.values():
			if i.has('weight') && str(i.owner) == 'backpack':
				currentweight += i.weight
		for i in array:
			for k in i.gear.values():
				if k != null && globals.state.unstackables[k].code == 'acctravelbag': maxweight += 20
		var dict = {currentweight = currentweight, maxweight = maxweight, overload = maxweight < currentweight}
		return dict
	
	func reputation_set(value):
		var text = ''
		var color
		for i in value:
			if ghostrep[i] != value[i]:
				value[i] = min(max(value[i], -50),50)
				if ghostrep[i] > value[i]:
					text += "Reputation with " + i.capitalize() + " has worsened!"
					color = 'red'
				else:
					text += "Reputation with " + i.capitalize() + " has increased!"
					color = 'green'
				ghostrep[i] = value[i]
		if globals.get_tree().get_current_scene().has_node("infotext"):
			globals.get_tree().get_current_scene().infotext(text,color)

	
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
	var name = ''
	var surname = ''
	var nickname = ''
	var unique = null
	var id = 0
	var race = ''
	var age = ''
	var mindage = ''
	var sex = ''
	var spec = null
	var imageportait = null
	var imagefull = null
	var haircolor = ''
	var hairlength = ''
	var hairstyle = ''
	var eyecolor = ''
	var skin = ''
	var height = ''
	var titssize = ''
	var asssize = ''
	var eyeshape = 'normal'
	var eyesclera = 'normal'
	var arms = 'normal'
	var legs = 'normal'
	var bodyshape = 'humanoid'
	var skincov = 'none'
	var furcolor = 'none'
	var ears = 'human'
	var tail = 'none'
	var wings = 'none'
	var horns = 'none'
	var beauty = 0 setget ,beauty_get
	var beautybase = 0 setget beautybase_set
	var beautytemp = 0 
	
	var asser = 0
	var pubichair = 'clean'
	
	var lewdness = 0
	var lactation = false
	var titsextra = 0
	var titsextradeveloped = false
	var consent = false
	var vagina = 'normal'
	var vagvirgin = true
	var mouthvirgin = true
	var assvirgin = true
	var penis = 'none'
	var balls = 'none'
	var penistype = 'human'
	var penisextra = 0
	var penisvirgin = true
	var sensvagina = 0
	var sensmouth = 0
	var senspenis = 0
	var sensanal = 0
	var knowntechniques = []
	
	var preg = {fertility = 0, has_womb = true, duration = 0, baby = null}
	var rules = {'silence':false, 'pet':false, 'contraception':false, 'aphrodisiac':false, 'masturbation':false, 'nudity':false, 'betterfood':false, 'personalbath':false,'cosmetics':false,'pocketmoney':false}
	var traits = []
	var relatives = {father = -1, mother = -1, siblings = [], children =[]}
	var gear = {costume = null, underwear = null, armor = null, weapon = null, accessory = null}
	var genes = {}
	var effects = {}
	var brand = 'none'
	var work = 'rest'
	var sleep = ''
	var farmoutcome = false
	
	var ability = ['attack']
	var abilityactive = ['attack']
	var customdesc = ''
	var piercing = {earlobes = null, eyebrow = null, nose = null, lips = null, tongue = null, navel = null, clit = null, nipples = null, clit = null, labia = null, penis = null}
	var tattoo = {chest = 'none', face = 'none', ass = 'none', arms = 'none', legs = 'none', waist = 'none'}
	var level = 1
	var xp = 0 setget xp_set, xp_get
	var realxp = 0
	var skillpoints = 2
	var levelupreqs = {} setget levelupreqs_set
	var punish = {expect = false, strength = 0}
	var praise = 0
	var away = {duration = 0, at = ''}
	var cattle = {is_cattle = false, work = '', used_for = 'food'}
	var mods = {}
	var tattooshow = {chest = true, face = true, ass = true, arms = true, legs = true, waist = true}
	var tags = []
	var origins = 'slave'
	var originstrue = ''
	var memory = ''
	var attention = 0
	var sexuals = {actions = {}, unlocked = false, affection = 0, kinks = {}, unlocks = [], lastaction = ''}
	var kinks = []
	var forcedsex = false
	var sexexp = {}
	var sensation = {}
	var metrics = {ownership = 0, jail = 0, mods = 0, brothel = 0, sex = 0, partners = [], randompartners = 0, item = 0, spell = 0, orgy = 0, threesome = 0, win = 0, capture = 0, goldearn = 0, foodearn = 0, manaearn = 0, birth = 0, preg = 0, vag = 0, anal = 0, oral = 0, roughsex = 0, roughsexlike = 0, orgasm = 0}
	var fromguild = false
	var masternoun = 'Master'
	var lastinteractionday = 0
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
		cour_max = 100,
		cour_base = 0,
		conf_max = 100,
		conf_base = 0,
		wit_max = 100,
		wit_base = 0,
		charm_max = 100,
		charm_base = 0,
		obed_cur = 0.0,
		obed_max = 100,
		obed_min = 0,
		obed_mod = 0,
		stress_cur = 0.0,
		stress_max = 150,
		stress_min = 0,
		stress_mod = 0,
		tox_cur = 0.0,
		tox_max = 100,
		tox_min = 0,
		lust_cur = 0,
		lust_max = 100,
		lust_min = 0,
		lust_mod = 0,
		health_cur = 0,
		health_max = 100,
		health_base = 0,
		health_bonus = 1,
		energy_cur = 75,
		energy_max = 100,
		energy_mod = 0,
		armor_cur = 0,
		armor_max = 0,
		armor_base = 0,
		loyal_cur = 0.0,
		loyal_mod = 0,
		loyal_max = 100,
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
	var toxicity setget tox_set,tox_get
	var energy setget energy_set,energy_get
	var sstr setget str_set,str_get
	var sagi setget agi_set,agi_get
	var smaf setget maf_set,maf_get
	var send setget end_set,end_get
	
	func get_traits():
		var array = []
		for i in traits:
			array.append(globals.origins.trait(i))
		return array
	
	func add_trait(trait, remove = false):
		trait = globals.origins.trait(trait)
		var conflictexists = false
		var text = ""
		var traitexists = false
		for i in get_traits():
			if i.name == trait.name:
				traitexists = true
			for ii in i.conflict:
				if trait.name == ii:
					print('conflicting trait detected')
					conflictexists = true
		if traitexists || conflictexists:
			print("Can't apply: trait exists or conflicting with another trait")
		else:
			traits.append(trait.name)
			if globals.get_tree().get_current_scene().has_node("infotext") && globals.slaves.find(self) >= 0 && away.at != 'hidden':
				text += self.dictionary("$name acquired new trait: " + trait.name)
				globals.get_tree().get_current_scene().infotext(text,'yellow')
			if trait['effect'].empty() != true:
				add_effect(trait['effect'])
	
	func trait_remove(trait):
		var text = ''
		trait = globals.origins.trait(trait)
		if traits.find(trait.name) < 0:
			return
		traits.erase(trait.name)
		if trait['effect'].empty() != true:
			add_effect(trait['effect'], true)
		text += self.dictionary("$name lost trait: " + trait.name)
		if globals.get_tree().get_current_scene().has_node("infotext") && globals.slaves.find(self) >= 0 && away.at != 'hidden':
			globals.get_tree().get_current_scene().infotext(text,'yellow')
	
	func levelupreqs_set(value):
		levelupreqs = value
	
	func levelup():
		levelupreqs.clear()
		level += 1
		skillpoints += 3
		realxp = 0
		sexuals.affection += round(rand_range(5,10))
		if self != globals.player:
			globals.get_tree().get_current_scene().infotext(dictionary("$name has advanced to Level " + str(level)),'green')
		else:
			globals.get_tree().get_current_scene().infotext(dictionary("You have advanced to Level " + str(level)),'green')
	
	func xp_set(value):
		var difference = value - realxp
		realxp += max(difference/max(level,1),1)
		realxp = round(clamp(realxp, 0, 100))
		if realxp >= 100 && self == globals.player:
			levelup()
	
	
	func xp_get():
		return realxp
	
	func getessence():
		var essence
		if race in ['Demon', 'Arachna', 'Lamia']:
			essence = 'taintedessenceing'
		elif race in ['Fairy', 'Drow', 'Dragonkin']:
			essence = 'magicessenceing'
		elif race == 'Dryad':
			essence = 'natureessenceing'
		elif race in ['Harpy', 'Centaur'] || race.find('Beastkin') >= 0 || race.find('Halfkin') >= 0:
			essence = 'bestialessenceing'
		elif race in ['Slime','Nereid', "Scylla"]:
			essence = 'fluidsubstanceing'
		return essence
	
	
	func cleartraits():
		spec = null
		for i in traits:
			trait_remove(i)
		for i in ['str_base','agi_base', 'maf_base', 'end_base','str_cur','agi_cur', 'maf_cur', 'end_cur']:
			stats[i] = 0
		skillpoints = 2
		level = 1
		xp = 0
	
	func add_effect(effect, remove = false):
		if effects.has(effect.code):
			if remove == true:
				effects.erase(effect.code)
				for i in effect:
					if stats.has(i):
						stats[i] = stats[i] + -effect[i]
					elif i == 'beautybase':
						beautybase = beautybase + -effect[i]
					elif i == 'beautytemp':
						beautytemp = beautytemp + -effect[i]
		elif remove != true:
			effects[effect.code] = effect
			for i in effect:
				if stats.has(i):
					stats[i] = stats[i] + effect[i]
				elif i == 'beautybase':
					beautybase = beautybase + effect[i]
				elif i == 'beautytemp':
					beautytemp = beautytemp + effect[i]
	
	
	func beauty_get():
		return beautybase + beautytemp
	
	
	func health_set(value):
		stats.health_max = (50 + stats.end_cur*25)*stats.health_bonus
		stats.health_cur = min(value, stats.health_max) 
	
	func obed_set(value):
		var difference = stats.obed_cur - value
		var string = ""
		var color
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
			text = self.dictionary("$name's obedience has decreased " + string)
			color = 'red'
		else:
			difference = abs(difference)
			if abs(difference) < 20:
				string = "(+)"
			elif abs(difference) < 40:
				string = "(++)"
			else:
				string = "(+++)"
			text = self.dictionary("$name's obedience has grown " + string)
			color = 'green'
			stats.obed_cur += difference*(1 + stats.obed_mod/100)
		
		stats.obed_cur = max(min(stats.obed_cur, stats.obed_max),stats.obed_min)
		if stats.obed_cur < 50 && spec == 'executor':
			stats.obed_cur = 50
		if globals.get_tree().get_current_scene().has_node("infotext") && globals.slaves.find(self) >= 0 && away.at != 'hidden':
			globals.get_tree().get_current_scene().infotext(text,color)
	
	func loyal_set(value):
		var difference = stats.loyal_cur - value
		var string = ""
		var color
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
			text = self.dictionary("$name's loyalty decreased " + string)
			color = 'red'
		elif difference < 0:
			difference = abs(difference)
			if abs(difference) < 5:
				string = "(+)"
			elif abs(difference) < 10:
				string = "(++)"
			else:
				string = "(+++)"
			text = self.dictionary("$name's loyalty grown " + string)
			color = 'green'
			stats.loyal_cur += difference*(1 + stats.loyal_mod/100) 
		
		
		stats.loyal_cur = max(min(stats.loyal_cur, stats.loyal_max),stats.loyal_min)
		if globals.get_tree().get_current_scene().has_node("infotext") && globals.slaves.find(self) >= 0 && away.at != 'hidden':
			globals.get_tree().get_current_scene().infotext(text,color)
	
	func stress_set(value):
		
		var difference = stats.stress_cur - value
		var string = ""
		var text = ""
		var color
		if difference < 0:
			difference = abs(difference)
			if abs(difference) < 15:
				string = "(+)"
			elif abs(difference) < 30:
				string = "(++)"
			else:
				string = "(+++)"
			stats.stress_cur += difference*(1 + stats.stress_mod/100)
			text = self.dictionary("$name's stress has grown " + string)
			color = 'red'
		else:
			difference = abs(difference)
			if abs(difference) < 15:
				string = "(-)"
			elif abs(difference) < 30:
				string = "(--)"
			else:
				string = "(---)"
			text = self.dictionary("$name's stress has reduced " + string)
			color = 'green'
			stats.stress_cur -= difference*(1 + stats.stress_mod/100)
		
		stats.stress_cur = max(min(stats.stress_cur, 150),stats.stress_min)
		if globals.get_tree().get_current_scene().has_node("infotext") && globals.slaves.find(self) >= 0 && away.at != 'hidden':
			globals.get_tree().get_current_scene().infotext(text,color)
		if self == globals.player:
			stats.stress_cur = 0
		
	
	func tox_set(value):
		stats.tox_cur = max(min(value, stats.tox_max),stats.tox_min)
	
	func energy_set(value):
		value = round(value)
		stats.energy_cur = max(min(value*(1 + stats.energy_mod/100), stats.energy_max),0)
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
	
	func str_set(value):
		stats.str_cur = min(value-stats.str_mod, stats.str_max)
	
	func agi_set(value):
		stats.agi_cur = min(value-stats.agi_mod, stats.agi_max)
	
	func maf_set(value):
		stats.maf_cur = min(value-stats.maf_mod, stats.maf_max)
	
	func end_set(value):
		stats.end_cur = min(value-stats.end_mod, stats.end_max)
		self.health = self.health
	
	func beautybase_set(value):
		value = round(value)
		beautybase = min(max(value,0),100)
	
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
	
	func awareness():
		var number = 0
		number = self.sagi*3 + self.wit/10
		if mods.has('augmenthearing'):
			number += 3
		return number
	
	
	func health_icon():
		var health
		if float(stats.health_cur)/stats.health_max > 0.75: 
			health = load("res://files/buttons/icons/health/2.png")
		elif float(stats.health_cur)/stats.health_max > 0.4:
			health = load("res://files/buttons/icons/health/1.png")
		else:
			health = load("res://files/buttons/icons/health/3.png")
		return health
	
	func obed_icon():
		var obed
		if float(stats.obed_cur)/stats.obed_max > 0.75: 
			obed = load("res://files/buttons/icons/obedience/2.png")
		elif float(stats.obed_cur)/stats.obed_max > 0.4:
			obed = load("res://files/buttons/icons/obedience/1.png")
		else:
			obed = load("res://files/buttons/icons/obedience/3.png")
		return obed
	
	func stress_icon():
		var stress
		if stats.stress_cur >= 70: 
			stress = load("res://files/buttons/icons/stress/3.png")
		elif stats.stress_cur > 35:
			stress = load("res://files/buttons/icons/stress/1.png")
		else:
			stress = load("res://files/buttons/icons/stress/2.png")
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
		string = string.replace('$penis', globals.fastif(penis == 'none', 'strapon', '$his cock'))
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
		string = string.replace('$master', masternoun)
		string = string.replace('[haircolor]', haircolor)
		string = string.replace('[eyecolor]', eyecolor)
		return string
	
	func dictionaryplayer(text):
		var string = text
		string = string.replace('[Playername]', globals.player.name_short())
		string = string.replace('$name', name_short())
		string = string.replace('$penis', globals.fastif(penis == 'none', 'strapon', '$his cock'))
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
		string = string.replace('[haircolor]', haircolor)
		string = string.replace('[eyecolor]', eyecolor)
		string = string.replace('$race', globals.decapitalize(race).replace('_', ' '))
		return string
	
	func dictionaryplayerplus(text):
		var string = text
		string = string.replace(' has', ' have')
		string = string.replace(' Has', ' have')
		string = string.replace('You is', 'You are')
		string = string.replace("You's", "You're")
		string = string.replace('appears', 'appear')
		return string
	
	func description():
		return globals.description.getslavedescription(self)
	
	func descriptionsmall():
		return globals.description.getslavedescription(self, 'compact')
	
	func status():
		return globals.description.getstatus(self)
	
	func countluxury():
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
		price = beautybase*2.5 + beautytemp*1.5
		price += (level-1)*50
		if vagvirgin == true:
			price = price*1.2
		if sex == 'futanari':
			price = price*1.1
		for i in get_traits():
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
		elif race == 'Slime'||race == 'Lamia' || race == 'Arachna' || race == 'Harpy' || race == 'Scylla':
			price = price*2.5
		elif race == 'Dragonkin':
			price = price*3.5
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
	
	func buyprice():
		return calculateprice()
	
	func sellprice(alternative = false):
		var price = calculateprice()*0.6
		
		if effects.has('captured') == true && alternative == false:
			price = price/2
		for i in globals.slaves:
			if i.traits.has("Influential"):
				price *= 1.2
		price = max(round(price), 10)
		return price
	
	
	func removefrommansion():
		globals.slaves.erase(self)
		globals.get_tree().get_current_scene().infotext(self.dictionary("$name $surname is no longer in your posession. "),'red')
		for i in gear.values():
			if !i in ['underwearplain','clothcommon'] && i != null:
				globals.state.unstackables[i].owner = null
	
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
	rval.personal = personal_room
	rval.your_bed = your_bed
	rval.jail = jail
	rval.farm = farm
	rval.communal = communal
	return rval

func impregnation(mother, father = null, anyfather = false):
	var realfather
	if father == null:
		var gender
		realfather = -1
		if globals.rules.futa == true:
			gender = ['male','futanari']
		else:
			gender = ['male']
		if anyfather == false:
			father = globals.newslave('randomcommon', 'random', gender[rand_range(0,gender.size())])
		else:
			father = globals.newslave('randomany', 'random', gender[rand_range(0,gender.size())])
	else:
		if father.penis == 'none':
			return
		realfather = father.id
	if mother.preg.has_womb == false || mother.preg.duration > 0 || mother == father:
		return
	var rand = rand_range(1,100)
	if mother.preg.fertility < rand:
		mother.preg.fertility += rand_range(5,15)
		return
	var age = ''
	var babyrace = mother.race
	if globals.rules.children == true:
		age = 'child'
	else: 
		age = 'teen'
	if (mother.race.find('Beastkin') >= 0 && father.race.find('Beastkin') < 0)|| (father.race.find('Beastkin') >= 0 && mother.race.find('Beastkin') < 0):
		if father.race.find('Beastkin') >= 0 && mother.race in ['Human','Elf','Dark Elf','Drow','Demon','Seraph']:
			babyrace = father.race.replace('Beastkin', 'Halfkin')
		else:
			babyrace = mother.race.replace('Beastkin', 'Halfkin')
		
	var baby = globals.newslave(babyrace, age, 'random', mother.origins)
	baby.surname = mother.surname
	var array = ['skin','tail','ears','wings','horns','arms','legs','bodyshape','haircolor','eyecolor','eyeshape','eyesclera']
	for i in array:
		if rand_range(0,10) > 5:
			baby[i] = father[i]
		else:
			baby[i] = mother[i]
	if baby.race.find('Halfkin')>=0 && mother.race.find('Beastkin') >= 0 && father.race.find('Beastkin') < 0:
		baby.bodyshape = 'humanoid'
	if rand_range(0,10) > 5:
		baby.beautybase = father.beautybase
	else:
		baby.beautybase = mother.beautybase
	baby.relatives.father = realfather
	baby.relatives.mother = mother.id
	mother.preg.baby = baby.id
	mother.preg.duration = 1
	mother.metrics.preg += 1
	globals.state.babylist.append(baby)

var baby


func showtooltip(text):
	main.get_node("tooltip/RichTextLabel").set_bbcode(text)
	var pos = main.get_global_mouse_pos()
	pos = Vector2(pos.x+20, pos.y+20)
	main.get_node("tooltip").set_pos(pos)
	var screen = get_viewport().get_visible_rect()
	var tooltipsize = main.get_node("tooltip").get_rect()
	if tooltipsize.pos.x + tooltipsize.size.x >= screen.size.x:
		main.get_node("tooltip").set_pos(Vector2(tooltipsize.pos.x + (screen.size.x - (tooltipsize.pos.x + tooltipsize.size.x)) , tooltipsize.pos.y))
	tooltipsize = main.get_node("tooltip").get_rect()
	if tooltipsize.pos.y + tooltipsize.size.y >= screen.size.y:
		main.get_node("tooltip").set_pos(Vector2(tooltipsize.pos.x, tooltipsize.pos.y + (screen.size.y - (tooltipsize.pos.y + tooltipsize.size.y))-10))
	main.get_node("tooltip").set_hidden(false)
	yield(get_tree(), "idle_frame")
	main.get_node("tooltip/RichTextLabel").set_size(Vector2(main.get_node("tooltip/RichTextLabel").get_size().width, main.get_node("tooltip/RichTextLabel").get_v_scroll().get_max()))
	main.get_node("tooltip").set_size(Vector2(main.get_node("tooltip").get_size().x, main.get_node("tooltip/RichTextLabel").get_size().y + 30))


func hidetooltip():
	main.get_node("tooltip").set_hidden(true)

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


func itemdescription(item):
	var text = ''
	var name = ''
	name = item.name 
	text = item.description
	if item.has('owner'):
		text += '\n\n'
		if item.enchant == 'basic':
			name = '[color=green]' + name + '[/color]'
		for i in item.effects:
			text += i.descript + "\n"
	if item.has('weight'):
		text += "\n\n[color=yellow]Weight: " + str(item.weight) + "[/color]"
	return '[center]' + name + '[/center]\n' + text

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
	savegame.open(savename, File.WRITE)
	var nodedata = save()
	var date = OS.get_datetime()
	for i in date:
		if date[i] < 10:
			date[i] = '0' + str(date[i])
		else:
			date[i] = str(date[i])
	var entry = {name = "Master " + player.name + ", Day " + str(resources.day) + ', Gold ' + str(resources.gold) + ', Slaves: ' + str(slavecount()), path = savename, date = date.hour + ":" + date.minute + " " + date.day + '.' + date.month + '.' + date.year}
	savelist[savename] = entry
	overwritesettings()
	savegame.store_line(nodedata.to_json())
	savegame.close()
	get_tree().get_current_scene().infotext("Game Saved.",'green')

func load_game(filename):
	var savegame = File.new()
	var newslave
	if !savegame.file_exists(filename):
		return #Error!  We don't have a save to load
	clearstate()
	var currentline = {} 
	savegame.open(filename, File.READ)
	currentline.parse_json(savegame.get_as_text())
	get_tree().change_scene("res://files/Mansion.scn")
	resources = dict2inst(currentline.resources)
	player = dict2inst(currentline.player)
	state = dict2inst(currentline.state)
	var statetemp = progress.new()
	for i in statetemp.reputation:
		if state.ghostrep.has(i) == false:
			state.ghostrep[i] = statetemp.reputation[i]
		if state.reputation.has(i) == false:
			state.reputation[i] = statetemp.reputation[i]
	for i in state.itemlist:
		if itemdict.has(i):
			itemdict[i].amount = state.itemlist[i].amount
			itemdict[i].unlocked = state.itemlist[i].unlocked
	for i in statetemp.sidequests:
		if state.sidequests.has(i) == false:
			state.sidequests[i] = statetemp.sidequests[i]
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
		if i.has('face'):
			newslave.beautybase = round(i.face.beauty)
		slaves.append(newslave)
	for i in currentline.babylist:
		newslave = slave.new()
		newslave = dict2inst(i)
		if i.has('face'):
			newslave.beautybase = round(i.face.beauty)
		state.babylist.append(newslave)
	savegame.close()
	if state.customcursor == null:
		Input.set_custom_mouse_cursor(null)
	else:
		state.customcursor = "res://files/buttons/kursor1.png"
	
	
	gameloaded = true
	if state.currentversion != gameversion:
		print("Using old save, attempting repair")
		repairsave()
	

func repairsave():
	state.currentversion = gameversion
	for slave in [player] + slaves:
		if slave.gear.costume == 'clothcommon':
			slave.gear.costume = null
		if slave.gear.underwear == 'underwearplain':
			slave.gear.underwear = null
	for i in globals.state.unstackables.values():
		if i.enchant == null:
			i.enchant = ''

var showalisegreet = false

func dir_contents(target = "user://saves"):
	var dir = Directory.new()
	var array = []
	if dir.open(target) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if !dir.current_is_dir():
				array.append(target + "/" + file_name)
			elif !file_name in ['.','..', null] && dir.current_is_dir():
				array += dir_contents(target + "/" + file_name)
			file_name = dir.get_next()
		return array
	else:
		print("An error occurred when trying to access the path.")

var currentslave
var currentsexslave

func evaluate(input): #used to read strings as conditions when needed
	var script = GDScript.new()
	script.set_source_code("var slave\nfunc eval():\n\treturn " + input)
	script.reload()
	var obj = Reference.new()
	obj.set_script(script)
	obj.slave = currentslave
	return obj.eval()

func weightedrandom(array): #array must be made out of dictionaries with {value = name, weight = number} Number is relative to other elements which may appear
	var total = 0
	var counter = 0
	for i in array:
		if typeof(i) == TYPE_DICTIONARY:
			total += i.weight
		else:
			total += i[1]
	var random = rand_range(0,total)
	for i in array:
		if typeof(i) == TYPE_DICTIONARY:
			if counter + i.weight >= random:
				return i.value
			counter += i.weight
		else:
			if counter + i[1] >= random:
				return i[0]
			counter += i[1]

func randomfromarray(array):
	return array[rand_range(0,array.size())]

func buildportrait(node, slave):
	var array = ['race','hairlength','ears'] #add more pieces of layers in order they should be added
	var imagedict = { #should have all pieces you added to the array with paths
	race = {human = load('humanheadimage.png'), elf = load('elfheadimage.png')},
	hairlength = {long = load('longhairimage.png'), short = load('shorthairimage.png')},
	ears = {normal = load('normalears.png'), pointy = load('pointyearsimg.png')},
	} 
	for i in array:
		var newlayer = node.duplicate()
		node.add_child(newlayer)
		newlayer.set_texture(imagedict[i][slave[i]])

func checkfurryrace(text):
	if text in ['Cat','Wolf','Fox','Bunny','Tanuki']:
		if rules.furry == true:
			if rand_range(0,1) >= 0.5:
				text = 'Halfkin ' + text
			else:
				text = 'Beastkin ' + text
		else:
			text = 'Halfkin ' + text
	return text
