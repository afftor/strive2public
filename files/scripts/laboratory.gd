
extends Node
############### Laboratory

var labslave

func _on_lab_pressed(slave = null):
	var main = get_tree().get_current_scene()
	var labassist
	if slave != null:
		slave.work = 'labassist'
	for i in globals.slaves:
		if i.work == 'labassist':
			labassist = i
	var text = "Your basement laboratory is set and functioning. Rows of books and manuscripts can be found on your work table and shelves. Restricting and enhancing equipment kept clean and working at the far walls. "
	if labassist == null:
		main.background_set('lab1')
		if OS.get_name() != 'HTML5' && globals.rules.fadinganimation == true:
			yield(main, 'animfinished')
		main.hide_everything()
		get_node("labstart").set_disabled(true)
		get_node("chooseassist").set_text("Choose Assistant")
		text = text + "\n[color=yellow]You need to assign a Lab Assistant before you can conduct any modifications. [/color]"
	else:
		main.background_set('lab2')
		if OS.get_name() != 'HTML5' && globals.rules.fadinganimation == true:
			yield(main, 'animfinished')
		main.hide_everything()
		labassist.work = 'labassist'
		get_node("chooseassist").set_text("Unassign Assistant")
		get_node("labstart").set_disabled(false)
		text = text + labassist.dictionary("\n[color=aqua]$name[/color] taking care of the lab and it's residents. ")
	set_hidden(false)
	get_node("labinfo").set_bbcode(text)
	if globals.state.tutorial.lab == false:
		get_tree().get_current_scene().get_node("tutorialnode").lab()

func _on_chooseassist_pressed():
	if get_node("chooseassist").get_text() == ("Choose Assistant"):
		get_tree().get_current_scene().selectslavelist(false,'_on_lab_pressed',self)
	else:
		for i in globals.slaves:
			if i.work == 'labassist':
				i.work = 'rest'
		_on_lab_pressed()

func _on_labselectself_pressed():
	labslave = globals.player
	_on_labstart_pressed()
	_on_labstart_pressed(globals.player)
	get_node("labmodpanel/labselect").set_text('Deselect')



func _on_labstart_pressed(selected = null):
	for i in get_node("labmodpanel/ScrollContainer/primalmodlist").get_children():
		i.set_pressed(false)
	var text = ''
	labslave = selected
	var slave = labslave
	var labassist
	for i in globals.slaves:
		if i.work == 'labassist':
			labassist = i
	get_node("labmodpanel").set_hidden(false)
	if selected == null:
		get_node("labmodpanel/labselect").set_text('Select Subject')
		for i in get_node("labmodpanel/ScrollContainer1/secondarymodlist").get_children():
			if i != get_node("labmodpanel/ScrollContainer1/secondarymodlist/buttontemp"):
				i.set_hidden(true)
				i.queue_free()
		get_node("labmodpanel/labconfirm").set_disabled(true)
		for i in get_node("labmodpanel/ScrollContainer/primalmodlist").get_children():
			i.set_disabled(true)
	elif labassist == slave:
		for i in get_node("labmodpanel/ScrollContainer1/secondarymodlist").get_children():
			if i != get_node("labmodpanel/ScrollContainer1/secondarymodlist/buttontemp"):
				i.set_hidden(true)
				i.queue_free()
		get_node("labmodpanel/labselect").set_text('Deselect')
		get_node("labmodpanel/labconfirm").set_disabled(true)
		text = text + slave.dictionary("You can't conduct modifications on $name as $he is your current assistant.")
		for i in get_node("labmodpanel/ScrollContainer/primalmodlist").get_children():
			i.set_disabled(true)
	else:
		get_node("labmodpanel/labselect").set_text('Deselect')
		for i in get_node("labmodpanel/ScrollContainer/primalmodlist").get_children():
			i.set_disabled(false)
	if slave != null:
		if slave.tail == "snake tail" || slave.tail == 'tentacles' || slave.tail == 'horse' || slave.tail == 'spider abdomen':
			get_node("labmodpanel/ScrollContainer/primalmodlist/tail").set_hidden(true)
		else:
			get_node("labmodpanel/ScrollContainer/primalmodlist/tail").set_hidden(false)
		if slave.skin == 'jelly':
			get_node("labmodpanel/ScrollContainer/primalmodlist/skin").set_hidden(true)
		else:
			get_node("labmodpanel/ScrollContainer/primalmodlist/skin").set_hidden(false)
	get_node("labmodpanel/modificationtext").set_bbcode(text)


func _on_labcancel_pressed():
	labslave = null
	get_node("labmodpanel").set_hidden(true)

