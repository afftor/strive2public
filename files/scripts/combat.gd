
extends Node

var nocaptures = false
var area
var currentenemies
var playergroup = []
var enemygroup = []
var enemygear
var chosencharacter
var selectedcombatant
var selectmode = null
var cursortexture = Texture
var deads = []
var trapper = false
var trappername

class fighter:
	var name
	var person
	var health
	var healthmax
	var speed
	var speedbase
	var power
	var powerbase
	var magic
	var magicbase
	var energy
	var energymax
	var armor
	var armorbase
	var protection
	var abilities
	var activeabilities
	var cooldowns
	var state
	var effects
	var action
	var target
	var targetfull
	var lasttargetof
	var lasttarget
	var party
	var button
	var icon
	var passives = []
	var ai
	var aimemory = []
	
	func sendbuff():
		var effect = str2var(var2str(globals.abilities.effects[action.effect]))
		var buff = {duration = effect.duration, name = effect.name, code = effect.code, type = effect.type, stats = {}}
		for i in effect.stats:
			var temp = i[1].split(',')
			temp = Array(temp)
			for ii in range(0, temp.size()):
				if temp[ii].find('caster') >= 0:
					var temp2 = temp[ii].split('.')
					temp[ii] = self[temp2[1]]
				elif temp[ii].find('target') >= 0:
					var temp2 = temp[ii].split('.')
					temp[ii] = action.target[temp2[1]]
			var temp2 = ''
			for i in temp:
				temp2 += str(i)
			buff.stats[i[0]] = globals.evaluate(temp2)
		var temptarget
		if (action.target == 'enemy' && self.party == 'ally') || (self.party == 'enemy' && action.target in ['ally','self']):
			temptarget = globals.get_tree().get_current_scene().get_node('combat').enemygroup[target]
		else:
			temptarget = globals.get_tree().get_current_scene().get_node('combat').playergroup[target]
		temptarget.getbuff(buff)
	
	
	func getbuff(buff):
		var buffexists = false
		if effects.has(buff.code):
			buffexists = true
		if buffexists == true:
			effects[buff.code].duration = buff.duration
		else:
			effects[buff.code] = buff
			for i in buff.stats:
				self[i] = self[i] + buff.stats[i]
	
	func removebuff(buffcode):
		if effects.has(buffcode):
			if buffcode == 'stun':
				state = 'normal'
			for i in effects[buffcode].stats:
				self[i] = self[i] - effects[buffcode].stats[i]
			effects.erase(buffcode)




func start_battle(nosound = false):
	if get_parent().get_node("new slave button").is_visible() == false:
		get_node("autowin").set_hidden(true)
	var slave
	var combatant
	trapper = false
	get_node("autoattack").set_pressed(globals.rules.autoattack)
	get_tree().get_current_scene().get_node("outside").set_hidden(true)
	if nosound == false:
		get_tree().get_current_scene().music_set('combat')
	deads = []
	playergroup.clear()
	enemygroup.clear()
	selectedcombatant = null
	set_hidden(false)
	get_node("combatlog").set_bbcode('')
	var array = globals.state.playergroup
	slave = globals.player
	combatant = fighter.new()
	combatant.person = slave
	combatant.name = slave.name_short()
	combatant.health = slave.health
	combatant.healthmax = slave.stats.health_max
	combatant.speed = 10 + slave.sagi*3
	combatant.power = 3 + slave.sstr*2
	if slave.race == 'Seraph':
		combatant.speed += 4
	elif slave.race.find('Wolf') >= 0:
		combatant.power += 2 
	combatant.magic = slave.smaf
	combatant.energy = slave.stats.energy_cur
	combatant.energymax = slave.stats.energy_max
	combatant.armor = slave.stats.armor_cur
	combatant.protection = 0
	combatant.abilities = {}
	combatant.activeabilities = []
	combatant.cooldowns = {}
	combatant.state = 'normal'
	combatant.effects = {}
	combatant.action = null
	combatant.target = null
	combatant.party = 'ally'
	for i in slave.abilityactive:
		combatant.activeabilities.append(globals.abilities.abilitydict[i])
	for i in slave.ability:
		combatant.abilities[i] = globals.abilities.abilitydict[i]
	for i in slave.gear.values():
		if !i in ['clothcommon','underwearplain'] && i != null:
			var tempitem = globals.state.unstackables[i]
			for k in tempitem.effects:
				if k.type == 'incombat' && has_method(k.effect):
					call(k.effect, combatant, k.effectvalue)
	
	playergroup.append(combatant)
	for i in globals.state.playergroup: # Take combatants from player group
		slave = globals.state.findslave(i)
		if slave.spec == 'trapper':
			trapper = true
			trappername = slave.name_short()
		combatant = fighter.new()
		combatant.person = slave
		combatant.name = slave.dictionary('$name')
		combatant.health = slave.health
		combatant.healthmax = slave.stats.health_max
		combatant.speed = 6 + slave.sagi*3
		combatant.power = 3 + slave.sstr*2
		if slave.race == 'Seraph':
			combatant.speed += 4
		elif slave.race.find('Wolf') >= 0:
			combatant.power += 2 
		if slave.spec == 'assassin':
			combatant.speed += 5
		combatant.magic = slave.smaf
		combatant.energy = slave.stats.energy_cur
		combatant.energymax = slave.stats.energy_max
		combatant.armor = slave.stats.armor_cur
		combatant.protection = 0
		combatant.state = 'normal'
		combatant.abilities = {}
		combatant.activeabilities = []
		combatant.cooldowns = {}
		combatant.effects = {}
		combatant.action = null
		combatant.target = null
		combatant.party = 'ally'
		for i in slave.abilityactive:
			combatant.activeabilities.append(globals.abilities.abilitydict[i])
		for i in slave.ability:
			combatant.abilities[i] = globals.abilities.abilitydict[i]
		for i in slave.gear.values():
			if i != null:
				var tempitem = globals.state.unstackables[i]
				for k in tempitem.effects:
					if k.type == 'incombat':
						call(k.effect, combatant, k.effectvalue)
		playergroup.append(combatant)
	
	#build enemy group
	for i in currentenemies:
		combatant = fighter.new()
		if i.icon != null:
			combatant.icon = i.icon
		if nocaptures == false && i.capture != null:
			combatant.person = i.capture
			if i.capture.sex in ['female','futa'] && i.has('iconalt'):
				combatant.icon = i.iconalt
		else:
			combatant.person = null
		combatant.ai = 'attack'
		if combatant.person == null:
			combatant.name = i.name
			combatant.healthmax = i.stats.health
			combatant.speed = i.stats.speed
			combatant.power = i.stats.power
			combatant.magic = i.stats.magic
			combatant.energy = i.stats.energy
			combatant.energymax = i.stats.energy
			combatant.armor = i.stats.armor
			combatant.protection = 0
			combatant.state = 'normal'
			combatant.abilities = []
			combatant.cooldowns = {}
			combatant.effects = {}
			combatant.action = null
			combatant.target = null
			combatant.party = 'enemy'
			combatant.button = null
			if get_parent().get_node("explorationnode").deeperregion:
				combatant.power = ceil(combatant.power * 1.25)
				combatant.healthmax = ceil(combatant.healthmax * 1.5)
				combatant.speed = ceil(combatant.speed + 5)
			combatant.health = combatant.healthmax
			for ii in i.stats.abilities:
				combatant.abilities.append(globals.abilities.abilitydict[ii])
		else:
			slave = combatant.person
			if slave.spec == 'trapper':
				trapper = true
				trappername = slave.name_short()
			combatant = fighter.new()
			combatant.person = slave
			combatant.name = i.name
			combatant.health = slave.health
			combatant.healthmax = slave.stats.health_max
			combatant.speed = 6 + slave.sagi*3
			combatant.power = 3 + slave.sstr*2
			if slave.race == 'Seraph':
				combatant.speed += 4
			elif slave.race.find('Wolf') >= 0:
				combatant.power += 2 
			if slave.spec == 'assassin':
				combatant.speed += 5
			combatant.magic = slave.smaf
			combatant.energy = slave.stats.energy_cur
			combatant.energymax = slave.stats.energy_max
			combatant.armor = slave.stats.armor_cur
			combatant.protection = 0
			combatant.state = 'normal'
			combatant.abilities = []
			combatant.activeabilities = []
			combatant.cooldowns = {}
			combatant.effects = {}
			combatant.action = null
			combatant.target = null
			combatant.party = 'ally'
			for i in slave.abilityactive:
				combatant.activeabilities.append(globals.abilities.abilitydict[i])
			for i in slave.ability:
				combatant.abilities.append(globals.abilities.abilitydict[i])
			for i in slave.gear.values():
				if i != null:
					var tempitem = enemygear[i]
					for k in tempitem.effects:
						if k.type == 'incombat':
							call(k.effect, combatant, k.effectvalue)
		enemygroup.append(combatant)
	set_process(true)
	set_process_input(true)
	nocaptures = false
	updatepanels()
	
	if globals.state.tutorial.combat == false:
		get_tree().get_current_scene().get_node("tutorialnode").combat()
	

