extends Control

var scenearray = []
var currentscene
onready var player = get_parent().get_node("screenchange/AnimationPlayer")
var timer = Timer.new()
var timer2 = Timer.new()
var stage

var patrons = globals.patronlist.patrons

func _ready():
	currentscene = finale()
	timer.connect("timeout", self, 'advance')
	timer2.connect("timeout", self, 'patronlist')
	set_process_input(true)
	add_child(timer)
	add_child(timer2)
	stage = 'epilogue'
#	launch()
#	advance()

func patronlist():
	var counter = 4
	var linecounter = 0
	var newlabelline
	var newlabel
	var array = []
	for i in get_node("TextureFrame/VBoxContainer").get_children():
		if i.get_name() != 'HBoxContainer':
			i.set_hidden(true)
			i.queue_free()
	for i in patrons:
		if linecounter >= 10 && counter >= 3:
			timer2.set_wait_time(5)
			timer2.start()
		else:
			array.append(i)
			if counter >= 3:
				counter = 0
				newlabelline = get_node("TextureFrame/VBoxContainer/HBoxContainer").duplicate()
				newlabelline.set_hidden(false)
				get_node("TextureFrame/VBoxContainer").add_child(newlabelline)
				linecounter += 1
			counter += 1
			newlabel = newlabelline.get_node("Label"+str(counter))
			newlabel.set_text(i)
			newlabel.set_hidden(false)
	for i in array:
		patrons.erase(i)

func _input(event):
	if player.is_playing():
		return
	if event.is_pressed() && event.is_action("escape") && stage in ['credits','patrons']:
		stage = 'alise'
		advance()
	if event.is_pressed() && (event.is_action("LMB") || event.type == 1):#event.is_action("LMB") &&
		advance()

func launch():
	scenearray.clear()
	scenearray += ["finale","wimborn","gorn","frostford"]
	if globals.state.decisions.has('goodroute'):
		if globals.state.decisions.has("melissanoslave"):
			scenearray.append("melissa")
	else:
		scenearray.append("amberguard")
	scenearray.append("maple")
	scenearray.append("ayda")
	if globals.state.sidequests.emily > 1:
		scenearray.append("emilytisha")
	if globals.state.sidequests.cali > 0:
		scenearray.append("cali")
	if globals.state.sidequests.chloe > 0:
		scenearray.append("chloe")
	if globals.state.sidequests.yris > 0:
		scenearray.append("yris")
	if globals.state.sidequests.zoe > 0:
		scenearray.append("zoe")
	if globals.state.sidequests.ayneris > 0:
		scenearray.append("ayneris")
	currentscene = scenearray[0]
	show(call(currentscene))
	timer.set_wait_time(15)
	timer.start()

func show(dict):
	get_node("background").set_texture(globals.backgrounds[dict.background])
	get_node("textpanel/RichTextLabel").set_bbcode('[color=yellow]'+dict.text+'[/color]')
	if dict.sprite != null:
		get_node("character").set_texture(globals.spritedict[dict.sprite])
	else:
		get_node("character").set_texture(null)
	if dict.has("spriteblack"):
		get_node("character").set_modulate(Color(0.1,0.1,0.1))
	else:
		get_node("character").set_modulate(Color(1,1,1))
	if dict.has('sprite2'):
		get_node("character2").set_texture(globals.spritedict[dict.sprite2])
	else:
		get_node("character2").set_texture(null)
	if dict.has("spriteblack2"):
		get_node("character2").set_modulate(Color(0.1,0.1,0.1))
	else:
		get_node("character2").set_modulate(Color(1,1,1))
	yield(get_tree(), "idle_frame")
	get_node("textpanel/RichTextLabel").set_size(Vector2(get_node("textpanel/RichTextLabel").get_size().width, get_node("textpanel/RichTextLabel").get_v_scroll().get_max()))
	get_node("textpanel").set_size(Vector2(get_node("textpanel").get_size().x, get_node("textpanel/RichTextLabel").get_size().y + 30))

