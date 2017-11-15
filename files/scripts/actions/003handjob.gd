extends Node

var category = 'caress'
var code = 'handjob'
var givers
var takers
var canlast = true
var givereffects = {lust = 50, sens = 20}
var targeteffects = {lust = 50, sens = 100}
var giverpart = ''
var takerpart = 'penis'

func getname(state = null):
	return "Handjob"

func getongoingname(givers, takers):
	return "[name1] give[s/1] [a /1]handjob[/s1] to [name2]."

func getongoingdescription(givers, takers):
	var temparray = []
	temparray += ["[name1] {^steadily :rhythmically :carefully :}{^massage:stroke:rub:jerk}[s/1] [names2] [penis2]{^, trying to maintain eye contact:, studying [his2] reactions:}."]
	temparray += ["[name1] {^massage:work:stroke:rub}[s/1] {^up and down the length of:all along:the shaft[/s2] of} [names2] [penis2] with [his1] hands."]
	return temparray[rand_range(0,temparray.size())]

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1 || givers.size() + takers.size() > 3:
		valid = false
	else:
		for i in takers:
			if i.penis != null || i.person.penis == 'none':
				valid = false
	return valid

func initiate():
	var temparray = []
	temparray += ["[name1] {^grip:grab:seize}[s/1] [names2] [penis2] and {^massage:stroke:rub:jerk}[s/1] [it2] with {^inensity:intense focus:fervor:passion}."]
	temparray += ["[name1] {^tease[s/1]:brush[es/1] against} the {^tip:shaft:base}[/s2] of [names2] [penis2] with [his1] fingertips as [he1] begin[s/1] {^servicing:stroking:milking:attending} [it2] with [his1] hands."]
	return temparray[rand_range(0,temparray.size())]
