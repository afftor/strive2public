
extends Node

static func getHeights(slave):
	var text
	if slave['bodyshape'] != 'shortstack':
		text = [ 'petite', 'short', 'average', 'tall', 'towering' ]
	else:
		text = [ 'tiny' ]
	return text

static func getSkinColors(slave):
	var text = [ 'pale', 'fair', 'olive', 'tan' ]
	var text2 = {
	"Dark Elf" : [ 'tan', 'brown', 'dark' ],
	"Drow" : ['blue', 'purple', 'pale blue'],
	"Orc" : ['green'],
	"Goblin" : ['green'],
	"Dryad" : ['green'],
	"Slime" : ['jelly'],
	"Nereid" : ['teal', 'blue', 'pale blue']
	}
	if (text2.has(slave['race'])):
		text = text2[slave['race']]
	return text

static func getHornTypes(slave):
	var text = [ 'None' ]
	var text2 = {
	"Demon" : ['short', 'long_straight', 'curved'],
	"Dragonkin" : ['short', 'long_straight', 'curved'],
	"Taurus" : ['long_straight'],
	}
	if (text2.has(slave['race'])):
		text = text2[slave['race']]
	return text


static func getWings(slave):
	var text = [ 'None' ]
	var text2 = {
	"Fairy" : ['insect'],
	"Demon" : ['leather_black', 'leather_red'],
	"Dragonkin" : ['leather_black', 'leather_red'],
	"Seraph" : ['feathered_black', 'feathered_white', 'feathered_brown'],
	}
	if (text2.has(slave['race'])):
		text = text2[slave['race']]
	return text


static func getFurColors(slave):
	var text = [ 'None' ]
	var text2 = {
	"Beastkin Cat" : ['white', 'gray', 'orange_white','black_white','black_gray','black'],
	"Beastkin Fox" : ['black_white', 'orange'],
	"Beastkin Wolf" : ['gray', 'black_gray', 'brown'],
	"Beastkin Bunny" : ['white', 'gray'],
	"Beastkin Tanuki" : ['black_gray'],
	}
	if (text2.has(slave['race'])):
		text = text2[slave['race']]
	return text

static func getRandomFurColor():
	var temp = ['white', 'gray', 'orange_white','black_white','black_gray','black', 'orange', 'brown']
	return temp[rand_range(0,temp.size())] 


static func getRandomName(slave):
	var text = {}
	if (slave.race == 'Human' && slave.sex != 'male'):
		text['name'] = getRandomHumanFName()
		text['surname'] = getRandomHumanSurname()
	elif (slave.race == 'Human' && slave.sex == 'male'):
		text['name'] = getRandomHumanMName()
		text['surname'] = getRandomHumanSurname()
	elif ((slave.race == 'Elf'|| slave.race == 'Dark Elf' || slave.race == 'Drow') && slave.sex != 'male'):
		text['name'] = getRandomFElfName()
		text['surname'] = getRandomElfSurname()
	elif ((slave.race == 'Elf'|| slave.race == 'Dark Elf' || slave.race == 'Drow') && slave.sex == 'male'):
		text['name'] = getRandomMElfName()
		text['surname'] = getRandomElfSurname()
	elif slave.race.find('Beastkin') >= 0 || (slave.race.find('Halfkin') >= 0 && rand_range(0,1)>0.6) :
		if slave.sex != 'male':
			text['name'] = getRandomHumanFName()
		else:
			text['name'] = getRandomHumanMName()
		text.surname = getRandomFurrySurname()
	elif slave.sex != 'male':
		text['name'] = getRandomHumanFName()
		text['surname'] = getRandomHumanSurname()
	else:
		text['name'] = getRandomHumanMName()
		text['surname'] = getRandomHumanSurname()
	return text

static func getRandomSex():
	var text
	if (globals.rules['male_chance'] > 0 && rand_range(0, 100) < globals.rules['male_chance']):
		text = 'male'
	elif (rand_range(0, 100) < globals.rules['futa_chance']) && globals.rules.futa == true:
		text = 'futanari'
	else:
		text = 'female'
	return text