func damage(combatant, value):
	combatant.power += value

func armor(combatant, value):
	combatant.armor += value

func speed(combatant, value):
	combatant.speed += value

func passive(combatant, value):
	combatant.passives.append(value)

func protection(combatant, value):
	combatant.protection += value

func _process(delta):
	var button
	for i in playergroup:
		button = get_node("grouppanel/groupline").get_child(playergroup.find(i)+1)
		if i.action == null && i.state != 'chasing':
			i.target = null
			button.get_node('Panel').set_hidden(true)
		else:
			button.get_node('Panel').set_hidden(false)
		if i.target == null:
			button.get_node('target').set_text('Nothing')
			if i.state == 'chasing':
				button.get_node('target').set_text('Chasing')
		elif i.action.target == 'enemy':
			button.get_node('target').set_text(i.action.name + ' - ' + enemygroup[i.target].name)
		elif i.action.target == 'ally':
			button.get_node('target').set_text(i.action.name + ' - ' + playergroup[i.target].name)
		elif i.action.target == 'self':
			button.get_node('target').set_text(i.action.name)
	if selectedcombatant != null:
		get_node("grouppanel/groupline").get_child(playergroup.find(selectedcombatant)+1)
	else:
		for i in get_node("grouppanel/groupline").get_children():
			i.set_pressed(false)
	if get_node("warning").get_opacity() != 0:
		get_node("warning").set_opacity(get_node("warning").get_opacity()-delta/2.5) 
	if selectmode != null:
		get_node("confirm").set_disabled(true)
		Input.set_custom_mouse_cursor(load("res://files/buttons/kursor_act.png"))
		get_node("selectedskill").set_hidden(false)
		get_node("selectedskill").set_bbcode("[center]Select Target: "+ selectmode.capitalize() + "[/center]\n[center][color=yellow]Active ability: "+ selectedcombatant.action.name+  "[/color][/center]")
	else:
		get_node("selectedskill").set_hidden(true)
		if globals.state.customcursor != null:
			Input.set_custom_mouse_cursor(load(globals.state.customcursor))
		else:
			Input.set_custom_mouse_cursor(null)
		get_node("confirm").set_disabled(false)
	if selectedcombatant == null:
		get_node("abilitites").set_disabled(true)
		var counter = 0
		playergroup.invert()
		for i in playergroup:
			if i.target == null && i.state in ['normal']:
				choosecharacter(i)
			else:
				counter += 1
		if counter >= playergroup.size():
			deselecteverything()
		playergroup.invert()
	else:
		get_node("grouppanel/groupline").get_child(playergroup.find(selectedcombatant)+1).set_pressed(true)
		get_node("abilitites").set_disabled(false)
	#get_node("combatlog").set_bbcode(text)

