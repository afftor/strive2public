extends Node



var pieces = {
body = {
nor = load("res://files/images/alise/bodynormal.png"), 
nornaked = load("res://files/images/alise/bodynormalnude.png"),
pos = load("res://files/images/alise/bodypose.png"),
posnaked = load("res://files/images/alise/bodyposenude.png"),
alt = load("res://files/images/alise/bodyalt.png"),
altnaked = load("res://files/images/alise/bodyaltnude.png"),
},
face = {
hap1 = load("res://files/images/alise/facehappy1.png"), 
hap2 = load("res://files/images/alise/facehappy2.png"),
hap3 = load("res://files/images/alise/facehappy3.png"),
neu1 = load("res://files/images/alise/faceneutral1.png"),
neu2 = load("res://files/images/alise/faceneutral2.png"),
nes1 = load("res://files/images/alise/faceneutralside1.png"),
sid1 = load("res://files/images/alise/faceside1.png"),
sid2 = load("res://files/images/alise/faceside2.png"),
smi1 = load("res://files/images/alise/facesmile1.png"),
smi2 = load("res://files/images/alise/facesmile2.png"),
smi3 = load("res://files/images/alise/facesmile3.png"),
smh3 = load("res://files/images/alise/facesmilehappy3.png"),
win1 = load("res://files/images/alise/facewink1.png"),
win2 = load("res://files/images/alise/facewink2.png"),
win3 = load("res://files/images/alise/facewink3.png"),

}
}

#nor - normal, pos = pose, alt = alt 
#hap = happy, neu = neutral, sid = side, smi = smile, win = wink


