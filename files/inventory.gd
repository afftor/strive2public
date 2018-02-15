extends Node

var state
var location = 'mansion'
var selectedslave

var categories = {everything = true, potion = false, ingredient = false, gear = false, supply = false}
onready var itemgrid = get_node("ScrollContainer/GridContainer")

var shades = {
arachna = {male = load("res://files/buttons/inventory/shades/Arachna_M.png"), female = load("res://files/buttons/inventory/shades/Arachna_F.png")},
bunny = {male = load("res://files/buttons/inventory/shades/Beastkin-Bunny_M.png"), female = load("res://files/buttons/inventory/shades/Beastkin-Bunny_F.png")},
cat = {male = load("res://files/buttons/inventory/shades/Beastkin-Cat_M.png"), female = load("res://files/buttons/inventory/shades/Beastkin-Cat_F.png")},
fox = {male = load("res://files/buttons/inventory/shades/Beastkin-Fox_M.png"), female = load("res://files/buttons/inventory/shades/Beastkin-Fox_F.png")},
tanuki = {male = load("res://files/buttons/inventory/shades/Beastkin-Tanuki_M.png"), female = load("res://files/buttons/inventory/shades/Beastkin-Tanuki_F.png")},
wolf = {male = load("res://files/buttons/inventory/shades/Beastkin-Wolf_M.png"), female = load("res://files/buttons/inventory/shades/Beastkin-Wolf_F.png")},
centaur = {male = load("res://files/buttons/inventory/shades/Centaur_M.png"), female = load("res://files/buttons/inventory/shades/Centaur_F.png")},
demon = {male = load("res://files/buttons/inventory/shades/Demon_M.png"), female = load("res://files/buttons/inventory/shades/Demon_F.png")},
dragonkin = {male = load("res://files/buttons/inventory/shades/Dragonkin_M.png"), female = load("res://files/buttons/inventory/shades/Dragonkin_F.png")},
dryad = {male = load("res://files/buttons/inventory/shades/Dryad_M.png"), female = load("res://files/buttons/inventory/shades/Dryad_F.png")},
elf = {male = load("res://files/buttons/inventory/shades/Elf_M.png"), female = load("res://files/buttons/inventory/shades/Elf_F.png")},
fairy = {male = load("res://files/buttons/inventory/shades/Fairy_M.png"), female = load("res://files/buttons/inventory/shades/Fairy_F.png")},
gnome = {male = load("res://files/buttons/inventory/shades/Gnome_M.png"), female = load("res://files/buttons/inventory/shades/Gnome_F.png")},
goblin = {male = load("res://files/buttons/inventory/shades/Goblin_M.png"), female = load("res://files/buttons/inventory/shades/Goblin_F.png")},
harpy = {male = load("res://files/buttons/inventory/shades/Harpy_M.png"), female = load("res://files/buttons/inventory/shades/Harpy_F.png")},
human = {male = load("res://files/buttons/inventory/shades/Human_M.png"), female = load("res://files/buttons/inventory/shades/Human_F.png")},
lamia = {male = load("res://files/buttons/inventory/shades/Lamia_M.png"), female = load("res://files/buttons/inventory/shades/Lamia_F.png")},
nereid = {male = load("res://files/buttons/inventory/shades/Nereid_M.png"), female = load("res://files/buttons/inventory/shades/Nereid_F.png")},
scylla = {male = load("res://files/buttons/inventory/shades/Scylla_M.png"), female = load("res://files/buttons/inventory/shades/Scylla_F.png")},
seraph = {male = load("res://files/buttons/inventory/shades/Seraph_M.png"), female = load("res://files/buttons/inventory/shades/Seraph_F.png")},
slime = {male = load("res://files/buttons/inventory/shades/Slime_M.png"), female = load("res://files/buttons/inventory/shades/Slime_F.png")},
taurus = {male = load("res://files/buttons/inventory/shades/Taurus_M.png"), female = load("res://files/buttons/inventory/shades/Taurus_F.png")},
orc = {male = load("res://files/buttons/inventory/shades/Orc_-M.png"), female = load("res://files/buttons/inventory/shades/Orc_F.png")},

}


