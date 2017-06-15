extends Node

var spritedict = {
neutral1 = load('res://files/images/aliseneutral1.png'),
happy1 = load('res://files/images/alisehappy1.png'),
wink1 = load('res://files/images/alisewink1.png'),
smile2 = load('res://files/images/alisesmile2.png'),
happy2 = load('res://files/images/alisehappy2.png'),
wink2 = load('res://files/images/alisewink2.png'),
smile3 = load('res://files/images/alisesmile3.png'),
happy3 = load('res://files/images/alisehappy3.png'),
wink3 = load('res://files/images/alisewink3.png'),
}

var textdict = {
loadgreeting = [
{sprite = 'happy1', text = "Pleased to meet you! We might not have met before, but from now I'll be around in case you need some help! I hope we will get along!"},
{text = "Now, to call me up, just hit that question mark at the top!"},
{sprite = 'neutral1', text = 'Not distracting you anymore! Surely, you have more important things to take care of. ', choice = 'close'}
],
introduction = [
{sprite = 'happy1',text = "Welcome, welcome! My name is alise."},
{text = "I'm here to explain you everything you wish to know, hun!", choice = 'intro'},
],
endtutorial = [
{sprite = 'neutral1', text = 'Got you! Not distracting you anymore! '},
{sprite = 'wink3', text = "In case you need me again, hit that question mark at the top!", choice = 'close'},
],
basicstext = [
{sprite = 'happy1', text = 'Hi!'},
],
call = [
{sprite = 'happy2', text = "At your service!"},
{text = "How can I please you?", choice = 'menu'},
],
redress = [
{sprite = 'neutral1', text = "Ahem... This kind of serivce is a bit..."},
{text = "..............Fine, how can I say no to you? Just give me a moment.", funct = 'hide'},
{text = "You like it?", funct = 'unhide'},
{text = "Please, just don't stare too hard. Even I can get embarrassed sometimes. "},
{text = "Let me know what else you would like!", choice = 'menu'}
],
}

var choices = {
intro = [{text = "— Go on", funct = 'basics'}, {text = "— I'm fine for now (skip current section)", funct = ""}, {text = "— No need (skip tutorial)", funct = "endtutorial"}],
close = [{text = "End", funct = 'close'}],
menu = [{text = "I want to ask about...", funct = 'infochoose'}, {text = "I want to see the old help section", funct = "oldhelp"}, {text = "I want you to wear something more revealing", funct = 'alisechange', reqs = 'supporter'},{text = "Nothing", funct = 'close'}]
}

var currentdict setget currentdict_set
var counter
var currentline
var lastline

func _ready():
	set_process_input(true)
	set_process(true)

func _input(event):
	if event.is_action("LMB") && event.is_pressed():
		if get_node("speech/RichTextLabel").get_visible_characters() < get_node("speech/RichTextLabel").get_total_character_count():
			get_node("speech/RichTextLabel").set_visible_characters(get_node("speech/RichTextLabel").get_total_character_count())
		else:
			if lastline != true && currentdict != null:
				advance()

func _process(delta):
	if get_node("speech/RichTextLabel").get_visible_characters() < get_node("speech/RichTextLabel").get_total_character_count():
		get_node("speech/RichTextLabel").set_visible_characters(get_node("speech/RichTextLabel").get_visible_characters() + 2)

func advance():
	show(currentline)
	counter += 1
	if currentdict.size() > counter:
		currentline = currentdict[counter]

func currentdict_set(value):
	lastline = false
	get_node("speech").set_hidden(true)
	currentdict = value
	counter = 0
	currentline = currentdict[0]
	advance()

func show(dict):
	if dict.has('sprite'):
		get_node("tutsprite").set_texture(spritedict[dict.sprite])
		set_process_input(true)
		set_process(true)
		if is_visible() == false:
			set_hidden(false)
			get_parent().get_node("AnimationPlayer").play("aliseshow")
			get_node("response").set_hidden(true)
			if OS.get_name() != "HTML5":
				set_process_input(false)
				set_process(false)
				yield(get_parent().get_node("AnimationPlayer"), 'finished')
				set_process_input(true)
				set_process(true)
	if dict.has('text'):
		get_node("speech").set_hidden(false)
		get_node("speech/RichTextLabel").set_visible_characters(0)
		get_node("speech/RichTextLabel").set_bbcode('[center][color=yellow]' + globals.player.dictionary(dict.text) + '[/color][/center]')
	else:
		get_node("speech").set_hidden(true)
	if dict.has('funct'):
		call(dict.funct)
	if dict.has('choice'):
		showchoice(dict.choice)
	else:
		nochoice()

func showchoice(arg):
	lastline = true
	var skip = false
	var choice = choices[arg]
	for i in get_node("response/VBoxContainer").get_children():
		if i != get_node("response/VBoxContainer/Button"):
			i.set_hidden(true)
			i.queue_free()
	get_node("response").set_hidden(false)
	for i in choice:
		if i.has('reqs'):
			skip = false
			for k in i.reqs:
				if k == 'supporter' && globals.state.supporter == false:
					skip = true
		if skip == true:
			continue
		var newbutton = get_node("response/VBoxContainer/Button").duplicate()
		newbutton.set_hidden(false)
		get_node("response/VBoxContainer").add_child(newbutton)
		newbutton.set_text(i.text)
		newbutton.connect("pressed",self,i.funct)



func nochoice():
	get_node("response").set_hidden(true)

func hide():
	get_parent().get_node("AnimationPlayer").play_backwards("aliseshow")

func unhide():
	get_parent().get_node("AnimationPlayer").play("aliseshow")

func basics():
	self.currentdict = textdict.basicstext

func oldhelp():
	close()
	get_node("tutsprite").set_as_toplevel(true)
	get_parent().oldglossary()

func alisegreet():
	self.currentdict = textdict.loadgreeting

func endtutorial():
	for i in globals.state.tutorialstate.values():
		i = true
	self.currentdict = textdict.endtutorial

func callalise():
	self.currentdict = textdict.call

func alisechange():
	self.currentdict = textdict.redress

func close():
	get_parent().get_node("AnimationPlayer").play_backwards("aliseshow")
	get_node("response").set_hidden(true)
	get_node("speech").set_hidden(true)
	if OS.get_name() != "HTML5":
		yield(get_parent().get_node("AnimationPlayer"), 'finished')
	set_hidden(true)
	set_process(false)
	set_process_input(false)

