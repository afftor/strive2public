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
	return "[name1] give[%1s] a handjob to [name2]."

func getongoingdescription(givers, takers):
	if givers.size() + takers.size() == 2:
		return "[name1] strokes [name2]'s [penis2]. "
	else:
		return "[name1] work on [name2]'s cocks with [his1] mouth. "

func requirements():
	var valid = true
	if takers.size() != 1 || givers.size() != 1:
		valid = false
	else:
		for i in takers:
			if i.penis != null || i.person.penis == 'none':
				valid = false
	return valid



func initiate():
	var text = ''
	if givers.size() + takers.size() == 2:
		text += "[name1] grips [name2]'s [penis2] and stroke[%1s] it intensely."
	return text


func reaction(member):
	var text = ''
	return text

