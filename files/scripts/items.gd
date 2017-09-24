extends Node


var slave
var main


func _init():
	globals.itemdict = itemlist


var itemlist = {
food = {
	code = 'food',
	name = 'Provisions',
	icon = load("res://files/images/items/food.png"),
	description = "Various assortments of preserved food servable for daily ration. Mostly stale, yet in high demand. \nPrice for 20 units.",
	effect = "foodpurchase",
	recipe = '',
	cost = 10,
	type = 'dummy',
	amount = 0,
	unlocked = true,
},
supply = {
	code = 'supply',
	name = 'Supplies',
	icon = load("res://files/images/items/supply.png"),
	description = "An assemblance of various commodities which can be sold or used in certain tasks.",
	effect = "supplypurchase",
	recipe = '',
	cost = 5,
	type = 'ingredient',
	amount = 0,
	unlocked = true,
},
teleportwimborn = {
	code = 'teleportwimborn',
	name = 'Teleportation Stone: Wimborn',
	icon = load("res://files/images/items/teleportwimborn.png"),
	description = "A waypoint stone made by skilled Arcanesmith which allows personal transportation to specific faraway places when integrated into specifically designed mechanisms. \n\n[color=yellow]Unlocks teleportation to Wimborn.[/color] ",
	effect = "teleportunlock",
	recipe = '',
	cost = 500,
	type = 'dummy',
	amount = 0,
	unlocked = true,
},
teleportgorn = {
	code = 'teleportgorn',
	name = 'Teleportation Stone: Gorn',
	icon = load("res://files/images/items/teleportgorn.png"),
	description = "A waypoint stone made by skilled Arcanesmith which allows personal transportation to specific faraway places when integrated into specifically designed mechanisms. \n\n[color=yellow]Unlocks teleportation to Gorn.[/color] ",
	effect = "teleportunlock",
	recipe = '',
	cost = 500,
	type = 'dummy',
	amount = 0,
	unlocked = true,
},
teleportfrostford = {
	code = 'teleportfrostford',
	name = 'Teleportation Stone: Frostford',
	icon = load("res://files/images/items/teleportfrostford.png"),
	description = "A waypoint stone made by skilled Arcanesmith which allows personal transportation to specific faraway places when integrated into specifically designed mechanisms. \n\n[color=yellow]Unlocks teleportation to Frostford.[/color] ",
	effect = "teleportunlock",
	recipe = '',
	cost = 500,
	type = 'dummy',
	amount = 0,
	unlocked = true,
},
teleportamberguard = {
	code = 'teleportamberguard',
	name = 'Teleportation Stone: Amberguard',
	icon = load("res://files/images/items/teleportamberguard.png"),
	description = "A waypoint stone made by skilled Arcanesmith which allows personal transportation to specific faraway places when integrated into specifically designed mechanisms. \n\n[color=yellow]Unlocks teleportation to Amberguard.[/color]",
	effect = "teleportunlock",
	recipe = '',
	cost = 1500,
	type = 'dummy',
	amount = 0,
	unlocked = true,
},
teleportumbra = {
	code = 'teleportumbra',
	name = 'Teleportation Stone: Umbra',
	icon = load("res://files/images/items/teleportumbra.png"),
	description = "A waypoint stone made by skilled Arcanesmith which allows personal transportation to specific faraway places when integrated into specifically designed mechanisms. \n\n[color=yellow]Unlocks teleportation to Umbra.[/color] ",
	effect = "teleportunlock",
	recipe = '',
	cost = 500,
	type = 'dummy',
	amount = 0,
	unlocked = true,
},
aphrodisiac = {
	code = 'aphrodisiac',
	name = 'Aphrodisiac',
	icon = load("res://files/images/items/aphrodisiacpot.png"),
	description = "The simple dream drug of the past. Increases the drinker's lust. ",
	effect = 'aphrodisiaceffect',
	recipe = 'recipeaphrodisiac',
	cost = 75,
	type = 'potion',
	toxicity = 15,
	unlocked = false,
	amount = 0
	},
hairdye = {
	code = 'hairdye',
	name = 'Hair Dye',
	icon = load("res://files/images/items/hairdyepot.png"),
	description = "Allows you to permanently change hair color when applied. For external use only. ",
	effect = 'hairdyeeffect',
	recipe = '',
	cost = 50,
	toxicity = 0,
	unlocked = false,
	amount = 0,
	type = 'potion',
	},
hairgrowthpot = {
	code = 'hairgrowthpot',
	name = 'Hair Growth Elixir',
	icon = load("res://files/images/items/hairgrowthpot.png"),
	description = "Makes hair grow instantly! A tiny disclaimer says this potion is not a FairyCo. product. ",
	effect = 'hairgrowtheffect',
	recipe = 'recipehairgrowth',
	cost = 120,
	type = 'potion',
	toxicity = 15,
	unlocked = false,
	amount = 0
	},
maturingpot = {
	code = 'maturingpot',
	name = 'Maturing Elixir',
	icon = load("res://files/images/items/maturingpot.png"),
	description = "Causes a rapid acceleration in user's physical growth, results may vary. ",
	effect = 'maturingpot',
	recipe = 'recipematuringpot',
	cost = 200,
	type = 'potion',
	toxicity = 40,
	unlocked = false,
	amount = 0
	},
youthingpot = {
	code = 'youthingpot',
	name = 'Youthing Elixir',
	icon = load("res://files/images/items/youthingpot.png"),
	description = "Causes a regression of users's physical growth. 'Cause the smaller, the cuter. ",
	effect = 'youthingpot',
	recipe = 'recipeyouthingpot',
	cost = 200,
	type = 'potion',
	toxicity = 40,
	unlocked = false,
	amount = 0
	},
regressionpot = {
	code = 'regressionpot',
	name = 'Elixir of Regression',
	icon = load("res://files/images/items/regressionpot.png"),
	description = "Causes a regression of user's mental state to that of a child. Dangerous, but quite effective when you have a need to rehabilitate someone from their inconvenient character.",
	effect = 'regressionpoteffect',
	recipe = '',
	cost = 400,
	type = 'potion',
	toxicity = 50,
	unlocked = false,
	amount = 0
	},
amnesiapot = {
	code = 'amnesiapot',
	name = 'Amnesia Potion',
	icon = load("res://files/images/items/amnesiapot.png"),
	description = "Erases memories of the past (won't affect backstory or impactful experience). ",
	effect = 'amnesiapoteffect',
	recipe = 'recipeamnesiapot',
	cost = 200,
	type = 'potion',
	toxicity = 25,
	unlocked = false,
	amount = 0
	},
lactationpot = {
	code = 'lactationpot',
	name = 'Nursing Potion',
	icon = load("res://files/images/items/nursingpot.png"),
	description = "Special mixture causing perpetual lactation.",
	effect = 'lactationpoteffect',
	recipe = 'recipelactationpot',
	cost = 100,
	type = 'potion',
	toxicity = 20,
	unlocked = false,
	amount = 0
	},
oblivionpot = {
	code = 'oblivionpot',
	name = 'Oblivion Potion',
	icon = load("res://files/images/items/oblivionpot.png"),
	description = "The drinker of this potion experiences a form of targeted amnesia, retaining their personality but clearing their fixations.\n\n[color=aqua]Resets level-up requirement.[/color]",
	effect = 'oblivionpoteffect',
	recipe = 'recipeoblivionpot',
	cost = 300,
	type = 'potion',
	toxicity = 50,
	unlocked = false,
	amount = 0
	},
miscariagepot = {
	code = 'miscariagepot',
	name = 'Miscariage Potion',
	icon = load("res://files/images/items/miscarriagepot.png"),
	description = "The temporal solution to shortsightedness.",
	effect = 'misscariageeffect',
	recipe = 'recipemiscariagepot',
	cost = 100,
	type = 'potion',
	toxicity = 20,
	unlocked = false,
	amount = 0
	},
stimulantpot = {
	code = 'stimulantpot',
	name = 'Stimulant Potion',
	icon = load("res://files/images/items/stimulantpot.png"),
	description = "Boosts person's sensitivity and strengthens mental response.",
	effect = 'stimulanteffect',
	recipe = 'recipestimulantpot',
	cost = 150,
	type = 'potion',
	toxicity = 20,
	unlocked = false,
	amount = 0
	},
deterrentpot = {
	code = 'deterrentpot',
	name = 'Deterrent Potion',
	icon = load("res://files/images/items/deterrentpot.png"),
	description = "Dulls person's sensitivity and weakens mental response.",
	effect = 'deterrenteffect',
	recipe = 'recipedeterrentpot',
	cost = 150,
	type = 'potion',
	toxicity = 20,
	unlocked = false,
	amount = 0
	},
minoruspot = {
	code = 'minoruspot',
	name = 'Minorus Concoction',
	icon = load("res://files/images/items/minoruspot.png"),
	description = "Application of this potion will reduce cumbersome body parts to more manageable sizes. For External use only.",
	effect = 'minoruseffect',
	recipe = 'recipeminoruspot',
	cost = 250,
	type = 'potion',
	toxicity = 30,
	unlocked = false,
	amount = 0
	},
majoruspot = {
	code = 'majoruspot',
	name = 'Majorus Concoction',
	icon = load("res://files/images/items/majoruspot.png"),
	description = "Apply to various parts of someone's anatomy for rapid and fantastic results! For external use only.",
	effect = 'majoruseffect',
	recipe = 'recipemajoruspot',
	cost = 250,
	type = 'potion',
	toxicity = 30,
	unlocked = false,
	amount = 0
	},
beautypot = {
	code = 'beautypot',
	name = 'Beauty Mixture',
	icon = load("res://files/images/items/beautypot.png"),
	description = "Clears the complexion and smoothes unsightly contours. Temporal effect. Administer with care. ",
	effect = 'beautyeffect',
	recipe = '',
	cost = 50,
	type = 'potion',
	toxicity = 10,
	unlocked = false,
	amount = 0
	},
aphroditebrew = {
	code = 'aphroditebrew',
	name = 'Aphrodite Brew',
	icon = load("res://files/images/items/aphroditespot.png"),
	description = "Extremely potent mixture of aphrodisiacs. Even slightest amounts of this can easily dim person's mind and awake their carnal desires. \n[color=yellow]Can't be used for single person, required to start orgy. [/color]",
	effect = '',
	recipe = 'recipeaphroditebrew',
	cost = 400,
	type = 'ingredient',
	unlocked = false,
	amount = 0
	},
basicsolutioning = {
	code = 'basicsolutioning',
	name = 'Basic Solution',
	icon = load("res://files/images/items/basicsolution.png"),
	description = "Primal ingredient which is used as base for many potions.",
	effect = '',
	recipe = '',
	cost = 20,
	type = 'ingredient',
	unlocked = false,
	amount = 0
	},
magicessenceing = {
	code = 'magicessenceing',
	name = 'Magic Essence',
	icon = load("res://files/images/items/magicessence.png"),
	description = "A gleaming fluid, rich with potent energy.",
	effect = '',
	recipe = '',
	cost = 50,
	type = 'ingredient',
	unlocked = false,
	amount = 0
	},
taintedessenceing = {
	code = 'taintedessenceing',
	name = 'Tainted Essence',
	icon = load("res://files/images/items/taintedessence.png"),
	description = "A dark fluid, imbued with corrupting magic.",
	effect = '',
	recipe = '',
	cost = 50,
	type = 'ingredient',
	unlocked = false,
	amount = 0
	},
natureessenceing = {
	code = 'natureessenceing',
	name = 'Nature Essence',
	icon = load("res://files/images/items/natureessence.png"),
	description = "A clear fluid, rich with raw life-energy.",
	effect = '',
	recipe = '',
	cost = 50,
	type = 'ingredient',
	unlocked = false,
	amount = 0
	},
bestialessenceing = {
	code = 'bestialessenceing',
	name = 'Bestial Essence',
	icon = load("res://files/images/items/beastessence.png"),
	description = "A pale and milky fluid, rich with vigorous energy.",
	effect = '',
	recipe = '',
	cost = 50,
	type = 'ingredient',
	unlocked = false,
	amount = 0
	},
fluidsubstanceing = {
	code = 'fluidsubstanceing',
	name = 'Fluid Substance',
	icon = load("res://files/images/items/fluidsubstance.png"),
	description = "An oily transparent liquid with some unique abilities. Sometimes used as cheap lubricant. ",
	effect = '',
	recipe = '',
	cost = 50,
	type = 'ingredient',
	unlocked = false,
	amount = 0
	},
gem = {
	code = 'gem',
	name = 'Precious Gem',
	icon = load("res://files/images/items/gemstone.png"),
	description = "An unusually big precious gem. Traders will likely pay a huge sum for it. ",
	effect = '',
	recipe = '',
	cost = 1250,
	type = 'ingredient',
	unlocked = false,
	amount = 0
	},
	
	
	
	######################################GEAR
clothcommon = {
	code = 'clothcommon',
	name = 'Common Clothes',
	iconbig = true,
	icon = load("res://files/images/items/clothcommon.png"),
	description = "Bland common clothes without much of appeal. Thankfully there's no shortage of them.",
	effect = '',
	recipe = '',
	reqs = null,
	cost = 0,
	type = 'gear',
	subtype = 'costume',
	amount = -1,
	unlocked = true,
},
clothsundress = {
	code = 'clothsundress',
	name = 'Sundress',
	icon = load("res://files/images/items/sundress.png"),
	iconbig = true,
	description = "Simple, comfortable, and lighthearted. Perfect for relaxation and exposure to sudden wind gusts.",
	effect = [{type = 'onendday', effect = 'sundresseffect', descript = "Reduces Stress by the end of a day"}],
	recipe = '',
	reqs = null,
	cost = 75,
	type = 'gear',
	subtype = 'costume',
	amount = 0,
	unlocked = true,
},
clothmaid = {
	code = 'clothmaid',
	name = 'Maid Uniform',
	icon = load("res://files/images/items/maiduniform.png"),
	iconbig = true,
	description = "A set of black and white frilly clothes with a mandatory skirt and garter belt. Makes cleaning duty pleasant to watch.",
	effect = [{type = 'onendday', effect = 'maiduniformeffect', descript = "Increases Obedience by the end of a day"}],
	recipe = '',
	reqs = null,
	cost = 75,
	type = 'gear',
	subtype = 'costume',
	amount = 0,
	unlocked = true,
},
clothkimono = {
	code = 'clothkimono',
	name = 'Kimono',
	icon = load("res://files/images/items/clothkimono.png"),
	description = "Brightly colored foreign clothes which are pretty popular for certain people.",
	effect = [{type = 'onequip', effect = 'beauty', effectvalue = 10, descript = "Slightly increases beauty"}],
	recipe = '',
	reqs = null,
	cost = 150,
	type = 'gear',
	subtype = 'costume',
	amount = 0,
	unlocked = true,
},
clothmiko = {
	code = 'clothmiko',
	name = 'Miko Outfit',
	icon = load("res://files/images/items/clothmiko.png"),
	description = "Contrasting red and white clothes, originally worn by young women of certain foreign religions. They are now fetishized by certain people...",
	effect = [{type = 'onendday', effect = 'mikoeffect', descript = "Reduces stress and lust by the end of a day"}],
	recipe = '',
	reqs = null,
	cost = 200,
	type = 'gear',
	subtype = 'costume',
	amount = 0,
	unlocked = true,
},
clothninja = {
	code = 'clothninja',
	name = 'Ninja Suit',
	icon = load("res://files/images/items/clothninja.png"),
	description = "A compact and versatile outfit rumored to be used by foreign assassins.",
	effect = [{type = 'onequip', effect = 'agi', effectvalue = 1, descript = "+1 Agility"}],
	recipe = '',
	reqs = null,
	cost = 200,
	type = 'gear',
	subtype = 'costume',
	amount = 0,
	unlocked = true,
},
clothpet = {
	code = 'clothpet',
	name = 'Pet Suit',
	icon = load("res://files/images/items/clothpet.png"),
	description = "Specially designed pieces of leather decoration which represent a domestic animal, and force the wearer to walk on all fours. For obvious reasons, this should generally not be worn outside.",
	effect = [{type = 'onendday', effect = 'peteffect', descript = "Greatly increases obedience. If Confidence above 40, cause stress penalty and lowers it by the end of a day."}],
	recipe = '',
	reqs = null,
	cost = 250,
	type = 'gear',
	subtype = 'costume',
	amount = 0,
	unlocked = true,
},
clothchain = {
	code = 'clothchain',
	name = 'Chainmail Bikini',
	icon = null,
	description = "Sexy “armor” that emphasizes the physical fitness of the wearer. Contrary to popular belief it is an impractical choice for protective wear.",
	effect = [{type = 'onequip', effect = 'armor', effectvalue = 1, descript = "+1 Armor"}],
	recipe = '',
	reqs = null,
	cost = 250,
	type = 'gear',
	subtype = 'costume',
	amount = 0,
	unlocked = true,
},
clothbutler = {
	code = 'clothbutler',
	name = 'Butlers Uniform',
	icon = load("res://files/images/items/clothbutler.png"),
	description = "This is the uniform of a butler, a well fitted suit comprising of a double-breasted coat, waistcoat and trousers, along with a small black tie.",
	effect = [{type = 'onendday', effect = 'butleruniformeffect', descript = "Increases Obedience by the end of a day"}],
	recipe = '',
	reqs = null,
	cost = 75,
	type = 'gear',
	subtype = 'costume',
	amount = 0,
	unlocked = true,
},
clothbedlah = {
	code = 'clothbedlah',
	name = 'Bedlah',
	icon = load("res://files/images/items/clothbedlah.png"),
	description = "Loose, translucent clothing from southern regions, generally worn by dancers and members of a harem.",
	effect = [{type = 'onendday', effect = 'bedlaheffect', descript = "Slightly increases Charm by the end of a day."}],
	recipe = '',
	reqs = null,
	cost = 250,
	type = 'gear',
	subtype = 'costume',
	amount = 0,
	unlocked = true,
},
underwearplain = {
	code = 'underwearplain',
	name = 'Plain Underwear',
	icon = load("res://files/images/items/underwear.png"),
	iconbig = true,
	description = "Plain white cotton underwear for everyday life.",
	effect = "",
	recipe = '',
	reqs = null,
	cost = 0,
	type = 'gear',
	subtype = 'underwear',
	amount = -1,
	unlocked = true,
},
underwearlacy = {
	code = 'underwearlacy',
	name = 'Lacy Underwear',
	icon = load("res://files/images/items/underwearlacy.png"),
	description = "Fancy and cute underwear available for people with moderate income.\n[color=green]Increases slave's luxury[/color]",
	effect = [],
	recipe = '',
	reqs = null,
	cost = 100,
	type = 'gear',
	subtype = 'underwear',
	amount = 0,
	unlocked = true,
},
underwearboxers = {
	code = 'underwearboxers',
	name = 'Silk Boxers',
	icon = load("res://files/images/items/underwearboxers.png"),
	description = "Fancy and comfortable male underwear available for people with moderate income.\n[color=green]Increases slave's luxury[/color]",
	effect = [],
	recipe = '',
	reqs = null,
	cost = 100,
	type = 'gear',
	subtype = 'underwear',
	amount = 0,
	unlocked = true,
},
armorleather = {
	code = 'armorleather',
	name = 'Leather Armor',
	icon = load("res://files/images/items/armorleather.png"),
	description = "Suit of tanned leather, providing some protection while not restricting movement too much.",
	effect = [{type = 'onequip', effect = 'armor', effectvalue = 2, descript = "+2 Armor"}],
	recipe = '',
	reqs = null,
	cost = 100,
	type = 'gear',
	subtype = 'armor',
	amount = 0,
	unlocked = true,
},
armorchain = {
	code = 'armorchain',
	name = 'Chain Armor',
	icon = load("res://files/images/items/armorchain.png"),
	description = "A finely crafted suit of armor created from interwoven iron rings. Offers reasonable protection against sharp objects. ",
	effect = [{type = 'onequip', effect = 'armor', effectvalue = 5, descript = "+5 Armor"}],
	recipe = '',
	reqs = null,
	cost = 250,
	type = 'gear',
	subtype = 'armor',
	amount = 0,
	unlocked = true,
},
armorelvenchain = {
	code = 'armorelvenchain',
	name = 'Elven Chain Armor',
	icon = load("res://files/images/items/armorelvenchain.png"),
	description = "A suit of elvish armor created from interwoven mithril rings. It is supple and light yet provides ample protection.",
	effect = [{type = 'onequip', effect = 'armor', effectvalue = 7, descript = "+7 Armor"}, {type = 'incombat', effect = 'speed', effectvalue = 3, descript = "+5 speed"}],
	recipe = '',
	reqs = null,
	cost = 500,
	type = 'gear',
	subtype = 'armor',
	amount = 0,
	unlocked = true,
},
armorplate = {
	code = 'armorplate',
	name = 'Plate Armor',
	icon = load("res://files/images/items/armorplate.png"),
	description = "An old, durable suit of plate armor. Protects the wearer against most physical damage. ",
	effect = [{type = 'onequip', effect = 'armor', effectvalue = 10, descript = "+10 Armor"}],
	recipe = '',
	reqs = null,
	cost = 750,
	type = 'gear',
	subtype = 'armor',
	amount = 0,
	unlocked = true,
},
armorrobe = {
	code = 'armorrobe',
	name = "Wizard's Robe",
	icon = load("res://files/images/items/armorrobe.png"),
	description = "Despite what might appear as a clunky piece of clothing, combat robes allow the wearer to hold and hide various items and potions for quick and unexpected use and don't restrict movement. Outer fabric is easily torn to prevent grabbing and tuckling and can be quickly repaired with magic later. ",
	effect = [{type = 'onequip', effect = 'armor', effectvalue = 4, descript = "+4 Armor"},{type = 'onequip', effect = 'maf', effectvalue = 1, descript = "+1 Magic Affinity"}],
	recipe = '',
	reqs = null,
	cost = 350,
	type = 'gear',
	subtype = 'armor',
	amount = 0,
	unlocked = true,
},
weapondagger = {
	code = 'weapondagger',
	name = 'Dagger',
	icon = load("res://files/images/items/weapondagger.png"),
	description = "A simple weapon providing bare minimum of physical power. ",
	effect = [{type = 'incombat', effect = 'damage', effectvalue = 4, descript = "+4 Damage"}],
	recipe = '',
	reqs = null,
	cost = 50,
	type = 'gear',
	subtype = 'weapon',
	amount = 0,
	unlocked = true,
},
weaponsword = {
	code = 'weaponsword',
	name = 'Long Sword',
	icon = load("res://files/images/items/weaponsword.png"),
	description = "Medium sized sword perfectly balanced for close combat. ",
	effect = [{type = 'incombat', effect = 'damage', effectvalue = 7, descript = "+7 Damage"}],
	recipe = '',
	reqs = null,
	cost = 150,
	type = 'gear',
	subtype = 'weapon',
	amount = 0,
	unlocked = true,
},
weaponclaymore = {
	code = 'weaponclaymore',
	name = 'Claymore',
	icon = load("res://files/images/items/weaponclaymore.png"),
	description = "Large, two-handed sword for extra punch. Slows the wielder a little due to its size and weight.\n[color=yellow]Requirements: 2 Strength[/color] ",
	effect = [{type = 'incombat', effect = 'damage', effectvalue = 12, descript = "+12 Damage"}, {type = 'incombat', effect = 'speed', effectvalue = -3, descript = "-3 speed"}],
	recipe = '',
	reqs = [{reqstat = 'sstr', oper = 'gte', reqvalue = 2}],
	cost = 450,
	type = 'gear',
	subtype = 'weapon',
	amount = 0,
	unlocked = true,
},
accgoldring = {
	code = 'accgoldring',
	name = 'A Golden Ring',
	icon = load("res://files/images/items/goldring.png"),
	description = "This finely crafted gold ring comprises of two intertwined bands.\n[color=green]Increases slave's luxury[/color]",
	effect = [],
	recipe = '',
	reqs = null,
	cost = 250,
	type = 'gear',
	subtype = 'accessory',
	amount = 0,
	unlocked = true,
},
accslavecollar = {
	code = 'accslavecollar',
	name = 'A Leather Slave Collar',
	icon = load("res://files/images/items/collar.png"),
	description = "This leather collar is designed to fit tightly around the neck. It has rings to which bindings can be attached.\n",
	effect = [{type = 'onendday', effect = 'slavecollareffect', descript = "Increases Obedience by the end of a day. "}],
	recipe = '',
	reqs = null,
	cost = 150,
	type = 'gear',
	subtype = 'accessory',
	amount = 0,
	unlocked = true,
},
acchandcuffs = {
	code = 'acchandcuffs',
	name = 'A Pair Of Handcuffs',
	icon = load("res://files/images/items/handcuffs.png"),
	description = "These handcuffs are lightly padded but robust enough to secure even the most troublesome slave.\n",
	effect = [{type = 'onendday', effect = 'handcuffeffect', descript = "Increases Obedience by the end of a day and prevents escapes. "}],
	recipe = '',
	reqs = null,
	cost = 250,
	type = 'gear',
	subtype = 'accessory',
	amount = 0,
	unlocked = true,
},

}

