extends Node

var category = 'caress'
var givers
var takers

func getname(state = null):
	if givers.size() > 1 || takers.size() > 1:
		return "Double Kiss"
	else:
		return "Kiss"

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1 || givers.size() + takers.size() > 3:
		valid = false
	return valid



func initiate():
	var text = ''
	if givers.size() == 2:
		text += "[name1] take turns french kissing [name2] and licking [his2] face..."
	elif takers.size() == 2:
		text += "[name1] takes turns intertwining [his1] tongue with [name2], as they ask for kisses..."
	else:
		text += "[name1] grabs [name2] and kisses [him2], entangling tongues in every way possible.\n"
		if takers[0].lust > 50 || takers[0].person.loyal >= 50:
			text += "%[name2] enthusiastically returns the kiss with a dreamy expression on [his2] face..."
	return text


