extends Node

var category = 'caress'
var code = 'titjob'
var givers
var takers
var canlast = true
var givereffects = {lust = 50, sens = 20}
var targeteffects = {lust = 50, sens = 100}
var giverpart = ''
var takerpart = 'penis'

func getname(state = null):
	return "Titjob"

func getongoingname(givers, takers):
	return "[name1] give[s/1] [a /1]titjob[/s1] to [name2]."

func getongoingdescription(givers, takers):
	var temparray = []
	temparray += ["[name1] continue[s/1] rubbing [names2] [penis2] with [his1] [tits1]."]
	return temparray[randi()%temparray.size()]

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() != 1:
		valid = false
	else:
		for i in givers:
			if i.person.titssize in ['masculine','flat']:
				valid = false
		for i in takers:
			if i.penis != null || i.person.penis == 'none':
				valid = false
	return valid

func givereffect(member):
	var result
	var effects = {lust = 65, lewd = 1}
	if member.consent == true || (member.person.traits.find("Likes it rough") >= 0 && member.lewd >= 20):
		result = 'good'
	elif member.person.traits.find("Likes it rough") >= 0:
		result = 'average'
	else:
		result = 'bad'
	return [result, effects]

func takereffect(member):
	var result
	var effects = {lust = 75, sens = 100, lewd = 2}
	if member.consent == true || (member.person.traits.find("Likes it rough") >= 0 && member.lewd >= 25):
		result = 'good'
	elif member.person.traits.find("Likes it rough") >= 0:
		result = 'average'
	else:
		result = 'bad'
	return [result, effects]

func initiate():
	var temparray = []
	temparray += ["[name1] buries [names2] [penis2] in [his1] [tits1], {^squeezing:teasing} and {^rubbing:massaging:milking} [it2]. "]
	return temparray[randi()%temparray.size()]
