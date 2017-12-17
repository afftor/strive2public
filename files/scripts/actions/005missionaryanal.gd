extends Node

const category = 'fucking'
const code = 'missionaryanal'
var givers
var takers
const canlast = true
const givereffects = {lust = 50, sens = 100}
const targeteffects = {lust = 50, sens = 100, pain = 40}
const giverpart = 'penis'
const takerpart = 'anus'
const virginloss = true
var giverconsent = 'basic'
var takerconsent = 'any'

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
		return "Missionary Pegging"
	else:
		return "Missionary Anal"

func getongoingname(givers, takers):
	return "[name1] thrust[s/1] [his1] tail in and out of [names2] [ass2]."

func givereffect(member):
	var result
	var effects = {lust = 90, sens = 100, lewd = 3}
	if member.consent == true || (member.person.traits.find("Likes it rough") >= 0 && member.lewd >= 30):
		result = 'good'
	elif member.person.traits.find("Likes it rough") >= 0:
		result = 'average'
	else:
		result = 'bad'
	if member.person.penis == 'none':
		effects.sens /= 1.2
		effects.lust /= 1.2
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
	return [result, effects]

const initiate = ['start_1_sexa','start_2_sexa']

const ongoing = ['main_1_sexa','main_2_sexa']

const reaction = ['react_1_sex','react_2_sex','react_3_sexa']

const links = [code, "missionary", "doggy", "doggyanal"]

const act_lines = {

start_1_sexa = {
	
	repeat_nice = {
	conditions = {
		link = [code, "missionary"],
		consent = [true],
	},
	lines = [
		"[name1] {^hold:lift}[s/1] [names2] legs{^ over [his2] head: apart}",
		"[name1] {^hug:hold:squeeze}[s/1] [name2] close to [him1]",
	]},
	
	repeat_mean = {
	conditions = {
		link = [code, "missionary"],
		consent = [false],
	},
	lines = [
		"[name1] {^roughly :}{^pull[s/1]:spread[s/1]:hold[s/1]} [names2] legs{^ over [his2] head: apart}",
		"[name1] {^pin[s/1]:hold[s/1]} [name2] down",
	]},
	
	doggy_nice = {
	conditions = {
		link = ["doggyanal", "doggy"],
		consent = [true],
	},
	lines = [
		"[name1] {^flip:roll:turn}[s/1] [name2] over {^onto [his2] back[/s2]:to face [him1]}",
		"[name1] {^lift:guide:pull}[s/1] [name2] up off [his2] hands and knees and {^flip:roll:turn}[s/1] [him2] over",
	]},
	
	doggy_mean = {
	conditions = {
		link = ["doggyanal", "doggy"],
		consent = [false],
	},
	lines = [
		"[name1] {^flip:roll:turn}[s/1] [name2] over {^onto [his2] back[/s2]:to face [him1]}",
		"[name1] {^yank:jerk:pull}[s/1] [name2] up off [his2] hands and knees and {^flip:roll:turn}[s/1] [him2] over",
	]},
	
	insert_nice = {
	conditions = {
		link = [null],
		consent = [true],
	},
	lines = [
		"[name1] {^gently :}{^lay:set}[s/1] [name2] down{^ on [his2] back:}",
		"[name1] {^roll:shift}[s/1] [name2] onto [his2] back",
	]},
	
	insert_mean = {
	conditions = {
		link = [null],
		consent = [false],
	},
	lines = [
		"[name1] {^roughly :}{^push[es/1]:pin[s/1]:hold[s/1]} [name2] down{^ on [his2] back:}",
		"[name1] {^toss[es/1]:throw[s/1]} [name2] onto [his2] back",
	]},
	
},

start_2_sexa = {
	
	swap_nice = {
	conditions = {
		link = ["doggyanal"],
		consent = [true],
	},
	lines = [
		"{^ before continuing to:, beginning again to} [fuck1] [his2] [anus2]. ",
	]},
	
	swap_mean = {
	conditions = {
		link = ["doggyanal"],
		consent = [false],
	},
	lines = [
		"{^ before continuing to:, beginning again to} {^agressively :roughly :savagely :}[fuck1] [his2] [anus2]. ",
	]},
	
	repeat_nice = {
	conditions = {
		link = [code],
		consent = [true],
	},
	lines = [
		"{^,: while:, all the while} continuing to [fuck1] [his2] [anus2]. ",
	]},
	
	repeat_mean = {
	conditions = {
		link = [code],
		consent = [false],
	},
	lines = [
		"{^,: while:, all the while} continuing to {^agressively :roughly :savagely :}[fuck1] [his2] [anus2]. ",
	]},
	
	holeswap = {
	conditions = {
		link = ["doggy", "missionary"],
	},
	lines = [
		", {^pulling:removing} [his1] [penis1] from [names2] [pussy2] and {^aligning it:lining it up} with [his2] [anus2] instead. ",
		", {^slipping:sliding} [himself1] out from [names2] [pussy2] and {^probing:pushing} into the {^enterance:mouth} of [his2] [anus2]. ",
	]},
	
	insert = {
	conditions = {
		link = [null],
	},
	lines = [
		", {^spreading:parting:pulling apart:holding apart} [his2] thighs to expose [his2] [anus2]. ",
		", {^aligning:lining up} [his1] [penis1] with the {^enterance:mouth} of [his2] [anus2]. ",
		", {^probing:pressing} {^the tip of :}[his1] [penis1] into the {^enterance:mouth} of [his2] [anus2]. ",
	]},
	
},

main_1_sexa = {
	
	virgin_nice = {
	conditions = {
		virgin = [true],
		consent = [true],
	},
	lines = [
		"[name2] {^brace[s/2] [himself2]:steels [his2] resolve:stare[s/2] down with wide eyes}",
	]},
	
	virgin_mean = {
	conditions = {
		virgin = [true],
		consent = [false],
	},
	lines = [
		"[name2] {^brace[s/2] [himself2]:reels with shock:stare[s/2] down with horror}",
	]},
	
	nice = {
	conditions = {
		virgin = [false],
		consent = [true],
	},
	lines = [
		"[name2] {^throw[s/2] [his2] arms around:wrap[s/2] [his2] legs around} [name1]",
	]},
	
	mean = {
	conditions = {
		virgin = [false],
		consent = [false],
	},
	lines = [
		"[name2] {^helplessly :fruitlessly :}tr[ies/y2] to {^push:move} away",
	]},
	
},

main_2_sexa = {
	
	repeat = {
	conditions = {
		virgin = [false],
		link = [code, "doggyanal"],
	},
	lines = [
		" as [he1] [fucks1] [partners2] {^[body2]:[anus2]}. ",
	]},
	
	insert = {
	conditions = {
		virgin = [false],
		link = [null, "missionary", "doggy"],
	},
	lines = [
		" as [he1] {^slide[s/1]:push[es/1]} [himself1] {^down:deep} {^into:inside} [partners2] {^[body2]:[anus2]}. ",
		" as [he1] {^begin:start}[s/1] [fucking1] [partners2] {^[body2]:[anus2]}. ",
	]},
	
},

react_3_sexa = {
	
	default = {
	conditions = {
	},
	lines = [
		" as [name1] [fucks1] [partners2] [anus2].",
	]},
	
},

}