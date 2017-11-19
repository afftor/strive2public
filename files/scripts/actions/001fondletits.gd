extends Node

var category = 'caress'
var code = 'fondletits'
var givers
var takers
var canlast = true
var givereffects = {lust = 50, sens = 0}
var targeteffects = {lust = 50, sens = 50}
var giverpart = ''
var takerpart = ''

func getname(state = null):
	return "Fondle Chest"

func getongoingname(givers, takers):
	return "[name1] fondle[s/1] [names2] chest."

func getongoingdescription(givers, takers):
	var temparray = []
	temparray += ["[name1] continue[s/1] fondling [names2] breasts."]
	return temparray[rand_range(0,temparray.size())]
	
func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1:
		valid = false
	return valid

func givereffect(member):
	var result
	var effects = {lust = 50}
	if member.consent == true || (member.person.traits.find("Likes it rough") >= 0 && member.lewd >= 10):
		result = 'good'
	elif member.person.traits.find("Likes it rough") >= 0:
		result = 'average'
	else:
		result = 'bad'
	return [result, effects]

func takereffect(member):
	var result
	var effects = {lust = 50, sens = 85}
	if member.consent == true || (member.person.traits.find("Likes it rough") >= 0 && member.lewd >= 10):
		result = 'good'
	elif member.person.traits.find("Likes it rough") >= 0:
		result = 'average'
	else:
		result = 'bad'
	if member.person.sex == 'male':
		effects.sens /= 2
	return [result, effects]

func initiate():
	var text = ''
	var kissable = true
	var temparray = []
	for i in givers:
		if i.mouth != null:
			kissable = false
	temparray += ["[name1] caress [names2] [tits2] and play[s/2] with [his2] nipples. "]
	text += temparray[rand_range(0,temparray.size())]
	return text

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = "[name2] lie[s/2] unconscious, {^trembling:twitching} {^slightly :}as [his2] body {^responds:reacts} to {^the stimulation:[names1] touch:[names1] caress}."
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = "[name2] {^show:give}[s/2] little {^response:reaction} to {^the stimulation:[names1] touch:[names1] caress}."
	elif member.sens < 400:
		text = "[name2] {^begin:start}[s/2] to {^respond:react} to {^the stimulation:[names1] touch:[names1] caress}."
	elif member.sens < 800:
		text = "[name2] {^revel:bask}[s/2] in {^the stimulation:[names1] touch:[names1] caress}{^, [his2] arousal clearly showing:, becoming more and more excited:}."
	else:
		text = "[names2] body {^trembles:quivers} {^at the slightest touch:with every touch:each time [name1] touch[es/1] [him2]}{^ as [he2] rapidly near[s/2] orgasm: as [he2] approach[es/2] orgasm: as [he2] edge[s/2] toward orgasm:}."
	return text
