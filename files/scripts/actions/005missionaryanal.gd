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
	return "[name1] fuck[s/1] [names2] ass[/es2] in the missionary position."

func getongoingdescription(givers, takers):
	return "[name1] continue[s/1] fucking [names2] [anus2] in the missionary position."

func requirements():
	var valid = true
	if takers.size() != 1 || givers.size() != 1:
		valid = false
	elif !givers[0].penis in [takers[0].vagina, takers[0].anus] && (takers[0].anus != null || givers[0].penis != null || givers[0].person.penis == 'none'):
		valid = false
	return valid

func givereffect(member):
	var result
	var effects = {lust = 90, sens = 100, lewd = 3}
	if member.consent == true || (member.person.traits.find("Likes it rough") >= 0 && member.lewdness >= 30):
		result = 'good'
	elif member.person.traits.find("Likes it rough") >= 0:
		result = 'average'
	else:
		result = 'bad'
	return [result, effects]

func takereffect(member):
	var result
	var effects = {lust = 80, sens = 110, lewd = 3}
	if (member.consent == true || member.person.traits.find("Likes it rough") >= 0) && member.lewdness >= 40 && member.lube >= 5:
		result = 'good'
	elif (member.consent == true || member.person.traits.find("Likes it rough") >= 0):
		result = 'average'
	else:
		result = 'bad'
	if member.lube < 5:
		effects.pain += 3
	return [result, effects]

func initiate():
	var text = ''
	text = "[name1] lay[s/1] [name2] down on [his2] back, parting [his2] thighs to expose [his2] [anus2]. [names2] [ass2] envelop [names1] [penis1] as [he1]"
	if takers[0].person.assvirgin == true:
		text += " break[s/1] in [partners2] virgin butthole[/s2]."
		takers[0].person.assvirgin = false
	else:
		text += " push[es/1] [his1] [penis1] deep into [partners2] [anus2]."
	text += " [names2] bod[y/ies2] twitch[es/2] as [his2] [anus2] get[s/2] stretched by [names1] [penis1]."
	return text


#func reaction(member):
#	var text = ''
#	var pleasure = member.sens
#	return text

