
extends Node

var itemdict = {}
var spelldict = {}
var effectdict = {}
var guildslaves = {wimborn = [], gorn = [], frostford = []}
var gameversion = 044
var state = progress.new()

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
undercity = load("res://files/backgrounds/undercity.jpg"),
lab1 = load("res://files/backgrounds/laboratory1.jpg"),
lab2 = load("res://files/backgrounds/laboratory2.jpg"),
gorn = load("res://files/backgrounds/gorn.jpg"),
frostford = load("res://files/backgrounds/frostford.jpg"),
mountains = load("res://files/backgrounds/mountains.jpg"),
borealforest = load("res://files/backgrounds/borealforest.jpg"),
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
}

class resource:
	var day = 1 setget day_set
	var gold = 0 setget gold_set
	var mana = 0 setget mana_set
	var energy = 0 setget energy_set
	var food = 0  setget food_set
	var panel
	var array = ['day','gold','mana','energy','food']
	
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
		mana = round(value)
		if mana < 0:
			mana = 0
		if panel != null:
			panel.get_node('mana').set_text(str(mana))
	
	func energy_set(value):
		if panel != null:
			panel.get_node("energy").set_text(str(round(globals.player.energy)))

#var wimborn = {'enabled': true, 'code':'wimborn', 'name':'Wimborn'}
#var shaliq = {'enabled':false, 'code':'shaliq', 'name':'Shaliq Village'} 
#var gorn = {'enabled':true, 'code':'gorn', 'name':'Gorn'} 
#var frostford = {'enabled':true, 'code':'frostford', 'name':'Frostford'} 

#var portalsarray = [wimborn, shaliq, gorn, frostford]

class progress:
	var tutorialcomplete = false
	var supporter = false
	var location = 'wimborn'
	var rooms = {bed = 1, jail = 2, communal = 4, personal = 1}
	var roomscap = {bed = 3, jail = 8, communal = 20, personal = 10}
	var condition = 85 setget cond_set
	var conditionmod = 1.3
	var alchemy = 0
	var laboratory = 0 
	var farm = 0 
	var apiary = 0
	var library = 0
	var branding = 0
	var slaveguildvisited = 0
	var itemlist = {}
	var spelllist = {}
	var mainquest = 0
	var rank = 0
	var password = ''
	var sidequests = {emily = 0, brothel = 0, cali = 0, dolin = 0, ayda = 0, ivran = ''}
	var repeatables = {wimbornslaveguild = [], frostfordslaveguild = [], gornslaveguild = []}
	var babylist = []
	var companion = -1
	var headgirlbehavior = 'none'
	var portals = [{'enabled' : true, 'code' : 'wimborn'}, {'enabled':true, 'code' : 'gorn'}, {'enabled':true, 'code' : 'frostford'}, {'enabled':false, 'code':'shaliq'}]
	var sebastianorder = {race = 'none', taken = false, duration = 0}
	var sebastianslave
	var sandbox = false
	var snails = 0
	var groupsex = true
	var playergroup = []
	var timedevents = {}
	var customcursor = "res://files/buttons/kursor1.png"
	var upcomingevents = []
	var reputation = {wimborn = 0, frostford = 0, gorn = 0}
	var dailyeventcountdown = 0
	var dailyeventprevious = 0
	var currentversion = 0336
	var unstackables = {}
	var supplykeep = 10
	
	var itemcounter = 0
	
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
	var sexuals = {actions = {}, unlocked = false, affection = 0, kinks = {}, unlocks = []}
	var kinks = []
	var affiliation = {wimborn = 0, frostford = 0, gorn = 0}
	var metrics = {ownership = 0, jail = 0, mods = 0, brothel = 0, sex = 0, partners = [], randompartners = 0, item = 0, spell = 0, orgy = 0, threesome = 0, win = 0, capture = 0, goldearn = 0, foodearn = 0, manaearn = 0, birth = 0, preg = 0, vag = 0, anal = 0, oral = 0, roughsex = 0, roughsexlike = 0, orgasm = 0}
	var stats = {
		str_cur = 0,
		str_max = 0,
		str_base = 1,
		agi_cur = 1, 
		agi_max = 0, 
		agi_base = 1,
		maf_cur = 0,
		maf_max = 0,
		maf_base = 0,
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
		for i in [stats.str_cur, stats.agi_cur, stats.maf_cur, stats.end_cur]:
			i = 0
	
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
		
		stats.stress_cur = max(min(stats.stress_cur, stats.stress_max),stats.stress_min)
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
		stats.str_base = min(stats.str_cur + value,stats.str_max)
		stats.str_cur = stats.str_base
	
	func agi_set(value):
		stats.agi_base = min(stats.agi_cur + value,stats.agi_max)
		stats.agi_cur = stats.agi_base
	
	func maf_set(value):
		stats.maf_base = min(stats.maf_cur + value,stats.maf_max)
		stats.maf_cur = stats.maf_base
	
	func end_set(value):
		stats.end_base = min(stats.end_cur + value,stats.end_max)
		stats.end_cur = stats.end_base
	
	
	func loyal_get():
		return stats.loyal_cur
	
	func health_get():
		return stats.health_cur
	
	func obed_get():
		return stats.obed_cur
	
	func stress_get():
		return stats.stress_cur
	
	func cour_get():
		return stats.cour_base
	
	func conf_get():
		return stats.conf_base
	
	func wit_get():
		return stats.wit_base
	
	func charm_get():
		return stats.charm_base
	
	func lust_get():
		return stats.lust_cur
	
	func dom_get():
		return stats.dom_cur
	
	func tox_get():
		return stats.tox_cur
	
	func energy_get():
		return stats.energy_cur
	
	func str_get():
		return stats.str_cur
	
	func agi_get():
		return stats.agi_cur
	
	func maf_get():
		return stats.maf_cur
	
	func end_get():
		return stats.end_cur
	
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
			return name + ' ' + surname
		else:
			return nickname
	
	func name_short():
		if nickname == '':
			return name
		else:
			return nickname
	
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
	
	
	func skill_level(value):
		var text
		if value < 20:
			text = 'None'
		elif value < 40:
			text = 'Novice'
		elif value < 60:
			text = 'Apprentice'
		elif value < 80:
			text = 'Journeyman'
		elif value < 100:
			text = 'Expert'
		else:
			text = 'Master'
		return text
	
	func get_skill_short(input):
		var text
		var dict = {Novice = 'Nov',
		Apprentice = 'Apr',
		Journeyman = 'Jor',
		Expert = 'Exp',
		Master = 'Mast',
		}
		return dict[input]
	
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
	#repairing slaves
	var tempslaves = []
	tempslaves.append(player)
	for i in slaves:
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
	#repairing items
	if state.alchemy >= 2:
		itemdict.aphroditebrew.unlocked = true
	state.currentversion = gameversion


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

