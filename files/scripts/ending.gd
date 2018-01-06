extends Control

var scenearray = []
var currentscene
onready var player = get_node("AnimationPlayer")
var timer = Timer.new()
var timer2 = Timer.new()
var stage

var patrons = ["Samantha Monroe","William Strable","Alex Hernandez","littlekingdeath","JEX","Stuart Faulds","King of Kings","ben falls","Kind Phantom","David Hall","amon koth","War God","Martin Fendl","Sam Klingspor","tom illingworth","Lucid Fayt","Kentrop","Zefyr590","Balazsi Szilard","Krow","Hapilex","retchit","John Foster","klaas444","K. Nguyen","Ghostfield","Joshua","Brown Man","NovaShards","Benji Steel","Lenrir","BeeBrett","Brennen Nichols","Aleksis Lindewall","Shaun Holmes","Neverstorm","Benny Castillo","Kriskon","sarcasm2k1","Blacktouch","Greg P Weimar","Cimbri","Jackson Sossaman","Terje","Thomas Phykos","Sho McDoom","Tim Coleman","Zivich","Knugen","Ted Frick","moleman","Kirin","Bryce Cole","Marr","Ai Muhao","Jakob RichtnГ©r Ahlin","Andrea Durall","Coiasira Luminarium","Richard Pembroke","B J","Birbsus","MrIncognito","S.P.","Strykerclaw96","Ern Flor","Spencer (iruleatgames) Geller","Spooks Skeleman","Martin Dokken","Amstaad","lhopitallier","Destroyer-x","Samuel Jennings","Reed","Jonathan M Osborne","Von Neely","AnonEMoose","Matthew Jultak","Andrew","Joshua Edwards","Johnny G","Fandley","Altruin","Jason Fejfar","Goldmember","Sean Daugherty","Tickle_myPickle23","Mike Wells","John Blakeley","Benjamin Choi","cody drewiega","John","John F Schmidley","Steve B","Storme","Chatles Stonewall","Der sonderbare MufflonkГ¶nig","Glenn Kingston","WeirdPete","Alex Clausen","Matty","Doc","JacenHaggard","Petter","Joseph","Diogenes","Nick","Cody Hicks","Tim Ater","The Storyteller","Dan","Skynin","Logon Bays","Kevin SaoPaulo","abomasal","James Michael McClendon","Dirty Whelk","Stephen Wright","Rutger","jhag","eduardo espinoza","Malphas","Felix Argyle","crakkyboii","Sung Jun Yang","Tyler Lee","Mia Amyton","JC","Caim S Pact","ncricket42","Alex Proasheck","Abaddon_Almighty","Griever","Mr. Mann","Michael Ian Baillie","Richie191","Drone of war","Onlyheretofollow","IronHandKnight","DJ BadDad","Jon Conner","Ryan Pangle","Tim Santiago","MrAbusay","Rax Ixor","Alexander Kampfer","John Ash","Joe Meeks","nickolas evans","Zamiel Sailgait","Tofuman","Brittney Alexander","Mike Rathbone","Random","VikC","Manraj Dhanda","Woodrow Howard","Kevin Craig","Karsten Bock","Zach","Michael","Tray Johnson","Corick Khaal","Grizzer","Larius","Kelvin Ng","john m barnett","Ansemslayer","Chris","Malleator","Royce Love","CJ","Joar Rost","Colby","Jibob","Citillara","Brandon Robinet","Martin Hunt","Joseph Marquez-Ruiz","Owen Castle","Nunya","Casey Freeburg","Sagaritus","simez","DS","Forban Jones","Kevin Ma","Aaron Wilcox","mackenzie Woodliffe","ja som anon","lightningshifter","Chris","RogueRandom","CamperNQQB","Apollo81","Ryan Norman-Adams","August Cochi","Espadron","Michael Bourne","Adrian Arcila","Jakub Czerczak","Dark","Rezz7399","Mack Legendary","Rob","D C","Toby","Chris Thomas","Daniel J Pitzer","ReaDavid","Chronos189","john hop","dr klayton","Christiane bingham","Random Havoc","Adrian Lee","Skinnybastrd","Shiver Metimbers","Per Hans","Austin Ely","Arcseraphim","victor montes","Luke","Bored_Immortal","Knut Ivar Hellsten","Kevin","Landon Plyler","Joshua Copley","Chandler Simonds","t","Mikael Dahlberg","dougal heimer","Patrick Eperjesi","Philip Robbins","David Braga","No","K","Michael Abravanel","NK","Robin Lindholm","John Smith","Serizawa","Tony Venvik","Andrew","Matt Bellamy","John Smith","Drew","Dale Wong","Beaureguard","materpuppet13","Glib Gentleman","Regelios","Obsidian Razor","Anthony Teare","Kts","R","Andrew Wright","Tyler Crowl","Deadlysinners","Mortume","Salvador","Sveny","Adam Wood","Mackenzie Buckle","J'ree","Julian Shadoan","James Whitaker","W","Daniel Dainwood","A guy","NBaron","Mac Echrain","HeyTosa","CrazeStasis","Eric Bellinger","Ashley Gray","Will Nolens","Griffinblitz","Jason","Chris Sims","varden","Edwin Fame","AKen","Zantengetsu","David Ramsey","Steve Martinez","Gregory Johnson","Rielly Johnson","Shane Weaver","Jim Cantrell","Marshal Case","Charles Fey","Jerome Stokes","NoStereotype","Ryan Cooper","Tom Erik Trydal Soldal","Kevin Brown","RFW","Gabriel Valdes","matt richman","Shayne","Jordan Covarrubias","Jason Kite","Thomas","Deathcat","Kay Tomassi","Alan Glas","Sunny","Ben","Lazer Elf","ScaredEnigma","Bruno Gameiro","IAmHiding","RafaЕ‚ Malek","Blaat","jaron","Michael Foat","Ryan Pulliam","nate starr","Michael Hupton","Mark","InAHoleInTheWoods","Joel Denlinger","Patrik Andersson","Jordan Pugeda","zedither","Cil","Karim Oubouzar","cameron d fike","Christopher T","Anonim Demisan","Christopher","Andrew Stapleton","Joshua Helsel","Adhelkab","Jack Larson","Cody","Chris Leeds","raul barreto","Trevor Frye","PW1747","P4Nd0RaS","evilkarma213","Cornelius","asafsdf","Friggitt","Killroy","Victor","Ilya Grin","Marvin Ma","D00D","DapperDog","TenMinuteTom","Kaukis","SPANU","Maliver","Tom Meyers","Strafe","Kiwi Byrde","Jack Bauer","WINGKAI","Miller Wiens","mystic","KT Daxon","kv315","David J. Rosequist","lewis newhouse","Thunder","Mike","Quartz","Jim Reel","Garder190","Dick Maximus","meme lord","Loric","OrderAbove","justforpretend","HuWatWenY","Quinton Alexander Glazebrooks","Garion437","silvercrest","Landar","Russ","Gavin Lane","michael Blackwood","Tobias Pedersen","Altan Tagrin","Austin Humphrey","Hunter","Kejpi","Jo Heine","myles simpson","Andrew Gallant","Joseph Hendricks","richard","Niels Wever","Reverant","Madness","Bryce White","D.M.","Kotr","Haruka Erizawa","Kenny","Anime guy 117","christopher bezic","Swift Shot","Problemchild","JP","Nobody679","Kirk Lund","Tim","P.G","Florid Lunacy","Christian Igametse","Brad","Dracsis","Scarecrowlust","sibobb","Nicol Liu","dotdotdot","Gapho","Auruum","Dick Jones","Parker Christiansen","James Sutton","Billy Pollock","mitchel serwa","Tristan Harden","Lucas Ibister","Tony","Dutchess","AltonV","Jackle","Vister1","FriendlyNeighborhood Wolfman","trenadegun11","Nick Farlee","Dominic Trottier","Kevin Van den Bosch","Mikael Trkulja","Carl Johannes Huglen","IngГіlfur","John Limbacher","zachary bohuslar","Teach","Wayne Ledbetter","Adel Konig","hashkov","Kyle Long","Mohammed Ali Mohammed","leif ericson","Chris Corbett","Brandon","BackSpin","Ivan Sizi","Jonah Homp","jordan lindsay","Arden Kopistoff","Zakory Slingerland","James","Adrian Sinclair","hog_jockey","Geoffrey Austin Magness","celestialkitsune","Aemiliana","Renny","Patrick Spencer","Alexander","Amanda Pleva","montresor","Nicholas Rocco","Ozzie Din","Scott Keller","Sedjet","Greg","Kyle Mac","Shuuu","Taran MacDonald","Isaiah Soles","Gene","Hans","jesse case-allan","James Borden","Jack Black","Kenneth Rowe","jeffb","Malcolm Easton","Reece Dempsey","Gwaxer","Gullindjemprins","CaptVix","Hogle","Brian Dillon","Seth Lou","gurlag gurlag","simrhe18","shdwfsh63","Aelandill","D.Devil","Damian Wiechmann","Conner Weston","Brendan Dore","Martian.Craig","Sir Spanky","dave salisbury","Elliott Moore","vees","DBry","Sabledean","Luis Garza","Richard Beasley","Ragadadadoda","Angela Matthews","Ming The Merciless","ethan adams","Paul","Albert Viereckl","N113","Vikteren","Paulet Michel Junior","Adam","Anton D.","Rain91","dave rhodes","Canochick","alqp","Nuclear_Dice","EroCK","Aaron Grandy","DeathbyKimchi","Charles Brakley","LoversLab","Verhext","Isuma Oni","Marcus Karlsson","Trevor Smith","Eric Lin","Tikinosu","patman","eduardo barajas","Felix Meyer-Hoitz","Christhereaper","Dylan A. Sanchez","Kharnos Strayder","Tanner Mortimer","Isabella","Kenneth","Isaiah Emond","Randy Maxey","Anon Ymous","Inyx","Will Leitheiser","...","Zef","Puget Dolphin","Jonathan","Ken-ГҐge","michael j robinson","Xig","Tony","BadKarma89","Jonathan Harper","voper45","Vernon Loeb","Zackary Smith","Isaac Lucas Grainger","Kohey","Rel","Redep","Lukas Nyman","Khinzaw","OGK","Jasraj Panesar","Zack Polster","Billy Olsson","John Jimmson","H Dizzie","Sanhae","z","Concave Paradox","loga delarosa","Kris Frye","Myshella","thedark1","Promenade","ybo678","jefferson wright","Shirro","silentark","Elin Stefansdottir","Shelby Simpler","SotF","curt raley","Will Ross","Nathaniel scheil","Ackerlight","david casort","Jerry","Adam Barnette","Torinir","DibbyDabba","brandon","Aron Whidden","john applesea","ElCrazy1","Aaron Small","Kasper Rude Wind","Diablo8x","Nick Tinsley","Ann Fowler Avery","Michael Cummings","Jashin","Jacob Rayman","CompilerError","Mike","Hyrikul","sheng","mcdade","Nevyn","Chikuzenni","FrГ©dГ©ric","Ramon Diaz","Strausenhat","Fenris","Alessandro Ginex","Chris Baldwin","Lithos","Angry Panini","Benjamin","Fou","Evangleline","Marvs","Aisha king","Adrian Carroll","Chance Carroll","Ethan Visser","Envoy","claus sandgreen jensen","kyle bastien","Thomas Cromwell","Shovern","Xero Soul","EtherLicker","Omnimagnus","Georg Lechner","Gleb Blgakow","Thomas Martin","Robert Black","grim42","Christopher Garrison","Treize82","D.T.","Schell Oldham","onecoolzuchini","Leho Landman","Patch","Tobias Krupp","Kaitlynn","Vkad 64","Steve Madden","Christopher Abel","Darkfirephoenix","Serialpeacemaker","William Black","Bobbington","GIBTheDoctor","Jonathan Murphy","Emil Larsen","DavyJones","Connor Johns","Azuregene","ValosDaNightmare","Anti-No","Llywelyn Thomas","Zalavier","Swift Assassin","Just a Genius","Danny Banger","Halb Blahson","vedeh","Cryostorm","Phaos","Paween Hinmuangkao","Sihong Fu","jeroen verboom","Thomas M&uuml;ller","maxwellccm","Ross Johnson","Mark Lillington","awk1995","Jemma Hurley","Kaya Blue","Joey Unicorn","Christy","wootifus","Alex Moreno","zane graham","kristoffer Wirenfeldt Johanensen","Whatever","Remsiv","Haise Kaneki","Swigglez","joe","Calrak","Xagnam","Liam","Curtis","NeoMage","Sawyer Gardner","Robert L Allen","Charles Welker","Gundraub","Prutus","raska42","Thomas Charville","KleptoKobold","Bonin","Zeke LeGrow","Daniel Iwar Brekke","Verden","Mathieu Duval","Ali Mutlu","Tom","Smo Queed","Dassath","Destont","jezzjoker","James A. Messick III","HentaiHeitai","Trisynth","Nebula Fox","Konomori","Lorem.Ipsum","rhogleg","Spigot Frigate","Michael Hoover","Doob","J R","Jean-SГ©bastien Sirois","aliquis","Demosbane","random poster","DisturbJin","BjГёrn Zederkof","Nathan Smith","ozxecho","John Pierce","Fleming Folster","Mirokasi","pfargtl","Kevin2533","James Ahlstrom","Zekuro","Thordain","Oldcityguy","Alice Carlan","Carl Miller","Rikkatyra","Tom Hourie","Beolwin Norgannon","Shawn McAuley","Justanx","David Johnson","Matt Miller","jacques","Dominic Leach","SwoctorDales","Kaerea Shine","Grnd91","Jack Peverall","D. A.","thomas790","Rainef","Kurt","Scott","Parker Mcqueen","Reuben","David Donnelly","Human Brown","Erok","Crette","jonas","Callum Dunn","matthew c sisti","Kubebzz","Litland","Jeremy Springer","Scott S.","overkill9","kirk hamman","Maraistan","Tiberiumkyle","Cecil Kane","Somedude","Joshua Smith","Lys","Alex McGregor","Guy Gower","concon361","Crazybue","Ornithorhynchus","KnightSky","Tom Skelton","Alfredo J Sanchez","CyclopsSlayer","morraisen","foolfirefly","Haapy","Mister Luke","Christoffer Carlsson","jake m","Lish Zero","Hadrian","Daniel Downie","Dat Boss","Alex Clark","Leif Bonderud","M.L.","Phillip Horwitz","Tomasu","avid farmer","Antonio Martinez","David Boniface","Ziggy Lam","Kazama","Jay","Marius Berven Worren","Ross Ramsay","Daniel Power","Kallen Bodily","oliver kuspiel","Knapen Michel","Brett Poe","DemonFish","Jessica Ahlberg","Dwight","Managarmr","Introspective Ninja","Sleepless","bianca pandino","Ryii","Theodore Chaos","John Yarbrough","RazRazor","miguel diaz","Prepare to Crab","Jules Corbel","Yunus Demirag","mcmounes","Karol DoliЕ„ski","Phatez Anonimal","Sarah Baptiste","Lisa","rock","Bru","Jason Bradtmueller","Eachwaythief","MrAnderson","Brock Wienandt","Slaanesh06","Sqinatima Produ","Tobias","Marshall Johnson","Lightness","BasNek","Selie Siena","Angry Gorilla","Siao","Tove","Crim at Studio 1-14","Tazanik","iltonham","manshy","Robert Salender","zdront"]