var textdict = {
loadgreeting = [
{sprite = 'norhap', text = "Pleased to meet you! We might not have met before, but from now I'll be around in case you need some help! I hope we will get along!"},
{text = "Now, to call me up, just hit that question mark at the top!"},
{sprite = 'pos', text = 'Not distracting you anymore! Surely, you have more important things to take care of. '},
{funct = 'close'}
],
introduction = [
{sprite = 'norhap',text = "My pleasure to meet you! You can call me Alise, and starting today I’ll be helping you out with this lengthy adventure! "},
{text = "I’m here to teach you the basic functions needed to be successful within this realm.",  choice = 'intro'},
],
endtutorial = [
{sprite = 'norneu', text = 'Got you! Not distracting you anymore! '},
{sprite = 'poswin', text = "In case you need me again, hit that question mark at the top!"},
{funct = 'close'},
],
basicstext = [
{sprite = 'poshap', text = "Ahhh, the advantages by owning your own estate, so many possibilities are now available.  It feels amazing doesn't it?"},
{text = "Please keep in mind that you are responsible for yourself, the estate, and its residents.  Please take care of them.  If you do, they will take care of you. "},
{text = "Your main goal is survival it its truest form. To do so you need to make a steady income and stockpile basic supplies such as food to which you will need on a daily basis. "},
{sprite = 'poswin',text = "You can find your current Money and Food stock in the panel at the top of the screen. "},
{text = 'To earn food and income you will need to assign your servants to various occupations, then end the current day by clicking the button at the bottom of the screen or by pressing your "F" key.'},
{sprite = 'althap',text = "You can see the current available servants you have on the right hand side of screen. "},
{text = "Once you are familiar with your new abode and the depth of it, feel free to leave it and explore your surroundings. "},
{funct = 'closeorcont'},
],
slavetext = [
{sprite = 'althap', text = "You'd " + ' like to get intimate with your servants? Would you like me to give you the "lowdown" on this subject?',choice = 'slave'}
],
slavechar = [
{sprite  = 'poswin',text = "Everyone is different, imagine that!"},
{text = "Seriously, if you didn't know that... forget it.  Let's continue with the topic."},
{sprite = 'norhap', text = "There are two attributes, Mental and Physical, which are deciding factors in how servants perform and react to the variety of things you put them through."},
{text = "The Mental stats consist of [color=aqua]Courage[/color], [color=aqua]Confidence[/color], [color=aqua]Wit[/color], and [color=aqua]Charm[/color].  The higher those are, the better servants will perform their tasks and jobs."},
{text = "Those stats could also play against you if you're servants are not happy or rebelling against you.  In other words, their high aptitude may push them further away from you."},
{text = "The Physical stats are way more important when regarding combat. They are pretty self-explanatory.  We can talk about them later if you need more explanation. "},
{text = "Lastly, your servants will gain experience from their actions and from combat, battling your enemies.  When a servant gains a level they also gain extra skill points which you can assign at a later time.", choice = 'slave'},
],
slavecond = [
{sprite = 'norwin', text = "There are three things you need to have knowledge of about your servants.  These are: Obedience, Stress and Loyalty."},
{text = "All of these are important. Let's start off with Obedience.  You simply can't force a servant to do work unless you  cater to them or savagely control them.  A disobedient servant is a recipe for disaster as they can refuse to follow orders, publicly cause discord, or escape your control. "},
{sprite = 'poshap', text = "Obedience can generally be raised by your interactions with the servant and the punishments you hand out to them. However, don't overdo punishments or overpraise your pets as that can cause disobedience."},
{text = 'If you are an effective master, you will understand how to hand out just enough punishment and praise to keep your pets "in line".'},
{text = "Stress is the gauge which shows a servant's reaction to recent events happening to them. A high stress can cause mental and emotional scarring to a servant and will impede your progress with them."},
{text = "Lastly, Loyalty is the long-term affection servants hold for you, some call it 'love' and some call it infatuation.  You can call it whatever you wish to. ", choice = 'slave'},
],
slavegrade = [
{text = "All servants have specific grade ratings assigned to them. This grade determines what their mental potential is and also adjust the expectations from their master."},
{text = "High Grade rated servants are nice to have. They make for better workers, generally. However, be prepared to give them a personal room or special attention as most dislike the community rooms and also have certain requirements to maintain their higher pedigree."},
{text = "Lower Grade rated servants are more obedient and less demanding of their masters.  This makes them perfect as a starting pet."},
{text = "Then again, you can always adjust Grades at the Slavers Guild, for a price, if you should find slaves you want to start upgrade or downgrade.  Between those choices lowering a Grade rating is much cheaper.", choice = 'slave'},
],
slavework = [
{text = "It's entirely up to you, how your servants spend their free time! Isn't it great? "},
{text = "By taking part in various daily occupations they will be able to earn you food, gold and maybe something else. "},
{text = "However, not every occupation can be picked up by anyone, some have very strict requirements. "},
{text = "By progressing through the story you will be able to unlock more interesting places and occupations too, so keep your eyes open!"},
{text = "Location related tasks will affect servant's affiliation to that location and make them also adopt that location's view on you."},
{text = "I.E. if they work at local town, which hates you, they will also grow to dislike you!", choice = 'slave'},
],
slavesex = [
{sprite = 'possid',text = "I know that gleam in your eye all too well. You are curious about sex and procreation?"},
{text = "Sexuality is not only fun; it is a way of life.  Not only that, it also is your main tool to produce mana for your needs. "},
{text = "Firstly, you'll need to unlock it by propositioning your servant... or you could use force.  However, the latter option might not be as appealing to them and may have a detrimental effect."},
{text = "The stats that affect this are Obedience, Loyalty, and Lust.  If these stats are high enough, they may accept your proposal. "},
{text = "This will open up a whole new menu of choices that you can earn over the course of your sexual escapades with your servant. Lust makes them more willing to try new things in this department."},
{text = "Through sexual activities you gain Affection Points which you can be used to unlock new actions."},
{text = "These Affection Points can be gained in numerous ways by having frequent intimate interactions being the most effective. "},
{text = "Please keep in mind though, sexual actions will drain you and your servant's energy.  Unlike you, your servant recovers energy slower. "},
{text = "Having vaginal intercourse can and will get your ladies pregnant.  Keep this in mind while choosing specific actions! Taking care of your offspring isn't something you should take lightly."},
{text = "Don't think that because you aren't sexually active with your servant doesn't mean that they aren't sexually active. "},
{text = "Even if you don't touch them, they still can get into naughty situations and masturbate here and there. ", choice = 'slave'},
],
slaveend = [
{sprite = 'possmi', text = "In case you forget anything, don't hesitate to ask!"}, 
{funct = 'closeorcont'}
],
jail = [
{sprite = 'norhap', text = "It is a bit grim here isn't it? It is a bit grim here isn't it? You didn’t expect a resort, did you? "},
{text = "This is your Jail and it allows you to imprison bad people or those that you wish to become a slave of yours. "},
{text = "Being locked behind bars and shackled to a wall is not very pleasant for most humanoids, but that's exactly what helps in the creation of a servant out of a hostile captive.  "},
{text = "Some of these servants may still carry a grudge for their initial incarceration even after you release them to servant duties.  There are other magical means that could allow one to forget the jail time they served.  "},
{text = "You can also use this area to punish your unruly servants.  You can perform some forms of bondage in this area in order to make those here more subservient."},
{text = "In order to take advantage of this place you will have to establish a Jailer.  A Jailer is pretty much a guard that holds the keys to the Jail and makes sure that all prisoners have some form of basic care."},
{text = "Naturally, anyone within the Jail won't be able to escape or cause any sort of mischief.  Please remember this because it can come in handy from time to time. "},
{funct = 'closeorcont'},
],
alchemy = [
{sprite = 'norhap', text = "This is a pretty cool place; don't you think?  All the beakers, flasks, vials, and magical ingredients is almost intoxicating! "},
{text = "Well, to be honest, if you didn't know what alchemy is then I will give you a basic "+ ' "run-down".' + "  You introduce ingredients to other types of ingredients in order to gain a desired effect."},
{text = "An ingredient is an herb or substance and can be found at stores or while exploring the world."},
{text = "In addition, some substances can be gained from performing lewd acts with specific races.  I've also heard, but can't confirm myself, that chances are higher with the magically gifted!"},
{text = "Many potions are very convenient for your daily tasks, so keep an eye out for the possibilities!"},
{text = "Lastly, potions are considered wild magic and will build up a magical" +  ' "toxicity" '+", if that is what you want to call it, in those that consume them.  This can produce wild, probably negative effects, that affect the health and well-being of those consumers. "},
{text = "Please use your discretion and great care should you use them."},
{funct = 'closeorcont'},
],
lab = [
{sprite = 'norhap', text = "Ah, the sweet smell of science!  Are you about showing your intelligence?  That is quite admirable attribute to have!"},
{text = "Actually, the Laboratory is more practical than simply research.  A laboratory will allow you to physically modify your servants to your specific tastes or needs!"},
{text = "All this sounds great, doesn't it?  However, the cost is pricey and an operation will add undesired stress to your servant undergoing the changes."},
{text = "First off, you'll need a lab assistant who will be maintaining the daily operations. A skilled assistant will help with operation costs significantly, so choose wisely!"},
{ text = "Ah, the sweet smell of science!"},
{funct = 'closeorcont'},
],
farm = [
{sprite = 'nornes',text = "A farm, not the kind of place I prefer to stay in.  I guess it's more a 'Dairy', truth be told."},
{text = "However, it does have a purpose it rightly serves.  This place can net you some serious income provided you follow some basic guidelines.  Let me briefly explain these."},
{text = "First off, a farm manager is a must and will be in charge of caring for the... *ahem*... cattle. Their individual skill will define the overall income of this operation."},
{text = "In general, the servants you put here will determine your prosperity, depending on their relating qualities. "},
{text = "I'm sure you'll be able to figure out the rest on your own, so if you'll excuse me..."},
{funct = 'closeorcont'},
],
outside = [
{sprite = 'norhap', text = "Starving for some fresh air?  Do you want to explore?  Just wanting to stretch your legs?  Regardless of your reasons, it’s always a good practice to get familiar with your surroundings in any situation."},
{text = "While you're outside you can visit shops and the guild, find new people, discover and complete quests, or locate new servants.  The choice is purely up to you."},
{text = "You can return to your mansion any time you desire, just as long as you're not caught up in some event. "},
{text = "Go out and explore, see what you may find. "},
{funct = 'closeorcont'},
],
combatintro = [
{sprite = 'norsid', text = "Phew... jeez, running all the way here was really exhausting. "},],
combat = [
{sprite = 'norhap', text = "A few things will happen here in the wilds. The bulk of it revolves around your party fighting your enemies."},
{text = "If you are fighting against sentient beings, then you may be able to capture them and force them into servitude!"},
{text = "Sometimes the enemy gets the upper-hand on you and get the jump on you.  Generally, servants with a high Agility and Wit will be able to prevent such actions by your enemy. "},
{text = "Sometimes you run into typical, innocent people.  Starting a fight with these citizens will cause the local controlling faction's reputation, with you, to drop.  This can cause many significant issues in the future. "},
{text = "When an opposing enemy drops too low they may and probably will try to run.  You can manually send your servants after them to try and intercept those that flee.  "},
{text = "The last opponent standing in combat will always stand their ground and do not need a servant to pursue them. This is notable because you could make the most desired enemy, that you would like to capture, the last one standing.  "},
{text = "When you capture enemies you can decide several fates for them.  Some of these choices are violent, some are vile, some are selfless, and some are simply gains for you.  Although, those you make captives won’t be happy."},
{text = "You also are able to use abilities, that you have learned, during combat.  Keep in mind though that these skills will require energy so it is good practice to keep your energy at a decent level."},
{text = "Regardless, always remember that during combat you can die.  If you do depart this realm as a spirit, it's game over! So do yourself and me a favor and don't die."},
{funct = 'closeorcont'},
],

call = [
{sprite = 'poshap', text = "At your service!"},
{text = "How can I please you?", choice = 'menu'},
],
redress = [
{sprite = 'nornes', text = "Ahem... This kind of serivce is a bit..."},
{text = "..............Fine, how can I say no to you? Just give me a moment.", funct = ['hide', 'alisenaked']},
{sprite = 'posneu', text = "Do you like it?", funct = ['unhide']},
{text = "Please, just don't stare too hard. Even I can get embarrassed sometimes. "},
{sprite = 'norhap',text = "You want anything else?", choice = 'menu'}
],
redressback = [
{sprite = 'nornes', text = "If you wish so.", funct = ['hide', 'alisenormal']},
{sprite = 'altsmi', text = "Done!", funct = ['unhide']},
{text = "You want anything else?", choice = 'menu'}
],
returntomain = [
{sprite = 'norhap', text = "Any other questions, hun?", choice = 'gamehelp'},
],
bugreport = [
{sprite = 'norneu',text = "Oh, I'm so sorry you happened to come across the bug. Strive is still heavily in development, so please excuse us. "},
{text = "You can report it either at [color=aqua][url=patreon]Patreon[/url][/color], or at [color=aqua][url=itch]itch.io bug report thread[/url][/color]. Click on one of the links to open it in your browser."},
{sprite = 'possmi', text = "Thank you for helping us make game better!", choice = 'help'}
],
helpproject = [
{sprite = 'althap', text = "That's amazing! I'm trully happy to hear, that you enjoy it. " },
{text = "You can support us at [color=aqua][url=patreon]Patreon[/url][/color] and become our literal employer, we also give our supporters access to earlier version and some additional features, make sure to check it out. "},
{text = 'Alternatively, you can donate via [color=aqua][url=irch]Itch.io[/url][/color] page. This platform helps us to easily update and destribute latest versions as well.'},
{sprite = 'poswin', text = "Can't spare any money? We understand, everyone has their hardships. If you could recommend Strive to others or anyhow promote it, we also would really appreciate it!"},
{text = "Lastly, if you want to offer your skills to the project, make sure to visit our [color=aqua][url=blogpost]blogspot[/url][/color] and contact us via striveforpower@gmail.com. ", choice = 'help'},
],
}