func armor(value):
	slave.stats.armor_cur += value

func agi(value):
	slave.stats.agi_mod += value

func stren(value):
	slave.stats.str_mod += value

func maf(value):
	slave.stats.maf_mod += value

func end(value):
	slave.stats.end_mod += value

func beauty(value):
	slave.beautytemp += value

func checkreqs(item):
	if item.reqs == null:
		return true
	for i in item.reqs:
		if i.oper == 'gte':
			if slave[i.reqstat] < i.reqvalue:
				return false
		elif i.oper == 'lte':
			if slave[i.reqstat] > i.reqvalue:
				return false
		elif i.oper == 'eq':
			if slave[i.reqstat] != i.reqvalue:
				return false
	return true

### CLOTH EFFECTS
func sundresseffect(slave):
	slave.stress -= rand_range(4,8)
	return "$name's sundress help $him slightly relax.\n"

func maiduniformeffect(slave):
	slave.obed += rand_range(5,10)
	return "$name's maid uniform inspires $him to be more obedient.\n"

func kimonoeffect(slave):
	pass

func peteffect(slave):
	var text = slave.dictionary("$name wears pet suit ")
	slave.obed += rand_range(8,16)
	if slave.conf >= 40 && slave.traits.has('Submissive') == false:
		text += slave.dictionary("and is very unhappy about it, although $his obedience grows.\n")
		slave.stress += rand_range(5,10)
		slave.conf += rand_range(-2,-4)
	else:
		text += slave.dictionary("and $his obedience grows.\n")
	return text

