extends Node

var category = 'caress'
var code = 'tailjob'
var givers
var takers
var canlast = true
var givereffects = {lust = 50, sens = 20}
var targeteffects = {lust = 50, sens = 100}
var giverpart = 'tail'
var takerpart = 'penis'

func getname(state = null):
	return "Tailjob"

func getongoingname(givers, takers):
	return "[name1] give[s/1] [a /1]tailjob[/s1] to [name2]."

func getongoingdescription(givers, takers):
	var temparray = []
	temparray += ["[name1] wrap[/s1] [his1] tail around [names2] [penis2] and stroke[/s1] it."]
	return temparray[rand_range(0,temparray.size())]

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1:
		valid = false
	else:
		for i in givers:
			if i.tail != null || !globals.longtails.has(i.person.tail):
				valid = false
		for i in takers:
			if i.penis != null || i.person.penis == 'none':
				valid = false
	return valid

func givereffect(member):
	var result
	var effects = {lust = 65, lewd = 2}
	if member.consent == true || (member.person.traits.find("Likes it rough") >= 0 && member.lewd >= 20):
		result = 'good'
	elif member.person.traits.find("Likes it rough") >= 0:
		result = 'average'
	else:
		result = 'bad'
	return [result, effects]

func takereffect(member):
	var result
	var effects = {lust = 75, sens = 110, lewd = 2}
	if member.consent == true || (member.person.traits.find("Likes it rough") >= 0 && member.lewd >= 30):
		result = 'good'
	elif member.person.traits.find("Likes it rough") >= 0:
		result = 'average'
	else:
		result = 'bad'
	return [result, effects]

func initiate():
	var temparray = []
	temparray += ["[name1] wrap[/s1] [his1] tail around [names2] [penis2] squeezing and stroking it."]
	return temparray[rand_range(0,temparray.size())]