var choices = {
intro = [{text = "— Go on (enable tutorial help)", funct = 'basics'}, {text = "— No need (skip tutorial)", funct = "endtutorial"}],
close = [{text = "End", funct = 'close'}],
menu = [{text = "I want to ask about...", funct = 'help'}, {text = "I want to see the old help section", funct = "oldhelp"}, {text = "I want you to wear something more revealing", funct = 'alisechange', reqs = "globals.state.alisecloth != 'naked'"},{text = "I want you to wear your normal costume", funct = 'alisechangeback', reqs = "globals.state.alisecloth != 'normal'"},{text = "Nothing", funct = 'close'}],
slave = [
{text = 'Characteristics', funct = 'slavechar'},
{text = 'Conditions', funct = 'slavecond'},
{text = 'Grade', funct = 'slavegrade'},
{text = "Jobs", funct = 'slavejobs'},
{text = 'Sexuality', funct = 'slavesex'},
{text = 'I know what I need', funct = 'slaveend'},
],
help = [
{text = "Return", funct = "menu"},
{text = "Gameplay", funct = "gamehelp"},
{text = "I want to report a bug...", funct = "bugreport"},
{text = "I want to help this project...", funct = "projecthelp"},
],
gamehelp = [
{text = "Return", funct = "help"},
{text = "Basics", funct = 'basics'},
{text = "Servants", funct = 'slavechoice', reqs = 'globals.state.tutorial.slave == true'},
{text = "Jail", funct = "jail", reqs = 'globals.state.tutorial.jail == true'},
{text = "Alchemy", funct = 'alchemy', reqs = 'globals.state.tutorial.alchemy == true'},
{text = "Laboratory", funct = 'lab', reqs = 'globals.state.tutorial.lab == true'},
{text = "Farm", funct = 'farm', reqs = 'globals.state.tutorial.farm == true'},
{text = "Exploration", funct = 'outside', reqs = 'globals.state.tutorial.outside == true'},
{text = "Combat", funct = 'combat', reqs = 'globals.state.tutorial.combat == true'},
],
}