func mikoeffect(slave):
	var text = slave.dictionary("$name's miko outfit helps $him to collect $his thoughts and calm down.\n")
	slave.stress += rand_range(-3,-5)
	slave.lust = rand_range(-4,-6)
	return text

func bedlaheffect(slave):
	var text = slave.dictionary("$name's revealing clothes teach $him how to better present $himself to others. \n")
	slave.charm += rand_range(1,3)
	return text

func chainbikinieffect(slave):
	return

func butleruniformeffect(slave):
	slave.obed += rand_range(5,10)
	return "$name is at your beck and call dressed as a butler $his obedience grows.\n"

func slavecollareffect(slave):
	var text = "$name "
	if slave.traits.has('Submissive') == true:
		text += "happily wears the leather collar about $his neck showing $he is your slave.\n"
		slave.loyal += rand_range(1,3)
	else:
		if slave.obed >= 70:
			text += "obediently wears the leather collar learning $his place.\n"
			slave.obed += rand_range(3,6)
		else:
			text += "picks at the leather collar begging you to take it off.\n"
			slave.obed += rand_range(3,6)
			slave.stress += rand_range(3,6)
	return text
	
func handcuffeffect(slave):
	var text = "$name "
	if slave.traits.has('Deviant') == true:
		text += "becomes more aroused being bound by the handcuffs.\n"
		slave.lust += rand_range(5,10)
		slave.obed += rand_range(3,6)
	else:
		if slave.obed >= 75:
			text += "attempts to do their daily tasks while handcuffed behind $his back.\n"
			slave.obed += rand_range(3,6)
			slave.dom += rand_range(-1,-3)
		else:
			text += "becomes more stressed as $he struggles to do $his daily tasks while handcuffed behind $his back.\n"
			slave.obed += rand_range(3,6)
			slave.stress += rand_range(5,10)
			slave.dom += rand_range(-1,-3)
	return text