func advance():
	if stage == 'epilogue':
		if scenearray.find(currentscene)+1 >= scenearray.size():
			stage = 'credits'
			player.play("blackout")
			yield(player, 'finished')
			player.play_backwards("blackout")
			advance()
			return
		currentscene = scenearray[scenearray.find(currentscene)+1]
		player.play("blackout")
		yield(player, 'finished')
		show(call(currentscene))
		timer.set_wait_time(15)
		timer.start()
		player.play_backwards("blackout")
	elif stage == 'credits':
		get_node("TextureFrame").set_hidden(false)
		get_node("TextureFrame/RichTextLabel").set_hidden(false)
		stage = 'patrons'
	elif stage == 'patrons':
		if patrons.size() == 0:
			stage = 'alise'
			advance()
		else:
			get_node("TextureFrame").set_hidden(false)
			get_node("TextureFrame/RichTextLabel").set_hidden(true)
			get_node("TextureFrame/RichTextLabel1").set_hidden(false)
			get_node("TextureFrame/VBoxContainer").set_hidden(false)
			patronlist()
	elif stage == 'alise' && get_node("TextureFrame/alise").is_hidden():
		get_node("TextureFrame").set_hidden(false)
		get_node("TextureFrame/RichTextLabel").set_hidden(true)
		get_node("TextureFrame/RichTextLabel1").set_hidden(true)
		get_node("TextureFrame/VBoxContainer").set_hidden(true)
		player.play("blackout")
		yield(player,'finished')
		get_node("TextureFrame/alise").set_hidden(false)
		player.play_backwards("blackout")




func _on_continue_pressed():
	timer.stop()
	timer2.stop()
	get_parent()._on_mansion_pressed()
	get_node("TextureFrame/alise/continue").disconnect("pressed",self,'_on_continue_pressed')
	player.play('blackout')
	yield(player, 'finished')
	get_parent().close_dialogue('instant')
	set_hidden(true)
	player.play_backwards("slowfade")
	#yield(get_parent().get_node("screenchange/AnimationPlayer"), 'finished')



func _on_leave_pressed():
	get_parent().mainmenu()


func finale():
	var dict = {text = '', background = 'mageorder', sprite = null} 
	if globals.state.decisions.has("goodroute"):
		dict.text = "With some effort, The Council was eventually able to restore order around the headquarters following your rescue. A long series of censures, imprisonments and executions followed the event, which would later be called “The Southern Treason”, due to many offenders originating from the southern regions. \n\nYour actions were rewarded and revered among The Order to the point where you were made Headmaster of the Wimborn Order. "
		if globals.state.decisions.has("haderelease"):
			dict.text += "\n\nA few distant perpetrators managed to stay hidden but, due to Melissa's letter, a couple officials, including a few prominent slave traders, were arrested. "
		elif globals.state.decisions.has('hadekeep'):
			dict.text += "\n\nHade was publicly executed and, at your request, Melissa has been entrusted to you as payment for killing your servant; her fate now is in your hands. "
	elif globals.state.decisions.has('badroute'):
		dict.text = "After the reformation, a set of new laws and regulations were adopted by The Order. The overthrow was not well publicized as Hade kept his profile relatively low, but many non-humans have been expelled from governing structures around The Empire. Some local Orders including Wimborn's have changed their operational rules to provide headmasters absolute power across the region. You were quickly instated as one of them."
	
	return dict


func wimborn():
	var dict = {text = 'Wimborn remained prosperous, continuing to influence its surroundings with you as The Order’s local Headmaster. ', background = 'wimborn', sprite = null}
	if globals.state.reputation.wimborn >= 20:
		dict.text += '\n\nYour standing has been greatly bolstered by the recognition of various local organizations. '
	elif globals.state.reputation.wimborn <= -10:
		dict.text += "\n\nHowever, your standing has been a subject of harsh criticism by most of the local population and organizations. "
	return dict

func gorn():
	var dict = {text = "Gorn has continued to grow in wealth and power being dominant force in southern regions. ", background = 'gorn', sprite = 'garthor'}
	
	if globals.state.reputation.wimborn >= 20:
		dict.text += "\n\nThe Orc's lands immediately agreed to cooperate with your regime, helping to form new trading routes. "
	elif globals.state.reputation.wimborn <= -10:
		dict.text += "\n\nGorn's officials were not enthusiastic about your assignment. The Empire and Gorn's relationship has grown more stressed as of late. "
	
	dict.text += "\n\n"
	if globals.state.decisions.has('goodroute') && !globals.state.decisions.has('killgarthor'):
		dict.spriteblack = true
		dict.text += "Garthor has gone missing and has not been seen since the incident. His clan lost most of their power and has been subject to harsh oversight. "
	elif globals.state.decisions.has('killgarthor'):
		dict.text += "Garhor's death served a grim reminder for those clans willing to oppose The Empire's influence. His clan lost most of their power and has been subject to harsh oversight. "
		dict.spriteblack = true
	else:
		dict.text += "Garthor and his clan soon acquired the highest standing in Gorn's Palace. After that, he became an official Chieftain, seizing power around the southern lands. "
	return dict

