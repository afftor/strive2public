extends Node

var tishasprites = [globals.spritedict.tishahappy, globals.spritedict.tishaneutral, globals.spritedict.tishaangry, globals.spritedict.tishashocked, globals.spritedict.tishanakedhappy, globals.spritedict.tishanakedneutral]
var currentsprite
var characterarray = ['emily','tisha','cali','melissa','dolin','zoe','ayda','yris', 'fairy']
var chardescript = {
emily = "Wimborn's orhpan.",
tisha = "Emily's sister",
cali = "Halfkin wolf girl.",
melissa = "Wimborn's Mage's order boss",
fairy = "Guide of slaver's guild",
dolin = "Shaliq's gnome researcher",
zoe = "Frostford's wolfkin girl",
ayda = "Gorn's dark elf alchemist",
yris = "Gorn's beastkin cat bar girl",
}

func _ready():
	show()

func _on_nextsprite_pressed():
	var temp = tishasprites.find(get_node("TextureFrame").get_texture())+1
	if temp >= tishasprites.size():
		temp = 0
	get_node("TextureFrame").set_texture(tishasprites[temp])

func show():
	
	for i in get_node("VBoxContainer").get_children():
		if i != get_node("Button"):
			i.set_hidden(true)
			i.queue_free()
	
	for i in characterarray:
		var newbutton = get_node("VBoxContainer/Button").duplicate()
		newbutton.set_text(i.capitalize())
		newbutton.set_hidden(false)
		newbutton.connect('pressed', self, 'selectchar', [i])
		get_node("VBoxContainer").add_child(newbutton)

func selectchar(name):
	var text = ''
	get_node("RichTextLabel").set_bbcode(text)