func createunstackable(itemcode):
	var item = itemlist[itemcode]
	var tempitem = {code = item.code, type = item.subtype, name = item.name, owner = null, effects = item.effect, enchant = null, reqs = item.reqs, icon = item.icon, description = item.description}
	tempitem.id = "I" + str(globals.state.itemcounter) 
	globals.state.itemcounter += 1
	return tempitem

func aphrodisiaceffect():
	if slave == globals.player:
		return('You decide this potion is not going to benefit you at all.')
	slave.lust += 25
	var text = slave.dictionary("After ingesting an aphrodisiac, $name begins showing signs of growing excitement.")
	return text

func regressionpoteffect():
	if slave == globals.player:
		return('You decide this potion is not going to benefit you at all.')
	slave.trait_remove('Uncivilized')
	slave.add_trait(globals.origins.trait('Pliable'))
	slave.add_trait(globals.origins.trait('Regressed'))
	slave.loyal += rand_range(15,25)
	var text = slave.dictionary("As $name drinks the potion, the look on $his face becomes less and less focused, until eventually $his mind is reformed back into a very young and learning state. With this you can leave much greater impact on $his consciousness. ")
	return text

func hairdyeeffect():
	get_node("hairdyepanel/TextEdit").set_text('')
	get_node("hairdyepanel").set_hidden(false)