func _on_labselect_pressed():
	if get_node("labmodpanel/labselect").get_text() == 'Select Subject':
		get_tree().get_current_scene().selectslavelist(true,'_on_labstart_pressed',self,"globals.currentslave.work != 'labassist'",true)
	else:
		labslave = null
		_on_labstart_pressed()
		get_node("labmodpanel/labselect").set_text('Select Subject')

var horns = {
type = 'cosmetics',
description = '',
options =  ['none','short', 'long_straight', 'curved'],
target = 'horns',
price = {mana = 50, gold = 200},
items = {magicessenceing = 1, taintedessenceing = 3},
time = 2
}
var ears = {
type = 'cosmetics',
description = '',
options =  ['human','pointy','short_furry','long_pointy_furry','long_round_furry','long_droopy_furry','feathery','fins'],
target = 'ears',
price = {mana = 40, gold = 200},
items = {natureessenceing = 2},
time = 3
}
var tail = {
type = 'cosmetics',
description = '',
options = ['none','demon','dragon', 'scruffy', 'bird', 'cat', 'fox', 'wolf', 'bunny', 'racoon','fish'],
target = 'tail',
price = {mana = 65, gold = 300},
items = {bestialessenceing = 3},
time = 5
}
var wings = {
type = 'cosmetics',
description = '',
options = ['none', 'insect','feathered_black', 'feathered_white', 'feathered_brown', 'leather_black', 'leather_red'],
target = 'wings',
price = {mana = 80, gold = 350},
items = {bestialessenceing = 2, magicessenceing = 4},
time = 7
}
var skin = {
type = 'cosmetics',
description = '',
options =['pale', 'fair', 'olive', 'tan', 'brown','dark','blue','pale blue','green', 'red', 'purple', 'teal'],
target = 'skin',
price = {mana = 50, gold = 250},
items = {magicessenceing = 2},
time = 5
}
var penis = {
code = 'penis',
type = 'custom',
description = '',
options = [''],
target = '',
data = {
grow = {price = {mana = 100, gold = 250}, items = {majoruspot = 1}, time = 3},
remove = {price = {mana = 50, gold = 150}, items = {taintedessenceing = 2}, time = 4},
humanshape = {price = {mana = 40, gold = 200}, items = {magicessenceing = 2}, time = 3},
felineshape = {price = {mana = 60, gold = 300}, items = {bestialessenceing = 2}, time = 4},
canineshape = {price = {mana = 60, gold = 350}, items = {bestialessenceing = 2}, time = 4},
equineshape = {price = {mana = 60, gold = 400}, items = {bestialessenceing = 2}, time = 6},
pussy = {price = {mana = 50, gold = 300}, items = {natureessenceing = 2, fluidsubstanceing = 2}, time = 5},
},
}
var balls = {
code = 'balls',
type = 'custom',
description = '',
options = [''],
target = '',
data = {
grow = {price = {mana = 75, gold = 250}, items = {majoruspot = 1}, time = 3},
remove = {price = {mana = 50, gold = 150}, items = {taintedessenceing = 2}, time = 4},},
}
var tits = {
code = 'tits',
type = 'custom',
description = '',
options = [''],
target = 'titssize',
data = {
developtits = {price = {mana = 120, gold = 500}, items = {maturingpot = 2}, time = 6},
reversetits = {price = {mana = 60, gold = 300}, items = {youthingpot = 1}, time = 4},
addnipples = {price = {mana = 40, gold = 200}, items = {natureessenceing = 2, bestialessenceing = 2}, time = 2},
removenipples = {price = {mana = 25, gold = 200}, items = {taintedessenceing = 2}, time = 2},
maximizenipples = {price = {mana = 100, gold = 500}, items = {natureessenceing = 5, bestialessenceing = 5}, time = 5},
minimizenipples = {price = {mana = 50, gold = 200}, items = {taintedessenceing = 5}, time = 5},
hollownipples = {price = {mana = 100, gold = 400}, items = {natureessenceing = 2, fluidsubstanceing = 2, magicessenceing = 2}, time = 7}
},
}
var mods = {
code = 'mod',
type = 'custom',
description = '',
options = [''],
target = '',
data = {
tongue = {price = {mana = 75, gold = 250}, items = {natureessenceing = 3, magicessenceing = 1}, time = 3},
fur = {price = {mana = 100, gold = 250}, items = {natureessenceing = 2, magicessenceing = 2}, time = 6},
scales = {price = {mana = 100, gold = 250}, items = {natureessenceing = 2, magicessenceing = 2}, time = 6},
hearing = {price = {mana = 50, gold = 150}, items = {bestialessenceing = 1, magicessenceing = 1}, time = 4},
"str" : {price = {mana = 75, gold = 200}, items = {bestialessenceing = 2, magicessenceing = 2}, time = 5},
"agi" : {price = {mana = 75, gold = 200}, items = {bestialessenceing = 2, natureessenceing = 2}, time = 5},
"beauty" : {price = {mana = 50, gold = 300}, items = {magicessenceing = 2, natureessenceing = 2, beautypot = 1}, time = 5},
},}
var eyecolor = {
type = 'cosmetics',
description = '',
options = ['input'],
target = 'eyecolor',
price = {mana = 40, gold = 100},
items = {natureessenceing = 1},
time = 3
}