#,'weaponclaymore','clothpet','clothkimono','underwearlacy','weaponaynerisrapier'
func _ready():
#	var i = 3
#	if globals.player.name == '':
#		globals.player = globals.newslave(globals.allracesarray[rand_range(0,globals.allracesarray.size())], 'random', 'random')
#		while i > 0:
#			i -= 1
#			var slave = globals.newslave(globals.allracesarray[rand_range(0,globals.allracesarray.size())], 'random', 'random')
#			globals.slaves = slave
	
	
#	for i in globals.itemdict.values():
#		i.unlocked = true
#		if !i.type in ['gear','dummy']:
#			i.amount += 10
#	for i in ['armorchain','armorchain','armorchain','armorchain','armorchain']:
#		var tmpitem = globals.items.createunstackable(i)
#		globals.items.enchantrand(tmpitem)
#		globals.state.unstackables[str(tmpitem.id)] = tmpitem
	
	
	
	for i in ['costume','weapon','armor','accessory','underwear']:
		get_node("gearpanel/" + i).connect("pressed", self, 'gearinfo', [i])
		get_node("gearpanel/" + i + "/unequip").connect("pressed", self, 'unequip', [i])
	
	for i in get_tree().get_nodes_in_group("invcategory"):
		i.connect("pressed",self,'selectcategory',[i])
	
#	open()



func selectcategory(button):
	if button.get_name() == 'everything':
		for i in get_tree().get_nodes_in_group('invcategory'):
			i.set_pressed(i == button)
	else:
		categories.everything = false
		get_node("everything").set_pressed(false)
	for i in categories:
		categories[i] = get_node(i).is_pressed()
	categoryitems()

func categoryitems():
	for i in get_node("ScrollContainer/GridContainer/").get_children():
		if (categories.everything == true && i.get_name() != 'Button' )|| (i.has_meta('category') && categories[i.get_meta('category')] == true):
			i.set_hidden(false)
		else:
			i.set_hidden(true)

func gearinfo(gear):
	if selectedslave != null && selectedslave.gear[gear] != null:
		var item = globals.state.unstackables[selectedslave.gear[gear]]
		get_node("iteminfo/RichTextLabel").set_bbcode(globals.itemdescription(item))
		get_node("iteminfo/TextureFrame").set_texture(load(item.icon))
		get_node("iteminfo").popup()

func unequip(gear):
	if selectedslave != null && selectedslave.gear[gear] != null:
		if location == 'mansion':
			globals.state.unstackables[selectedslave.gear[gear]].owner = null
		else:
			globals.state.unstackables[selectedslave.gear[gear]].owner = 'backpack'
		selectedslave.gear[gear] = null
		slavegear(selectedslave)
		updateitems()

func open(place = 'mansion', part = 'inventory', keepslave = false):
	
	location = place
	state = part
	if keepslave == false:
		selectedslave = null
	if selectedslave == null:
		get_node("gearpanel").set_hidden(true)
	updateitems()
	calculateweight()
	slavelist()
	
	set_hidden(false)

func updateitems():
	clearitems()
	if state == 'inventory':
		itemsinventory()
	elif state == 'backpack':
		itemsbackpack()
	categoryitems()

var modetextures = {inventory = load("res://files/buttons/inventory/12_chest.png"), backpack = load("res://files/buttons/inventory/13_bag.png")}

func _on_mode_pressed():
	if state == 'inventory':
		open('mansion','backpack',true)
	else:
		open('mansion','inventory',true)
	get_node("mode").set_normal_texture(modetextures[state])

func clearitems():
	for i in itemgrid.get_children():
		if i.get_name() != "Button":
			i.set_hidden(true)
			i.queue_free()


