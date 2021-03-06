extends Node


var chardescript = {
emily = "Young girl from Wimborn's orphanage. Despite her harsh life she's pretty naive and kind. ",
tisha = "Emily's older sister. Since an early age she has aimed to work hard to provide for both herself and her sister a better life than what they initially had. Being constantly abused by rich and powerful people, Tisha grew to despise others. She is rather protective towards her sister. ",
cali = "Halfkin wolf-girl who ended up in Wimborn due to some unfortunate events. Although her age and appearance might not suggest it, she is quite cheeky. ",
chloe = "A gnome girl from Shaliq village, who decided to venture out of her homeland due to her research or in search of adventure. Contrary to that, she's pretty timid and seems to be insecure about her height. ",
yris = "A beastkin resident of Gorn's bar. A Catgirl with a playful nature who loves thrill and challenges. ",
zoe = "Young member of Frostford's ruling wolven clan. Being discontent with her suggested position, she seeks a way to prove herself and try a different life. Theron's niece. ",
ayneris = "Youngest child of a powerful elven clan with declining prosperity. Her attempts to rival her siblings didn't worked out in a way she wanted, but in return she may have discovered something exciting about herself... ",
melissa = "Second-in-command of the Wimborn's Mage's Order and your direct mentor. Despite her friendly appearance she seems to have her own undisclosed goals. ",
fairy = "One of the Wimborn Slaver Guild's main attendants. Her cheerful and friendly nature helps new customers to settle in quickly. ",
ayda = "Resident alchemist in Gorn's Palace. Though she prefers to keep to herself, she is forced to cooperate to fulfill her needs. ",
garthor = "One of the leading persons around Gorn. As a head of his clan, he's very dependanble and a skillful politician.",
theron = "Frostford's leader and a chieftain of his clan. His high moral standards and combat skills earned him great respect around Frostford. ",
hade = "An unknown man recently appearing around The Empire with hidden intentions. Few authorities around The Order believe he might be a dangerous hostile. ",
}

var charactergallery = { 
emily = {
unlocked = false, name = 'Emily Hale', descript = chardescript.emily, sprite = 'emily2happy', naked = 'emilynakedhappy', nakedunlocked = false,
scenes = [{code = 'emilyshowersex', name = 'Hazy first day', unlocked = false, text = "Spiked taste of adult life"}, {code = 'showerrape', name = 'Harsh Reception', unlocked = false, text = 'Forceful approach'}, {code = 'tishaemilysex', name = 'Sisters Love', unlocked = false, text = 'Let two sisters bond with each other'}]
},
tisha = {
unlocked = false, name = 'Tisha Hale', descript = chardescript.tisha, sprite = 'tishaneutral', naked = 'tishanakedneutral', nakedunlocked = false, 
scenes = [{code = 'tishablackmail', name = 'Blackmail', unlocked = false, text = "Older sister will have to 'stay up' for younger"}, {code = 'tishareward', name = 'Gratitude', unlocked = false, text = "Your help will be repaid with sincerencess"}, {code = 'tishaemilysex', name = 'Sisters Love', unlocked = false, text = 'Let two sisters bond with each other'}]
},
cali = {
unlocked = false, name = 'Cali', descript = chardescript.cali, sprite = 'calineutral', naked = 'calinakedhappy', nakedunlocked = false, 
scenes = [{code = 'calivirgin', name = "Cali's first time", unlocked = false, text = 'Young girl might feel stronger about you, if there were no rush'}]
},
chloe = {
unlocked = false, name = 'Chloe', descript = chardescript.chloe, sprite = 'chloeneutral', naked = 'chloenakedneutral', nakedunlocked = false, 
scenes = [{code = 'chloemana', name = 'Mana harvest', unlocked = false, text = 'Trade with Benefits'}, {code = 'chloeforest', name = 'Gnome in need', unlocked = false, text = 'An accident in the forest'}]
},
yris = {
unlocked = false, name = 'Yris', descript = chardescript.yris, sprite = 'yrisnormal', naked = 'yrisnormalnaked', nakedunlocked = false, 
scenes = [{code = 'yrisblowjob', name = 'First Bet', unlocked = false, text = 'Her bets can be tough'}, {code = 'yrissex', name = 'Second Bet', unlocked = false, text = 'Eventual success'}, {code = 'yrissex2', name = 'Third Bet', unlocked = false, text = 'A Breakthrough'}]
},
zoe = {
unlocked = false, name = 'Zoe', descript = chardescript.zoe, sprite = 'zoeneutral', naked = 'zoeneutralnaked', nakedunlocked = false,
scenes = []
},
ayneris = {
unlocked = false, name = 'Ayneris', descript = chardescript.ayneris, sprite = 'aynerisneutral', naked = 'aynerisneutralnaked', nakedunlocked = false,
scenes = [{code = 'aynerispunish', name = 'Dirty Punishment', unlocked = false, text = 'Even rich need discipline'}, {code = 'aynerissex', name = 'Advanced Punishment',unlocked = false, text = 'Additional Discipline... might go too far'}]
},
melissa = {
unlocked = false, name = 'Melissa', descript = chardescript.melissa, sprite = 'melissafriendly', naked = 'null', nakedunlocked = false, 
scenes = []
},
maple = {
unlocked = false, name = 'Maple', descript = chardescript.fairy, sprite = 'fairy', naked = 'fairynaked', nakedunlocked = false,
scenes = [{code = 'mapleflirt', name = 'Risky Affair', unlocked = false, text = 'Build relationship sooner'},{code = 'mapleflirt2', name = 'Repeating Affair', unlocked = false, text = 'Foregone conclusion'}]
},
ayda = {
unlocked = false, name = 'Ayda', descript = chardescript.ayda, sprite = 'aydanormal', naked = 'null', nakedunlocked = false,
scenes = []
},
garthor = {
unlocked = false, name = 'Garthor', descript = chardescript.garthor, sprite = 'garthor', naked = 'null', nakedunlocked = false,
scenes = []
},
theron = {
unlocked = false, name = 'Theron', descript = chardescript.theron, sprite = 'theron', naked = 'null', nakedunlocked = false,
scenes = []
},
hade = {
unlocked = false, name = 'Hade', descript = chardescript.hade, sprite = 'hadeneutral', naked = 'null', nakedunlocked = false,
scenes = []
},
} setget charactergallery_set

