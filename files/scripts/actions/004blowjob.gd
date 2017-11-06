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
	return "[name1] give[%1s] a blowjob to [name2]."

func getongoingdescription(givers, takers):
	if givers.size() + takers.size() == 2:
		return "[name1] steadily sucks [name2]'s cock while maintaining eye contact. "
	else:
		return "[name1] work on [name2]'s cocks with [his1] mouth. "

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() != 1:
		valid = false
	else:
		for i in takers:
			if i.penis != null || i.person.penis == 'none' || i.penis != givers[0].vagina || i.penis != givers[0].anus:
				valid = false
	return valid



func initiate():
	var text = ''
	text += "[name1] takes [name2]'s [penis2] into [his1] mouth, carefully serving it with [his1] tongue..."
	return text


func reaction(member):
	var text = ''
	return text