func itemsinventory():
	
	var button
	var array = []
	var tempitem
	
	for i in globals.itemdict.values():
		if i.amount < 1 || i.type in ['gear','dummy']:
			continue
		array.append(i)
	array.sort_custom(globals.items,'sortitems')
	
	for i in array:
		button = get_node("ScrollContainer/GridContainer/Button").duplicate()
		button.set_hidden(false)
		button.get_node('number').set_text(str(i.amount))
		button.get_node("Label").set_text(i.name)
		button.get_node("info").connect("pressed",self,'info',[button])
		button.get_node("discard").connect("pressed",self,'discard',[button])
		button.get_node("move").connect("pressed",self,'movetobackpack',[button])
		if i.type != 'potion':
			button.get_node("use").set_hidden(true)
		else:
			button.get_node("use").connect("pressed",self,'use',[button])
		button.set_meta('item', i)
		button.set_meta("number", i.amount)
		button.set_meta("category", i.type)
		if i.icon != null:
			button.get_node("icon").set_texture(i.icon)
		itemgrid.add_child(button)
	array.clear()
		
	for i in globals.state.unstackables.values():
		if (i.owner != null && str(i.owner) != 'backpack') && globals.state.findslave(i.owner) == null && i.owner != globals.player.id:
			i.owner = null
		if i.owner != null:
			continue
		var entryexists = false
		for k in array:
			if k.size() > 0 && k[0].code == i.code && str(k[0].effects) == str(i.effects) :
				k.append(i)
				entryexists = true
				break
		if entryexists == false:
			array.append([])
			array[array.size()-1].append(i)
		
	for i in array:
		button = get_node("ScrollContainer/GridContainer/Button").duplicate()
		button.set_hidden(false)
		button.get_node('number').set_text(str(i.size()))
		button.get_node("Label").set_text(i[0].name)
		button.get_node("info").connect("pressed",self,'info',[button])
		button.get_node("discard").connect("pressed",self,'discard',[button])
		button.get_node("move").connect("pressed",self,'movetobackpack',[button])
		button.get_node("use").connect("pressed",self,'use',[button])
		button.get_node("use").set_tooltip("Equip")
		button.set_meta('item', i[0])
		button.set_meta("itemarray", i)
		button.set_meta("number", i.size())
		button.set_meta("category", 'gear')
		if i[0].enchant != '':
			button.get_node("Label").set('custom_colors/font_color', Color(0,0.5,0))
		if i[0].icon != null:
			button.get_node("icon").set_texture(load(i[0].icon))
		itemgrid.add_child(button)

func itemsbackpack():
	var itemgrid = get_node("ScrollContainer/GridContainer")
	var button
	var array = []
	var items = false
	var tempitem
	for i in globals.state.backpack.stackables:
		tempitem = globals.itemdict[i]
		button = get_node("ScrollContainer/GridContainer/Button").duplicate()
		get_node("ScrollContainer/GridContainer").add_child(button)
		button.set_hidden(false)
		button.get_node("Label").set_text(tempitem.name)
		button.get_node("info").connect("pressed",self,'info',[button])
		button.get_node("discard").connect("pressed",self,'discard',[button])
		button.get_node("move").connect("pressed",self,'movefrombackpack',[button])
		button.get_node("number").set_text(str(globals.state.backpack.stackables[i]))
		if tempitem.type != 'potion':
			button.get_node("use").set_hidden(true)
		else:
			button.get_node("use").connect("pressed",self,'use',[button])
		if tempitem.icon != null:
			button.get_node("icon").set_texture(tempitem.icon)
		button.set_meta("item", tempitem)
		button.set_meta("category", tempitem.type)
	array.clear()
	for i in globals.state.unstackables.values():
		if (i.owner != null && str(i.owner) != 'backpack') && globals.state.findslave(i.owner) == null && i.owner != globals.player.id:
			i.owner = null
		if str(i.owner) != 'backpack':
			continue
		var entryexists = false
		for k in array:
			if k.size() > 0 && k[0].code == i.code && str(k[0].effects) == str(i.effects) :
				k.append(i)
				entryexists = true
				break
		if entryexists == false:
			array.append([])
			array[array.size()-1].append(i)
	
	for i in array:
		
		button = get_node("ScrollContainer/GridContainer/Button").duplicate()
		button.set_hidden(false)
		button.get_node('number').set_text(str(i.size()))
		button.get_node("Label").set_text(i[0].name)
		button.get_node("info").connect("pressed",self,'info',[button])
		button.get_node("discard").connect("pressed",self,'discard',[button])
		button.get_node("move").connect("pressed",self,'movefrombackpack',[button])
		button.get_node("use").connect("pressed",self,'use',[button])
		button.get_node("use").set_tooltip("Equip")
		button.set_meta('item', i[0])
		button.set_meta("itemarray", i)
		button.set_meta("number", i.size())
		button.set_meta("category", 'gear')
		if i[0].enchant != '':
			button.get_node("Label").set('custom_colors/font_color', Color(0,0.5,0))
		if i[0].icon != null:
			button.get_node("icon").set_texture(load(i[0].icon))
		get_node("ScrollContainer/GridContainer").add_child(button)


