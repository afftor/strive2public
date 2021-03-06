extends Node

var slave
onready var sstr = get_node("sstr/Label")
onready var sagi = get_node("sagi/Label")
onready var smaf = get_node("smaf/Label")
onready var send = get_node("send/Label")
onready var cour = get_node("cour/cur")
onready var conf = get_node("conf/cur")
onready var wit = get_node("wit/cur")
onready var charm = get_node("charm/cur")
var mode = 'slavebase'

func _ready():
	for i in ['send','smaf','sstr','sagi']:
		get_node(i+'/Button').connect("pressed", self, 'statup', [i])
#	for i in globals.statsdict:
#		self[i].get_parent().get_node("Control").connect("mouse_enter", self, 'showtooltip', [i])
#		self[i].get_parent().get_node("Control").connect("mouse_exit", globals, 'hidetooltip')

func showtooltip(value):
	var text = globals.statsdescript[value]
	globals.showtooltip(text)

func statup(stat):
	slave[stat] += 1
	slave.skillpoints -= 1
	show()

func show():
	var text = ''
	var mentals = [cour, conf, wit, charm]
	for i in globals.statsdict:
		text = ''
		if i in ['sstr','sagi','smaf','send']:
			if slave.stats[globals.maxstatdict[i].replace("_max",'_mod')] >= 1:
				text = "[color=green]"
			elif slave.stats[globals.maxstatdict[i].replace("_max",'_mod')] < 0:
				text = "[color=red]"
		text += str(slave[i]) 
		if mode in ['full','slaveadv']:
			if text.find('color') >= 0:
				text += "[/color]"
			text += "/" +str(min(slave.stats[globals.maxstatdict[i]], slave.originvalue[slave.origins]))
		#self[i].set_bbcode(text)
	for i in mentals:
		if mode == 'slavebase' || slave == globals.player:
			i.get_parent().set_hidden(true)
		else:
			i.get_parent().set_hidden(false)
	if !slave.traits.empty():
		text = "$name has trait(s): "
		var text2 = ''
		for i in slave.get_traits():
			text2 += '[url=' + i.name + ']' + i.name + "[/url]"
			if i.tags.find('sexual') >= 0:
				text2 = "[color=#ff5ace]" + text2 + '[/color]'
			elif i.tags.find('detrimental') >= 0:
				text2 = "[color=#ff4949]" + text2 + '[/color]'
			text2 += ', '
			text += text2
		text = text.substr(0, text.length() - 2) + '.'
	get_node("traittext").set_bbcode(slave.dictionary(text))
	if mode == 'full':
		text = "[url=race][color=aqua]"+ slave.race + "[/color][/url]\nHealth : " + str(round(slave.health)) + '/' + str(round(slave.stats.health_max)) + '\nEnergy : ' + str(round(slave.energy)) + '/' + str(round(slave.stats.energy_max)) + '\nLevel : '+str(slave.level) + '\nAttribute Points : '+str(slave.skillpoints)
		if slave == globals.player:
			text = slave.dictionary('$name $surname\nRace: ') + slave.dictionary(' $race\n').capitalize() + text
	else:
		text =  'Level : '+str(slave.level) + '\nAvailable Attribute Points : '+str(slave.skillpoints)
	get_node("leveltext").set_bbcode(slave.dictionary(text))
	get_node("levelprogress/Label").set_text("Experience: " + str(slave.xp) + '%')
	get_node("levelprogress").set_val(slave.xp)
	for i in ['send','smaf','sstr','sagi']:
		if slave.skillpoints >= 1 && (globals.slaves.find(slave) >= 0||globals.player == slave) && slave.stats[globals.maxstatdict[i].replace('_max','_cur')] < slave.stats[globals.maxstatdict[i]]:
			get_node(i+'/Button').set_hidden(false)
		else:
			get_node(i+'/Button').set_hidden(true)
	if slave.levelupreqs.empty() && slave.xp < 100:
		get_node("levelreqs").set_bbcode("")
	elif slave.xp >= 100 && slave.levelupreqs.empty():
		get_node("levelreqs").set_bbcode(slave.dictionary("You don't know what might unlock $name's potential further, yet. "))
	else:
		get_node("levelreqs").set_bbcode(slave.levelupreqs.descript)




func _on_traittext_meta_clicked( meta ):
	var text = globals.origins.trait(meta).description
	globals.showtooltip(slave.dictionary(text))


func _on_traittext_mouse_exit():
	globals.hidetooltip()


func _on_leveltext_meta_clicked( meta ):
	get_tree().get_current_scene().showracedescript(slave)
