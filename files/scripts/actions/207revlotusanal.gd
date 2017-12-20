extends Node

const category = 'fucking'
const code = 'revlotusanal'
var givers
var takers
const canlast = true
const givereffects = {lust = 50, sens = 100}
const targeteffects = {lust = 50, sens = 100, pain = 40}
const giverpart = 'penis'
const takerpart = 'anus'
const virginloss = true

func requirements():
	var valid = true
	if takers.size() != 1 || givers.size() != 1:
		valid = false
	elif givers.size() + takers.size() == 2 && (!givers[0].penis in [takers[0].vagina, takers[0].anus] ):
		valid = false
	for i in givers:
		if i.person.penis == 'none' && i.strapon == null:
			valid = false
		elif i.penis != null && givers.size() > 1:
			valid = false
	for i in takers:
		if i.anus != null && takers.size() > 1:
			valid = false
	
	return valid

func getname(state = null):
	if givers[0].strapon != null:
		return "Rev. Lotus Pegging"
	else:
		return "Rev. Lotus Anal"

func getongoingname(givers, takers):
	return "[name1] fuck[s/1] [names2] ass[/es2] in the reverse lotus position."

func givereffect(member):
	var result
	var effects = {lust = 90, sens = 100, lewd = 3}
	if member.consent == true || (member.person.traits.find("Likes it rough") >= 0 && member.lewd >= 30):
		result = 'good'
	elif member.person.traits.find("Likes it rough") >= 0:
		result = 'average'
	else:
		result = 'bad'
	return [result, effects]

func takereffect(member):
	var result
	var effects = {lust = 80, sens = 110, lewd = 3}
	if (member.consent == true || member.person.traits.find("Likes it rough") >= 0) && member.lewd >= 40 && member.lube >= 5:
		result = 'good'
	elif (member.consent == true || member.person.traits.find("Likes it rough") >= 0):
		result = 'average'
	else:
		result = 'bad'
	if member.lube < 5:
		effects.pain = 3
	if member.person.penis == 'none':
		effects.sens /= 1.2
		effects.lust /= 1.2
	return [result, effects]

#orientation of givers/takers
const rotation1 = Quat(0.0,0.0,0.0,0.0)
const rotation2 = Quat(0.0,0.0,0.0,1.0)

const initiate = ['start_1_revlotus','start_2_sexa']

const ongoing = ['main_1_sexa','main_2_sexa','main_3_sex']

const reaction = ['react_1_sex','react_2_sex','react_3_sexa']

const linkset = "sex"

const act_lines = {

start_2_sexa = {
	
	shift = {
	conditions = {
		orifice = ["shift"],
	},
	lines = [
		", {^enjoying:finding glee in} putting [partner2] in such an embarassing position. ",
	]},
	
},

main_3_sex = {
	
	locational = {
	conditions = {
	},
	lines = [
		". ",
		" from below. ",
	]},
	
},

react_3_sexa = {
	
	default = {
	conditions = {
	},
	lines = [
		" as [name1] make[s/1] a show of [him2].",
	]},
	
},

}