extends Node

var category = 'fucking'
var code = 'frottage'
var givers
var takers
var canlast = true
var givereffects = {lust = 50, sens = 20}
var targeteffects = {lust = 50, sens = 100}
var giverpart = 'penis'
var takerpart = 'penis'

func getname(state = null):
	return "Frottage"

func getongoingname(givers, takers):
	return "[name1] and [name2] rub [their] cocks together."

func getongoingdescription(givers, takers):
	return "[name1] and [name2] continues to {^rub:grind} [their] {^cocks:penises} together. "

func requirements():
	var valid = true
	if takers.size() != 1 || givers.size() != 1:
		valid = false
	else:
		for i in givers:
			if i.person.penis == 'none':
				valid = false
		for i in takers:
			if i.person.penis == 'none':
				valid = false
	return valid

func givereffect(member):
	var result
	var effects = {lust = 75, sens = 100, lewd = 2}
	if member.consent == true || (member.person.traits.find("Likes it rough") >= 0 && member.lewd >= 30):
		result = 'good'
	elif member.person.traits.find("Likes it rough") >= 0:
		result = 'average'
	else:
		result = 'bad'
	return [result, effects]

func takereffect(member):
	var result
	var effects = {lust = 75, sens = 100, lewd = 2}
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
	text += "[name1] and [name2] {^stroke} [their] {^cocks:dicks:penises} against each other..."
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