func hairgrowtheffect():
	var text = ''
	var list = globals.hairlengtharray
	if slave.hairlength != 'hips':
		slave.hairlength = list[list.find(slave.hairlength)+1]
		text = "Applying the elixir to $his hair, $name shows almost instant growth as $his hair gains new length."
	else:
		text = "The Hairgrowth Elixir isn't effective as $name applies it, as $his hair is already overly long."
	if slave == globals.player:
		text = text.replace("$name's", 'your')
		text = text.replace("$name", 'you')
	return text

func maturingpot():
	var text = ''
	if slave.age != 'adult':
		slave.age = globals.agesarray[globals.agesarray.find(slave.age)+1]
		if slave == globals.player:
			text = slave.dictionary('You chug down an Elixir of Maturity and observe new changes in a nearby mirror. ')
		else:
			text = slave.dictionary('You hand an Elixir of Maturity to $name, and tell $him to drink it. After a few moments, $his body begins to change. $He looks down in bewilderment, then checks out $his new, more mature-looking self in a nearby mirror. ')
		if rand_range(1,10) > 5 && slave.height != 'tiny' && slave.height != 'towering':
			slave.height = globals.heightarray[globals.heightarray.find(slave.height)+1]
			text = text + "$name has become taller. "
		if rand_range(1,10) > 5 && slave.hairlength != 'hips':
				slave.hairlength = globals.hairlengtharray[globals.hairlengtharray.find(slave.hairlength)+1]
				text = text + "$name's hair has grown longer. "
		if slave.sex != 'male':
			if rand_range(1,10) > 5 && slave.ass != 'huge':
				slave.ass = globals.sizearray[globals.sizearray.find(slave.ass)+1]
				text = text + "$name's butt has grown bigger. "
			if rand_range(1,10) > 5 && slave.tits.size != 'huge':
				slave.tits.size = globals.sizearray[globals.sizearray.find(slave.tits.size)+1]
				text = text + "$name's tits have grown bigger. "
		if slave.penis.number > 0:
			if rand_range(1,10) > 5 && slave.penis.size != 'big':
				slave.penis.size = globals.genitaliaarray[globals.genitaliaarray.find(slave.penis.size)+1]
				text = text + "$name's cock has grown bigger. "
		if slave.balls != 'none':
			if rand_range(1,10) > 5 && slave.balls != 'big':
				slave.balls = globals.genitaliaarray[globals.genitaliaarray.find(slave.balls)+1]
				text = text + "$name's balls have grown bigger. "
	else:
		text = 'Elixir of Maturity had no visible effect on $name. '
	if slave == globals.player:
		text = text.replace("$name's", 'Your')
		text = text.replace("$name", 'You')
	return text