func charactergallery_set(value):
	charactergallery = value
	globals.overwritesettings()


func create(code):
	if characters.has(code):
		var slave = globals.newslave(characters[code].basics[0], characters[code].basics[1],characters[code].basics[2],characters[code].basics[3])
		slave.cleartraits()
		if slave.age == 'child' && globals.rules.children == false:
			slave.age = 'teen'
		for i in characters[code]:
			if i != 'basics':
				slave[i] = characters[code][i]
		return slave
	else:
		return "Character not found: " + code


var characters = {
Melissa = {
basics = ['Human', 'adult', 'female', 'noble'],
name = 'Melissa',
surname = '',
titssize = 'big',
asssize = 'average',
beautybase = 84,
hairlength = 'shoulder',
height = 'average',
haircolor = 'brown',
eyecolor = 'green',
hairstyle = 'straight',
vagvirgin = false,
unique = 'Melissa',
imageportait = "res://files/images/melissa/melissaportrait.png",
obed = 20,
cour = 77,
conf = 90,
wit = 97,
charm = 84,
skin = 'fair',
traits = ['Authority']
},
Emily = {
basics = ['Human', 'teen', 'female', 'poor'],
name = 'Emily',
surname = 'Hale',
titssize = 'small',
asssize = 'small',
beautybase = 33,
hairlength = 'neck',
height = 'average',
haircolor = 'brown',
eyecolor = 'gray',
hairstyle = 'straight',
vagvirgin = true,
unique = 'Emily',
tags = ['nosex'],
relatives = {father = -1, mother = 2, siblings = [], children =[]},
imageportait = "res://files/images/emily/emilyportrait.png",
obed = 80,
cour = 35,
conf = 28,
wit = 54,
charm = 41,
skin = 'pale',
traits = ['Small Eater']
},
Tisha = {
basics = ['Human', 'adult', 'female', 'commoner'],
name = 'Tisha',
surname = 'Hale',
unique = 'Tisha',
beautybase = 80,
haircolor = 'auburn',
hairlength = 'waist',
hairstyle = 'braid',
titssize = 'big',
asssize = 'average',
skin = 'fair',
eyecolor = 'gray',
vagvirgin = false,
cour = 65,
conf = 58,
wit = 39,
charm = 71,
height = 'average',
relatives = {father = -1, mother = 2, siblings = [], children =[]},
imageportait = "res://files/images/tisha/tishaportrait.png",
traits = ['Hard Worker']
},
Cali = {
basics = ['Halfkin Wolf', 'child', 'female', 'commoner'],
name = 'Cali',
surname = '',
titssize = 'flat',
asssize = 'small',
beautybase = 55,
hairlength = 'shoulder',
height = 'short',
haircolor = 'gray',
eyecolor = 'blue',
eyeshape = 'slit',
hairstyle = 'straight',
skin = 'fair',
imageportait = 'res://files/images/cali/caliportrait.png',
vagvirgin = true,
obed = 65,
cour = 47,
conf = 55,
wit = 35,
charm = 20,
unique = "Cali",
traits = ['Sturdy']
},
Chloe = {
basics = ['Gnome', 'adult', 'female', 'commoner'],
name = 'Chloe',
unique = 'Chloe',
surname = '',
titssize = 'average',
asssize = 'big',
beautybase = 60,
hairlength = 'shoulder',
height = 'tiny',
haircolor = 'red',
eyecolor = 'blue',
skin = 'fair',
hairstyle = 'twintails',
vagvirgin = false,
imageportait = 'res://files/images/chloe/chloeportrait.png',
cour = 57,
conf = 34,
wit = 77,
charm = 51,
obed = 90,
traits = ['Grateful', 'Gifted']
},
Tia = {
basics = ['Human', 'teen', 'female', 'commoner'],
name = 'Tia',
surname = '',
beautybase = 75,
haircolor = 'brown',
hairlength = 'waist',
hairstyle = 'straight',
titssize = 'small',
asssize = 'small',
skin = 'fair',
eyecolor = 'blue',
vagvirgin = true,
cour = 23,
conf = 31,
wit = 55,
charm = 82,
height = 'short',
},
Ayneris = {
basics = ['Elf', 'teen', 'female', 'noble'],
name = 'Ayneris',
unique = 'Ayneris',
imageportait = "res://files/images/ayneris/aynerisportrait.png",
surname = '',
titssize = 'average',
asssize = 'average',
beautybase = 65,
hairlength = 'waist',
height = 'average',
haircolor = 'blond',
eyecolor = 'blue',
skin = 'fair',
hairstyle = 'straight',
vagvirgin = false,
cour = 65,
conf = 88,
wit = 51,
charm = 48,
level = 2,
sagi = 2,
sstr = 1,
skillpoints = 2,
obed = 90,
traits = ['Grateful', 'Nimble']
},
Yris = {
basics = ['Beastkin Cat', 'adult', 'female', 'commoner'],
name = 'Yris',
unique = 'Yris',
surname = '',
titssize = 'big',
asssize = 'average',
beautybase = 72,
hairlength = 'neck',
height = 'average',
haircolor = 'blond',
eyecolor = 'blue',
eyeshape = 'slit',
skin = 'fair',
furcolor = 'orange_white',
hairstyle = 'straight',
vagvirgin = false,
charm = 71,
wit = 62,
cour = 33,
conf = 48,
imageportait = "res://files/images/yris/yrisportrait.png",
sagi = 1,
send = 1,
loyal = 25,
obed = 90,
traits = ['Grateful', 'Scoundrel']
},
Maple = {
basics = ['Fairy', 'adult', 'female', 'rich'],
name = 'Maple',
unique = 'Maple',
surname = '',
titssize = 'average',
asssize = 'small',
beautybase = 74,
hairlength = 'shoulder',
height = 'tiny',
haircolor = 'red',
eyecolor = 'red',
skin = 'fair',
hairstyle = 'straight',
vagvirgin = false,
imageportait = 'res://files/images/maple/mapleportrait.png',
cour = 65,
conf = 73,
wit = 69,
charm = 92,
level = 5,
skillpoints = 14,
obed = 90,
traits = ['Grateful', 'Influential']
},
Zoe = {
basics = ['Beastkin Wolf', 'teen', 'female', 'noble'],
name = 'Zoe',
unique = 'Zoe',
surname = '',
beautybase = 45,
haircolor = 'brown',
hairlength = 'shoulder',
hairstyle = 'straight',
titssize = 'average',
asssize = 'average',
skin = 'fair',
eyecolor = 'red',
vagvirgin = true,
cour = 45,
conf = 55,
wit = 87,
charm = 66,
height = 'average',
furcolor = 'gray',
obed = 90,
loyal = 25,
imageportait = 'res://files/images/zoe/zoeportrait.png',
smaf = 1,
traits = ['Grateful', 'Mentor']
},
}