func _input(event):
	if event.is_echo() == true || event.is_pressed() == false || get_node("abilitites/Panel").is_hidden() == false || is_hidden() == true:
		return
	if get_node("win").is_visible() == true && event.is_action_pressed("F") == true:
		_on_winconfirm_pressed()
		return
	elif get_node("win").is_visible() == true:
		return
	if event.type == 1:
		var dict = {49 : 1, 50 : 2, 51 : 3, 52 : 4,53 : 5,54 : 6,55 : 7,56 : 8,}
		if event.scancode in [KEY_1,KEY_2,KEY_3,KEY_4,KEY_5,KEY_6,KEY_7,KEY_8] && selectedcombatant != null:
			var key = dict[event.scancode]
			if event.is_action_pressed(str(key)) == true && get_node("grouppanel/skilline").get_children().size() >= key+1 && is_visible() == true && get_node("escapewarn").is_hidden() == true:
				activateskill(get_node("grouppanel/skilline").get_child(key).get_meta('skill'), selectedcombatant)
			elif event.is_action_pressed(str(key)) == true && get_node("escapewarn").is_visible() == true && get_node("escapewarn/escapeoption").get_item_count() >= key:
				get_node("escapewarn/escapeoption").select(key-1)
			elif get_node("escapewarn").is_visible() == true:
				return
	if event.is_action_pressed("RMB") == true && selectmode != null:
		selectmode = null
		selectedcombatant.action = null
		updatepanels()
		for i in get_node("grouppanel/skilline").get_children():
			i.set_pressed(false)
	if event.is_action_pressed("F") == true && selectmode == null && get_node("escapewarn").is_visible() != true:
		_on_confirm_pressed()
	elif event.is_action_pressed("F") == true && get_node("escapewarn").is_visible() == true:
		_on_escapeconfirm_pressed()
	if event.is_action_pressed('f1') == true  && get_node("grouppanel/groupline").get_children().size() > 1:
		choosecharacter(get_node("grouppanel/groupline").get_child(1).get_meta('char'))
		get_node("grouppanel/groupline").get_child(1).set_pressed(true)
	elif event.is_action_pressed('f2') == true && get_node("grouppanel/groupline").get_children().size() > 2:
		choosecharacter(get_node("grouppanel/groupline").get_child(2).get_meta('char'))
		get_node("grouppanel/groupline").get_child(2).set_pressed(true)
	elif event.is_action_pressed('f3') == true && get_node("grouppanel/groupline").get_children().size() > 3:
		choosecharacter(get_node("grouppanel/groupline").get_child(3).get_meta('char'))
		get_node("grouppanel/groupline").get_child(3).set_pressed(true)
	elif event.is_action_pressed('f4') == true && get_node("grouppanel/groupline").get_children().size() > 4:
		choosecharacter(get_node("grouppanel/groupline").get_child(4).get_meta('char'))
		get_node("grouppanel/groupline").get_child(4).set_pressed(true)

func updatepanels():
	var newbutton
	clearpanels()
	for combatant in playergroup:
		var slave = combatant.person
		var temp = ''
		newbutton = get_node("grouppanel/groupline/character").duplicate()
		if slave.imageportait != null:
			newbutton.get_node("portait").set_texture(load(slave.imageportait))
		newbutton.set_hidden(false)
		get_node("grouppanel/groupline").add_child(newbutton)
		newbutton.get_node("name").set_text(combatant.name)
		if (combatant.health/combatant.healthmax) < 0.35:
			newbutton.get_node("hp").set('custom_colors/font_color', Color(1,0.29,0.29,1))
		newbutton.get_node("hp").set_text('HP: ' + str(ceil(combatant.health)) +'/'+ str(ceil(combatant.healthmax)))
		newbutton.get_node("energy").set_text('E:'+str(floor(combatant.energy)) +'/'+ str(floor(combatant.energymax)))
		newbutton.get_node("power").set_text('P:'+str(round(combatant.power)))
		newbutton.get_node("speed").set_text('S:'+str(round(combatant.speed)))
		newbutton.set_meta("char", combatant)
		newbutton.connect("mouse_enter", self, 'bufftooltip', [combatant])
		newbutton.connect("mouse_exit", self, 'bufftooltiphide')
		newbutton.connect("pressed",self,'choosecharacter',[combatant])
	for combatant in enemygroup:
		if combatant.state in ['normal']:
			var slave = combatant.person
			newbutton = get_node("enemypanel/enemyline/character").duplicate()
			if combatant.icon != null:
				newbutton.get_node("icon").set_texture(combatant.icon)
			newbutton.set_hidden(false)
			get_node("enemypanel/enemyline").add_child(newbutton)
			newbutton.set_meta("char", combatant)
			newbutton.get_node("name").set_text(combatant.name)
			newbutton.get_node("hpbar").set_val((combatant.health/combatant.healthmax)*100)
			newbutton.get_node("hpbar/hp").set_text(str(ceil(combatant.health)) +'/'+ str(ceil(combatant.healthmax)))
			if playergroup[0].effects.has('mindreadeffect') == false:
				newbutton.get_node("hpbar/hp").set_hidden(true)
			newbutton.connect("pressed",self,'chooseenemy',[combatant])
			newbutton.connect("mouse_enter", self, 'enemytooltip', [combatant])
			newbutton.connect("mouse_exit", self, 'enemytooltiphide')
			combatant.button = newbutton

