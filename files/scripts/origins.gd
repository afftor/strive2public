
extends Node


############################### TRAITS ################################

var traitlist = {}

func _init():
	traitlist = load("res://files/scripts/traits.gd").new().traits



func traits(tag):
	var rval = []
	var traits = traitlist
	
	if tag == 'any':
		for i in traits:
			if traits[i]['tags'].has('secondary') != true:
				rval.append(traits[i])
	else:
		var temp = traits.keys()
		if typeof(tag) != TYPE_ARRAY:
			for i in traits:
				if traits[i]['tags'].has(tag):
					rval.append(traits[i])
		else:
			for i in traits:
				if traits[i]['tags'].has(tag[0]) && traits[i]['tags'].has(tag[1]):
					rval.append(traits[i])
	return rval[rand_range(0, rval.size())]

var traitscript = load("res://files/scripts/traits.gd")

func trait(trait):
	return traitlist[trait]





static func set_childhood(slave, specify = 'empty'):
	var childhood
	if specify == 'empty':
		return
	elif specify == '$slave':
		childhood = childhood_pool('slavery')
		slave.cour = -rand_range(5,15)
		slave.conf = -rand_range(5,15)
		slave.wit = -rand_range(5,15)
		slave.charm = -rand_range(5,15)
		slave.face.beauty = rand_range(1,40)
		if rand_range(0,10) > 7:
			if rand_range(0,10) < 6:
				slave.traits = traits('detrimental')
			else:
				slave.traits = traits('any')
	else:
		slave.traits = traits('any')
		childhood = childhood_pool('slavery')
	#slave.traits = traits('any')
	slave.origins.childhood = childhood
	var effects = childhood.effects
	slave.fetch(effects)
	return slave

static func calculate(slave, origin):
	for key in origin.stats:
		if slave.stats.has(key):
			var tv = slave[key]
			if typeof(tv) == TYPE_DICTIONARY:
				calculate(tv, origin[key])
			else:
				slave[key] = slave.stats[key] + origin.stats[key]
	if origin.has('skills'):
		globals.merge(slave.skills, origin.skills)