func youthingpot():
	var text = ''
	if (slave.age != 'child' && globals.rules.children == true) || slave.age == 'adult':
		slave.age = globals.agesarray[globals.agesarray.find(slave.age)-1]
		if slave == globals.player:
			text = slave.dictionary('You chug down an Elixir of Youth and observe new changes in a nearby mirror. ')
		else:
			text = slave.dictionary('You hand an Elixir of Youth over to $name and tell $him to drink it. After a few moments, $his body begins to change. $He looks down in bewilderment, then checks out $his new, younger-looking self in a nearby mirror. ')
		if rand_range(1,10) > 5 && slave.height != 'tiny' && slave.height != 'petite':
			slave.height = globals.heightarray[globals.heightarray.find(slave.height)-1]
			text = text + "$name has become shorter. "
		if slave.sex != 'male':
			if rand_range(1,10) > 5 && slave.ass != 'flat':
				slave.ass = globals.sizearray[globals.sizearray.find(slave.ass)-1]
				text = text + "$name's butt shrinks in size. "
			if rand_range(1,10) > 5 && slave.tits.size != 'flat':
				slave.tits.size = globals.sizearray[globals.sizearray.find(slave.tits.size)-1]
				text = text + "$name's tits shrink in size. "
		if slave.penis.number > 0:
			if rand_range(1,10) > 5 && slave.penis.size != 'small':
				slave.penis.size = globals.genitaliaarray[globals.genitaliaarray.find(slave.penis.size)-1]
				text = text + "$name's cock shrinks in size. "
		if slave.balls != 'none':
			if rand_range(1,10) > 5 && slave.balls != 'small':
				slave.balls = globals.genitaliaarray[globals.genitaliaarray.find(slave.balls)-1]
				text = text + "$name's balls shrink in size. "
	else:
		text = 'Elixir of Youth had no visible effect on $name. '
	if slave == globals.player:
		text = text.replace("$name's", 'Your')
		text = text.replace("$name", 'You')
	return text

func amnesiapoteffect():
	if slave == globals.player:
		return('You decide this potion is not going to benefit you at all.')
	var text = ''
	text = slave.dictionary('After chugging down the Amnesia Potion, $name looks lightheaded and confused. "W-what was that? I feel like I have forgotten something..." $He is lost, unable to recall the memories of the time before $his confinement as your servant. ')
	if slave.effects.has('captured'):
		slave.add_effect(globals.effectdict.captured, true)
		text = text + slave.dictionary('Memories from before $his confinement no longer influence $him to resist you. ')
	if slave.loyal < 50 && slave.memory != 'clear':
		text = text + slave.dictionary("$He grows closer to you, having no one else $he can rely on. ")
		slave.loyal += rand_range(15,25) - slave.conf/10
	slave.memory = 'clear'
	return text

func lactationpoteffect():
	var text = ''
	if slave.tits.lactation == false:
		slave.tits.lactation = true
		if slave == globals.player:
			text = slave.dictionary("A few hours after drinking the Nursing Potion, your tits start secreting milk. ")
		else:
			text = slave.dictionary("A few hours after drinking the Nursing Potion, $name's tits started secreting milk. ")
	else:
		if slave == globals.player:
			text = slave.dictionary('The Nursing Potion has no apparent effect on you, as you are already lactating. ')
		else:
			text = slave.dictionary('The Nursing Potion has no apparent effect on $name, as $he is already lactating. ')
	return text

