extends Node

var selectedcategory
var selectedupgrade

var categories = {
mansion = {upgrades = ['mansioncommunal','mansionpersonal','mansionbed', 'mansionluxury']},
facilities = {upgrades = ['mansionalchemy', 'mansionlibrary', 'mansionkennels', 'mansionnursery', 'mansionlab']},
jail = {upgrades = ['jailcapacity','jailtreatment','jailincenses']},
storage = {upgrades = ['foodcapacity', 'foodpreservation']},
farm = {upgrades = ['farmcapacity', 'farmhatchery', 'farmtreatment']},
}

var purchaseupgrade

func _ready():
	purchaseupgrade = get_node("upgradepanel/purchaseupgrade")
	purchaseupgrade.connect("pressed",self,'purchasconfirm')
	for i in get_node("categories/VBoxContainer").get_children():
		if i.get_type() == "Button":
			i.connect("pressed",self,'categoryselect', [i])

func show():
	get_tree().get_current_scene()._on_mansion_pressed()
	if OS.get_name() != 'HTML5' && globals.rules.fadinganimation == true:
		yield(get_tree().get_current_scene(), 'animfinished')
	set_hidden(false)
	get_node("upgradepoints").set_text("Free upgrade points:"+str(globals.resources.upgradepoints))
	selectedupgrade = null
	selectedcategory = null
	get_node("categories/VBoxContainer/farm").set_hidden(globals.state.farm < 3)
	get_node("upgradepanel").set_hidden(true)
	for i in get_node("upgrades/VBoxContainer").get_children():
		if i != get_node("upgrades/VBoxContainer/button"):
			i.set_hidden(true)
			i.queue_free()
	for i in get_node("categories/VBoxContainer").get_children():
		if i != get_node("categories/VBoxContainer/Label"):
			i.set_pressed(false)

func categoryselect(button):
	selectedcategory = button
	for i in get_node("categories/VBoxContainer").get_children():
		if i != button && i.get_type() != 'Label':
			i.set_pressed(false)
	button.set_pressed(true)
	for i in get_node("upgrades/VBoxContainer").get_children():
		if i != get_node("upgrades/VBoxContainer/button"):
			i.set_hidden(true)
			i.queue_free()
	var category = button.get_name()
	selectedupgrade = button
	for i in categories[category].upgrades:
		var upgrade = globals.mansionupgradesdict[i]
		var newbutton = get_node("upgrades/VBoxContainer/button").duplicate()
		var currentupgradelevel = globals.state.mansionupgrades[upgrade.code]
		get_node("upgrades/VBoxContainer").add_child(newbutton)
		newbutton.set_text(upgrade.name)
		if upgrade.levels == currentupgradelevel:
			newbutton.set('custom_colors/font_color', Color(0,1,0))
			newbutton.set('custom_colors/font_color_hover', Color(0,1,0))
			newbutton.set('custom_colors/font_color_pressed', Color(0,1,0))
		newbutton.set_hidden(false)
		newbutton.set_meta("upgrade", upgrade)
		newbutton.connect("pressed",self,'upgradeselected',[upgrade])

var alchemy1 = ['aphrodisiac','hairgrowthpot','amnesiapot','lactationpot','miscariagepot','stimulantpot','deterrentpot']
var alchemy2 = ['oblivionpot','oblivionpot','minoruspot','majoruspot','aphroditebrew']

func upgradeselected(upgrade):
	var text = ''
	var noprice = false
	var canpurchase = true
	var currentupgradelevel = globals.state.mansionupgrades[upgrade.code]
	var cost
	var limit = upgrade.levels
	get_node("upgradepanel").popup()
	for i in get_node("upgrades/VBoxContainer").get_children():
		if i != get_node("upgrades/VBoxContainer/button") && i.get_meta('upgrade') != upgrade:
			i.set_pressed(false)
	text = upgrade.description
	if upgrade.code in ['mansioncommunal', 'mansionpersonal','mansionbed','jailcapacity'] && globals.state.nopoplimit == true:
		limit = 999
		
	if limit == 1:
		if currentupgradelevel == 1:
			noprice = true
			canpurchase = false
			text += "\n[color=green]This upgrade is already purchased.[/color]"
	else:
		if currentupgradelevel < limit:
			if currentupgradelevel >= 1 && upgrade.has("description2"):
				text = upgrade.description2
			text += "\n\nCurrent level: " + str(currentupgradelevel) + "/" + str(limit)
		else:
			noprice = true
			canpurchase = true
			text += "\n\n[color=green]This improvement is already purchased.[/color]"
	purchaseupgrade.set_meta('upgrade',upgrade)
	
	if upgrade.has("valuename"):
		text += "\n\n\t\t\t\t" + upgrade.valuename + '\nCurrent level: '
		if upgrade.has("valuenumber"):
			text += upgrade.valuenumber[currentupgradelevel]
		else:
			text += str(currentupgradelevel)
		if limit > currentupgradelevel:
			text += "\nNext Level: "
			if upgrade.has("valuenumber"):
				text += upgrade.valuenumber[currentupgradelevel+1]
			else:
				text += str(currentupgradelevel+1)
	if !noprice:
		if typeof(upgrade.cost) == TYPE_INT:
			cost = upgrade.cost
		else:
			cost = upgrade.cost[currentupgradelevel]
		purchaseupgrade.set_meta('cost', cost)
		text += "\n\nPrice: [color=yellow]" + str(cost) + '[/color]'
		text += "\n\nRequired Upgrade Points: " + str(upgrade.pointscost)
		if globals.resources.gold < cost || globals.resources.upgradepoints < upgrade.pointscost:
			canpurchase = false
	get_node("upgradepanel/RichTextLabel").set_bbcode(text)
	
	
	if canpurchase == false || noprice:
		purchaseupgrade.set_disabled(true)
	else:
		purchaseupgrade.set_disabled(false)

func _on_cancelupgrade_pressed():
	get_node("upgradepanel").set_hidden(true)

func purchasconfirm():
	var upgrade = purchaseupgrade.get_meta("upgrade")
	var currentupgradelevel = globals.state.mansionupgrades[upgrade.code]
	var cost = purchaseupgrade.get_meta("cost")
	if upgrade.code == 'mansionalchemy':
		if currentupgradelevel == 0:
			for i in alchemy1:
				globals.itemdict[i].unlocked = true
		elif currentupgradelevel == 1:
			for i in alchemy2:
				globals.itemdict[i].unlocked = true
	globals.resources.gold -= cost
	globals.resources.upgradepoints -= upgrade.pointscost
	globals.state.mansionupgrades[upgrade.code] += 1
	categoryselect(selectedcategory)
	upgradeselected(upgrade)
	#get_node("upgradepanel").set_hidden(true)
	#show()
