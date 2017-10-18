extends Node

var mode = 'portrait'
var slave

var portaitsbuilt = false
var portraitspath = "user://portraits/"
var portaitsfolder = 'file://' + OS.get_data_dir() + '/portraits'

func chooseimage():
	if get_node("racelock").is_pressed() == false:
		get_node("search").set_hidden(false)
		get_node("search").set_text("")
	else:
		get_node("search").set_hidden(true)
	popup()
	if portaitsbuilt == false:
		portaitsbuilt = true
		buildportaitlist()
	resort()


func _on_reloadlist_pressed():
	buildportaitlist()

func buildportaitlist():
	var dir = Directory.new()
	var array = []
	var filecheck = File.new()
	if dir.dir_exists(portraitspath) == false:
		dir.make_dir(portraitspath)
	for i in get_node("ScrollContainer/GridContainer").get_children():
		if i.get_name() != "Button":
			i.set_hidden(true)
			i.free()
	for i in globals.dir_contents(portraitspath):
		if !filecheck.file_exists(portraitspath+i):
			array.append(i)
	#array.sort_custom(self, "directoryfirst")
	for i in array:
		var node = get_node("ScrollContainer/GridContainer/Button").duplicate()
		get_node("ScrollContainer/GridContainer").add_child(node)
		node.get_node("Label").set_text(i.replacen('.jpg','').replacen('.png','').replacen('female','F').replacen('male','M'))
		node.set_meta("type", i)
	for i in globals.dir_contents(portraitspath):
		if filecheck.file_exists(portraitspath+i):
			var node = get_node("ScrollContainer/GridContainer/Button").duplicate()
			get_node("ScrollContainer/GridContainer").add_child(node)
			node.get_node("pic").set_texture(load(portraitspath + i))
			node.connect('pressed', self, 'setportrait', [i])
			node.get_node("Label").set_text(i.replacen('.jpg','').replacen('.png','').replacen('female','F').replacen('male','M'))
			node.set_meta("type", i)
	resort()


func resort():
	var strictsearch = get_node("racelock").is_pressed()
	var gender = slave.sex
	var race = slave.race
	var counter = 0
	if gender == 'futanari':
		gender = 'female'
	race = race.replace("Beastkin ", "").replace("Halfkin ", "")

	
	
	
	for i in get_node("ScrollContainer/GridContainer").get_children():
		i.set_hidden(true)
		if i == get_node("ScrollContainer/GridContainer/Button"):
			continue
		if strictsearch == true:
			if i.get_meta('type').findn(race) < 0:
				continue 
		if strictsearch == false && get_node("search").get_text() != '' && i.get_node("Label").get_text().findn(get_node("search").get_text()) < 0:
			continue
		i.set_hidden(false)
		counter += 1
	if counter < 1:
		get_node("noimagestext").set_hidden(false)
	else:
		get_node("noimagestext").set_hidden(true)

func setportrait(path):
	slave.imageportait = (portraitspath + path)
	set_hidden(true)
	updatepage()



func _on_cancelportait_pressed():
	set_hidden(true)


func _on_racelock_pressed():
	chooseimage()
	resort()


func _on_search_text_changed( text ):
	resort()

func _on_removeportrait_pressed():
	slave.imageportait = null
	set_hidden(true)
	updatepage()

func _on_reverseportrait_pressed():
	if slave.unique != null:
		if slave.unique == 'Cali':
			slave.imageportait = 'res://files/images/cali/caliportrait.png'
		elif slave.unique == 'Emily':
			slave.imageportait = "res://files/images/emily/emilyportrait.png"
		elif slave.unique == 'Tisha':
			slave.imageportait = "res://files/images/tisha/tishaportrait.png"
		elif slave.unique == 'Chloe':
			slave.imageportait = "res://files/images/chloe/chloeportrait.png"
		elif slave.unique == 'Yris':
			slave.imageportait = "res://files/images/yris/yrisportrait.png"
		elif slave.unique == 'Maple':
			slave.imageportait = "res://files/images/maple/mapleportrait.png"
		set_hidden(true)
		updatepage()



func _on_addcustom_pressed():
	get_node("FileDialog").popup()

func _on_FileDialog_file_selected( path ):
	var dir = Directory.new()
	var path2 = path.substr(path.find_last('/'), path.length()-path.find_last('/'))
	dir.copy(path, portraitspath + path2)
	buildportaitlist()

func _on_openfolder_pressed():
	OS.shell_open(portaitsfolder)

func updatepage():
	if slave == globals.player:
		get_tree().get_current_scene()._on_selfbutton_pressed()
	else:
		get_tree().get_current_scene().get_node("MainScreen/slave_tab")._on_slave_tab_visibility_changed()
		get_tree().get_current_scene().rebuild_slave_list()
