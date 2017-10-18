extends Node

var dict = {
farmcapacity = {
name = "Capacity", 
code = 'farmcapacity',
description = "Adds new stables to the farm, increasing number of residents that can be assigned at a time.", 
levels = 3,
cost = 500,
pointscost = 3,
valuename = "Allowed cattle: ",
valuenumber = ['2','5','8','12'],
},
farmhatchery = {
name = "Hatchery", 
code = 'farmhatchery',
description = "Provides the farm with new equipment, allowing the use of slaves and snails for egg laying.", 
levels = 1,
pointscost = 10,
cost = 1000,
},
farmtreatment = {
name = "Improved Treatment", 
code = 'farmtreatment',
description = "Equips the farm with relaxation furniture and devices which are gentler on your cattle negating the demoralization of residents on the farm.", 
levels = 1,
pointscost = 20,
cost = 2500,
},

foodcapacity = {
name = "Food Storage Capacity",
code = 'foodcapacity',
description = "Adds additional space to the food storage area allowing you to keep more food at a time.", 
levels = 5,
cost = [250,500,1000,1500,2500],
pointscost = 5,
valuename = "Maximum food: ",
valuenumber = ['500', '750', '1000', '1500', '2000', '3000'],
},
foodpreservation = {
name = "Food Storage Preservation",
code = 'foodpreservation',
description = "Equips your food storage area with a cooling system which helps prevent food spoilage when storage is nearly full.", 
levels = 1,
pointscost = 15,
cost = 1500,
},

jailcapacity = {
name = "Capacity",
code = 'jailcapacity',
description = "Adds additional cells to your jail, increasing maximum number of prisoners it can hold at a time.", 
levels = 8,
cost = 200,
pointscost = 3,
valuename = "Jail Cells: ",
},
jailtreatment = {
name = "Better Furnishing",
code = 'jailtreatment',
description = "Equips your jail with better furnishings and health care, preventing prisoners from accumulating stress.", 
levels = 1,
pointscost = 15,
cost = 750,
},
jailincenses = {
name = "Soothing Incences",
code = 'jailincenses',
description = "Equips your jail with burners for a special incenses which helps calm and adjust prisoners' attitude.", 
levels = 1,
pointscost = 20,
cost = 1500,
},

mansioncommunal = {
name = "Communal Room Beds",
code = 'mansioncommunal',
description = "Adds new beds to communal room, providing space for additional residents to sleep. ", 
levels = 20,
cost = 100,
pointscost = 1,
valuename = "Total beds: ",
},
mansionpersonal = {
name = "New Personal Room",
code = 'mansionpersonal',
description = "Set up one of the free rooms for living. Personal rooms provide sense of [color=yellow]Luxury[/color] to their hosts. ", 
levels = 10,
cost = 300,
pointscost = 3,
valuename = "Total rooms: ",
},
mansionbed = {
name = "Master's Bed Enlargement",
code = 'mansionbed',
description = "Enlarges your bed allowing you to host more people with you at night.. Sleeping in your room provides a sense of [color=yellow]Luxury[/color] to your partners.", 
levels = 3,
cost = 300,
pointscost = 3,
valuename = "Allowed partners: ",
},
mansionluxury = {
name = "Mansion Furnishment",
code = 'mansionluxury',
description = "Decorates the mansion with better furniture and additional pieces of art. This provides a boost to the [color=yellow]Luxury[/color] provided to servants sleeping in personal rooms and your bed.", 
levels = 2,
pointscost = 15,
cost = [1000,2000],
},
mansionalchemy = {
name = "Alchemy Room",
code = 'mansionalchemy',
description = "Equips a spare room with alchemical tools and paraphernalia allowing you to brew basic potions.", 
description2 = "Upgrades your Alchemy Room with additional equipment enabling you to brew a larger variety of potions.",
levels = 2,
pointscost = 5,
cost = [500,1000],
},
mansionlibrary = {
name = "Library",
code = 'mansionlibrary',
description = "Purchases new books and furniture for your library providing access to new books, articles and information as well as improving residents’ studies.", 
levels = 3,
pointscost = 3,
cost = [500,1000,1500],
},
mansionlab = {
name = "Laboratory",
code = 'mansionlab',
description = "Equips a spare room within the mansion with advanced devices and tools allowing you to conduct experiments and operations on both yourself and your slaves.", 
description2 = "Upgrades your laboratory with the latest equipment and tools, unlocking new operations.", 
levels = 2,
pointscost = 10,
cost = [1000,3000],
},
mansionkennels = {
name = "Kennels",
code = 'mansionkennels',
description = "Builds a kennel on the mansion’s grounds providing space to keep hounds. Having hounds on the property reduces the chances of slaves escaping during the night, and for those so inclined unlocks the beastality action. ", 
levels = 1,
pointscost = 15,
cost = 1500,
},
mansionnursery = {
name = "Nursery Room",
code = 'mansionnursery',
description = "Upgrades and equips a room within the mansion to provide care for newborn babies and young children for a limited period.", 
levels = 1,
pointscost = 15,
cost = 2000,
},
mansionparlor = {
name = "Beauty Parlor",
code = 'mansionparlor',
description = "Upgrades and equips a room within the mansion allowing to alter servants via [color=aqua]Piercing[/color] and [color=aqua]Tattoo[/color] (Tattoos can empower your slaves).", 
levels = 1,
pointscost = 10,
cost = 1000,
},
}
