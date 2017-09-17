extends Node


var chardescript = {
emily = "Young girl from Wimborn's orphanage. Despite her harsh life she's pretty naive and kind. ",
tisha = "Emily's older sister. Since an early age she has aimed to work hard to provide for both herself and her sister a better life than what they initially had. Being constantly abused by rich and powerful people, Tisha grew to despise others. She is rather protective towards her sister. ",
cali = "Halfkin wolf-girl who ended up in Wimborn due to some unfortunate events. Although her age and appearance might not suggest it, she is quite cheeky. ",
chloe = "A gnome girl from Shaliq village, who decided to venture out of her homeland due to her research or in search of adventure. Contrary to that, she's pretty timid and seems to be insecure about her height. ",
yris = "A beastkin resident of Gorn's bar. A Catgirl with a playful nature who loves thrill and challenges. ",
zoe = "Young member of Frostford's ruling wolven clan. Being discontent with her suggested position, she seeks a way to prove herself and try a different life. ",
ayneris = "Youngest child of a powerful elven clan with declining prosperity. Her attempts to rival her siblings didn't worked out in a way she wanted, but in return she may have discovered something exciting about herself... ",
melissa = "Second-in-command of the Wimborn's Mage's Order and your direct mentor. Despite her friendly appearance she seems to have her own undisclosed goals. ",
fairy = "One of the Wimborn Slaver Guild's main attendants. Her cheerful and friendly nature helps new customers to settle in quickly. ",
ayda = "Resident alchemist in Gorn's Palace. Though she prefers to keep to herself, she is forced to cooperate to fulfill her needs. ",
}

var charactergallery = { 
emily = {
unlocked = false, name = 'Emily Hale', descript = chardescript.emily, sprite = 'emily2normal', naked = 'emilynakedhappy', nakedunlocked = false,
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
unlocked = false, name = 'Yris', descript = chardescript.yris, sprite = 'null', naked = 'null', nakedunlocked = false, 
scenes = [{code = 'yrisblowjob', name = 'First Bet', unlocked = false, text = 'Her bets can be tough'}, {code = 'yrissex', name = 'Second Bet', unlocked = false, text = 'Eventual success'}, {code = 'yrissex2', name = 'Third Bet', unlocked = false, text = 'A Breakthrough'}]
},
zoe = {
unlocked = false, name = 'Zoe', descript = chardescript.zoe, sprite = 'null', naked = 'null', nakedunlocked = false,
scenes = []
},
ayneris = {
unlocked = false, name = 'Ayneris', descript = chardescript.ayneris, sprite = 'null', naked = 'null', nakedunlocked = false,
scenes = [{code = 'aynerispunish', name = 'Dirty Punishment', unlocked = false, text = 'Even rich need discipline'}, {code = 'aynerissex', name = 'Advanced Punishment',unlocked = false, text = 'Additional Discipline... might go too far'}]
},
melissa = {
unlocked = false, name = 'Melissa', descript = chardescript.melissa, sprite = 'melissafriendly', naked = 'null', nakedunlocked = false, 
scenes = []
},
fairy = {
unlocked = false, name = 'Guild Fairy', descript = chardescript.fairy, sprite = 'fairy', naked = 'null', nakedunlocked = false,
scenes = []
},
ayda = {
unlocked = false, name = 'Ayda', descript = chardescript.ayda, sprite = 'aydanormal', naked = 'null', nakedunlocked = false,
scenes = []
},
} setget charactergallery_set

func charactergallery_set(value):
	charactergallery = value
	globals.overwritesettings()