func bufftooltip(combatant):
	var text = ''
	var label = ''
	get_node("bufftooltip").set_hidden(false)
	for i in get_node("bufftooltip/VBoxContainer").get_children():
		if i != get_node("bufftooltip/VBoxContainer/tooltipbase"):
			i.set_hidden(true)
			i.queue_free()
	for i in combatant.effects.values():
		text = ''
		label = get_node("bufftooltip/VBoxContainer/tooltipbase").duplicate()
		label.set_hidden(false)
		get_node("bufftooltip/VBoxContainer").add_child(label)
		text += i.name +' - duration: ' + str(i.duration)+ ' turns, ' + str(i.stats).replace('(','').replace(')','')
		label.set_bbcode(text)
	get_node("bufftooltip/VBoxContainer").set_size(get_node("bufftooltip/VBoxContainer").get_minimum_size())
	get_node("bufftooltip").set_size(get_node("bufftooltip/VBoxContainer").get_size())
	var pos = get_node("grouppanel/groupline").get_child(playergroup.find(combatant)+1).get_global_pos()
	pos.y -= 25
	get_node("bufftooltip").set_global_pos(pos)

func bufftooltiphide():
	get_node("bufftooltip").set_hidden(true)

func clearpanels():
	for i in get_node("enemypanel/enemyline").get_children():
		if i != get_node("enemypanel/enemyline/character"):
			i.set_hidden(true)
			i.queue_free()
	for i in get_node("grouppanel/groupline").get_children():
		if i != get_node("grouppanel/groupline/character"):
			i.set_hidden(true)
			i.queue_free()

func choosecharacter(combatant):
	var newbutton
	if combatant.state == 'chasing' || (combatant.state == 'stunned' && selectmode == null):
		get_node("warning").set_text(combatant.name + " can't act this turn: " + combatant.state.capitalize() + '. ')
		get_node("warning").set_opacity(1)
		get_node("grouppanel/groupline").get_child(playergroup.find(combatant)+1).set_pressed(false)
		return
	if selectmode == null:
		selectedcombatant = combatant
		for i in get_node("grouppanel/groupline/").get_children():
			if i.has_meta('char'):
				if i.get_meta('char') == combatant:
					i.set_pressed(true)
				else:
					i.set_pressed(false)
		for i in get_node("grouppanel/skilline").get_children():
			if i != get_node("grouppanel/skilline/skill"):
				i.set_hidden(true)
				i.free()
		for i in combatant.activeabilities:
			newbutton = get_node("grouppanel/skilline/skill").duplicate()
			get_node("grouppanel/skilline").add_child(newbutton)
			newbutton.set_disabled(combatant.cooldowns.has(i.code))
#			if combatant.cooldowns.has(i.code):
#				newbutton.set_disabled(true)
#			else:
#				newbutton.get_node("Panel").set_hidden(true)
			newbutton.set_hidden(false)
			newbutton.get_node("Label").set_text(i.name)
			
			newbutton.get_node("number").set_text(str(get_node("grouppanel/skilline").get_children().size()-1))
			newbutton.set_meta("skill", i)
			newbutton.connect("mouse_enter",self,'showskilltooltip',[i])
			newbutton.connect("mouse_exit",self,'hideskilltooltip')
			if i.has('iconnorm'):
				newbutton.set_normal_texture(i.iconnorm)
				newbutton.set_pressed_texture(i.iconpressed)
				newbutton.set_disabled_texture(i.icondisabled)
			newbutton.connect("pressed",self,'activateskill',[i,combatant])
			if combatant.action != null:
				if combatant.action.name == i.name:
					newbutton.set_pressed(true)
			if newbutton.is_disabled():
				newbutton.get_node("Label").set('custom_colors/font_color', Color(1,0,0,1))
			elif newbutton.is_pressed():
				newbutton.get_node("Label").set('custom_colors/font_color', Color(0,1,1,1))
			newbutton.set_meta('skill', i)
	elif selectmode == 'ally':
		for i in get_node("grouppanel/groupline/").get_children():
			if i.has_meta('char'):
				if i.get_meta('char') == selectedcombatant:
					i.set_pressed(true)
				else:
					i.set_pressed(false)
		selectmode = null
		selectedcombatant.target = playergroup.find(combatant)
		selectedcombatant = null

	elif selectmode == 'enemy':
		get_node("warning").set_text("Can't target ally")
		get_node("warning").set_opacity(1)
		get_node("grouppanel/groupline").get_child(playergroup.find(combatant)+1).set_pressed(false)

func activateskill(skill, combatant):
	if skill.code == 'escape' && area.tags.find("noreturn") >= 0:
		get_node("warning").set_text("Can't escape in this location")
		get_node("warning").set_opacity(1)
		return
	if selectmode != null:
		selectmode = null
	combatant.target = null
	get_node("tooltippanel").set_hidden(true)
	if combatant.energy < skill.costenergy:
		get_node("warning").set_text("Not enough energy")
		get_node("warning").set_opacity(1)
		deselecteverything()
		return
	if globals.resources.mana < skill.costmana:
		get_node("warning").set_text("Not enough mana")
		get_node("warning").set_opacity(1)
		deselecteverything()
		return
	if combatant.cooldowns.has(skill.code):
		get_node("warning").set_text("Skill is on cooldown")
		get_node("warning").set_opacity(1)
		deselecteverything()
		return
	combatant.action = skill
	#get_node("grouppanel/groupline").get_child(playergroup.find(combatant)+1).get_node('target').set_text(combatant.action.name)
	#get_node("grouppanel/groupline").get_child(playergroup.find(combatant)+1).get_node('Panel').set_hidden(true)
	for i in get_node("grouppanel/skilline").get_children():
			if i.has_meta('skill'):
				if i.get_meta('skill') != skill:
					i.set_pressed(false)
				else:
					i.set_pressed(true)
	if skill.target == 'enemy':
		selectedcombatant = combatant
		selectmode = 'enemy'
		var counter = 0
		var tempenemy
		for i in enemygroup:
			if i.state in ['escaped','captured','defeated']:
				counter+= 1
			else:
				tempenemy = i
		if enemygroup.size() - counter <= 1:
			selectmode = 'enemy'
			chooseenemy(tempenemy)
	elif skill.target == 'self':
		selectmode = null
		combatant.target = playergroup.find(combatant)
		selectedcombatant = null
	elif skill.target == 'ally':
		selectedcombatant = combatant
		selectmode = 'ally'


