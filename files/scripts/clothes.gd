
extends Node

static func costumelist():
	var array = []
	var dict = {
	common = {
	id = 1,
	code = 'common',
	name = 'Common Clothes', 
	tooltip = "Bland common clothes without much of appeal. Thankfully there's no shortage of them.",
	effect = ''
	},
	sundress = {
	id = 2,
	code = 'sundress',
	name = 'Sundress', 
	tooltip = "Simple, comfortable, and lighthearted. Perfect for relaxation and exposure to sudden wind gusts.",
	effect = ''
	},
	maid = {
	id = 3,
	code = 'maid',
	name = 'Maid Uniform', 
	tooltip = "A set of black and white frilly clothes with a mandatory skirt and garter belt. Makes cleaning duty pleasant to watch.",
	effect = ''
	},
	kimono = {
	id = 4,
	code = 'kimono',
	name = 'Kimono', 
	tooltip = "Brightly colored foreign clothes which are pretty popular for certain people.",
	effect = ''
	},
	pet = {
	id = 5,
	code = 'pet',
	name = 'Pet Suit', 
	tooltip = "Specially designed pieces which represent a domestic animal, and force the wearer to walk on all fours. For obvious reasons, this should generally not be worn outside.",
	effect = ''
	},
	ninja = {
	id = 6,
	code = 'ninja',
	name = 'Ninja Suit', 
	tooltip = "A compact and versatile outfit rumored to be used by foreign assassins.",
	effect = ''
	},
	miko = {
	id = 7,
	code = 'miko',
	name = 'Miko outfit', 
	tooltip = "Contrasting red and white clothes, originally worn by young women of certain foreign religions. They are now fetishized by certain people...",
	effect = ''
	},
	chainmail = {
	id = 8,
	code = 'chainmail',
	name = 'Chainmail Bikini', 
	tooltip = "Sexy “armor” that emphasizes the physical fitness of the wearer. Contrary to popular belief it is an impractical choice for protective wear.",
	effect = ''
	},
	bedlah = {
	id = 9,
	code = 'bedlah',
	name = 'Bedlah', 
	tooltip = "Loose, translucent clothing from southern regions, generally worn by dancers and members of a harem.",
	effect = ''
	},
	}
	for i in dict:
		array.append(dict[i])
	array.sort_custom(load("res://files/scripts/clothes.gd"), 'sort_alphabetically')
	return array

static func sort_alphabetically(value1, value2):
	if value1.id < value2.id:
		return true
	else:
		return false

static func underwearlist():
	var array = []
	var dict = {
	plain = {
	id = 1,
	code = 'plain',
	name = 'Plain Underwear',
	tooltip = "Plain white cotton underwear for everyday's life.",
	effect = '',
	},
	lacy = {
	id = 2,
	code = 'lacy',
	name = 'Lacy Underwear',
	tooltip = "Fancy and cute underwear available for people with moderate income.",
	effect = '',
	},
	naked = {
	id = 3,
	code = 'naked',
	name = 'No underwear',
	tooltip = "This may be bit too daring for many.",
	effect = '',
	},
	
	}
	for i in dict:
		array.append(dict[i])
	array.sort_custom(load("res://files/scripts/clothes.gd"), 'sort_alphabetically')
	return array

