extends Node

var enchantmentdict = {
enchdmg = {name = "+% Damage", id = 'weapondamage', effect = "damage", mineffect = 2, maxeffect = 3, itemtypes = ['weapon'], type = 'incombat'},
enchspeed = {name = "+% Speed", id = 'weaponspeed', effect = "speed", mineffect = 3, maxeffect = 5, itemtypes = ['weapon'], type = 'incombat'},
encharmor = {name = "+% Armor", id = 'armorbonus', effect = "armor", mineffect = 2, maxeffect = 4, itemtypes = ['armor'], type = 'incombat'},
enchstr = {name = "+% Strength", id = 'armorstr', effect = "stren", mineffect = 1, maxeffect = 1, itemtypes = ['armor'], type = 'onequip'},
enchagi = {name = "+% Agility", id = 'armoragi', effect = "agi", mineffect = 1, maxeffect = 1, itemtypes = ['armor'], type = 'onequip'},
enchend = {name = "+% Endurance", id = 'armorend', effect = "end", mineffect = 1, maxeffect = 1, itemtypes = ['armor'], type = 'onequip'},
enchmaf = {name = "+% Magic affinity", id = 'armormaf', effect = "maf", mineffect = 1, maxeffect = 1, itemtypes = ['armor'], type = 'onequip'},
enchhealth = {name = "+% Health", id = 'armorhealth', effect = "health", mineffect = 15, maxeffect = 25, itemtypes = ['armor'], type = 'onequip'},
enchenergy = {name = "+% Energy", id = 'armorenergy', effect = "energy", mineffect = 10, maxeffect = 20, itemtypes = ['armor'], type = 'onequip'},
enchcour = {name = "+% Courage", id = 'costumecour', effect = "cour", mineffect = 10, maxeffect = 20, itemtypes = ['costume'], type = 'onequip'},
enchconf = {name = "+% Confidence", id = 'costumeconf', effect = "conf", mineffect = 10, maxeffect = 20, itemtypes = ['costume'], type = 'onequip'},
enchwit = {name = "+% Wit", id = 'costumewit', effect = "wit", mineffect = 10, maxeffect = 20, itemtypes = ['costume'], type = 'onequip'},
enchcharm = {name = "+% Charm", id = 'costumecharm', effect = "charm", mineffect = 10, maxeffect = 20, itemtypes = ['costume'], type = 'onequip'},
enchbeauty = {name = "+% Beauty", id = 'costumebeauty', effect = "beauty", mineffect = 5, maxeffect = 15, itemtypes = ['costume'], type = 'onequip'},

}


func addrandomenchant(item, number = 1):
	var encharray = []
	var existingenchants = []
	var existingenchantsids = []
	for i in item.effects:
		existingenchants.append(i.effect)
		if i.has("id"):
			existingenchantsids.append(i.id)
	for i in enchantmentdict:
		if enchantmentdict[i].itemtypes.has(item.type) && !existingenchantsids.has(enchantmentdict[i].id):
			encharray.append(i)
	while number > 0 && encharray.size() > 0:
		number -= 1
		item.enchant = 'basic'
		var tempenchant = enchantmentdict[encharray[randi()%encharray.size()]]
		var enchant = {type = tempenchant.type, effect = tempenchant.effect, effectvalue = 0, descript = ""}
		encharray.erase(tempenchant)
		if tempenchant.has("mineffect") and tempenchant.has("maxeffect"):
			enchant.effectvalue = round(rand_range(tempenchant.mineffect, tempenchant.maxeffect))
		elif tempenchant.has('effectvalue'):
			enchant.effectvalue = tempenchant.effectvalue
		enchant.descript = "[color=green]" + tempenchant.name.replace("%", str(enchant.effectvalue)) + "[/color]"
		
		item.effects += [enchant]

func addenchant(item):
	pass