extends Node

var category = 'caress'
var code = 'blowjob'
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
	return "[name1] licks [name2]'s pussy."

func getongoingdescription(givers, takers):
	return "[name1] {^eats out:licks:savours} [name2]'s [pussy2]. "

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1:
		valid = false
	else:
		for i in takers:
			if i.vagina != null || i.person.vagina == 'none' || i.vagina != givers[0].penis || i.anus != givers[0].penis:
				valid = false
	return valid



func initiate():
	var text = ''
	text += "[name1] licks [name2]'s [pussy2], {^gently:steadily:diligently} stimulating [his2] pink clit..."
	return text

	
func reaction(member):
	var text = ''
	var pleasure = member.sens
	if member.energy == 0:
		text = "[name] trembles nervously as [his] pussy is licked."
	elif pleasure < 300:
		text = "[name] doesn't show much pleasure as [his] pussy is licked."
	elif pleasure < 1000:
		text = "[name] is starting to react to the sensation of having [his] pussy licked."
	elif pleasure < 3000:
		text = "As [his] sensitive clit is licked, [name] gives herself over to pleasure, moaning and shaking [his] hips."
	elif pleasure < 6000:
		text = "As [name]'s clit is licked, [he] shakes [his] body and moans in pleasure."
	else:
		text = "[name] writhes and moans loudly in pleasure as [his] clit is intensely stimulated by a tongue."
	
	return text