func labbuttonselected(string):
	var slave = labslave
	get_node("labmodpanel/modificationtext").set_bbcode('')
	var dict = {'horns' : horns, 'ears':ears, 'tail':tail,'wings' : wings, 'skin':skin, 'eyecolor': eyecolor, 'penis':penis, 'tits':tits, 'eyecolor':eyecolor, 'balls':balls, 'mods':mods}
	for i in get_node("labmodpanel/ScrollContainer/primalmodlist").get_children():
		if i.get_name() != string && i.is_pressed() == true:
			i.set_pressed(false)
	for i in get_node("labmodpanel/ScrollContainer1/secondarymodlist").get_children():
		if i != get_node("labmodpanel/ScrollContainer1/secondarymodlist/buttontemp"):
			i.queue_free()
			i.set_hidden(true)
	if dict[string].type == 'custom':
		var newbutton
		if dict[string].code == 'penis':
			if slave.penis != 'none' && slave.vagina != 'none':
				newbutton = get_node("labmodpanel/ScrollContainer1/secondarymodlist/buttontemp").duplicate()
				newbutton.set_hidden(false)
				newbutton.set_text('Remove')
				get_node("labmodpanel/ScrollContainer1/secondarymodlist").add_child(newbutton)
				newbutton.connect("pressed",self,'genetalia', [dict[string],'remove'])
				newbutton.set_meta('effect', 'remove')
			if slave.penis != 'none' && slave.penistype != 'human':
				newbutton = get_node("labmodpanel/ScrollContainer1/secondarymodlist/buttontemp").duplicate()
				newbutton.set_hidden(false)
				newbutton.set_text('Shape: Normal')
				get_node("labmodpanel/ScrollContainer1/secondarymodlist").add_child(newbutton)
				newbutton.connect("pressed",self,'genetalia', [dict[string],'humanshape'])
				newbutton.set_meta('effect', 'humanshape')
			if slave.penis != 'none' && slave.penistype != 'feline':
				newbutton = get_node("labmodpanel/ScrollContainer1/secondarymodlist/buttontemp").duplicate()
				newbutton.set_hidden(false)
				newbutton.set_text('Shape: Feline')
				get_node("labmodpanel/ScrollContainer1/secondarymodlist").add_child(newbutton)
				newbutton.connect("pressed",self,'genetalia', [dict[string],'felineshape'])
				newbutton.set_meta('effect', 'felineshape')
			if slave.penis != 'none' && slave.penistype != 'canine':
				newbutton = get_node("labmodpanel/ScrollContainer1/secondarymodlist/buttontemp").duplicate()
				newbutton.set_hidden(false)
				newbutton.set_text('Shape: Canine')
				get_node("labmodpanel/ScrollContainer1/secondarymodlist").add_child(newbutton)
				newbutton.connect("pressed",self,'genetalia', [dict[string],'canineshape'])
				newbutton.set_meta('effect', 'canineshape')
			if slave.penis != 'none' && slave.penistype != 'equine':
				newbutton = get_node("labmodpanel/ScrollContainer1/secondarymodlist/buttontemp").duplicate()
				newbutton.set_hidden(false)
				newbutton.set_text('Shape: Equine')
				get_node("labmodpanel/ScrollContainer1/secondarymodlist").add_child(newbutton)
				newbutton.connect("pressed",self,'genetalia', [dict[string],'equineshape'])
				newbutton.set_meta('effect', 'equineshape')
			if slave.penis == 'none':
				newbutton = get_node("labmodpanel/ScrollContainer1/secondarymodlist/buttontemp").duplicate()
				newbutton.set_hidden(false)
				newbutton.set_text('Grow')
				get_node("labmodpanel/ScrollContainer1/secondarymodlist").add_child(newbutton)
				newbutton.connect("pressed",self,'genetalia', [dict[string],'grow'])
				newbutton.set_meta('effect', 'grow')
			if slave.vagina == 'none' || slave.preg.has_womb == false:
				newbutton = get_node("labmodpanel/ScrollContainer1/secondarymodlist/buttontemp").duplicate()
				newbutton.set_hidden(false)
				newbutton.set_text('Female genitals')
				get_node("labmodpanel/ScrollContainer1/secondarymodlist").add_child(newbutton)
				newbutton.connect("pressed",self,'genetalia', [dict[string],'pussy'])
				newbutton.set_meta('effect', 'pussy')
		elif dict[string].code == 'tits':
			if slave.titsextra >= 1 && slave.titsextra <= 4&& slave.titsextradeveloped == false:
				newbutton = get_node("labmodpanel/ScrollContainer1/secondarymodlist/buttontemp").duplicate()
				newbutton.set_hidden(false)
				newbutton.set_text('Develop nipples')
				get_node("labmodpanel/ScrollContainer1/secondarymodlist").add_child(newbutton)
				newbutton.connect("pressed",self,'genetalia', [dict[string],'developtits'])
				newbutton.set_meta('effect', 'developtits')
			elif slave.titsextra >= 1:
				newbutton = get_node("labmodpanel/ScrollContainer1/secondarymodlist/buttontemp").duplicate()
				newbutton.set_hidden(false)
				newbutton.set_text('Remove nipples')
				get_node("labmodpanel/ScrollContainer1/secondarymodlist").add_child(newbutton)
				newbutton.connect("pressed",self,'genetalia', [dict[string],'reversetits'])
				newbutton.set_meta('effect', 'reversetits')
			if slave.titsextra < 4:
				newbutton = get_node("labmodpanel/ScrollContainer1/secondarymodlist/buttontemp").duplicate()
				newbutton.set_hidden(false)
				newbutton.set_text('Add nipples')
				get_node("labmodpanel/ScrollContainer1/secondarymodlist").add_child(newbutton)
				newbutton.connect("pressed",self,'genetalia', [dict[string],'addnipples'])
				newbutton.set_meta('effect', 'addnipples')
				newbutton = get_node("labmodpanel/ScrollContainer1/secondarymodlist/buttontemp").duplicate()
				newbutton.set_hidden(false)
				newbutton.set_text('Maximize nipples')
				get_node("labmodpanel/ScrollContainer1/secondarymodlist").add_child(newbutton)
				newbutton.connect("pressed",self,'genetalia', [dict[string],'maximizenipples'])
				newbutton.set_meta('effect', 'maximizenipples')
			if slave.titsextra > 0:
				newbutton = get_node("labmodpanel/ScrollContainer1/secondarymodlist/buttontemp").duplicate()
				newbutton.set_hidden(false)
				newbutton.set_text('Remove nipples')
				get_node("labmodpanel/ScrollContainer1/secondarymodlist").add_child(newbutton)
				newbutton.connect("pressed",self,'genetalia', [dict[string],'removenipples'])
				newbutton.set_meta('effect', 'removenipples')
				newbutton = get_node("labmodpanel/ScrollContainer1/secondarymodlist/buttontemp").duplicate()
				newbutton.set_hidden(false)
				newbutton.set_text('Minimize nipples')
				get_node("labmodpanel/ScrollContainer1/secondarymodlist").add_child(newbutton)
				newbutton.connect("pressed",self,'genetalia', [dict[string],'minimizenipples'])
				newbutton.set_meta('effect', 'minimizenipples')
			if globals.sizearray.find(slave.titssize) >= 3 && slave.mods.has('hollownipples') == false:
				newbutton = get_node("labmodpanel/ScrollContainer1/secondarymodlist/buttontemp").duplicate()
				newbutton.set_hidden(false)
				newbutton.set_text('Hollow nipples')
				get_node("labmodpanel/ScrollContainer1/secondarymodlist").add_child(newbutton)
				newbutton.connect("pressed",self,'genetalia', [dict[string],'hollownipples'])
				newbutton.set_meta('effect', 'hollownipples')
		elif dict[string].code == 'balls':
			if slave.balls == 'none':
				newbutton = get_node("labmodpanel/ScrollContainer1/secondarymodlist/buttontemp").duplicate()
				newbutton.set_hidden(false)
				newbutton.set_text('Grow')
				get_node("labmodpanel/ScrollContainer1/secondarymodlist").add_child(newbutton)
				newbutton.connect("pressed",self,'genetalia', [dict[string],'grow'])
				newbutton.set_meta('effect', 'grow')
			if slave.balls != 'none':
				newbutton = get_node("labmodpanel/ScrollContainer1/secondarymodlist/buttontemp").duplicate()
				newbutton.set_hidden(false)
				newbutton.set_text('Remove')
				get_node("labmodpanel/ScrollContainer1/secondarymodlist").add_child(newbutton)
				newbutton.connect("pressed",self,'genetalia', [dict[string],'remove'])
				newbutton.set_meta('effect', 'remove')
		elif dict[string].code == 'mod':
			if slave.skincov == 'full_body_fur' && slave.mods.has('augmentfur') == false:
				newbutton = get_node("labmodpanel/ScrollContainer1/secondarymodlist/buttontemp").duplicate()
				newbutton.set_hidden(false)
				newbutton.set_text('Enhanced fur')
				get_node("labmodpanel/ScrollContainer1/secondarymodlist").add_child(newbutton)
				newbutton.connect("pressed",self,'genetalia', [dict[string],'fur'])
				newbutton.set_meta('effect', 'fur')
			if slave.mods.has('augmenttongue') == false:
				newbutton = get_node("labmodpanel/ScrollContainer1/secondarymodlist/buttontemp").duplicate()
				newbutton.set_hidden(false)
				newbutton.set_text('Elongated tongue')
				get_node("labmodpanel/ScrollContainer1/secondarymodlist").add_child(newbutton)
				newbutton.connect("pressed",self,'genetalia', [dict[string],'tongue'])
				newbutton.set_meta('effect', 'tongue')
			if slave.skincov == 'scales' && slave.mods.has('augmentscales') == false:
				newbutton = get_node("labmodpanel/ScrollContainer1/secondarymodlist/buttontemp").duplicate()
				newbutton.set_hidden(false)
				newbutton.set_text('Enhanced scales')
				get_node("labmodpanel/ScrollContainer1/secondarymodlist").add_child(newbutton)
				newbutton.connect("pressed",self,'genetalia', [dict[string],'scales'])
				newbutton.set_meta('effect', 'scales')
			if slave.mods.has('augmenthearing') == false:
				newbutton = get_node("labmodpanel/ScrollContainer1/secondarymodlist/buttontemp").duplicate()
				newbutton.set_hidden(false)
				newbutton.set_text('Enhanced hearing')
				get_node("labmodpanel/ScrollContainer1/secondarymodlist").add_child(newbutton)
				newbutton.connect("pressed",self,'genetalia', [dict[string],'hearing'])
				newbutton.set_meta('effect', 'hearing')
			if slave.mods.has('augmentstr') == false:
				newbutton = get_node("labmodpanel/ScrollContainer1/secondarymodlist/buttontemp").duplicate()
				newbutton.set_hidden(false)
				newbutton.set_text('Enhanced muscles')
				get_node("labmodpanel/ScrollContainer1/secondarymodlist").add_child(newbutton)
				newbutton.connect("pressed",self,'genetalia', [dict[string],'str'])
				newbutton.set_meta('effect', 'str')
			if slave.mods.has('augmentagi') == false:
				newbutton = get_node("labmodpanel/ScrollContainer1/secondarymodlist/buttontemp").duplicate()
				newbutton.set_hidden(false)
				newbutton.set_text('Enhanced reflexes')
				get_node("labmodpanel/ScrollContainer1/secondarymodlist").add_child(newbutton)
				newbutton.connect("pressed",self,'genetalia', [dict[string],'agi'])
				newbutton.set_meta('effect', 'agi')
			if slave.mods.has('augmentbeauty') == false:
				newbutton = get_node("labmodpanel/ScrollContainer1/secondarymodlist/buttontemp").duplicate()
				newbutton.set_hidden(false)
				newbutton.set_text('Improve appearance')
				get_node("labmodpanel/ScrollContainer1/secondarymodlist").add_child(newbutton)
				newbutton.connect("pressed",self,'genetalia', [dict[string],'beauty'])
				newbutton.set_meta('effect', 'beauty')
		return

	for i in dict[string].options:
		if i == 'input':
			var newinput = LineEdit.new()
			newinput.set_custom_minimum_size(Vector2(200,30))
			newinput.set_name('labinput')
			get_node("labmodpanel/ScrollContainer1/secondarymodlist").add_child(newinput)
			newinput.connect("text_changed", self, 'modchosen', [dict[string], string, i])
		else:
			var newbutton = get_node("labmodpanel/ScrollContainer1/secondarymodlist/buttontemp").duplicate()
			newbutton.set_hidden(false)
			newbutton.set_text(i.capitalize())
			get_node("labmodpanel/ScrollContainer1/secondarymodlist").add_child(newbutton)
			newbutton.connect("pressed",self,'modchosen', [dict[string], string, i])