var sprites = {
chancellor = load("res://files/images/chancellor.png"),
merchant = load("res://files/images/merchant.png"),
fairy = load("res://files/images/maple/maple.png"),
fairynaked = load("res://files/images/maple/maplenaked.png"),
melissafriendly = load("res://files/images/melissa/melissafriendly.png"),
melissaneutral = load("res://files/images/melissa/melissaneutral.png"),
melissaworried = load("res://files/images/melissa/melissaworried.png"),
melissanakedfriendly = load("res://files/images/melissa/melissanakedfriendly.png"),
melissanakedneutral = load("res://files/images/melissa/melissanakedneutral.png"),
emilyhappy = load("res://files/images/emily/emilyhappy.png"),
emilynormal = load("res://files/images/emily/emilyneutral.png"),
emily2normal = load("res://files/images/emily/emily2neutral.png"),
emily2happy = load("res://files/images/emily/emily2happy.png"),
emily2worried = load("res://files/images/emily/emily2worried.png"),
emilynakedhappy = load("res://files/images/emily/emilynakedhappy.png"),
emilynakedneutral = load("res://files/images/emily/emilynakedneutral.png"),
calineutral = load("res://files/images/cali/calineutral.png"),
calihappy = load("res://files/images/cali/calihappy.png"),
calinakedhappy = load("res://files/images/cali/calinakedneutral.png"),
calinakedangry = load("res://files/images/cali/calinakedangry.png"),
caliangry = load("res://files/images/cali/caliangry.png"),
calisad = load("res://files/images/cali/calisad.png"),
calinakedsad = load("res://files/images/cali/calinakedsad.png"),
sebastian = load("res://files/images/sebastian.png"),
tishahappy = load("res://files/images/tisha/tishahappy.png"),
tishaneutral = load("res://files/images/tisha/tishaneutral.png"),
tishaangry = load("res://files/images/tisha/tishaangry.png"),
tishashocked = load("res://files/images/tisha/tishashocked.png"),
tishanakedhappy = load("res://files/images/tisha/tishanakedhappy.png"),
tishanakedneutral = load("res://files/images/tisha/tishanakedneutral.png"),
chloehappy = load("res://files/images/chloe/chloehappy.png"),
chloenakedhappy = load("res://files/images/chloe/chloenakedhappy.png"),
chloeneutral = load("res://files/images/chloe/chloeneutral.png"),
chloenakedneutral = load("res://files/images/chloe/chloenakedneutral.png"),
chloehappy2 = load("res://files/images/chloe/chloehappy2.png"),
chloeshy2 = load("res://files/images/chloe/chloeshy2.png"),
chloenakedshy = load("res://files/images/chloe/chloenakedshy.png"),
chloeneutral2 = load("res://files/images/chloe/chloeneutral2.png"),
aydanormal = load("res://files/images/aydanormal.png"),
aydanormal2 = load("res://files/images/aydanormal2.png"),
yrisnormal = load("res://files/images/yris/yrisnormaldressed.png"),
yrisalt = load("res://files/images/yris/yrisaltdressed.png"),
yrisshock = load("res://files/images/yris/yrisshockdressed.png"),
yrisnormalnaked = load("res://files/images/yris/yrisnormalnaked.png"),
yrisaltnaked = load("res://files/images/yris/yrisaltnaked.png"),
yrisshocknaked = load("res://files/images/yris/yrisshocknaked.png"),
aynerisneutral = load("res://files/images/ayneris/aynerisneutral.png"),
aynerisangry = load("res://files/images/ayneris/aynerisangry.png"),
aynerispissed = load("res://files/images/ayneris/aynerispissed.png"),
aynerisneutralnaked = load("res://files/images/ayneris/aynerisneutralnaked.png"),
aynerisangrynaked = load("res://files/images/ayneris/aynerisangrynaked.png"),
aynerispissednaked = load("res://files/images/ayneris/aynerispissednaked.png"),
zoeneutral = load("res://files/images/zoe/zoeneutral.png"),
zoeneutralnaked = load("res://files/images/zoe/zoeneutralnaked.png"),
zoehappy = load("res://files/images/zoe/zoehappy.png"),
zoehappynaked = load("res://files/images/zoe/zoehappynaked.png"),
zoesad = load("res://files/images/zoe/zoesad.png"),
zoesadnaked = load("res://files/images/zoe/zoesadnaked.png"),

theron = load("res://files/images/theron.png"),
garthor = load("res://files/images/garthor.png"),

hadeneutral = load("res://files/images/hadeneutral.png"),
hadesmile = load("res://files/images/hadesmile.png"),
hadesad = load("res://files/images/hadesad.png"),
hadeangry = load("res://files/images/hadeangry.png"),
goblin = load("res://files/images/goblin.png"),
}

