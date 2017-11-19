extends Node

var category = 'SM'
var code = 'whipping'
var givers
var takers
var canlast = false
var givereffects = {lust = 0, sens = 0}
var targeteffects = {lust = 0, sens = 0, pain = 5}
var giverpart = ''
var takerpart = ''

func getname(state = null):
	return "Whipping"

func getongoingname(givers, takers):
	return "[name1] whip[s/1] [name2]."

func getongoingdescription(givers, takers):
	var temparray = []
	temparray += ["[name1] {^steadily :rhythmically :carefully :}{^suck:blow}[s/1] [names2] [penis2]{^, trying to maintain eye contact:, studying [his2] reactions:}."]
	temparray += ["[name1] {^work:nurse:serve}[s/1] {^the length of :the shaft[/s2] of :the tip[/s2] of :}[names2] [penis2] with [his1] mouth[/s1]."]
	return temparray[rand_range(0,temparray.size())]

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1:
		valid = false
	return valid

func givereffect(member):
	var result
	var effects = {lewd = 1}
	if member.consent == true || (member.person.traits.find("Likes it rough") >= 0 && member.lewd >= 10):
		result = 'good'
	elif member.person.traits.find("Likes it rough") >= 0:
		result = 'average'
	else:
		result = 'bad'
	return [result, effects]

func takereffect(member):
	var result
	var effects = {sens = 45, pain = 2, tags = ['sexpain']}
	member.person.obed += rand_range(15,20)
	if (member.person.traits.find("Likes it rough") >= 0 && member.lewd >= 30) || member.person.traits.find('Masochist') >= 0:
		result = 'good'
		effects.lust = 70
	elif member.person.traits.find("Likes it rough") >= 0 || member.lust >= 700:
		result = 'average'
		effects.lust = 30
		member.person.stress += rand_range(3,5)
	else:
		result = 'bad'
		member.person.stress += rand_range(4,9)
	return [result, effects]

func initiate():
	var temparray = []
	temparray += ["[name1] {^lash}[s/1] [names2] [body2] with a leather whip..."]
	return temparray[rand_range(0,temparray.size())]

func reaction(member):
	var text = ''
	#elif member.consent == false:
		#TBD
	if member.sens < 300:
		text = "[name2] twitches in pain from {^harsh:rough} threatment."
	elif member.sens < 600:
		text = "[name2] shows a mix of pain and pleasure on [his2] face."
	elif member.sens < 950:
		text = "[name2][s/2] moans make it hard to tell if [he2] suffers at all."
	else:
		text = "[name2] barely reacts to {^heavy:painful} strikes as [he2] edge[s/2] toward orgasm."
	if member.person.obed >= 90 && member.person != globals.player:
		text += "\n[color=green]During short break, [name2] shows [his2] complete submission to enforced discipline"
		if member.person.traits.find("Masochist") >= 0:
			text += ", but you also notice an unusual desire in [his2] eyes"
		text += '. [/color]'
	return text