func frostford():
	var dict = {text = "", background = 'frostford', sprite = 'theron'}
	if globals.state.decisions.has("theronfired"):
		dict.spriteblack = true
		dict.text += "After losing their previous leader due to your decision, Frostford's standing grew weaker over time. The Order's affiliated government has made sure it remains dependant, however. "
	elif globals.state.decisions.has("zoesaved"):
		dict.text += "Frostford soon flourished with prosperity after acquiring new methods of food production. In spite of such economic success, Theron's respect has strengthened Frostford's relationship with both The Empire and yourself."
	elif globals.state.decisions.has("zoedied"):
		dict.text += "Over time, Frostford grew more distant from The Order’s main governing body. Even after his defeat Theron is still searching for new ways to gain more independence from The Empire."
	else:
		dict.text += "Over time, Frostford grew more distant from The Order’s main governing body. While Theron kept his respect for you, he is still searching for new ways to gain more independence from The Empire."
	
	return dict

func amberguard():
	var dict = {text = "", background = 'amberguard', sprite = null}
	dict.text += "The Elves of Amberguard are treated harshly and received a new set of discriminatory laws after Hade took over. "
	
	return dict

func melissa():
	var dict = {text = "", background = "wimborn", sprite = 'melissaneutral'}
	dict.text = "Melissa has disappeared from Wimborn and hasn't been seen again. Some said she was one of perpetraitors, but you weren't able to confirm that. "
	dict.spriteblack = true
	return dict

func emilytisha():
	var dict = {text = "", background = 'wimborn', sprite = null}
	var text = ''
	var slaves = {emily = false, tisha = false}
	
	for i in globals.slaves:
		if i.unique == 'Emily':
			slaves.emily = true
		elif i.unique == 'Tisha':
			slaves.tisha = true
	if globals.state.sidequests.emily >= 16 && slaves.emily && slaves.tisha:
		dict.text = "Both Tisha and Emily continued to stay at your household. Their compassion for each other and yourself growing ever stronger. "
		dict.background = 'mansion'
		dict.sprite = 'tishahappy'
		dict.sprite2 = 'emily2happy'
	else:
		#emily
		if slaves.emily && !slaves.tisha && globals.state.sidequests.emily >= 16:
			dict.text = "Emily, while ultimately accepting her new life, is still not very happy about her sister's fate."
			dict.sprite2 = 'emily2happy'
		elif globals.state.decisions.has("emilyreleased"):
			dict.text = "Emily returned to the orphanage, eventually helping to raise younger orphans."
			dict.sprite2 = 'emilyneutral'
		if slaves.tisha && (globals.state.decisions.has("tishatricked") || globals.state.decisions.has("tishaemilytricked")):
			dict.text += "\n\nWith time, Tisha grew more accepting of your deeds, but she's still very cautious around you."
			dict.sprite = 'tishaneutral' 
			dict.background = 'mansion'
		elif slaves.tisha:
			dict.text += "\n\nTisha continued working at Wimborn, trying her best to make a life for herself."
			dict.sprite = 'tishaneutral'
		if !slaves.emily && !slaves.tisha:
			dict.text = "Tisha brought Emily to live with her. Their living conditions are anything but luxurious, but Emily tries her best to help her sister out. "
			dict.sprite2 = 'emilyneutral'
			dict.sprite = 'tishaneutral'
		if slaves.emily && !slaves.tisha && globals.state.sidequests.emily < 16:
			dict.spriteblack2 = true
			dict.text += "\n\nYou heard nothing more about Tisha’s whereabouts following her disappearance. Perhaps she suffered some grim fate or simply started a new life."
		
	return dict


func cali():
	var dict = {text = '', background = '', sprite = null}
	
	var cali = false
	for i in globals.slaves:
		if i.unique == 'Cali':
			cali = true
	
	
	if cali == false &&  !globals.state.decisions.has("calireturnedhome"):
		dict.text = "After Cali's disappearance, you stood no chance of hearing from her again. Her quick wits may have helped her to return home or at least to survive on her own."
		dict.sprite = "calineutral"
		dict.background = 'wimborn'
	elif globals.state.decisions.has("calireturnedhome"):
		dict.text = "Cali returned to her parents, living together happily." 
		dict.sprite = 'calihappy'
		dict.background = 'meadows'
	elif globals.state.decisions.has("calistayedwithyou"):
		dict.text = "Cali happily stayed with you. Her affection seems to have grown unusually strong. "
		if globals.state.decisions.has("calilove"):
			dict.text = "Cali happily stayed with you. After openly declaring her love, she tries her best to please you. "
		dict.sprite = 'calihappy'
		dict.background = 'mansion'
	elif globals.state.decisions.has("calibadstayed"):
		dict.text = "Having no better options, Cali stayed at your mansion. While she holds no ill will toward you, she has been anything but cheerful. "
		dict.sprite = 'calisad'
		dict.background = 'mansion'
	elif cali:
		dict.text = "Although Cali remains with you, she still remembers and longs for her old life. "
		dict.sprite = 'calineutral'
		dict.background = 'mansion'
		
	
	return dict