func slavelist():
	var button
	for i in get_node("slavelist/GridContainer").get_children():
		if i.get_name() != 'Button':
			i.set_hidden(true)
			i.queue_free()
	for i in [globals.player] + globals.slaves:
		if i.away.duration != 0:
			continue
		button = get_node("slavelist/GridContainer/Button").duplicate()
		get_node("slavelist/GridContainer").add_child(button)
		button.set_hidden(false)
		var text = i.name_long() + " [color=yellow]" + i.race + "[/color]"
		if i == globals.player:
			text += " [color=aqua]Master[/color]"
		else:
			text += " " + i.origins.capitalize()
		button.get_node("name").set_bbcode(text)
		button.get_node("hpbar").set_val(float((i.stats.health_cur)/float(i.stats.health_max))*100)
		button.get_node("enbar").set_val(float((i.stats.energy_cur)/float(i.stats.energy_max))*100)
		if i.imageportait != null:
			if File.new().file_exists(i.imageportait) == true:
				button.get_node("portrait").set_texture(load(i.imageportait))
			else:
				i.imageportait = null
		for k in ['sstr','sagi','smaf','send']:
			button.get_node(k).set_text(str(i[k])+ "/" +str(min(i.stats[globals.maxstatdict[k]], i.originvalue[i.origins])))
		button.connect("pressed",self,'selectslave',[button])
		button.set_meta('slave', i)

func selectslave(button):
	var slave = button.get_meta('slave')
	selectedslave = slave
	for i in get_tree().get_nodes_in_group("inventoryslaves"):
		i.set_pressed(i == button)
	slavegear(slave)

var sil = {costume = load("res://files/buttons/inventory/25.png"), underwear = load("res://files/buttons/inventory/26.png"), accessory = load("res://files/buttons/inventory/27.png"), weapon = load("res://files/buttons/inventory/29.png"), armor = load("res://files/buttons/inventory/28.png")}

func slavegear(slave):
	var text = ''
	text += "Health: " + str(slave.health) + "/" + str(slave.stats.health_max) + '\nEnergy: ' + str(slave.energy) + '/' + str(slave.stats.energy_max) + '\n'
	for i in slave.gear:
		if slave.gear[i] == null:
			continue
		var tempitem = globals.state.unstackables[slave.gear[i]]
		for k in tempitem.effects:
			text += k.descript + "\n"
	get_node("gearpanel/RichTextLabel").set_bbcode(text)
	get_node("gearpanel").set_hidden(false)
	var sex
	var race
	sex = slave.sex.replace('futanari','female')
	race = slave.race.replace("Beastkin ",'').replace("Halfkin ", '').to_lower()
	if race in ['dark elf', 'drow']:
		race = 'elf'
	get_node("gearpanel/charframe").set_texture(shades[race][sex])
	
	
	for i in ['weapon','costume','underwear','armor','accessory']:
		if slave.gear[i] == null:
			get_node("gearpanel/"+i+"/unequip").set_hidden(true)
			get_node("gearpanel/"+i+"/enchant").set_hidden(true)
			get_node("gearpanel/"+i).set_normal_texture(sil[i])
		else:
			get_node("gearpanel/"+i+"/unequip").set_hidden(false)
			get_node("gearpanel/"+i).set_normal_texture(load(globals.state.unstackables[slave.gear[i]].icon))
			get_node("gearpanel/"+i+"/enchant").set_hidden(globals.state.unstackables[slave.gear[i]].enchant == '')

