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
	return "[name1] and [name2] rub [their] [penis3] together."

func getongoingdescription(givers, takers):
	return "[name1] and [name2] continue to {^rub:grind} [their] [penis3] together."

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
	text += "[name1] and [name2] {^rub:grind:press} [their] [penis3] {^together:against one another}."
	return text

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = "[name2] lie[s/2] unconscious, {^trembling:twitching} {^slightly :}as [his2] [penis2] {^respond:react}[s/#2] to {^the stimulation:[names1] efforts:[name1] against [him2]}."
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = "[name2] {^show:give}[s/2] little {^response:reaction} to {^the stimulation:[names1] efforts}."
	elif member.sens < 400:
		text = "[name2] {^begin:start}[s/2] to {^respond:react} as [his2] [penis2] get[s/#2] {^rubbed:stimulated:teased}."
	elif member.sens < 800:
		text = "[name2] {^moans[s/2]:crie[s/2] out} in {^pleasure:arousal:extacy} as [his2] [penis2] get[s/#2] {^rubbed:stimulated:teased}."
	else:
		text = "[names2] body {^trembles:quivers} {^at the slightest movement of [names1] [penis1] against [his_2]:in response to [names1] efforts}{^ as [he2] rapidly near[s/2] orgasm: as [he2] approach[es/2] orgasm: as [he2] edge[s/2] toward orgasm:}."
	return text