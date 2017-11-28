extends Node

const category = 'fucking'
const code = 'missionary'
var givers
var takers
const canlast = true
const givereffects = {lust = 50, sens = 100}
const targeteffects = {lust = 50, sens = 100, pain = 20}
const giverpart = 'penis'
const takerpart = 'vagina'
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
		if i.person.vagina == 'none':
			valid = false
		elif i.vagina != null && takers.size() > 1:
			valid = false
	
	return valid

func getname(state = null):
	return "Missionary"

func getongoingname(givers, takers):
	return "[name1] fuck[s/1] [name2] in the missionary position."

func givereffect(member):
	var result
	var effects = {lust = 100, sens = 100, lewd = 1}
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
	var effects = {lust = 100, sens = 100, lewd = 1}
	if (member.consent == true || member.person.traits.find("Likes it rough") >= 0) && member.lewd >= 30 && member.lube >= 3:
		result = 'good'
	elif (member.consent == true || member.person.traits.find("Likes it rough") >= 0):
		result = 'average'
	else:
		result = 'bad'
	if member.lube < 3:
		effects.pain = 3
	return [result, effects]

const initiate = ['start_1_sexv','start_2_sexv']

const ongoing = ['main_1_sexv','main_2_sexv']

const reaction = ['react_1_sex','react_2_sex','react_3_sexv']

const links = [code, "missionaryanal", "doggy", "doggyanal"]

const act_lines = {

start_1_sexv = {
	
	repeat_nice = {
	conditions = {
		link = [code, "missionaryanal"],
		consent = [true],
	},
	lines = [
		"[name1] {^hold:lift}[s/1] [names2] legs{^ over [his2] head: apart}",
		"[name1] {^hug:hold:squeeze}[s/1] [name2] close to [him1]",
	]},
	
	repeat_mean = {
	conditions = {
		link = [code, "missionaryanal"],
		consent = [false],
	},
	lines = [
		"[name1] {^roughly :}{^pull[s/1]:spread[s/1]:hold[s/1]} [names2] legs{^ over [his2] head: apart}",
		"[name1] {^pin[s/1]:hold[s/1]} [name2] down",
	]},
	
	doggy_nice = {
	conditions = {
		link = ["doggy", "doggyanal"],
		consent = [true],
	},
	lines = [
		"[name1] {^flip:roll:turn}[s/1] [name2] over {^onto [his2] back[/s2]:to face [him1]}",
		"[name1] {^lift:guide:pull}[s/1] [name2] up off [his2] hands and knees and {^flip:roll:turn}[s/1] [him2] over",
	]},
	
	doggy_mean = {
	conditions = {
		link = ["doggy", "doggyanal"],
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

start_2_sexv = {
	
	swap_nice = {
	conditions = {
		link = ["doggy"],
		consent = [true],
	},
	lines = [
		"{^ before continuing to:, beginning again to} [fuck1] [his2] [pussy2]. ",
	]},
	
	swap_mean = {
	conditions = {
		link = ["doggy"],
		consent = [false],
	},
	lines = [
		"{^ before continuing to:, beginning again to} {^agressively :roughly :savagely :}[fuck1] [his2] [pussy2]. ",
	]},
	
	repeat_nice = {
	conditions = {
		link = [code],
		consent = [true],
	},
	lines = [
		"{^,: while:, all the while} continuing to [fuck1] [his2] [pussy2]{^ from above:}. ",
	]},
	
	repeat_mean = {
	conditions = {
		link = [code],
		consent = [false],
	},
	lines = [
		"{^,: while:, all the while} continuing to {^agressively :roughly :savagely :}[fuck1] [his2] [pussy2]{^ from above:}. ",
	]},
	
	holeswap = {
	conditions = {
		link = ["missionaryanal", "doggyanal"],
	},
	lines = [
		", {^pulling:removing} [his1] [penis1] from [names2] [anus2] and {^aligning it:lining it up} with [his2] [pussy2] instead. ",
		", {^slipping:sliding} [himself1] out from [names2] [anus2] and {^probing:pushing} into the {^enterance:mouth} of [his2] [pussy2]. ",
	]},
	
	insert = {
	conditions = {
		link = [null],
	},
	lines = [
		", {^spreading:parting:pulling apart:holding apart} [his2] thighs to expose [his2] [pussy2]. ",
		", {^aligning:lining up} [his1] [penis1] with the {^enterance:mouth} of [his2] [pussy2]. ",
		", {^probing:pressing} {^the tip of :}[his1] [penis1] into the {^enterance:mouth} of [his2] [pussy2]. ",
	]},
	
},

main_1_sexv = {
	
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

main_2_sexv = {
	
	repeat = {
	conditions = {
		virgin = [false],
		link = [code, "doggy"],
	},
	lines = [
		" as [he1] [fucks1] [partners2] {^[body2]:[pussy2]}. ",
	]},
	
	insert = {
	conditions = {
		virgin = [false],
		link = [null, "missionaryanal", "doggyanal"],
	},
	lines = [
		" as [he1] {^slide[s/1]:push[es/1]} [himself1] {^down:deep} {^into:inside} [partners2] {^[body2]:[pussy2]}. ",
		" as [he1] {^begin:start}[s/1] [fucking1] [partners2] {^[body2]:[pussy2]}. ",
	]},
	
},

react_3_sexv = {
	
	default = {
	conditions = {
	},
	lines = [
		" as [name1] [fucks1] [partner2].",
	]},
	
},

}