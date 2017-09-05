extends Node

onready var undress = get_node("undress")
onready var sprite = get_node("TextureFrame")
onready var charlist = get_node("charlist/VBoxContainer")
onready var eventlist = get_node("eventslist/events")

func _ready():
	show()

func _on_nextsprite_pressed():
	var temp

func show():
	undress.set_hidden(true)
	sprite.set_texture(null)
	get_node("RichTextLabel").set_bbcode('')
	for i in eventlist.get_children():
		if i != eventlist.get_node("Button"):
			i.set_hidden(true)
			i.queue_free()
	for i in charlist.get_children():
		if i != charlist.get_node("Button"):
			i.set_hidden(true)
			i.queue_free()
	
	var array = []
	for i in globals.charactergallery.values():
		array.append(i)
	array.sort_custom(globals, 'sortbyname')
	
	for i in array:
		var newbutton = charlist.get_node("Button").duplicate()
		if i.unlocked == false:
			newbutton.set_text("???")
			newbutton.set_disabled(true)
		else:
			newbutton.set_text(i.name.capitalize())
		newbutton.set_hidden(false)
		newbutton.set_meta('char', i)
		newbutton.connect('pressed', self, 'selectchar', [newbutton])
		charlist.add_child(newbutton)


func selectchar(button):
	var char = button.get_meta('char')
	var text = '[center]' + char.name + '[/center]\n\n' + char.descript
	get_node("RichTextLabel").set_bbcode(text)
	for i in charlist.get_children():
		if i.is_pressed() && i != button:
			i.set_pressed(false)
	button.set_pressed(true)
	if char.sprite != 'null':
		sprite.set_texture(globals.spritedict[char.sprite])
		get_node("noimage").set_hidden(true)
	else:
		sprite.set_texture(null)
		get_node("noimage").set_hidden(false)
	undress.set_hidden(false)
	undress.set_pressed(false)
	if char.naked == 'null' || char.nakedunlocked == false:
		undress.set_disabled(true)
	else:
		undress.set_disabled(false)
		undress.set_meta('naked', globals.spritedict[char.naked])
		undress.set_meta('clothed', globals.spritedict[char.sprite])
	for i in eventlist.get_children():
		if i != eventlist.get_node("Button"):
			i.set_hidden(true)
			i.free()
	for i in char.scenes:
		var newbutton = eventlist.get_node("Button").duplicate()
		newbutton.set_hidden(false)
		newbutton.set_tooltip(i.text)
		if i.unlocked == true:
			newbutton.set_text(i.name)
			newbutton.connect("pressed",self, 'sceneselected', [i.code])
		else:
			newbutton.set_text("???")
			newbutton.set_disabled(true)
		eventlist.add_child(newbutton)
	if eventlist.get_children().size() == 1:
		var label = Label.new()
		label.set_text("No scenes exist")
		eventlist.add_child(label)

func sceneselected(scene):
	globals.events.sexscene(scene)



func _on_undress_pressed():
	if undress.is_pressed() == true:
		sprite.set_texture(undress.get_meta("naked"))
	else:
		sprite.set_texture(undress.get_meta("clothed"))


func _on_close_pressed():
	set_hidden(true)