static func getRandomAge():
	var text = []
	if (globals.rules['children'] == true):
		text.append('child')
	
	if (globals.rules ['teens'] == true):
		text.append('teen')
	
	if (globals.rules ['adults'] == true):
		text.append('adult')
	
	return text[rand_range(0, text.size())]


static func getRandomHumanFName():
	var FHumanNames =["Alina","Alita","Amedea","Angelika","Ariana","Aya","Beatris","Cecile","Chira","Ciara","Cinthia","Dacia","Diana","Elinor","Elina","Eliza","Eloise","Emmy","Enna","Erlene","Evelien","Filicia","Fleurette","Freya","Genevie","Hanna","Irena","Isabella","Janna","Janette","Janay","Jenni","Jestine","Julene","Julia","Kellye","Krysten","Leanora","Lera","Lucilla","Maeva","Maria","Marylee","Mina","Nanci","Nelda","Nerissa","Nila","Nina","Palmira","Pelagia","Priscilla","Rita","Riya","Robin","Rose","Roterica","Samanta","Samira","Scarlet","Selina","Shana","Sharlene","Shaylee","Shelba","Sonya","Sophie","Susan","Tami","Tali","Telma","Teresa","Tira","Tracy","Trisha","Vanessa","Vikki","Yoana"]
	var text = FHumanNames[rand_range(0, FHumanNames.size())]
	return text
	
static func getRandomHumanMName():
	var MHumanNames = ['Alvin','Andrew','Blake','Brett','James','Brian','Carl','Charles','Dan','Daniel','Darius','Darrell','Derrick','Don','Dwayne','Edward','Gene','Glenn','Henry','Herman','Jeremy','John','Jonathon','Jose','Leo','Leon','Leon','Logan','Malik','Manuel','Micheal','Owen','Randall','Sam','Seth','Tom','Tyrone','Victor','Vincent','William']
	var text = MHumanNames[rand_range(0, MHumanNames.size())]
	return text
	
static func getRandomHumanSurname():
	var HumanSurnames = ["Adams","Anderson","Alexander","Baker","Brown","Black","Campbell","Clarke","Cooper","Davies","Davis","Doherty","Foster","Graham","Gray","Green","Evans","Hamilton","Hughes","Jackson","James","Johnson","Johnston","Jones","Kelly","Lewis","Leawis","Martin","Marshall","Mason","Mitchell","Moore","Murphy","Murray","O’Neill","Patel","Phillips","Quinn","Roberts","Robinson","Rose","Rogers","Smith","Smyth","Stewart","Taylor","Thomas","Thompson","Young","Walker","Williams","Wilson","Winthrop","Wood","Wright"]
	var text  = HumanSurnames[rand_range(0, HumanSurnames.size())]
	return text

static func getRandomFElfName():
	var FElfNames = ["Albis","Anhanna","Caenairra","Driszora","Durrastra","Eilcahne","Eilkyrath","Eilxana","Enacelle","Faeriele","Faesanna","Grucelle","Hyllyn","Illayana","Irexana","Jelenriele","Jelenshana","Jelenzane","Kaicahne","Kaiqirith","Kairastra","Menairra","Nairiele","Naitora","Nerixana","Oricelle","Rigrys","Rolhyssa","Shameiv","Trihyssa","Ulkyrath","Ulthaea","Ultrianna","Vacelle","Vameiv","Weswena","Weszora","Yllacelle","Yllaparys","Zenhanna"]
	var text  = FElfNames[rand_range(0, FElfNames.size())]
	return text

static func getRandomMElfName():
	var MElfNames = ['Ailduin','Alaion','Alluin','Ardryll','Darthoridan','Edwyrd','Elre','Elwin','Feno','Folwin','Haldir','Jannalor','Lysanthir','Malgath','Nieven','Nuvian','Oenel','Paeral','Pharom','Respen','Riluaneth','Ruith','Sataleeti','Sythaeryn','Taanyth','Taranath','Tarron','Theodmon','Volodar','Xanotter','Zandro','Zelphar','Zhoron']
	var text  = MElfNames[rand_range(0, MElfNames.size())]
	return text

