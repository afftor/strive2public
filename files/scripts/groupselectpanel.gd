extends Node

func show():
	var newbutton
	var group
	var text = ''
	get_parent().checkplayergroup()
	get_parent()._on_mansion_pressed()
	if OS.get_name() != 'HTML5' && globals.rules.fadinganimation == true:
		yield(get_parent(), 'animfinished')
	set_hidden(false)
	for i in get_node("grouppanel/ScrollContainer/VBoxContainer").get_children():
		if i != get_node("grouppanel/ScrollContainer/VBoxContainer/Button"):
			i.set_hidden(true)
			i.queue_free()
	for slave in globals.slaves:
		if slave.away.at == 'hidden':
			continue
		newbutton = get_node("grouppanel/ScrollContainer/VBoxContainer/Button").duplicate()
		get_node("grouppanel/ScrollContainer/VBoxContainer").add_child(newbutton)
		newbutton.set_hidden(false)
		newbutton.set_text(slave.name_long() + ' ' + slave.race)
		if globals.state.playergroup.find(slave.id) >= 0:
			newbutton.set_pressed(true)
		elif globals.state.playergroup.size() >= 3 || slave.energy <= 10 || slave.stress >= 80 || slave.loyal + slave.obed < 90 || slave.sleep == 'jail' || slave.away.duration != 0:
			newbutton.set_disabled(true)
		newbutton.connect("pressed",self,'addtogroup',[slave, newbutton])
	if globals.state.playergroup.size() <= 0:
		text = 'You have no assigned followers'
	else:
		text = 'You will be accompanied by:\n'
	for i in globals.state.playergroup:
		group = globals.state.findslave(i)
		text = text + group.name_long() + ', ' + group.race +', Level: ' +  str(group.level) + ', Health: '+str(round(group.health)) + ", Energy: "+ str(round(group.energy))+  '\n'
	get_node("grouppanel/grouplabel").set_bbcode(text)
	updateitemsinventory()
	updateitemsbackpack()
	calculateweight()


func calculateweight():
	var weight = globals.state.calculateweight()
	get_node("grouppanel/weightmeter/Label").set_text("Weight: " + str(weight.currentweight) + '/' + str(weight.maxweight))
	get_node("grouppanel/weightmeter").set_val((weight.currentweight*10/max(weight.maxweight,1)*10))
	if weight.overload == true:
		get_node("grouppanel/closegroup").set_tooltip("Reduce carry weight before proceeding")
		get_node("grouppanel/closegroup").set_disabled(true)
	else:
		get_node("grouppanel/closegroup").set_tooltip("")
		get_node("grouppanel/closegroup").set_disabled(false)

func addtogroup(slave, button):
	if button.is_pressed == true:
		globals.state.playergroup.append(slave.id)
	else:
		globals.state.playergroup.remove(globals.state.playergroup.find(slave.id))
	show()

func _on_closegroup_pressed():
	set_hidden(true)
	get_parent()._on_mansion_pressed()

func updateitemsinventory():
	var newbutton
	var tempitem
	for i in get_node("inventory/VBoxContainer").get_children():
		if i != get_node("inventory/VBoxContainer/Button"):
			i.set_hidden(true)
			i.queue_free()
	for i in globals.itemdict.values():
		if i.amount >= 1 && !i.type in ['gear','dummy']:
			newbutton = get_node("inventory/VBoxContainer/Button").duplicate()
			get_node("inventory/VBoxContainer").add_child(newbutton)
			newbutton.set_hidden(false)
			newbutton.get_node("amount").set_text(str(i.amount))
			if i.icon != null:
				newbutton.get_node("image").set_texture(i.icon)
			newbutton.connect("pressed",self,'moveitemtobackpack',[newbutton])
			newbutton.set_meta("item", i)
			newbutton.connect("mouse_enter", self, 'itemtooltip', [i])
			newbutton.connect("mouse_exit", self, 'itemtooltiphide')
	for i in globals.state.unstackables.values():
		if i.owner != null && globals.state.findslave(i.owner) == null && i.owner != globals.player.id:
			i.owner = null
		if i.owner == null:
			newbutton = get_node("inventory/VBoxContainer/Button").duplicate()
			get_node("inventory/VBoxContainer").add_child(newbutton)
			newbutton.set_hidden(false)
			newbutton.get_node("amount").set_hidden(true)
			if i.icon != null:
				newbutton.get_node("image").set_texture(load(i.icon))
			newbutton.connect("pressed",self,'moveitemtobackpack',[newbutton])
			newbutton.set_meta("item", i)
			newbutton.connect("mouse_enter", self, 'itemtooltip', [i])
			newbutton.connect("mouse_exit", self, 'itemtooltiphide')

