extends Node

var category = 'caress'
var code = 'tailjob'
var givers
var takers
var canlast = true
var givereffects = {lust = 50, sens = 20}
var targeteffects = {lust = 50, sens = 100}
var giverpart = 'tail'
var takerpart = 'penis'

func getname(state = null):
	return "Tailjob"

func getongoingname(givers, takers):
	return "[name1] give[s/1] [a /1]tailjob[/s1] to [name2]."

func getongoingdescription(givers, takers):
	var temparray = []
	temparray += ["[name1] {^steadily :rhythmically :carefully :}{^massage:stroke:rub:jerk}[s/1] [names2] [penis2] with [his1] tail[/s1]{^, trying to maintain eye contact:, studying [his2] reactions:}."]
	temparray += ["[name1] {^massage:work:stroke:rub}[s/1] {^up and down the length of:all along:the shaft[/s2] of} [names2] [penis2] with [his1] tail[/s1]."]
	return temparray[randi()%temparray.size()]

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1:
		valid = false
	elif takers.size() > givers.size():
		valid = false
	else:
		for i in givers:
			if i.tail != null || !globals.longtails.has(i.person.tail):
				valid = false
		for i in takers:
			if i.penis != null || i.person.penis == 'none':
				valid = false
	return valid

func givereffect(member):
	var result
	var effects = {lust = 65, lewd = 2}
	if member.consent == true || (member.person.traits.find("Likes it rough") >= 0 && member.lewd >= 20):
		result = 'good'
	elif member.person.traits.find("Likes it rough") >= 0:
		result = 'average'
	else:
		result = 'bad'
	return [result, effects]

func takereffect(member):
	var result
	var effects = {lust = 75, sens = 110, lewd = 2}
	if member.consent == true || (member.person.traits.find("Likes it rough") >= 0 && member.lewd >= 30):
		result = 'good'
	elif member.person.traits.find("Likes it rough") >= 0:
		result = 'average'
	else:
		result = 'bad'
	return [result, effects]

func initiate():
	var temparray = []
	temparray += ["[name1] wrap[/s1] [his1] tail around [names2] [penis2] and {^massage:stroke:rub:jerk}[s/1] [it2]."]
	temparray += ["[name1] {^tease[s/1]:brush[es/1] against} the {^tip:shaft:base}[/s2] of [names2] [penis2] as [he1] {^service:stroke:attend}[s/1] [it2] with [his1] tail[/s1]."]
	return temparray[randi()%temparray.size()]

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = "[name2] lie[s/2] unconscious, {^trembling:twitching} {^slightly :}as [his2] [penis2] {^respond:react}[s/#2] to {^the stimulation:[names1] tail[/s1]}."
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = "[name2] {^show:give}[s/2] little {^response:reaction} to {^the stimulation:[names1] efforts:[names1] tail[/s1]}."
	elif member.sens < 400:
		text = "[name2] {^begin:start}[s/2] to {^respond:react} as [his2] [penis2] get[s/#2] {^jerked:stroked} by [names1] tail[/s1]."
	elif member.sens < 800:
		text = "[name2] {^moans[s/2]:crie[s/2] out} in {^pleasure:arousal:extacy} as [his2] [penis2] get[s/#2] {^jerked:stroked} by [names1] tail[/s1]."
	else:
		text = "[names2] body {^trembles:quivers} {^at the slightest movement of [names1] tail[/s1] against [his2] [penis2]:in response to [names1] stroking}{^ as [he2] rapidly near[s/2] orgasm: as [he2] approach[es/2] orgasm: as [he2] edge[s/2] toward orgasm:}."
	return text