func chooseenemy(enemy):
	if selectmode == 'enemy':
		selectmode = null
		selectedcombatant.target = enemygroup.find(enemy)
		selectedcombatant = null
	elif selectmode == 'ally':
		get_node("warning").set_text("Can't target enemy")
		get_node("warning").set_opacity(1)

func actionexecute(actor, target, skill):
	var text = ''
	var damage
	var group
	var hit = 'hit'
	var targetparty 
	var targethealthinit = target.health
	if skill.cooldown > 0:
		actor.cooldowns[skill.code] = skill.cooldown
	if playergroup.find(actor) >= 0:
		text = actor.person.dictionary(skill.usetext) 
		group = 'player'
		globals.resources.mana -= skill.costmana
	else:
		group = 'enemy'
		text = skill.usetext 
	if skill.target == 'enemy':
		if group == 'enemy':#Checking for blockers
			targetparty = playergroup
			for i in playergroup:
				if i.target == playergroup.find(target) && i.action.code == 'protect' && i != target:
					text = '$name tries to attack ' + target.name + ', but ' + i.name + ' moves in and takes the hit. '
					if target.action.code == 'protect':
						target.target = playergroup.find(target)
					text += actionexecute(actor, i, skill)
					return text
		else:
			targetparty = enemygroup
			for i in enemygroup:
				if i.target == enemygroup.find(target) && i.action.code == 'protect':
					text = '$name tries to attack ' + target.name + ', but ' + i.name + ' moves in and takes the hit. '
					if target.action.code == 'protect':
						target.target = enemygroup.find(target)
					text += actionexecute(actor, i, skill)
					return text
		#checking hit chance
		if skill.attributes.find('damage') >= 0:
			if skill.can_miss == true && target.action != null && target.action.code != 'protect':
				hit = hitchance(actor, target)
			else:
				hit = 'hit'
			
			if skill.type == 'physical':
				if skill.attributes.find('physpen') < 0:
					damage = float((actor.power * 2.5)*skill.power) * float(float(100-target.protection)/100) - target.armor
				else:
					damage = ((actor.power * 2.5)*skill.power)
				if target.action.code == 'protect':
					if target.person.spec == 'bodyguard':
						damage = damage - damage*0.7
					else:
						damage = damage - damage*0.35
			elif skill.type == 'spell':
				damage = (actor.magic * 2.5) * skill.power
				if skill.code == 'mindblast':
					damage += target.healthmax/5
			if target.person != null and target.person.traits.has("Sturdy"):
				damage = damage*0.85
			actor.energy = max(actor.energy - skill.costenergy,0)
			if actor.person != null && actor.person.spec == 'assassin':
				damage += 5
			if hit == 'precise':
				damage = damage*1.3
				text = text + "$name's swift attack lands precisely at desirable spot. " 
			if damage < 0: damage = 0
			if actor.energy <= 0: damage = damage*0.66
			if hit != 'miss' && hit != 'glance':
				var power = powercompare(actor.power, target.power)
				if power == 'overpower':
					target.health -= damage*1.3
					text = text + "$name's  force overpowers " + target.name + ' and deals great damage.(' + str(round(damage*1.3)) + ")" 
				elif power == 'normal' || hit == 'precise':
					target.health -= damage
					text = text + "$name damages " + target.name + '.(' + str(round(damage)) + ")" 
				else:
					target.health -= damage/1.75
					text = text + "$name's attack struggles to ovecome " + target.name + "'s defence and falls in efficiency.(" + str(round(damage/1.75)) + ")" 
			elif hit == 'glance':
				target.health -= damage/2
				text = text + "$name's attack lacks in speed and only partly damages " + target.name + ".(" + str(round(damage/2)) + ")" 
			elif hit == 'miss':
				text = text + "$name's attack misses " + target.name + '. '
			if target.action.code != 'protect':
				target.energy -= (targethealthinit - target.health)/5
			else:
				target.energy -= (targethealthinit - target.health)/2.5
			if skill.attributes.find('allparty') >= 0:
				text += "\nStrong attack affects everyone in opposing party."
				for i in targetparty:
					if i != target:
						i.health -= damage
			if target.energy < 0:
				target.energy = 0
			if skill.attributes.find('lifesteal') >= 0:
				actor.health = min(actor.health + (targethealthinit - target.health)/4,actor.healthmax)
				text += actor.name + ' recovered some health back.' 
	elif skill.target == 'self':
		if skill.code == 'escape' && globals.get_tree().get_current_scene().get_node("explorationnode").launchonwin == null:
			actor.state = 'stopfight'
			actor.energy = max(actor.energy - skill.costenergy,0)
		elif skill.code == 'escape' && globals.get_tree().get_current_scene().get_node("explorationnode").launchonwin != null:
			globals.get_tree().get_current_scene().popup("You can't escape from this fight")
	elif skill.target == 'ally':
		if group == 'enemy':#Checking for blockers
			targetparty = enemygroup
		else:
			targetparty = playergroup
	if skill.effect != null && (skill.type == 'spell' || hit in ['precise','hit'] || skill.target in ['ally','self']):
		actor.sendbuff()
	if skill.code == 'heal':
		globals.abilities.restorehealth(actor,target)
	elif skill.code == "masshealcouncil":
		for i in targetparty:
				if i != actor:
					globals.abilities.restorehealth(actor,i)
	target.health = ceil(target.health)
	if target.health < 0:
		target.health = 0
		if actor.person != null && actor.person != globals.player:
			actor.person.stress -= rand_range(5,10)
			text += "\n$name has defeated " + target.name + ". "
	text = combatantdictionary(actor, text)
	return text