func use(button):
	if selectedslave == null:
		get_tree().get_current_scene().infotext("No slave selected")
		return
	var item = button.get_meta('item')
	var tempitem
	var slave = selectedslave
	globals.items.slave = slave
	if item.code in ['aphrodisiac', 'regressionpot', 'miscariagepot','amnesiapot','stimulantpot','deterrentpot'] && slave == globals.player:
		get_parent().popup(slave.dictionary(globals.items.call(item.effect)))
		return
	if item.type == 'potion':
		slave.metrics.item += 1
		if item.code != 'minoruspot' && item.code != 'majoruspot' && item.code != 'hairdye':
			get_tree().get_current_scene().popup(slave.dictionary(globals.items.call(item.effect)))
			slave.toxicity += item.toxicity
			item.amount -= 1
		else:
			call(item.effect)
		button.get_node('number').set_text(str(item.amount))
		if item.amount <= 0:
			button.set_hidden(true)
	else:
		if item.reqs != null:
			if globals.items.checkreqs(item) == false:
				get_parent().infotext(slave.dictionary("$name does not pass the requirements for ") + item.name, 'red')
				return
		if slave.gear[item.type] != null:
			tempitem = globals.state.unstackables[slave.gear[item.type]]
			for i in tempitem.effects:
				if i.type == 'onequip':
					globals.items.call(i.effect, -i.effectvalue)
			tempitem.owner = null
		slave.gear[item.type] = item.id
		item.owner = slave.id
		for i in item.effects:
			if i.type == 'onequip':
				globals.items.call(i.effect, i.effectvalue)
		var itemarray = button.get_meta('itemarray')
		itemarray.erase(item)
		button.get_node('number').set_text(str(itemarray.size()))
		if itemarray.size() <= 0:
			button.set_hidden(true)
		updateitems()
		calculateweight()
		slavegear(slave)

func info(button):
	get_node("iteminfo/RichTextLabel").set_bbcode(globals.itemdescription(button.get_meta('item')))
	get_node("iteminfo/TextureFrame").set_texture(button.get_node('icon').get_texture())
	get_node("iteminfo").popup()

func discard(button):
	var item = button.get_meta('item')
	if state == 'inventory' or (item.has('owner') && item.owner != null):
		if item.has('id'):
			var itemarray = button.get_meta('itemarray')
			var tempitem = itemarray[itemarray.size()-1]
			globals.state.unstackables.erase(tempitem.id)
			itemarray.erase(tempitem)
			button.get_node('number').set_text(str(itemarray.size()))
			if itemarray.size() <= 0:
				button.set_hidden(true)
			calculateweight()
		else:
			item.amount -= 1
			button.get_node('number').set_text(str(item.amount))
			if item.amount <= 0:
				button.set_hidden(true)
	elif state == 'backpack':
		globals.state.backpack.stackables[item.code] -= 1
		button.get_node('number').set_text(str(globals.state.backpack.stackables[item.code]))
		if globals.state.backpack.stackables[item.code] <= 0:
			globals.state.backpack.stackables.erase(item.code)
			button.set_hidden(true)
		calculateweight()

func movetobackpack(button):
	var item = button.get_meta('item')
	if item.has('owner') == false:
		item.amount -= 1
		if globals.state.backpack.stackables.has(item.code):
			globals.state.backpack.stackables[item.code] += 1
		else:
			globals.state.backpack.stackables[item.code] = 1
		button.get_node('number').set_text(str(item.amount))
		if item.amount <= 0:
			button.set_hidden(true)
	else:
		var itemarray = button.get_meta('itemarray')
		var tempitem = itemarray[itemarray.size()-1]
		itemarray.erase(tempitem)
		button.get_node('number').set_text(str(itemarray.size()))
		tempitem.owner = 'backpack'
		if itemarray.size() <= 0:
			button.set_hidden(true)
		#globals.state.backpack.unstackables.append(tempitem)
		#globals.state.unstackables.erase(tempitem.id)
	calculateweight()

func movefrombackpack(button):
	var item = button.get_meta('item')
	if item.has('owner') == false:
		item.amount += 1
		globals.state.backpack.stackables[item.code] -= 1
		button.get_node('number').set_text(str(globals.state.backpack.stackables[item.code]))
		if globals.state.backpack.stackables[item.code] <= 0:
			globals.state.backpack.stackables.erase(item.code)
			button.set_hidden(true)
	else:
		var itemarray = button.get_meta('itemarray')
		var tempitem = itemarray[itemarray.size()-1]
		itemarray.erase(tempitem)
		button.get_node('number').set_text(str(itemarray.size()))
		tempitem.owner = null
		if itemarray.size() <= 0:
			button.set_hidden(true)
		
		
#		globals.state.unstackables[str(item.id)].owner = null
#		button.set_hidden(true)
#		globals.state.backpack.unstackables.erase(item)
	calculateweight()



func calculateweight():
	var weight = globals.state.calculateweight()
	get_node("weightmeter/Label").set_text("Weight: " + str(weight.currentweight) + '/' + str(weight.maxweight))
	get_node("weightmeter").set_val((weight.currentweight*10/max(weight.maxweight,1)*10))


