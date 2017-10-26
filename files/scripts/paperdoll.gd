extends Control

var slave 
var availableitems

func _ready():
	for i in get_tree().get_nodes_in_group("paperdollbutton"):
		i.connect('pressed', self, 'paperdollpressed',[i])
		i.connect('mouse_enter', self, 'paperdolltooltip',[i])
		i.connect('mouse_exit', self, 'paperdolltooltipoff')
		i.set_meta('item', null)


func showup():
	var text = 'Gear effects: \n'
	var tempitem
	availableitems = []
	get_node("name").set_text(slave.name_long())
	var currentgear
	for i in globals.state.unstackables.values():
		if i.owner == null:
			availableitems.append(i)
	set_hidden(false)
	for i in get_tree().get_nodes_in_group("paperdollbutton"):
		currentgear = slave.gear[i.get_name()]
		i.set_meta("item", currentgear)
		if currentgear in ['clothcommon', 'underwearplain']:
			i.get_node("icon").set_texture(globals.itemdict[currentgear].icon)
			if i.get_node("icon").get_texture() == null:
				i.get_node('name').set_hidden(false)
				i.get_node('name').set_text(globals.itemdict[currentgear].name)
		else:
			if currentgear != null:
				tempitem = globals.state.unstackables[str(currentgear)]
				if typeof(tempitem.icon) != TYPE_STRING:
					i.get_node("icon").set_texture(tempitem.icon)
				else:
					i.get_node("icon").set_texture(globals.itemdict[tempitem.code].icon)
				for i in tempitem.effects:
					text += i.descript + "\n"
			else:
				i.get_node("icon").set_texture(null)
				i.get_node("name").set_hidden(true)
			if i.get_node("icon").get_texture() == null && currentgear != null:
				i.get_node('name').set_hidden(false)
				i.get_node('name').set_text(tempitem.name)
	if slave.gear.costume == null && slave.gear.armor == null:
		text += "\n[color=yellow]$name wearing no upper clothing![/color]"
	if slave.gear.underwear == null:
		text += "\n[color=yellow]$name wearing no underwear![/color]"
	if slave == globals.player:
		text = text.replace('$name', 'You')
	get_node("itemsummary").set_bbcode(slave.dictionary(text))


func paperdollpressed(button):
	var newbutton
	for i in get_node("selectitem/selectpanel/ScrollContainer/VBoxContainer").get_children():
		if i != get_node("selectitem/selectpanel/ScrollContainer/VBoxContainer/button"):
			i.set_hidden(true)
			i.queue_free()
	if slave.gear[button.get_name()] != null:
		newbutton = get_node("selectitem/selectpanel/ScrollContainer/VBoxContainer/button").duplicate()
		get_node("selectitem/selectpanel/ScrollContainer/VBoxContainer").add_child(newbutton)
		newbutton.set_text("Remove")
		newbutton.set_hidden(false)
		newbutton.connect("pressed", self, '_on_remove_pressed')
	
	if button.get_name() == 'costume' && slave.gear.costume != "clothcommon":
		newbutton = get_node("selectitem/selectpanel/ScrollContainer/VBoxContainer/button").duplicate()
		get_node("selectitem/selectpanel/ScrollContainer/VBoxContainer").add_child(newbutton)
		newbutton.set_text("Common Clothes")
		newbutton.set_hidden(false)
		newbutton.connect("pressed", self, 'selectitemforslot', ['clothcommon'])
	elif button.get_name() == 'underwear' && slave.gear.underwear != 'underwearplain':
		newbutton = get_node("selectitem/selectpanel/ScrollContainer/VBoxContainer/button").duplicate()
		get_node("selectitem/selectpanel/ScrollContainer/VBoxContainer").add_child(newbutton)
		newbutton.set_text("Plain Underwear")
		newbutton.set_hidden(false)
		newbutton.connect("pressed", self, 'selectitemforslot', ['underwearplain'])
	
	get_node("selectitem/selectpanel/ScrollContainer/VBoxContainer/button").set_meta('slot',button.get_name())
	for i in globals.state.unstackables.values():
		if i.type == button.get_name() && i.owner == null:
			newbutton = get_node("selectitem/selectpanel/ScrollContainer/VBoxContainer/button").duplicate()
			get_node("selectitem/selectpanel/ScrollContainer/VBoxContainer").add_child(newbutton)
			newbutton.set_text(i.name)
			newbutton.set_hidden(false)
			if get_tree().get_current_scene().get_node("itemnode").checkreqs(i) == false:
				newbutton.set_disabled(true)
				newbutton.set_tooltip(slave.dictionary("$name does not meet the requirements. "))
			newbutton.connect("pressed", self, 'selectitemforslot',[i])
	
	get_node("selectitem").popup()


func selectitemforslot(item):
	var tempitem
	if typeof(item) == TYPE_STRING:
		if item == 'underwearplain':
			if slave.gear.underwear != null && slave.gear.underwear != 'underwearplain':
				unequip(globals.state.unstackables[slave.gear.underwear])
			slave.gear.underwear = 'underwearplain'
		elif item == 'clothcommon':
			if slave.gear.costume != null && slave.gear.costume != 'clothcommon':
				unequip(globals.state.unstackables[slave.gear.costume])
			slave.gear.costume = 'clothcommon'
		get_node("selectitem").set_hidden(true)
		showup()
		return
	if slave.gear[item.type] != null && !slave.gear[item.type] in ['clothcommon','underwearplain']:
		tempitem = globals.state.unstackables[slave.gear[item.type]]
		unequip(tempitem)
	equip(item)
	get_node("selectitem").set_hidden(true)
	showup()
	



func _on_remove_pressed():
	var slot = get_node("selectitem/selectpanel/ScrollContainer/VBoxContainer/button").get_meta('slot')
	var tempitem
	if !slave.gear[slot] in ['clothcommon', 'underwearplain']:
		tempitem = globals.state.unstackables[slave.gear[slot]]
		unequip(tempitem)
	slave.gear[slot] = null
	get_node("selectitem").set_hidden(true)
	showup()

func equip(item):
	for i in item.effects:
		if i.type == 'onequip':
				get_tree().get_current_scene().get_node("itemnode").call(i.effect, i.effectvalue)
	item.owner = slave.id
	slave.gear[item.type] = item.id

func unequip(item):
	item.owner = null
	for i in item.effects:
		if i.type == 'onequip':
			get_tree().get_current_scene().get_node("itemnode").call(i.effect, -i.effectvalue)

func paperdolltooltip(button):
	var item 
	if button.has_meta('item'):
		item = button.get_meta('item')
	var text = ""
	var pos 
	pos = button.get_global_pos()
	if item in ['clothcommon', 'underwearplain']:
		item = globals.itemdict[item]
	elif item == null:
		return
	else:
		item = globals.state.unstackables[item]
		
	pos.x += 75
#	get_node("tooltippanel").set_hidden(false)
	text = "[center]"+item.name+"[/center]\n" + item.description 
	globals.showtooltip(text)
#	get_node("tooltippanel").set_global_pos(pos)
#	get_node("tooltippanel/RichTextLabel").set_bbcode(text)




func paperdolltooltipoff():
	globals.hidetooltip()

func _on_close_pressed():
	set_hidden(true)
	if slave != globals.player:
		get_parent().get_node("MainScreen/slave_tab")._on_slave_tab_visibility_changed()

