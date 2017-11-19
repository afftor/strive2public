extends Node

var category = 'caress'
var code = 'cunnilingus'
var givers
var takers
var canlast = true
var givereffects = {lust = 50, sens = 20}
var targeteffects = {lust = 50, sens = 100}
var giverpart = 'mouth'
var takerpart = 'vagina'

func getname(state = null):
	return "Cunnilingus"

func getongoingname(givers, takers):
	return "[name1] lick[s/1] [names2] puss[y/ies2]."

func getongoingdescription(givers, takers):
	return "[name1] {^eat[s/1] out:lick[s/1]:savour[s/1]} [names2] [pussy2]. "

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1 || givers.size() + takers.size() > 3:
		valid = false
	else:
		for i in givers:
			if i.mouth != null:
				valid = false
		for i in takers:
			if i.vagina != null || i.person.vagina == 'none':
				valid = false
	return valid

func givereffect(member):
	var result
	var effects = {lust = 50, lewd = 3}
	if member.consent == true || (member.person.traits.find("Likes it rough") >= 0 && member.lewd >= 30):
		result = 'good'
	elif member.person.traits.find("Likes it rough") >= 0:
		result = 'average'
	else:
		result = 'bad'
	return [result, effects]

func takereffect(member):
	var result
	var effects = {lust = 75, sens = 120, lewd = 3}
	member.lube()
	if member.consent == true || (member.person.traits.find("Likes it rough") >= 0 && member.lewd >= 30):
		result = 'good'
	elif member.person.traits.find("Likes it rough") >= 0:
		result = 'average'
	else:
		result = 'bad'
	return [result, effects]

func initiate():
	var text = ''
	text += "[name1] lick[s/1] [names2] [pussy2], {^gently:steadily:diligently} stimulating [his2] pink clit[/s2]..."
	return text

#func reaction(member):
#	var text = ''
#	var pleasure = member.sens
#	if member.energy == 0:
#		text = "[name] trembles nervously as [his] pussy is licked."
#	elif pleasure < 300:
#		text = "[name] doesn't show much pleasure as [his] pussy is licked."
#	elif pleasure < 1000:
#		text = "[name] is starting to react to the sensation of having [his] pussy licked."
#	elif pleasure < 3000:
#		text = "As [his] sensitive clit is licked, [name] gives herself over to pleasure, moaning and shaking [his] hips."
#	elif pleasure < 6000:
#		text = "As [name]'s clit is licked, [he] shakes [his] body and moans in pleasure."
#	else:
#		text = "[name] writhes and moans loudly in pleasure as [his] clit is intensely stimulated by a tongue."
#	return text
