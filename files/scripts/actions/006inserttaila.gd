extends Node

var category = 'fucking'
var code = 'inserttailv'
var givers
var takers
var canlast = true
var givereffects = {lust = 50}
var targeteffects = {lust = 50, sens = 100}
var giverpart = 'tail'
var takerpart = 'anus'
var virginloss = true
var giverconsent = 'advanced'
var takerconsent = 'any'

func getname(state = null):
	return "Insert Tail Ass"

func getongoingname(givers, takers):
	return "[name1] fuck[s/1] [name2]'s ass with [his1] tail."

func getongoingdescription(givers, takers):
	var temparray = []
	temparray += ["[name1] thrust[s/1] [his1] tail in and out of [names2] [ass2]."]
	return temparray[randi()%temparray.size()]

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1 || givers.size() + takers.size() > 3:
		valid = false
	else:
		for i in givers:
			if i.tail != null || !globals.longtails.has(i.person.tail):
				valid = false
		for i in takers:
			if i.anus != null:
				valid = false
	return valid

func givereffect(member):
	var result
	var effects = {lust = 50, lewd = 2}
	if member.consent == true || (member.person.traits.find("Likes it rough") >= 0 && member.lewd >= 35):
		result = 'good'
	elif member.person.traits.find("Likes it rough") >= 0:
		result = 'average'
	else:
		result = 'bad'
	return [result, effects]

func takereffect(member):
	var result
	var effects = {lust = 80, sens = 100, lewd = 2}
	if member.consent == true || (member.person.traits.find("Likes it rough") >= 0 && member.lewd >= 35):
		result = 'good'
	elif member.person.traits.find("Likes it rough") >= 0:
		result = 'average'
	else:
		result = 'bad'
	return [result, effects]


func initiate():
	var temparray = []
	temparray += ["[name1] insert[s/1] [his1] thick tail into [names2] [ass2]. "]
	return temparray[randi()%temparray.size()]

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = "[name2] lie[s/2] unconscious, {^trembling:twitching} {^slightly :}as [his2] [ass2] {^respond:react}[s/#2] to {^the stimulation:[names1] tail[/s1]}."
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = "[name2] {^show:give}[s/2] little {^response:reaction} to {^the stimulation:[names1] efforts:[names1] tail[/s1]}."
	elif member.sens < 400:
		text = "[name2] {^begin:start}[s/2] to {^respond:react} as [his2] [ass2] get[s/#2] {^fucked:penetrated} by [names1] tail[/s1]."
	elif member.sens < 800:
		text = "[name2] {^moans[s/2]:crie[s/2] out} in {^pleasure:arousal:extacy} as [his2] [ass2] get[s/#2] {^fucked:penetrated} by [names1] tail[/s1]."
	else:
		text = "[names2] body {^trembles:quivers} {^at the slightest movement of [names1] tail[/s1] inside [his2] [ass2]:in response to [names1] penetrating}{^ as [he2] rapidly near[s/2] orgasm: as [he2] approach[es/2] orgasm: as [he2] edge[s/2] toward orgasm:}."
	return text