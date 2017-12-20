extends Node

const category = 'SM'
const code = 'whipping'
var givers
var takers
const canlast = false
const givereffects = {lust = 0, sens = 0}
const targeteffects = {lust = 0, sens = 0, pain = 5}
const giverpart = ''
const takerpart = ''
const virginloss = false
const giverconsent = 'basic'
const takerconsent = 'any'

func getname(state = null):
	return "Whipping"

#func getongoingname(givers, takers):
#	return "[name1] whip[s/1] [name2]."

#func getongoingdescription(givers, takers):
#	var temparray = []
#	return temparray[rand_range(0,temparray.size())]

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
	var effects = {sens = 45, pain = 2, tags = ['punish'], obed = rand_range(14,22), stress = rand_range(5,10)}
	if (member.person.traits.find("Likes it rough") >= 0 && member.lewd >= 30) || member.person.traits.find('Masochist') >= 0:
		result = 'good'
		effects.lust = 70
	elif member.person.traits.find("Likes it rough") >= 0 || member.lust >= 700:
		result = 'average'
		effects.lust = 30
	else:
		result = 'bad'
	return [result, effects]

func initiate():
	var temparray = []
	temparray += ["[name1] {^lash}[s/1] at [names2] [body2] with a leather whip."]
	return temparray[rand_range(0,temparray.size())]

func reaction(member):
	var text = ''
	#elif member.consent == false:
		#TBD
	if member.sens < 300:
		text = "[name2] {^jerk:wince:writhe}[s/2] in pain from the {^harsh:severe:brutal} punishment."
	elif member.sens < 600:
		text = "[name2] cries out with each {^strike:lash}, though [his2] voice betrays some enjoyment."
	elif member.sens < 950:
		text = "[names2] moans make it {^hard:difficult} to tell if [he2] in pain or enjoying [himself2]."
	else:
		text = "[name2] barely reacts to {^heavy:painful} {^strikes:lashes} as [he2] edge[s/2] toward orgasm."
	if member.person.obed >= 90 && member.person != globals.player:
		text += "\n[color=green]Afterward, {^[name2] seems to have:it looks as though [name2] [has2]} {^learned [his2] lesson:reformed [his2] rebellious ways:surrendered} and shows {^complete:total} {^submission:obedience:compliance}"
		if member.person.traits.find("Masochist") >= 0:
			text += ", but there is also {^an unusual:a strange} {^flash:hint:look} of desire in [his2] eyes"
		text += '. [/color]'
	return text