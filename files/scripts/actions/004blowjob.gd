extends Node

var category = 'caress'
var code = 'blowjob'
var givers
var takers
var canlast = true
var givereffects = {lust = 50, sens = 20}
var targeteffects = {lust = 50, sens = 100}
var giverpart = 'mouth'
var takerpart = 'penis'

func getname(state = null):
	return "Blowjob"

func getongoingname(givers, takers):
	return "[name1] give[s/1] [a /1]blowjob[/s1] to [name2]."

func getongoingdescription(givers, takers):
	var temparray = []
	temparray += ["[name1] {^steadily :rhythmically :carefully :}{^suck:blow}[s/1] [names2] [penis2]{^, trying to maintain eye contact:, studying [his2] reactions:}."]
	temparray += ["[name1] {^work:nurse:serve}[s/1] {^the length of :the shaft[/s2] of :the tip[/s2] of :}[names2] [penis2] with [his1] mouth[/s1]."]
	return temparray[rand_range(0,temparray.size())]

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() != 1:
		valid = false
	else:
		for i in givers:
			if i.mouth != null:
				valid = false
		for i in takers:
			if i.penis != null || i.person.penis == 'none':
				valid = false
	return valid

func initiate():
	var temparray = []
	temparray += ["[name1] {^take:place:shove}[s/1] [names2] [penis2] into [his1] mouth[/s1], {^carefully serving:working the length of:coiling around} [it2] with [his1] tongue[/s1]..."]
	temparray += ["[name1] {^kiss[es/1]:rub[s/1] [his1] face against:lick[s/1] the tip of:admire[s/1]} [names2] [penis2] as [he1] begin[s/1] {^servicing:slurping at:milking:attending} [it2]."]
	return temparray[rand_range(0,temparray.size())]