func deselecteverything():
	for i in get_node("grouppanel/skilline").get_children():
		if i != get_node("grouppanel/skilline/skill"):
			i.set_hidden(true)
			i.queue_free()
	for i in get_node("grouppanel/groupline").get_children():
		i.set_pressed(false)
	selectedcombatant = null

func combatantdictionary(combatant, text):
	if playergroup.find(combatant) >= 0:
		if playergroup.find(combatant) == 0:
			text = text.replace('$name', 'You')
			text = text.replace(' goes ', ' go ')
			text = text.replace(' does ', ' do ')
			text = text.replace("'s ", "r ")
		else:
			text = text.replace('$name', combatant.name)
		if combatant.action.target == 'enemy':
			text = text.replace("$targetname", enemygroup[combatant.target].name)
		elif combatant == playergroup[combatant.target]:
			text = text.replace("$targetname", 'self')
		else:
			text = text.replace("$targetname", playergroup[combatant.target].name)
	else:
		text = text.replace('$name', combatant.name)
		if combatant.action.target == 'enemy':
			text = text.replace("$targetname", playergroup[combatant.target].name)
		elif combatant == enemygroup[combatant.target]:
			text = text.replace("$targetname", 'self')
		else:
			text = text.replace("$targetname", enemygroup[combatant.target].name)
	return text

func hitchance(attacker, target):
	var hit = ''
	var attackspeed = attacker.speed
	var targetspeed = target.speed
	if attacker.person != null && attacker.person.traits.has("Nimble"):
		attackspeed *= 1.25
	if attacker.action.has('accuracy'):
		attackspeed = attackspeed*attacker.action.accuracy
	if playergroup.find(target) >= 0:
		if target.person.race.findn("cat") >= 0:
			targetspeed += 4
	var hitchance = attackspeed - targetspeed
	if hitchance > 10 && rand_range(0,100) < (hitchance-5) * 5:
		hit = 'precise'
	elif hitchance >= -5 && rand_range(0,100) < (hitchance+8) * 9:
		hit = 'hit'
	elif (hitchance >= -10 && rand_range(0,100) > 75):
		hit = 'glance'
	else:
		if rand_range(0,100) <= 5:
			hit = 'glance'
		else:
			hit = 'miss'
	return hit

func powercompare(attackpower, targetpower):
	var power = ''
	if attackpower >= targetpower*2:
		power = 'overpower'
	elif attackpower >= targetpower*0.7:
		power = 'normal'
	else:
		power = 'halved'
	return power

func showskilltooltip(skill):
	var text = ''
	text += '[center]' + skill.name + '[/center]\n\n' + skill.description +'\nBasic cooldown: ' + str(skill.cooldown)
	if selectedcombatant.cooldowns.has(skill.code):
		text += '\n\nTurns until use: ' + str(selectedcombatant.cooldowns[skill.code])
	get_node("tooltippanel").set_hidden(false)
	get_node("tooltippanel/tooltiptext").set_bbcode(text)
	var pos = get_global_mouse_pos()
	pos.y -= find_node('tooltippanel').get_rect().size.height*1.3
	get_node("tooltippanel").set_pos(pos)

func hideskilltooltip():
	get_node("tooltippanel").set_hidden(true)

func enemytooltip(enemy):
	var text = ''
	text += '[center]' + enemy.name + '[/center]\n'
	if enemy.person != null:
		text += enemy.person.race + ' ' + enemy.person.age + ' ' + enemy.person.sex + '.\n'
	if playergroup[0].effects.has('mindreadeffect'):
		text += "Power: " + str(enemy.power) + " Speed: " + str(enemy.speed) + " Protection: " + str(enemy.protection) + " Armor: " + str(enemy.armor)
		if enemy.person != null:
			text += "\nOrigins: " + enemy.person.origins
#	if enemy.person != null:
#		text += enemygear[enemy.person.gear.armor].name + "\n" + enemygear[enemy.person.gear.weapon].name
	get_node("tooltippanel/tooltiptext").set_bbcode(text)
	get_node("tooltippanel").set_hidden(false)
	var pos = get_global_mouse_pos()
	get_node("tooltippanel").set_global_pos(pos)

func enemytooltiphide():
	get_node("tooltippanel").set_hidden(true)