func oblivionpoteffect():
	var text = ''
	if slave == globals.player:
		text = slave.dictionary('$name drinks the oblivion potion, forgetting all $his fixations. ')
		slave.level.reqs.clear()
	else:
		text = slave.dictionary('You drink the oblivion potion, but it seems to not have any effect on you. ')
	return text

func misscariageeffect():
	slave.preg.baby = null
	slave.preg.duration = 0
	return slave.dictionary("Drinking the miscarriage potion ends $name's pregnancy as $his body magically absorbs what had been growing inside it.")

func stimulanteffect():
	if slave == globals.player:
		return('You decide this potion is not going to benefit you at all.')
	if slave.effects.has('stimulated') == false:
		slave.add_effect(globals.effectdict.stimulated)
		return('After ingesting the potion, $name starts to act a lot more sensitive to being touched than before. ')
	else:
		return("Apparently, $name isn't greatly affected by drinking the potion as the previous effect hasn't worn off yet.")

func deterrenteffect():
	if slave == globals.player:
		return('You decide this potion is not going to benefit you at all.')
	if slave.effects.has('numbed') == false:
		slave.add_effect(globals.effectdict.numbed)
		return('After ingesting the potion, $name starts to act somewhat more dull then before. ')
	else:
		return("Apparently, $name isn't greatly affected by drinking the potion as the previous effect hasn't worn off yet.")
	if slave.traits.has("Sex-crazed"):
		slave.trait_remove('Sex-crazed')

func beautyeffect():
	var text = ''
	if slave == globals.player:
		text = slave.dictionary('You apply the Beauty Mixture to your face, which makes your skin smoother and hides visible flaws.')
	else:
		text = slave.dictionary('You order $name to apply Beauty Mixture to $his face, which will make $his skin smoother and hides visible flaws.')
	if slave.traits.has("Scarred"):
		slave.trait_remove('Scarred')
	slave.add_effect(globals.effectdict.beautypot)
	return text

var currentpotion = ''

func minoruseffect():
	var buttons = []
	var text = ''
	currentpotion = globals.itemdict.minoruspot
	if slave == globals.player:
		text = (slave.dictionary('Choose where would you like to apply Minorus Potion on yourself?'))
	else:
		text = (slave.dictionary('Choose where would you like to apply Minorus Potion on $name?'))
	if slave.ass != 'flat' && slave.ass != 'masculine':
		buttons.append(['Butt','applybutt'])
	if slave.tits.size != 'flat' && slave.tits.size != 'masculine':
		buttons.append(['Breasts','applytits'])
	if slave.penis.size != 'small' && slave.penis.number > 0:
		buttons.append(['Penis','applypenis'])
	if slave.balls != 'none' && slave.balls != 'small':
		buttons.append(['Testicles','applytestic'])
	main.dialogue(true, self, text, buttons)

func majoruseffect():
	currentpotion = globals.itemdict.majoruspot
	var buttons = []
	var text = ''
	if slave == globals.player:
		text = (slave.dictionary('Choose where would you like to apply Majorus Potion on yourself?'))
	else:
		text = (slave.dictionary('Choose where would you like to apply Majorus Potion on $name?'))
	if slave.ass != 'huge':
		buttons.append(['Butt','applybutt'])
	if slave.tits.size != 'huge':
		buttons.append(['Breasts','applytits'])
	if slave.penis.size != 'big' && slave.penis.number > 0:
		buttons.append(['Penis','applypenis'])
	if slave.balls != 'big' && slave.balls != 'none':
		buttons.append(['Testicles','applytestic'])
	main.dialogue(true, self, text, buttons)

func applybutt():
	var text = ''
	main.close_dialogue()
	if currentpotion.code == 'minoruspot':
		slave.ass = globals.sizearray[globals.sizearray.find(slave.ass)-1]
		if slave == globals.player:
			text = slave.dictionary("You apply the Minorus Potion to your butt. A little while later, you notice that it has shrunken in size. ")
		else:
			text = slave.dictionary("You apply the Minorus Potion to $name's butt. A little while later, you notice that it has shrunken in size. ")
	elif currentpotion.code == 'majoruspot':
		if slave.ass == 'masculine':
			slave.ass = globals.sizearray[globals.sizearray.find(slave.ass)+2]
		else:
			slave.ass = globals.sizearray[globals.sizearray.find(slave.ass)+1]
		if slave == globals.player:
			text = slave.dictionary("You apply the Majorus Potion to your butt. A little while later, you notice that it has grown bigger. ")
		else:
			text = slave.dictionary("You apply the Majorus Potion to $name's butt. A little while later, you notice that it has grown bigger. ")
	currentpotion.amount -= 1
	slave.toxicity = currentpotion.toxicity
	main.hide_everything()
	main.popup(text)

func applytits():
	var text = ''
	main.close_dialogue()
	if currentpotion.code == 'minoruspot':
		slave.tits.size = globals.sizearray[globals.sizearray.find(slave.tits.size)-1]
		if slave == globals.player:
			text = slave.dictionary("You apply the Minorus Potion to your breasts. A little while later, you notice that they have shrunken in size. ")
		else:
			text = slave.dictionary("You apply the Minorus Potion to $name's breasts. A little while later, you notice that they have shrunken in size. ")
	elif currentpotion.code == 'majoruspot':
		if slave.tits.size == 'masculine':
			slave.tits.size = globals.sizearray[globals.sizearray.find(slave.tits.size)+2]
		else:
			slave.tits.size = globals.sizearray[globals.sizearray.find(slave.tits.size)+1]
		if slave == globals.player:
			text = slave.dictionary("You apply the Majorus Potion to your breasts. A little while later, you notice that they have grown bigger. ")
		else:
			text = slave.dictionary("You apply the Majorus Potion to $name's breasts. A little while later, you notice that they have grown bigger. ")
	currentpotion.amount -= 1
	main.hide_everything()
	main.popup(text)

