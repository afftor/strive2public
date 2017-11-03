extends Node

var category = 'caress'
var code = 'kiss'
var givers
var takers
var canlast = true
var givereffects = {lust = 50, sens = 50}
var targeteffects = {lust = 50, sens = 50}
var giverpart = 'mouth'
var takerpart = 'mouth'

func getname(state = null):
	if givers.size() > 1 || takers.size() > 1:
		return "Double Kiss"
	else:
		return "Kiss"

func getongoingname(givers, takers):
	return "[name1] kiss[%1es] [name2]."

func getongoingdescription(givers, takers):
	if givers.size() + takers.size() == 2:
		return "[name1] and [name2] passionately exchange saliva, biting and sucking each other's lips. "
	else:
		if givers.size() >= 1:
			return "[name1] and [name2] kiss and entwine thier tongues together.  "
		else:
			return "[name2] and [name1] kiss and entwine thier tongues together. "

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1 || givers.size() + takers.size() > 3:
		valid = false
	for i in givers+takers:
		if i.mouth != null:
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
			text += "[name2] enthusiastically returns the kiss with a dreamy expression on [his2] face..."
	return text