func _on_confirm_pressed():
	if selectmode != null:
		get_node("warning").set_text("Select target first.")
		get_node("warning").set_opacity(1)
		return
	var text = ''
	for combatant in playergroup:
		if combatant.action == null && combatant.state in ['normal']:
			if globals.rules.autoattack == false:
				combatant.action = globals.abilities.abilitydict['pass']
				combatant.target = playergroup.find(combatant)
			else:
				combatant.action = globals.abilities.abilitydict.attack
				for i in enemygroup:
					if i.state == 'normal':
						combatant.target = enemygroup.find(i)
						continue
		elif combatant.state == 'chasing':
			combatant.action = globals.abilities.abilitydict['pass']
			combatant.target = playergroup.find(combatant)
	for combatant in enemygroup:
		combatant.action = null
		for i in combatant.cooldowns:
			combatant.cooldowns[i] -= 1
			if combatant.cooldowns[i] <= 0:
				combatant.cooldowns.erase(i)
		var abilitydict = []
		for i in combatant.abilities:
			if combatant.ai == 'attack':
				if combatant.aimemory != 'attack':
					abilitydict = combatant.abilities[0]
					combatant.aimemory = 'attack'
					break
				if combatant.cooldowns.has(i.code):
					continue
				if i.aipatterns.has('attack'):
					abilitydict.append({value = i, weight = i.aipriority})
			
		if typeof(abilitydict) == TYPE_ARRAY:
			abilitydict = globals.weightedrandom(abilitydict)
		combatant.action = abilitydict
		if combatant.action == null:
			combatant.action = combatant.abilities[0]
		if combatant.action.target == 'enemy':
			combatant.target = floor(rand_range(0,playergroup.size())-1)
		elif combatant.action.target == 'ally':
			combatant.target = floor(rand_range(0,enemygroup.size())-1)
		if combatant.action.target == 'enemy' && combatant.state in ['normal']:
			text += actionexecute(combatant, playergroup[combatant.target], combatant.action) + '\n'
		elif combatant.action.target == 'ally' && combatant.state in ['normal']:
			text += actionexecute(combatant, enemygroup[combatant.target], combatant.action) + '\n'
	for combatant in playergroup:
		if combatant.action.target == 'enemy':
			text += actionexecute(combatant, enemygroup[combatant.target], combatant.action) + '\n'
		elif combatant.action.target == 'self':
			text += actionexecute(combatant, combatant, combatant.action) + '\n'
		elif combatant.action.target == 'ally' && combatant.action.code != 'protect':
			text += actionexecute(combatant, playergroup[combatant.target], combatant.action) + '\n'
		if combatant.passives.has('doubleattack') && randf() < 0.5 && combatant.action.code == 'attack':
			text += "[color=aqua][Double Attack][/color]" + actionexecute(combatant, enemygroup[combatant.target], combatant.action) + '\n'
		for i in combatant.cooldowns:
			combatant.cooldowns[i] -= 1
			if combatant.cooldowns[i] <= 0:
				combatant.cooldowns.erase(i)
		if combatant.state == 'chasing':
			combatant.state = 'normal'
	get_node("combatlog").set_bbcode(text)
	resolution()

func resolution(text = ''):
	var counter = 0
	for i in playergroup:
		i.person.stress += 3
		for effect in i.effects.values():
			if effect.duration <= 0:
				i.removebuff(effect.code)
			else:
				effect.duration -= 1
	for i in enemygroup:
		if i.state in ['normal']:
			counter += 1
	for i in enemygroup:
		if i.health <= 0 && i.state in ['normal']:
			i.state = 'defeated'
			text += '\n[color=yellow]'+ i.name + ' has been defeated. [/color]'
			if i.person != null:
				var escapechance = (globals.originsarray.find(i.person.origins)+1)*15
				if rand_range(0,100) < escapechance:
					if counter > 1 && i.effects.has('shackleeffect'):
						i.state = 'captured'
						text += '\n[color=yellow]'+ i.name + ' has been defeated and subdued unable to escape. [/color]'
					elif trapper == true && rand_range(0,100) <= 50:
						i.state = 'captured'
						text += '\n[color=yellow]'+ i.name + ' has attempted to escape, but walked right into ' + trappername + "'s trap and was quickly subdued by your group. [/color]"
					elif counter == 1:
						i.state = 'captured'
						text += '\n[color=yellow]'+ i.name + ' has been defeated and surrounded by your group. [/color]'
					elif counter > 1 && !i.effects.has('shackleeffect'):
						capturesequence(i)
						return
				else:
					i.state = 'captured'
					text +=  '\n[color=yellow]'+ i.name + ' has been defeated and knocked out by your group. [/color]'
	for i in playergroup:
		if i.health <= 0:
			text += '\n[color=#ff4949]'+ i.name + ' has fallen. [/color]'
			playergroup.remove(playergroup.find(i))
			if i.person == globals.player:
				get_tree().get_current_scene().get_node("gameover").set_hidden(false)
				get_tree().get_current_scene().get_node("gameover/Panel/text").set_bbcode("[center]You have died. \nGame over.[/center]")
				return
			else:
				var slave = i.person
				if globals.rules.permadeath == false:
					slave.stats.health_cur = 10
					slave.away.duration = 3
					slave.away.at = 'rest'
					slave.work = 'rest'
					globals.state.playergroup.erase(i.person.id)
				else:
					globals.state.playergroup.erase(i.person.id)
					for i in globals.state.playergroup:
						globals.state.findslave(i).stress += rand_range(15,25)
					globals.slaves.erase(slave)
		elif i.effects.has("stun"):
			i.state = 'stunned'
		else:
			i.action = null
			i.target = null
	counter = 0
	for i in enemygroup:
		if i.state in ['escaped','defeated','captured']:
			counter += 1
	if counter >= enemygroup.size():
		get_node("win").set_hidden(false)
	elif playergroup[0].state == 'stopfight':
		clearpanels()
		set_hidden(true)
		set_process(false)
		for i in playergroup:
			i.person.stats.energy_cur = i.energy
			i.person.stats.health_cur = i.health
		get_tree().get_current_scene().get_node("explorationnode").enemyleave()
		get_tree().get_current_scene().popup('You hastly escape from the fight. ')
		get_tree().get_current_scene().get_node("outside").set_hidden(false)
		return
	else:
		for i in enemygroup:
			i.action = null
			i.target = null
	if selectedcombatant != null:
		choosecharacter(selectedcombatant)
	get_node("combatlog").set_bbcode(get_node("combatlog").get_bbcode() + text)
	updatepanels()
	deselecteverything()

func capturesequence(enemy):
	enemy.button.get_node('name').set_text(enemy.button.get_node('name').get_text() + ' - Escaping!')
	get_node("escapewarn").set_hidden(false)
	get_node("escapewarn/escapedescript").set_bbcode(combatantdictionary(enemy, "$name tries to escape. Send someone to stop them? (cost 30 energy and will be unable to attack for 1 turn)"))
	get_node("escapewarn/escapeoption").clear()
	get_node("escapewarn/escapeoption").set_meta('slave',enemy)
	get_node("escapewarn/escapeoption").add_item("Let them escape")
	var counter = 1
	for i in playergroup:
		if i.person != globals.player:
			get_node("escapewarn/escapeoption").add_item(i.name)
			get_node("escapewarn/escapeoption").set_item_disabled(counter, true)
			if i.state in ['normal'] && i.energy >= 30 && i.person != globals.player:
				get_node("escapewarn/escapeoption").set_item_disabled(counter, false)
			counter += 1