func chloe():
	var dict = {text = "", background = "", sprite = null}
	var chloe = false
	var crazed = false
	for i in globals.slaves:
		if i.unique == 'Chloe':
			chloe = true
			if i.traits.has('Sex-crazed'):
				crazed = true
	if chloe && !crazed:
		dict.background = 'mansion'
		dict.sprite = 'chloehappy'
		dict.text = "After joining you, Chloe eventually grew accustomed to life in your household and continued her research. She also started working on your biography."
	elif crazed:
		dict.background = 'mansion'
		dict.sprite = 'chloenakedshy'
		dict.text = "What was left of Chloe is kept in your mansion. She entertains you to this day."
	elif globals.state.decisions.has("chloebrothel"):
		dict.background = 'shaliq'
		dict.sprite = 'chloenakedhappy'
		dict.text = "What was left of Chloe is still serving clients of certain small brothel attracting customers."
	else:
		dict.background = 'shaliq'
		dict.text = "Chloe continued to live at Shaliq, working on her research and, sometimes, thinking about you."
		dict.sprite = 'chloehappy'
	
	return dict


func yris():
	var dict = {text = "", background = "", sprite = null}
	var yris = false
	for i in globals.slaves:
		if i.unique == 'Yris':
			yris = true
	
	if yris:
		dict = {text = "Yris stays with you to this day. Surprisingly to her, she seems content with your ownership.", background = "mansion", sprite = 'yrisalt'}
	else:
		dict = {text = "Yris still looking for a ways to survive around Gorn using her charm and wits.", background = "gorn", sprite = 'yrisalt'}
	return dict


func zoe():
	var dict = {text = "", background = "", sprite = null}
	var zoe = false
	for i in globals.slaves:
		if i.unique == 'Zoe':
			zoe = true
	if zoe:
		dict.text = "With time Zoe grew attached to you and decided to stay in your mansion."
		dict.sprite = "zoehappy"
		dict.background = 'mansion'
	elif globals.state.decisions.has("zoewander"):
		dict.text = "After some time Zoe, ran away from Frostford, venturing out into the world and seeking a different fate."
		dict.sprite = "zoeneutral"
		dict.background = "frostford"
	elif globals.state.decisions.has("zoedied"):
		dict.text = "Due to unfortunate circumstances Zoe deceased and has been buried at homeland in Frostford."
		dict.sprite = "zoesad"
		dict.background = "frostford"
		dict.spriteblack = true
	else:
		dict.text = "After some time Zoe, ran away from Frostford, venturing out into the world and seeking a different fate."
		dict.background = 'frostford'
		dict.sprite = 'zoeneutral'
	
	return dict


func maple():
	var dict = {text = "", background = "", sprite = null}
	var maple = false
	for i in globals.slaves:
		if i.unique == 'Maple':
			maple = true
	
	if maple:
		dict.text = "After your buyout, Maple quickly adapted to your ownership and found it even better than her old workplace. She joyfully accepted you as her true master and loyally serves you."
		dict.background = 'mansion'
		dict.sprite = 'fairy'
	else:
		dict.text = "Maple kept working at The Slavers Guild, successfully attracting and helping new customers."
		dict.background = 'wimborn'
		dict.sprite = 'fairy'
	
	
	return dict






func ayneris():
	var dict = {text = "", background = "", sprite = null}
	var ayneris = false
	for i in globals.slaves:
		if i.unique == 'Ayneris':
			ayneris = true
	
	if ayneris:
		dict.text = "Ayneris found your mansion to be worthy and grew attached to you. Her combat skills make her stand out among other servants and give her a reputation among the locals."
		dict.background = 'mansion'
		dict.sprite = 'aynerisneutral'
	else:
		dict.text = "Ayneris kept searching for you, but, after some time, eventually gave up and left her family in search of adventure."
		dict.background = 'amberguard'
		dict.sprite = 'aynerisneutral'
	
	return dict



func ayda():
	var dict = {text = "", background = "gorn", sprite = 'aydanormal'}
	if globals.state.decisions.has("mainquestelves"):
		dict.text = "Ayda returned to her work in Gorn, sending you letter of gratitude. Her assistant was exceptionally happy and continues to serve his master."
	else:
		dict.text = "Due to your actions in the caves, Ayda has died. After her funeral, her shop was closed and her servant sold to the local slaver guild. "
		dict.spriteblack = true
	return dict