func _on_iteminfo_input_event( ev ):
	if ev.is_action("LMB") && ev.is_pressed():
		get_node("iteminfo").set_hidden(true)


func hairdyeeffect():
	get_node("hairchange").popup()
	get_node("hairchange/TextEdit").clear()

func _on_inventoryclose_pressed():
	set_hidden(true)


func _on_haircancel_pressed():
	get_node("hairchange").set_hidden(true)


func _on_hairconfirm_pressed():
	if get_node("hairchange/TextEdit").get_text() == '':
		get_tree().get_current_scene().infotext("Please enter desired hair color")
		return
	if state == 'inventory':
		globals.itemdict.hairdye.amount -= 1
	elif state == 'backpack':
		globals.state.backpack.hairdye -= 1
		if globals.state.backpack.hairdye <= 1:
			globals.state.backpack.erase('hairdye')
	selectedslave.haircolor = get_node("hairchange/TextEdit").get_text()
	updateitems()
	get_node("hairchange").set_hidden(true)

var currentpotion

func minoruseffect():
	var buttons = []
	var text = ''
	currentpotion = 'minoruspot'
	if selectedslave == globals.player:
		text = (selectedslave.dictionary('Choose where would you like to apply Minorus Potion on yourself?'))
	else:
		text = (selectedslave.dictionary('Choose where would you like to apply Minorus Potion on $name?'))
	if selectedslave.asssize != 'flat' && selectedslave.asssize != 'masculine':
		buttons.append(['Butt','applybutt'])
	if selectedslave.titssize != 'flat' && selectedslave.titssize != 'masculine':
		buttons.append(['Breasts','applytits'])
	if !selectedslave.penis in ['none','small']:
		buttons.append(['Penis','applypenis'])
	if selectedslave.balls != 'none' && selectedslave.balls != 'small':
		buttons.append(['Testicles','applytestic'])
	globals.main.dialogue(true, self, text, buttons)

func majoruseffect():
	var buttons = []
	var text = ''
	currentpotion = 'majoruspot'
	if selectedslave == globals.player:
		text = (selectedslave.dictionary('Choose where would you like to apply Majorus Potion on yourself?'))
	else:
		text = (selectedslave.dictionary('Choose where would you like to apply Majorus Potion on $name?'))
	if selectedslave.asssize != 'huge':
		buttons.append(['Butt','applybutt'])
	if selectedslave.titssize != 'huge':
		buttons.append(['Breasts','applytits'])
	if selectedslave.penis != 'big' && selectedslave.penis != 'none':
		buttons.append(['Penis','applypenis'])
	if selectedslave.balls != 'big' && selectedslave.balls != 'none':
		buttons.append(['Testicles','applytestic'])
	globals.main.dialogue(true, self, text, buttons)



func applybutt():
	var text = ''
	globals.main.close_dialogue()
	if currentpotion == 'minoruspot':
		selectedslave.asssize = globals.sizearray[globals.sizearray.find(selectedslave.asssize)-1]
		if selectedslave == globals.player:
			text = selectedslave.dictionary("You apply the Minorus Potion to your butt. A little while later, you notice that it has shrunken in size. ")
		else:
			text = selectedslave.dictionary("You apply the Minorus Potion to $name's butt. A little while later, you notice that it has shrunken in size. ")
	elif currentpotion == 'majoruspot':
		if selectedslave.asssize == 'masculine':
			selectedslave.asssize = globals.sizearray[globals.sizearray.find(selectedslave.asssize)+2]
		else:
			selectedslave.asssize = globals.sizearray[globals.sizearray.find(selectedslave.asssize)+1]
		if selectedslave == globals.player:
			text = selectedslave.dictionary("You apply the Majorus Potion to your butt. A little while later, you notice that it has grown bigger. ")
		else:
			text = selectedslave.dictionary("You apply the Majorus Potion to $name's butt. A little while later, you notice that it has grown bigger. ")
	if state == 'inventory':
		globals.itemdict[currentpotion].amount -= 1
	elif state == 'backpack':
		globals.state.backpack[currentpotion] -= 1
		if globals.state.backpack[currentpotion] <= 1:
			globals.state.backpack.erase(currentpotion)
	selectedslave.toxicity += 30
	globals.main.popup(text)
	updateitems()