func victory():
	var deads = []
	get_node("win").set_hidden(true)
	for i in range(0, enemygroup.size()):
		if enemygroup[i].state == 'escaped':
			currentenemies[i].state = 'escaped'
		else:
			currentenemies[i].state = 'defeated'
			#deads.append(i)
#	deads.invert()
#	for i in deads:
#		currentenemies.remove(i)
	get_tree().get_current_scene().get_node("explorationnode").enemygroup.units = currentenemies
	clearpanels()
	set_hidden(true)
	get_tree().get_current_scene().get_node("outside").set_hidden(false)
	get_tree().get_current_scene().get_node("explorationnode").enemydefeated()




func _on_escapeconfirm_pressed():
	var text = ''
	var captured = false
	var basechance 
	var ID = get_node("escapewarn/escapeoption").get_selected()
	var slave = get_node("escapewarn/escapeoption").get_meta('slave')
	if ID == 0:
		slave.state = 'escaped'
		text = slave.name + ' has ran away in unknown direction. '
	else:
		var chaseslave = playergroup[ID]
		chaseslave.state = 'chasing'
		basechance = chaseslave.speed
		chaseslave.action = {code = 'chasing'}
		chaseslave.energy -= 30
		if chaseslave.person.spec == 'trapper':
			basechance += 5
		if basechance > slave.speed * 2:
			captured = true
			text = '[color=aqua]'+chaseslave.name + ' swiftly caught helpless ' + slave.name + '. [/color] '
		elif (basechance - slave.speed) + rand_range(0, 10) > 8:
			captured = true
			text = '[color=aqua]'+slave.name + ' has been caught and subdued by ' + chaseslave.name + '. [/color]'
		else:
			captured = false
			text = '[color=red]'+chaseslave.name + ' failed to catch escaping ' + slave.name + '. [/color]'
		if captured == true:
			chaseslave.person.metrics.capture += 1
			slave.state = 'captured'
		else:
			slave.state = 'escaped'
	get_node("escapewarn").set_hidden(true)
	resolution(text)


func _on_winconfirm_pressed():
	set_process(false)
	get_node("win").set_hidden(true)
	for i in playergroup:
		i.person.metrics.win += 1
		i.person.stats.energy_cur = i.energy
		i.person.stats.health_cur = i.health
	victory()


func _on_abilitites_pressed():
	get_node("abilitites/Panel").set_hidden(false)
	get_node("abilitites/Panel/use").set_disabled(true)
	get_node("abilitites/Panel/abilitydescript").set_bbcode('')
	var newbutton
	for i in get_node("abilitites/Panel/inactivecontainer/VBoxContainer").get_children():
		if i != get_node("abilitites/Panel/inactivecontainer/VBoxContainer/Button"):
			i.set_hidden(true)
			i.queue_free()
	for i in selectedcombatant.abilities.values():
		newbutton = get_node("abilitites/Panel/inactivecontainer/VBoxContainer/Button").duplicate()
		get_node("abilitites/Panel/inactivecontainer/VBoxContainer").add_child(newbutton)
		newbutton.set_hidden(false)
		newbutton.set_text(i.name)
		newbutton.set_meta('ability', i)
		if selectedcombatant.activeabilities.has(i) == true:
			newbutton.get_node("CheckBox").set_pressed(true)
		else:
			newbutton.get_node("CheckBox").set_pressed(false)
		newbutton.connect("pressed", self, "selectabilityfromlist" ,[i])
		newbutton.get_node("CheckBox").connect("pressed", self, "toggleabilityfromlist", [i, newbutton.get_node("CheckBox")])

func selectabilityfromlist(ability):
	var text = "[center]" + ability.name + "[/center]\n" + ability.description +  '\nTarget: ' + ability.target +  '\nCooldown - ' + str(ability.cooldown)
	get_node("abilitites/Panel/abilitydescript").set_bbcode(text)
	for i in get_node("abilitites/Panel/inactivecontainer/VBoxContainer").get_children():
		if i.has_meta('ability'):
			if i.get_meta('ability') == ability:
				i.set_pressed(true)
			else:
				i.set_pressed(false)
	var tempabil = selectedcombatant.abilities[ability.code]
	get_node("abilitites/Panel/abilitydescript").set_meta('ability', tempabil)
	if selectedcombatant.energy < tempabil.costenergy || selectedcombatant.cooldowns.has(tempabil.code) || globals.resources.mana < tempabil.costmana :
		get_node("abilitites/Panel/use").set_disabled(true)
	else:
		get_node("abilitites/Panel/use").set_disabled(false)





func toggleabilityfromlist(ability, checkbox):
	if checkbox.is_pressed() == true && selectedcombatant.activeabilities.has(ability) == false:
		selectedcombatant.activeabilities.append(ability)
		selectedcombatant.person.abilityactive.append(ability.code)
	else:
		selectedcombatant.activeabilities.remove(selectedcombatant.activeabilities.find(ability))
		selectedcombatant.person.abilityactive.erase(ability.code)
	_on_abilitites_pressed()


func _on_close_pressed():
	get_node("abilitites/Panel").set_hidden(true)
	deselecteverything()
	updatepanels()


func _on_use_pressed():
	var skill = get_node("abilitites/Panel/abilitydescript").get_meta('ability')
	get_node("abilitites/Panel").set_hidden(true)
	activateskill(skill, selectedcombatant)
	
	
	



func _on_autowin_pressed():
	selectmode = null
	set_process(false)
	victory()


func _on_autoattack_pressed():
	globals.rules.autoattack = get_node("autoattack").is_pressed()