func text_changed(changedtext = '', dict = {}, string = '', selected = ''):
	get_node("labmodpanel/modificationtext").set_bbcode()
	var slave = labslave
	var allow = true
	var assist
	for i in globals.slaves:
		if i.work == 'labassist':
			assist = i
	var modification = str2var(var2str(dict))
	

func modchosen(dict= {}, string = '', selected=''):
	var slave = labslave
	var text = ''
	var allow = true
	var assist
	for i in globals.slaves:
		if i.work == 'labassist':
			assist = i
	var modification = str2var(var2str(dict))
	if modification.type == 'cosmetics':
		get_node("labmodpanel/labconfirm").set_disabled(true)
		for i in get_node("labmodpanel/ScrollContainer1/secondarymodlist").get_children():
			if globals.decapitalize(i.get_text()) != selected:
				i.set_pressed(false) 
		if slave[modification.target] == selected:
			allow = false
			text = "$names already possess " + selected.capitalize().replace('None', 'no') + ' ' +  string + '.'
		else:
			text = "Change $name's " + string + ' to ' + selected.capitalize() + '? Currently $he has ' + slave[string].capitalize().replace('None', 'no') + ' ' + string + '. \nRequirements: \n' 
			for i in modification.price:
				modification.price[i] = round(modification.price[i]/(1+assist.wit/200.0))
				if slave == globals.player:
					modification.price[i] = modification.price[i]*2
				if globals.resources[i] >= modification.price[i]:
					text = text + '[color=yellow]'+str(i) + '[/color] - [color=green]' + str(modification.price[i]) + '[/color], \n'
				else:
					allow = false
					text = text + '[color=yellow]' + str(i) + '[/color] - [color=red]' + str(modification.price[i]) + '[/color], \n'
			for i in modification.items:
				modification.items[i] = round(modification.items[i]/(1+assist.wit/200.0))
				if slave == globals.player:
					modification.items[i] = modification.items[i]*2
				var item = globals.itemdict[i]
				if item.amount >= modification.items[i]:
					text = text + item.name + ' - [color=green]' + str(modification.items[i]) + '[/color], \n'
				else:
					allow = false
					text = text + item.name + ' - [color=red]' + str(modification.items[i]) + '[/color], \n'
			modification.time = max(round(modification.time/(1+assist.smaf/200.0)),1)
			if slave == globals.player:
				modification.time = 0
			text = text + 'Required time - ' + str(modification.time) + globals.fastif(modification.time == 1, ' day',' days')+'. ' 
	
	if allow == true:
		get_node("labmodpanel/labconfirm").set_meta('data', modification)
		get_node("labmodpanel/labconfirm").set_meta('effect', selected)
		get_node("labmodpanel/labconfirm").set_disabled(false)
	else:
		get_node("labmodpanel/labconfirm").set_disabled(true)
	if slave == globals.player:
		text = text.replace("has", "have")
		get_node("labmodpanel/modificationtext").set_bbcode(slave.dictionaryplayer(text))
	else:
		get_node("labmodpanel/modificationtext").set_bbcode(slave.dictionary(text))