func updateitemsbackpack():
	var newbutton
	var tempitem
	for i in get_node("backpack/VBoxContainer").get_children():
		if i != get_node("backpack/VBoxContainer/Button"):
			i.set_hidden(true)
			i.queue_free()
	for i in globals.state.backpack.stackables:
		tempitem = globals.itemdict[i]
		newbutton = get_node("backpack/VBoxContainer/Button").duplicate()
		get_node("backpack/VBoxContainer").add_child(newbutton)
		newbutton.set_hidden(false)
		newbutton.get_node("amount").set_text(str(globals.state.backpack.stackables[i]))
		if tempitem.icon != null:
			newbutton.get_node("image").set_texture(tempitem.icon)
		newbutton.connect("pressed",self,'moveitemtoinventory',[newbutton])
		newbutton.set_meta("item", tempitem)
		newbutton.connect("mouse_enter", self, 'itemtooltip', [tempitem])
		newbutton.connect("mouse_exit", self, 'itemtooltiphide')
	for i in globals.state.backpack.unstackables:
		newbutton = get_node("backpack/VBoxContainer/Button").duplicate()
		get_node("backpack/VBoxContainer").add_child(newbutton)
		newbutton.set_hidden(false)
		newbutton.get_node("amount").set_hidden(true)
		if i.icon != null:
			newbutton.get_node("image").set_texture(load(i.icon))
		newbutton.connect("pressed",self,'moveitemtoinventory',[newbutton])
		newbutton.set_meta("item", i)
		newbutton.connect("mouse_enter", self, 'itemtooltip', [i])
		newbutton.connect("mouse_exit", self, 'itemtooltiphide')
	calculateweight()

func moveitemtobackpack(button):
	var item = button.get_meta('item')
	if item.has('owner') == false:
		item.amount -= 1
		if globals.state.backpack.stackables.has(item.code):
			globals.state.backpack.stackables[item.code] += 1
		else:
			globals.state.backpack.stackables[item.code] = 1
	else:
		globals.state.backpack.unstackables.append(item)
		globals.state.unstackables.erase(item.id)
	updateitemsbackpack()
	updateitemsinventory()
	itemtooltiphide()

func moveitemtoinventory(button):
	var item = button.get_meta('item')
	if item.has('owner') == false:
		item.amount += 1
		globals.state.backpack.stackables[item.code] -= 1
		if globals.state.backpack.stackables[item.code] <= 0:
			globals.state.backpack.stackables.erase(item.code)
	else:
		globals.state.unstackables[str(item.id)] = item
		globals.state.backpack.unstackables.erase(item)
	updateitemsbackpack()
	updateitemsinventory()
	itemtooltiphide()

func itemtooltip(item):
	globals.showtooltip(globals.itemdescription(item))

func itemtooltiphide():
	globals.hidetooltip()



func _on_storeeverything_pressed():
	var array = []
	for i in globals.state.backpack.stackables:
		array.append(i)
	for i in array:
		var item = globals.itemdict[i]
		item.amount += globals.state.backpack.stackables[i]
		globals.state.backpack.stackables.erase(i)
	array.clear()
	for i in globals.state.backpack.unstackables:
		array.append(i)
	for i in array:
		globals.state.unstackables[str(i.id)] = i
		globals.state.backpack.unstackables.erase(i)
	updateitemsbackpack()
	updateitemsinventory()