func bugreport():
	self.currentdict = textdict.bugreport

func projecthelp():
	self.currentdict = textdict.helpproject

var currentdict setget currentdict_set
var counter
var currentline
var lastline
var help = false

signal textshown

func _ready():
	set_process_input(true)
	set_process(true)
	get_node("speech/RichTextLabel").connect("mouse_enter", self, 'stopinput')
	get_node("speech/RichTextLabel").connect("mouse_exit", self, 'startinput')
	
#	starttutorial()

func _input(event):
	if event.is_action("LMB") && event.is_pressed():
		if get_node("speech/RichTextLabel").get_visible_characters() < get_node("speech/RichTextLabel").get_total_character_count():
			get_node("speech/RichTextLabel").set_visible_characters(get_node("speech/RichTextLabel").get_total_character_count())
		else:
			if lastline != true && currentdict != null && (get_node("tutsprite").get_opacity() >= 1 || get_node("tutsprite").get_opacity() <= 0):
				advance()

func _process(delta):
	if get_node("speech/RichTextLabel").get_visible_characters() <= get_node("speech/RichTextLabel").get_total_character_count():
		get_node("speech/RichTextLabel").set_visible_characters(get_node("speech/RichTextLabel").get_visible_characters() + 1)
	if get_node("speech/RichTextLabel").get_visible_characters() >= get_node("speech/RichTextLabel").get_total_character_count():
		emit_signal('textshown')
		set_process(false)