func genetalia(dict, action):
	var slave = labslave
	var text = ''
	var allow = true
	var assist
	for i in globals.slaves:
		if i.work == 'labassist':
			assist = i
	var modification = str2var(var2str(dict))
	get_node("labmodpanel/labconfirm").set_disabled(true)
	
	for i in get_node("labmodpanel/ScrollContainer1/secondarymodlist").get_children():
		if i.has_meta('effect') == true:
			if i.get_meta('effect') != action:
				i.set_pressed(false) 
	
	if modification.code == 'penis' && action == 'grow':
		text = "$name's clit will be turned into a fully functional, fertile human penis. Semen will be produced by miniscule innards.\n\nRequirements: "
	elif modification.code == 'penis' && action == 'remove':
		text = "$name's penis will be magically reverted into a clitoris.\n\nRequirements:"
	elif modification.code == 'penis' && action == 'humanshape':
		text = "$name's cock will be changed to human shape. \n\nRequirements:"
	elif modification.code == 'penis' && action == 'felineshape':
		text = "$name's cock will be changed to feline shape, fitted with small barbs. \n\nRequirements:"
	elif modification.code == 'penis' && action == 'canineshape':
		text = "$name's cock will be changed to canine shape, with a sizeable knot at the base. \n\nRequirements:"
	elif modification.code == 'penis' && action == 'equineshape':
		text = "$name's cock will be changed to equine shape, with a blunt tip and flared head. \n\nRequirements:"
	elif modification.code == 'penis' && action == 'pussy':
		if slave.vagina == 'none':
			text = "$name will obtain a fully functional vagina capable of pregnancy. \n\nRequirements:"
		else:
			text = "$name's womb will be restored and capable of pregnancy again. \n\nRequirements:"
	elif modification.code == 'tits' && action == 'developtits':
		text = "$name's additional rudimentary nipples will be developed into full-functional mammaries. \n\nRequirements:"
	elif modification.code == 'tits' && action == 'reversetits':
		text = "$name's secondary tits will be reverted back to rudimentary nipples. \n\nRequirements:"
	elif modification.code == 'tits' && action == 'addnipples':
		text = "$name's chest will be augmented with an additional pair of nipples.\n\nRequirements:"
	elif modification.code == 'tits' && action == 'removenipples':
		text = "A pair of secondary nipples will be removed from $name's chest. \n\nRequirements:"
	elif modification.code == 'tits' && action == 'maximizenipples':
		text = "$name's chest and stomach will be modified to hold 4 pairs of additional nipples. \n\nRequirements:"
	elif modification.code == 'tits' && action == 'minimizenipples':
		text = "All but one pair of $his original nipples will be removed from $name's chest. \n\nRequirements:"
	elif modification.code == 'tits' && action == 'hollownipples':
		text = "$name's nipples will be altered to be more elastic and sensitive, with the breasts hollow inside allowing $him to receive pleasure from penetration. \n\nRequirements:"
	elif modification.code == 'balls' && action == 'grow':
		text = "$name will grow a pair of small testicles. \n\nRequirements:"
	elif modification.code == 'balls' && action == 'remove':
		text = "$name will have $his testicles moved inside his body cavity, hiding them from sight (does not impact fertility). \n\nRequirements:"
	elif modification.code == 'mod' && action == 'fur':
		text = "$name's fur will be magically augmented to provide better protection. \n\nRequirements:"
	elif modification.code == 'mod' && action == 'scale':
		text = "$name's scales will be magically augmented to provide better protection. \n\nRequirements:"
	elif modification.code == 'mod' && action == 'tongue':
		text = "$name's tongue will be elongated allowing better performance during oral sex. \n\nRequirements:"
	elif modification.code == 'mod' && action == 'hearing':
		text = "$name's hearing will be magically augmented and will raise $his awareness. \n\nRequirements:"
	elif modification.code == 'mod' && action == 'str':
		text = "Due to magical augmentation, $name's muscles will have more room for growth. (increases maximum strength by 2) \n\nRequirements:"
	elif modification.code == 'mod' && action == 'agi':
		text = "Due to magical augmentation, $name's flexibility will have more room for growth. (increases maximum agility by 2) \n\nRequirements:"
	elif modification.code == 'mod' && action == 'beauty':
		text = "$name's visual appearance will be improved by correcting flaws and problematic parts. (inceases basic beauty, can only be used once per servant) \n\nRequirements:"
	
	
	
	for i in modification.data[action].price:
		modification.data[action].price[i] = round(modification.data[action].price[i]/(1+assist.wit/200.0))
		if slave == globals.player:
			modification.data[action].price[i] = modification.data[action].price[i]*2
		if globals.resources[i] >= modification.data[action].price[i]:
			text = text + str(i) + ' - [color=green]' + str(modification.data[action].price[i]) + '[/color], \n'
		else:
			allow = false
			text = text + str(i) + ' - [color=red]' + str(modification.data[action].price[i]) + '[/color], \n'
	for i in modification.data[action].items:
		modification.data[action].items[i] = round(modification.data[action].items[i]/(1+assist.wit/200.0))
		if slave == globals.player:
			modification.data[action].items[i] = modification.data[action].items[i]*2
		var item = globals.itemdict[i]
		if item.amount >= modification.data[action].items[i]:
			text = text + item.name + ' - [color=green]' + str(modification.data[action].items[i]) + '[/color], \n'
		else:
			allow = false
			text = text + item.name + ' - [color=red]' + str(modification.data[action].items[i]) + '[/color], \n'
	modification.data[action].time = max(round(modification.data[action].time/(1+assist.smaf*4)),1)
	if slave == globals.player:
		modification.data[action].time = 0
	text = text + 'Required time - ' + str(modification.data[action].time) + globals.fastif(modification.data[action].time == 1, ' day',' days')+'. ' 
	
	if allow == true:
		get_node("labmodpanel/labconfirm").set_meta('data', modification)
		get_node("labmodpanel/labconfirm").set_meta('effect', action)
		get_node("labmodpanel/labconfirm").set_disabled(false)
	else:
		get_node("labmodpanel/labconfirm").set_disabled(true)
	if slave == globals.player:
		get_node("labmodpanel/modificationtext").set_bbcode(slave.dictionaryplayer(text))
	else:
		get_node("labmodpanel/modificationtext").set_bbcode(slave.dictionary(text))