func _ready():
	globals.state.decisions = ['goodroute']
	currentscene = finale()
	timer.connect("timeout", self, 'advance')
	timer2.connect("timeout", self, 'patronlist')
	set_process_input(true)
	add_child(timer)
	add_child(timer2)
	stage = 'epilogue'
	if globals.state.decisions.has('goodroute'):
		scenearray = ['finale']
	#launch()
	#show(currentscene)

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
		pass
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
		get_node("Panel 2").set_hidden(false)
		player.play("blackout")
		yield(player, 'finished')
		show(call(currentscene))
		timer.set_wait_time(9)
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
	get_node("TextureFrame/alise/continue").disconnect("pressed",self,'_on_continue_pressed')
	player.play('blackout')
	get_parent()._on_mansion_pressed()
	yield(player, 'finished')
	get_parent().close_dialogue('instant')
	set_hidden(true)
	get_parent().get_node("screenchange").set_hidden(false)
	get_parent().get_node("screenchange/AnimationPlayer").play_backwards("slowfade")
	yield(get_parent().get_node("screenchange/AnimationPlayer"), 'finished')
	get_parent().get_node("screenchange").set_hidden(true)



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
	elif globals.state.decision.has('badroute'):
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
	elif globals.state.decicions.has('killgarthor'):
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
	var text = ''
	text += "The Elves of Amberguard are treated harshly and received a new set of discriminatory laws after Hade took over. "
	
	return dict