func applytits():
	var text = ''
	globals.main.close_dialogue()
	if currentpotion == 'minoruspot':
		selectedslave.titssize = globals.sizearray[globals.sizearray.find(selectedslave.titssize)-1]
		if selectedslave == globals.player:
			text = selectedslave.dictionary("You apply the Minorus Potion to your breasts. A little while later, you notice that they have shrunken in size. ")
		else:
			text = selectedslave.dictionary("You apply the Minorus Potion to $name's breasts. A little while later, you notice that they have shrunken in size. ")
	elif currentpotion == 'majoruspot':
		if selectedslave.titssize == 'masculine':
			selectedslave.titssize = globals.sizearray[globals.sizearray.find(selectedslave.titssize)+2]
		else:
			selectedslave.titssize = globals.sizearray[globals.sizearray.find(selectedslave.titssize)+1]
		if selectedslave == globals.player:
			text = selectedslave.dictionary("You apply the Majorus Potion to your breasts. A little while later, you notice that they have grown bigger. ")
		else:
			text = selectedslave.dictionary("You apply the Majorus Potion to $name's breasts. A little while later, you notice that they have grown bigger. ")
	if state == 'inventory':
		globals.itemdict[currentpotion].amount -= 1
	elif state == 'backpack':
		globals.state.backpack[currentpotion] -= 1
		if globals.state.backpack[currentpotion] <= 1:
			globals.state.backpack.erase(currentpotion)
	selectedslave.toxicity += 30
	updateitems()
	globals.main.popup(text)

func applypenis():
	var text = ''
	globals.main.close_dialogue()
	if currentpotion == 'minoruspot':
		selectedslave.penis = globals.genitaliaarray[globals.genitaliaarray.find(selectedslave.penis)-1]
		if selectedslave == globals.player:
			text = selectedslave.dictionary("You apply the Minorus Potion to your penis. A little while later, you notice that it has shrunken in size. ")
		else:
			text = selectedslave.dictionary("You apply the Minorus Potion to $name's penis. A little while later, you notice that it has shrunken in size. ")
	elif currentpotion == 'majoruspot':
		selectedslave.penis = globals.genitaliaarray[globals.genitaliaarray.find(selectedslave.penis)+1]
		if selectedslave == globals.player:
			text = selectedslave.dictionary("You apply the Majorus Potion to your penis. A little while later, you notice that it has grown bigger. ")
		else:
			text = selectedslave.dictionary("You apply the Majorus Potion to $name's penis. A little while later, you notice that it has grown bigger. ")
	if state == 'inventory':
		globals.itemdict[currentpotion].amount -= 1
	elif state == 'backpack':
		globals.state.backpack[currentpotion] -= 1
		if globals.state.backpack[currentpotion] <= 1:
			globals.state.backpack.erase(currentpotion)
	selectedslave.toxicity += 30
	updateitems()
	globals.main.popup(text)

func applytestic():
	var text = ''
	globals.main.close_dialogue()
	if currentpotion == 'minoruspot':
		selectedslave.balls = globals.genitaliaarray[globals.genitaliaarray.find(selectedslave.balls)-1]
		if selectedslave == globals.player:
			text = selectedslave.dictionary("You apply the Minorus Potion to your balls. A little while later, you notice that they have shrunken in size. ")
		else:
			text = selectedslave.dictionary("You apply the Minorus Potion to $name's balls. A little while later, you notice that they have shrunken in size. ")
	elif currentpotion == 'majoruspot':
		selectedslave.balls = globals.genitaliaarray[globals.genitaliaarray.find(selectedslave.balls)+1]
		if selectedslave == globals.player:
			text = selectedslave.dictionary("You apply the Majorus Potion to your balls. A little while later, you notice that they have grown bigger. ")
		else:
			text = selectedslave.dictionary("You apply the Majorus Potion to $name's balls. A little while later, you notice that they have grown bigger. ")
	if state == 'inventory':
		globals.itemdict[currentpotion].amount -= 1
	elif state == 'backpack':
		globals.state.backpack[currentpotion] -= 1
		if globals.state.backpack[currentpotion] <= 1:
			globals.state.backpack.erase(currentpotion)
	selectedslave.toxicity += 30
	updateitems()
	globals.main.popup(text)