static func getRandomElfSurname():
	var ElfSurnames = ["Autumncrest","Autumnspirit","Blacksinger","Bladeheart","Blademane","Darksky","Dawnwind","Dewbreath","Dewspirit","Farspyre","Feathermane","Feathermoon","Feathersword","Fogbow","Forestwhisper","Greenwater","Lunarage","Moongrove","Rainsinger","Rapidsnow","Sagespear","Sagespirit","Sealight","Shademane","Shadewind","Shadowblade","Silverwhisper","Skyclouds","Skyswift","Stagbranch","Stillrunner","Summerbloom","Swiftseeker","Thunderspear","Treeleaf","Treespear","Truetree","Winterrage","Wintersinger","Woodforest"]
	var text  = ElfSurnames[rand_range(0, ElfSurnames.size())]
	return text

static func getRandomFurrySurname():
	var furrysurnames1 = ['Black','White','Red','Dark','Frost','Fire','Wind','Ice','Forest','Shade','Moon','Iron','Shadow','Gold','Strong','Grim','River','Silver','Great']
	var furrysurnames2 = ['paw','mane','tail','fang','howl','bone','pelt','eyes','hunter','claw','growl']
	return furrysurnames1[rand_range(0,furrysurnames1.size())] + furrysurnames2[rand_range(0,furrysurnames2.size())]

static func getRandomEyeStandardColor():
	var text = [ 'blue', 'green', 'brown', 'hazel', 'black', 'gray' ]
	return text[rand_range(0, text.size())]


static func getRandomBeastEyeColor():
	var text = [ 'blue', 'green', 'amber', 'red']
	return text[rand_range(0, text.size())]


static func getRandomHorns():
	var text = ['short', 'long_straight', 'curved']
	return text[rand_range(0, text.size())]


static func getRandomEyeFancyColor():
	var text = ['blue', 'green', 'amber', 'red', 'purple']
	return text[rand_range(0, text.size())]

static func getRandomAnyEyeColor():
	var text = [ 'blue', 'green', 'amber', 'red', 'purple', 'brown', 'hazel', 'black', 'gray' ]
	return text[rand_range(0, text.size())]

static func getRandomHairStandardColor():
	var text = ['blond', 'red', 'auburn', 'brown', 'black']
	return text[rand_range(0, text.size())]

static func getRandomHairFancyColor():
	var text = ['white', 'green', 'purple', 'blue', 'blond', 'red', 'auburn' ]
	return text[rand_range(0, text.size())]

static func getRandomHairAnyColor():
	var text = ['blond', 'red', 'auburn', 'brown', 'black', 'white', 'green', 'purple', 'blue', 'gradient' ]
	return text[rand_range(0, text.size())]

static func getHairLengthBase(slave):
	var text = '';
	if (slave.sex == 'male'):
		text = getRandomHairLengthShort()
	else:
		if (slave.age == 'child'):
			if (rand_range(0, 10) >= 8):
				text = getRandomHairLengthLong()
			else:
				text = getRandomHairLengthNormal()
		elif (slave.age != 'child' && rand_range(0,10) > 4):
			text = getRandomHairLengthLong() 
		else:
			text = getRandomHairLengthLong()
	return text#[rand_range(0, text.size())]

static func getRandomHairStyle(slave):
	var text = [];
	
	if (slave['hairlength'] != 'short' && rand_range(0,10) < 6):
		text = ['ponytail', 'twintails', 'braid', 'two braids', 'bun']
	else:
		text = ['straight']
	if (slave['sex'] == 'male'):
		text = ['straight', 'straight', 'straight', 'straight', 'ponytail']
	return text[rand_range(0, text.size())]


static func getRandomHairLengthShort():
	var text = ['ear', 'neck']
	return text[rand_range(0, text.size())]

static func getRandomHairLengthNormal():
	var text = ['ear', 'neck', 'shoulder']
	return text[rand_range(0, text.size())]

static func getRandomHairLengthLong():
	var text = ['shoulder', 'waist', 'hips']
	return text[rand_range(0, text.size())]

static func getRandomSkinColorStandard():
	var text = [ 'pale', 'pale', 'fair', 'fair', 'fair', 'olive', 'tan' ]
	return text[rand_range(0, text.size())]


static func getRandomSkinColorDark():
	var text = [ 'tan', 'brown', 'dark' ]
	return text[rand_range(0, text.size())]