func stopinput():
	set_process_input(false)

func startinput():
	set_process_input(true)

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
	set_process_input(true)
	set_process(true)
	if dict.has('sprite'):
		buildbody(get_node("tutsprite"), dict.sprite)
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
		get_node("speech").set_hidden(false)
		get_node("speech/RichTextLabel").set_visible_characters(0)
		get_node("speech/RichTextLabel").set_bbcode('[color=yellow]' + globals.player.dictionary(dict.text) + '[/color]')
	else:
		get_node("speech").set_hidden(true)
	if dict.has('funct'):
		var array = []
		if typeof(dict.funct) == TYPE_STRING:
			array = [dict.funct] 
		else:
			array = dict.funct
		for i in array:
			call(i)
	if dict.has('choice'):
		if dict.has('text') && OS.get_name() != "HTML5":
			yield(self, 'textshown')
		showchoice(dict.choice)
	else:
		nochoice()

func buildbody(node, sprite):
	var body = sprite.substr(0, 3)
	var face = sprite.substr(3, 6)
	if body == 'nor':
		face += '1'
	elif body == 'pos':
		face += '2'
	elif body == 'alt':
		face += '3'
	if globals.state.alisecloth != 'normal':
		body = body + 'naked'
	node.set_texture(pieces.body[body])
	node.get_node('face').set_texture(pieces.face[face])



