extends Node

var category = 'fucking'
var code = 'missionaryanal'
var givers
var takers
var canlast = true
var givereffects = {lust = 50, sens = 100}
var targeteffects = {lust = 50, sens = 100, pain = 40}
var giverpart = 'penis'
var takerpart = 'anus'

func getname(state = null):
	return "Missionary Anal"

func getongoingname(givers, takers):
	return "[name1] fuck[%1s] [name2]'s butt in the missionary position."

func getongoingdescription(givers, takers):
	return "[name1] continues fucking [name2] [anus2] in missionary position. "

func requirements():
	var valid = true
	if takers.size() != 1 || givers.size() != 1:
		valid = false
	elif !givers[0].penis in [takers[0].vagina, takers[0].anus] && (takers[0].anus != null || givers[0].penis != null || givers[0].person.penis == 'none'):
		valid = false
	return valid



func initiate():
	var text = ''
	
	text = "[name2] invites [name1] and lies back onto the bedding, presenting [his2] [body2] to [him1]. [name2] digs [his2] nails into the bedding, as [name1] pushes [him1]self downward into [partner2]'s [anus2]. [name2]'s toes curl as their hips noisily smack together. "
	if takers[0].person.assvirgin == true:
		takers[0].person.assvirgin = false
	
	
	return text


func reaction(member):
	var text = ''
	var pleasure = member.sens
	return text