func applypenis():
	var text = ''
	main.close_dialogue()
	if currentpotion.code == 'minoruspot':
		slave.penis.size = globals.genitaliaarray[globals.genitaliaarray.find(slave.penis.size)-1]
		if slave == globals.player:
			text = slave.dictionary("You apply the Minorus Potion to your penis. A little while later, you notice that it has shrunken in size. ")
		else:
			text = slave.dictionary("You apply the Minorus Potion to $name's penis. A little while later, you notice that it has shrunken in size. ")
	elif currentpotion.code == 'majoruspot':
		slave.penis.size = globals.genitaliaarray[globals.genitaliaarray.find(slave.penis.size)+1]
		if slave == globals.player:
			text = slave.dictionary("You apply the Majorus Potion to your penis. A little while later, you notice that it has grown bigger. ")
		else:
			text = slave.dictionary("You apply the Majorus Potion to $name's penis. A little while later, you notice that it has grown bigger. ")
	currentpotion.amount -= 1
	main.hide_everything()
	main.popup(text)

func applytestic():
	var text = ''
	main.close_dialogue()
	if currentpotion.code == 'minoruspot':
		slave.balls = globals.genitaliaarray[globals.genitaliaarray.find(slave.balls)-1]
		if slave == globals.player:
			text = slave.dictionary("You apply the Minorus Potion to your balls. A little while later, you notice that they have shrunken in size. ")
		else:
			text = slave.dictionary("You apply the Minorus Potion to $name's balls. A little while later, you notice that they have shrunken in size. ")
	elif currentpotion.code == 'majoruspot':
		slave.balls = globals.genitaliaarray[globals.genitaliaarray.find(slave.balls)+1]
		if slave == globals.player:
			text = slave.dictionary("You apply the Majorus Potion to your balls. A little while later, you notice that they have grown bigger. ")
		else:
			text = slave.dictionary("You apply the Majorus Potion to $name's balls. A little while later, you notice that they have grown bigger. ")
	currentpotion.amount -= 1
	main.hide_everything()
	main.popup(text)

#recipes
func recipedecrypt(item):
	var text = ''
	var recipe = item.recipe
	var canmake = true
	for i in self[recipe]:
		var ingredient = globals.itemdict[i]
		var amount = self[recipe][i]
		text += ingredient.name + ' - '+ str(amount) + ', '
		if ingredient.amount < amount:
			canmake = false
	var dict = {}
	dict.text = text
	dict.canmake = canmake
	return dict

func recipemake(item):
	var recipe = item.recipe
	for i in self[recipe]:
		var ingredient = globals.itemdict[i]
		var amount = self[recipe][i]
		ingredient.amount -= amount
	item.amount += 1


var recipeaphrodisiac = {
basicsolutioning = 1,
taintedessenceing = 1,
bestialessenceing = 1,
}

var recipehairgrowth = {
basicsolutioning = 1,
natureessenceing = 1,
bestialessenceing = 1
}

var recipematuringpot = {
majoruspot = 1,
magicessenceing = 2,
natureessenceing = 1
}

var recipeyouthingpot = {
minoruspot = 1,
magicessenceing = 2,
basicsolutioning = 2
}

var recipeminoruspot = {
basicsolutioning = 1,
taintedessenceing = 2,
fluidsubstanceing = 1
}

var recipemajoruspot = {
basicsolutioning = 1,
bestialessenceing = 2,
natureessenceing = 1
}

var recipeamnesiapot = {
basicsolutioning = 1,
fluidsubstanceing = 1,
taintedessenceing = 1
}

var recipeoblivionpot = {
amnesiapot = 1,
magicessenceing = 1,
fluidsubstanceing = 2
}

var recipelactationpot = {
basicsolutioning = 1,
bestialessenceing = 2,
natureessenceing = 1
}

var recipestimulantpot = {
basicsolutioning = 1,
fluidsubstanceing = 1,
natureessenceing = 1
}
var recipedeterrentpot = {
basicsolutioning = 1,
fluidsubstanceing = 1,
taintedessenceing = 1
}

var recipemiscariagepot = {
basicsolutioning = 1,
taintedessenceing = 2
}

var reciperegressionpot = {
basicsolutioning = 2,
amnesiapot = 1,
youthingpot = 1
}
var recipeaphroditebrew = {
aphrodisiac = 2,
stimulantpot = 1,
taintedessenceing = 2
}
func _on_cancel_pressed():
	get_node("hairdyepanel").set_hidden(true)


func _on_hairdyepanel_visibility_changed():
	if get_node("hairdyepanel/TextEdit").get_text() == '':
		get_node("hairdyepanel/confirm").set_disabled(true)
	else:
		get_node("hairdyepanel/confirm").set_disabled(false)


func _on_confirm_pressed():
	slave.haircolor = get_node("hairdyepanel/TextEdit").get_text()
	get_node("hairdyepanel").set_hidden(true)
	var temp = globals.itemdict['hairdye']
	temp.amount -= 1
	main.hide_everything()

func _on_TextEdit_text_changed( text ):
	_on_hairdyepanel_visibility_changed()


func sortitems(first, second):
	var type = ['potion','ingredient']
	if type.find(first.type) > type.find(second.type):
		return false
	elif type.find(first.type) == type.find(second.type):
		if first.name >= second.name:
			return false
		else:
			return true
	else:
		return true

func sortbytype(first, second):
	var type = ['potion','ingredient']
	if type.find(globals.itemdict[first].type) > type.find(globals.itemdict[second].type):
		return false
	elif type.find(globals.itemdict[first].type) == type.find(globals.itemdict[second].type):
		if first >= second:
			return false
		else:
			return true
	else:
		return true

func foodpurchase():
	var amount = globals.itemdict.food.amount
	globals.resources.gold -= amount*globals.itemdict.food.cost
	globals.resources.food += amount*20
	globals.itemdict.food.amount = 0

func teleportunlock(item):
	globals.resources.gold -= item.cost
	globals.state.portals[item.code.replace('teleport','')].enabled = true
	if item.code != 'teleportumbra':
		globals.get_tree().get_current_scene().popup("Unlocked portal to the " + item.code.replace('teleport','').capitalize() + '.')
	else:
		globals.get_tree().get_current_scene().get_node("outside").sebastianquest(4)
		globals.get_tree().get_current_scene().get_node("outside").shopclose()