func showchoice(arg):
	lastline = true
	var skip = false
	var choice = choices[arg]
	for i in get_node("response/ScrollContainer/VBoxContainer").get_children():
		if i != get_node("response/ScrollContainer/VBoxContainer/Button"):
			i.set_hidden(true)
			i.queue_free()
	get_node("response").set_hidden(false)
	for i in choice:
		skip = false
		if i.has('reqs'):
			if globals.evaluate(i.reqs) == false:
				skip = true
		if skip == true:
			continue
		var newbutton = get_node("response/ScrollContainer/VBoxContainer/Button").duplicate()
		newbutton.set_hidden(false)
		get_node("response/ScrollContainer/VBoxContainer").add_child(newbutton)
		newbutton.set_text(i.text)
		newbutton.connect("pressed",self,i.funct)

func nochoice():
	get_node("response").set_hidden(true)

func hide():
	if OS.get_name() != "HTML5":
		yield(self, 'textshown')
		get_parent().get_node("AnimationPlayer").play_backwards("aliseshow")
	else:
		get_parent().get_node("AnimationPlayer").play_backwards("aliseshow")

func unhide():
	if OS.get_name() != "HTML5":
		yield(self, 'textshown')
		get_parent().get_node("AnimationPlayer").play("aliseshow")
	else:
		get_parent().get_node("AnimationPlayer").play("aliseshow")

func basics():
	globals.state.tutorial.basics = true
	self.currentdict = textdict.basicstext

func starttutorial():
	self.currentdict = textdict.introduction

func menu():
	showchoice('menu')

func gamehelp():
	showchoice('gamehelp')

func slavechoice():
	showchoice('slave')

func help():
	showchoice('help')

func oldhelp():
	close()
	get_node("tutsprite").set_as_toplevel(true)
	get_parent().oldglossary()

func alisegreet():
	self.currentdict = textdict.loadgreeting

func endtutorial():
	for i in globals.state.tutorial:
		globals.state.tutorial[i] = true
	self.currentdict = textdict.endtutorial

func callalise():
	help = true
	self.currentdict = textdict.call

func alisechange():
	if globals.state.supporter == true:
		self.currentdict = textdict.redress
	else:
		get_parent().popup("This function is available only to supporters. Please, apply to [color=aqua][url=patreon]Patreon[/url][/color] to unlock it, or enter your Supporter code in options if you have it. ")

func alisenaked():
	globals.state.alisecloth = 'naked'

func alisenormal():
	globals.state.alisecloth = 'normal'

func alisechangeback():
	self.currentdict = textdict.redressback

func slaveinitiate():
	self.currentdict = textdict.slavetext

func slavechar():
	self.currentdict = textdict.slavechar

func slavecond():
	self.currentdict = textdict.slavecond

func slavegrade():
	self.currentdict = textdict.slavegrade

func slavejobs():
	self.currentdict = textdict.slavework

func slavesex():
	self.currentdict = textdict.slavesex

func slaveend():
	globals.state.tutorial.slave = true
	self.currentdict = textdict.slaveend

func jail():
	globals.state.tutorial.jail = true
	self.currentdict = textdict.jail

func alchemy():
	globals.state.tutorial.alchemy = true
	self.currentdict = textdict.alchemy

func lab():
	globals.state.tutorial.lab = true
	self.currentdict = textdict.lab

func farm():
	globals.state.tutorial.farm = true
	self.currentdict = textdict.farm

func outside():
	globals.state.tutorial.outside = true
	self.currentdict = textdict.outside

func combat():
	globals.state.tutorial.combat = true
	self.currentdict = textdict.combat

func closeorcont():
	if help == true:
		self.currentdict = textdict.returntomain
	else:
		close()

func close():
	help = false
	set_process(false)
	set_process_input(false)
	get_parent().get_node("AnimationPlayer").play_backwards("aliseshow")
	get_node("response").set_hidden(true)
	get_node("speech").set_hidden(true)
	if OS.get_name() != "HTML5":
		yield(get_parent().get_node("AnimationPlayer"), 'finished')
	set_hidden(true)

func _on_RichTextLabel_meta_clicked( meta ):
	if meta == 'patreon':
		OS.shell_open('https://www.patreon.com/maverik')
	elif meta == 'itch':
		OS.shell_open('https://itch.io/t/89635/bug-report-thread')
	elif meta == "blogpost":
		OS.shell_open('http://strivefopower.blogspot.com')