func emilytisha():
	var dict = {text = "", background = null, sprite = null}
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
			dict.text2 = "With time, Tisha grew more accepting of your deeds, but she's still very cautious around you."
			dict.sprite = 'tishaneutral' 
			dict.background = 'mansion'
		elif slaves.tisha:
			dict.text2 = "Tisha continued working at Wimborn, trying her best to make a life for herself."
			dict.sprite = 'tishaneutral'
		if !slaves.emily && !slaves.tisha:
			dict.text = "Tisha brought Emily to live with her. Their living conditions are anything but luxurious, but Emily tries her best to help her sister out. "
			dict.sprite2 = 'emilyneutral'
			dict.sprite = 'tishaneutral'
		if slaves.emily && !slaves.tisha && globals.state.sidequests.emily < 16:
			dict.spriteblack2 = true
			dict.text2 = "You heard nothing more about Tisha’s whereabouts following her disappearance. Perhaps she suffered some grim fate or simply started a new life."
		
	return dict


func cali():
	var dict = {text = '', background = '', sprite = null}
	
	var cali = false
	for i in globals.slaves:
		if i.unique == 'Cali':
			cali = true
	
	
	if cali == false && !globals.state.decisions.has("calibadleft") || !globals.state.decisions.has("calireturnedhome"):
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
		dict = {text = "Yris stays with you to this day. Surprisingly to her, she seems content with your ownership.", background = "mansion", sprite = 'yrisaltdressed'}
	else:
		dict = {text = "Yris still looking for a ways to survive around Gorn using her charm and wits.", background = "gorn", sprite = 'yrisaltdressed'}
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