static func getRandomSkinColorDrow():
	var text = [ 'blue', 'purple' ]
	return text[rand_range(0, text.size())]

static func getRandomSkinColorAny():
	var text = [ 'pale', 'fair', 'olive', 'tan', 'brown', 'blue', 'green', 'red', 'purple', 'dark', 'teal', 'jelly' ]
	return text[rand_range(0, text.size())]


static func getSexFeatures(slave):
	var age = slave['age']
	var bodyshape = slave['bodyshape']
	var sex = slave['sex']
	var height = []
	var titssize = []
	var tits = {
	size = '',
	extrapairs = 0,
	developed = false,
	lactation = false
	}
	var ass = []
	var rval = {}
	var balls = []
	var penissize = []
	var penistype = 'human'
	var penisnumber = 0
	var penis = {}
	var pussy = {}
	
	if (slave['race'].find("Beastkin") >= 0 && globals.rules['furrynipples'] == true):
		tits['extrapairs'] = 3
	
	if (sex != 'male'):
			if (age == 'child'):
				height = [ 'petite', 'short']
				titssize = ['flat', 'small']
				ass = titssize
			elif (age == 'teen'):
				height = [ 'petite', 'short', 'short', 'average', 'average', 'average', 'tall' ]
				titssize = ['flat', 'small','average','big']
				ass = titssize
			elif (age == 'adult'):
				height = [ 'short', 'short', 'average', 'average', 'average', 'tall', 'tall', 'towering']
				titssize = ['small','average','big', 'huge']
				ass = titssize
			
	elif (sex == 'male'):
		penisnumber = 1
		pussy['has'] = false
		pussy['virgin'] = false
		if (age == 'child'):
			height = [ 'petite', 'short']
			titssize = ['flat']
			ass = ['flat']
			penissize = ['small', 'average']
			balls = ['small', 'average']
		else:
			height = [ 'short', 'average', 'tall', 'towering' ]
			titssize = ['flat','masculine']
			ass = ['flat', 'masculine']
			penissize = ['small','average','big']
			balls = ['small', 'average', 'big']
		
	if (sex == 'futanari' && globals.rules['futa'] == true): #check for futas to be allowed
		penisnumber = 1
		if (age == 'child'):
			penissize = ['small', 'average']
		else:
			penissize = ['small','average','big']
			
	if (globals.rules['futaballs'] == true && sex == 'futanari'): #// check for balls to be allowed
		if (age == 'child'):
			balls = ['small', 'average']
		else:
			balls = ['small', 'average', 'big'];
	elif (sex != 'male'):
		balls = ['none']
		
		
	if (sex == 'female'):
		penissize = ['none']
		balls = ['none']
	elif (sex == 'male'):
		pussy['has'] = false
		
	if (sex != 'male') :
		pussy['has'] = true
		pussy['virgin'] = false
		if (age == 'child' && rand_range(0,12) < 10):
			pussy['virgin'] = true
		elif (age == 'teen'):
			if (rand_range(0,10) >= 4):
				pussy['virgin'] = false
			else:
				pussy['virgin'] = true
		elif (age == 'adult'):
			if (rand_range(0,10) >= 3):
				pussy['virgin'] = false
			else: 
				pussy['virgin'] = true
		else:
			pussy['virgin'] = false
		
		if (bodyshape == 'shortstack'):
			height = ['tiny']
	if (penissize != 'none' && slave['race'].find('Beastkin') >= 0):
		if (slave['race'].find('Cat') >= 0):
			penistype = 'feline'
		elif (slave['race'].find('Fox') >= 0 || slave['race'].find('Wolf') >= 0):
			penistype = 'canine'
	if (penissize != 'none' && slave['race'].find('Centaur') >= 0):
		penistype = 'equine'
	
	penis['type'] = penistype
	penis['size'] = penissize[rand_range(0, penissize.size())]
	penis['number'] = penisnumber
	tits['size'] = titssize[rand_range(0, titssize.size())]
	rval['tits'] = tits
	rval['ass'] = ass[rand_range(0, ass.size())]
	rval['height'] = height[rand_range(0, height.size())]
	rval['penis'] = penis
	rval['balls'] = balls[rand_range(0, balls.size())]
	rval['pussy'] = pussy
	return rval;