func _on_labconfirm_pressed():
	var slave = labslave
	var assist
	for i in globals.slaves:
		if i.work == 'labassist':
			assist = i
	var operation = get_node("labmodpanel/labconfirm").get_meta('data')
	var result = get_node("labmodpanel/labconfirm").get_meta('effect')
	slave.metrics.mods += 1
	if operation.type == 'cosmetics':
		slave[operation.target] = result
		get_tree().get_current_scene().rebuild_slave_list()
		get_node("labmodpanel").set_hidden(true)
		slave.away.duration = operation.time
		slave.away.at = 'lab'
		slave.stress += rand_range(70,95) - slave.loyal/3
		slave.health -= rand_range(slave.stats.health_max/8,slave.stats.health_max/4)
		for i in operation.price:
			globals.resources[i] -= operation.price[i]
		for i in operation.items:
			var item = globals.itemdict[i]
			item.amount -= operation.items[i]
	elif operation.type == 'custom' && operation.code == 'penis':
		if result == 'grow':
			slave.penis = 'small'
			slave.penistype = 'human'
		elif result == 'remove':
			slave.penis = 'none'
		elif result == 'humanshape':
			slave.penistype = 'human'
		elif result == 'felineshape':
			slave.penistype = 'feline'
		elif result == 'canineshape':
			slave.penistype = 'canine'
		elif result == 'equineshape':
			slave.penistype = 'equine'
		elif result == 'pussy':
			slave.vagina = 'normal'
			slave.vagvirgin = false
			slave.preg.has_womb = true
	elif operation.type == 'custom' && operation.code == 'tits':
		if result == 'developtits':
			slave.titsextradeveloped = true
		elif result == 'reversetits':
			slave.titsextradeveloped = false
		elif result == 'addnipples':
			slave.titsextra += 1
		elif result == 'removenipples':
			slave.titsextra -= 1
		elif result == 'maximizenipples':
			slave.titsextra = 4
		elif result == 'minimizenipples':
			slave.titsextra = 0
		elif result == 'hollownipples':
			slave.mods['hollownipples'] = 'hollownipples'
	elif operation.type == 'custom' && operation.code == 'balls':
		if result == 'grow':
			slave.balls = 'small'
		elif result == 'remove':
			slave.balls = 'none'
	elif operation.type == 'custom' && operation.code == 'mod':
		if result == 'fur':
			slave.mods['augmentfur'] = 'augmentfur'
			slave.add_effect(globals.effectdict.augmentfur)
		elif result == 'tongue':
			slave.mods['augmenttongue'] = 'augmenttongue'
		elif result == 'scales':
			slave.mods['augmentscales'] = 'augmentscales'
			slave.add_effect(globals.effectdict.augmentscales)
		elif result == 'str':
			slave.mods['augmentstr'] = 'augmentstr'
			slave.add_effect(globals.effectdict.augmentstr)
		elif result == 'agi':
			slave.mods['augmentagi'] = 'augmentagi'
			slave.add_effect(globals.effectdict.augmentagi)
		elif result == 'hearing':
			slave.mods['augmenthearing'] = 'augmenthearing'
		elif result == 'beauty':
			slave.mods['augmentbeauty'] = 'augmentbeauty'
			if slave.beautybase < 60:
				slave.beautybase += 30
			else:
				slave.beautybase += 20
	if operation.type == 'custom':
		slave.away.duration = operation.data[result].time
		slave.away.at = 'lab'
		slave.stress += rand_range(70,95) - slave.loyal/3
		slave.health -= rand_range(slave.stats.health_max/8,slave.stats.health_max/4)
		for i in operation.data[result].price:
			globals.resources[i] -= operation.data[result].price[i]
		for i in operation.data[result].items:
			var item = globals.itemdict[i]
			item.amount -= operation.data[result].items[i]
	
	labslave = null
	get_tree().get_current_scene().rebuild_slave_list()
	get_node("labmodpanel").set_hidden(true)



func _on_eyecolor_pressed():
	pass # replace with function body

