extends Node

var category = 'fucking'
var code = 'missionary'
var givers
var takers
var canlast = true
var givereffects = {lust = 50, sens = 100}
var targeteffects = {lust = 50, sens = 100, pain = 20}
var giverpart = 'penis'
var takerpart = 'vagina'

func getname(state = null):
	return "Missionary"

func getongoingname(givers, takers):
	return "[name1] fuck[%1s] [name2] in the missionary position."

func getongoingdescription(givers, takers):
	return "[name1] continues fucking [name2] [pussy2] in missionary position. "

func requirements():
	var valid = true
	if takers.size() != 1 || givers.size() != 1:
		valid = false
	
	elif !givers[0].penis in [takers[0].vagina, takers[0].anus] && (takers[0].vagina != null || givers[0].penis != null || takers[0].person.vagina == 'none' || givers[0].person.penis == 'none'):
		valid = false
	return valid



func initiate():
	var text = ''
	
	text = "[name1] lays [name2] down on [his2] back, parting [his2] thighs to expose [his2] [pussy2]. [name2]'s [labia2] envelop [name1]'s [penis1] as [he1] "
	if takers[0].person.vagvirgin == true:
		text += "rips open [partner2]'s hymen. "
		takers[0].person.vagvirgin = false
	else:
		text += "pushes [his1] [penis1] deep into [partner2]'s [pussy2]. "
	text += "[name2]'s body twitches, as [his2] [pussy2] gets stretched by [name1]'s [penis1]. "
	
	return text


func reaction(member):
	var text = ''
	var pleasure = member.sens
	return text

