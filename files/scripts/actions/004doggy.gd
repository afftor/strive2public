extends Node

const category = 'fucking'
const code = 'doggy'
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
	return "Doggy Style"

func getongoingname(givers, takers):
	return "[name1] fuck[s/1] [name2] doggy style."

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

var links = [code, "doggyanal", "missionary", "missionaryanal"]

const act_lines = {

start_1_sexv = {
	
	repeat_nice = {
	conditions = {
		link = [code, "doggyanal"],
		consent = [true],
	},
	lines = [
		"[name1] {^hold[s/1]:secure[s/1]:stead[ies/y1]} [name2] by [his2] {^hips:waist[/s2]}",
		"[name1] {^squeeze:hold:grab}[s/1] [names2] {^ass:butt}cheeks",
	]},
	
	repeat_mean = {
	conditions = {
		link = [code, "doggyanal"],
		consent = [false],
	},
	lines = [
		"[name1] {^roughly :}{^grabs[s/1]:seize[s/1]} [name2] by [his2] {^hips:waist[/s2]}",
		"[name1] {^pin[s/1]:hold[s/1]} [name2] down {^on all fours:on [his2] knees}",
	]},
	
	missionary_nice = {
	conditions = {
		link = ["missionary", "missionaryanal"],
		consent = [true],
	},
	lines = [
		"[name1] {^flip:roll:turn}[s/1] [name2] over onto {^all fours:[his2] knees:[his2] hands and knees}",
		"[name1] {^lift:guide:pull}[s/1] [name2] up off [his2] back[/s2] and {^flip:roll:turn}[s/1] [him2] over",
	]},
	
	missionary_mean = {
	conditions = {
		link = ["missionary", "missionaryanal"],
		consent = [false],
	},
	lines = [
		"[name1] {^flip:roll:turn}[s/1] [name2] over onto {^all fours:[his2] knees:[his2] hands and knees}",
		"[name1] {^yank:jerk:pull}[s/1] [name2] up off [his2] back[/s2] and {^flip:roll:turn}[s/1] [him2] over",
	]},
	
	insert_nice = {
	conditions = {
		link = [null],
		consent = [true],
	},
	lines = [
		"[name1] {^gently :}{^guide:set}[s/1] [name2] down onto {^all fours:[his2] knees}",
		"[name1] {^roll:shift}[s/1] [name2] onto [his2] hands and knees",
	]},
	
	insert_mean = {
	conditions = {
		link = [null],
		consent = [false],
	},
	lines = [
		"[name1] {^roughly :}{^push[es/1]:pin[s/1]:hold[s/1]} [name2] down {^on all fours:on [his2] knees}",
		"[name1] {^toss[es/1]:throw[s/1]} [name2] onto [his2] hands and knees",
	]},
	
},

start_2_sexv = {
	
	swap_nice = {
	conditions = {
		link = ["missionary"],
		consent = [true],
	},
	lines = [
		"{^ before continuing to:, beginning again to} [fuck1] [his2] [pussy2]. ",
	]},
	
	swap_mean = {
	conditions = {
		link = ["missionary"],
		consent = [false],
	},
	lines = [
		"{^ before continuing to:, beginning again to} {^agressively :roughly :savagely :}[fuck1] [his2] [pussy2]{^ from behind:}. ",
	]},
	
	repeat_nice = {
	conditions = {
		link = [code],
		consent = [true],
	},
	lines = [
		"{^,: while: all the while} continuing to [fuck1] [his2] [pussy2]{^ from behind:}. ",
	]},
	
	repeat_mean = {
	conditions = {
		link = [code],
		consent = [false],
	},
	lines = [
		"{^,: while: all the while} continuing to {^agressively :roughly :savagely :}[fuck1] [his2] [pussy2]{^ from behind:}. ",
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
		", {^adjusting:rolling} [his2] hips forward to expose [his2] [pussy2]. ",
		", {^pressing:pushing} [his2] upper body downward to expose [his2] [pussy2]. ",
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
		"[name2] {^brace[s/2] [himself2]:steels [his2] resolve:stare[s/2] back with wide eyes}",
	]},
	
	virgin_mean = {
	conditions = {
		virgin = [true],
		consent = [false],
	},
	lines = [
		"[name2] {^brace[s/2] [himself2]:reels with shock:stare[s/2] back with horror}",
	]},
	
	nice = {
	conditions = {
		virgin = [false],
		consent = [true],
	},
	lines = [
		"[name2] {^stare:glance:look}[s/2] {^back:backward} {^over [his2] shoulder :}at [name1]",
	]},
	
	mean = {
	conditions = {
		virgin = [false],
		consent = [false],
	},
	lines = [
		"[name2] {^helplessly :fruitlessly :}tr[ies/y2] to {^crawl:move} away",
	]},
	
},

main_2_sexv = {
	
	repeat = {
	conditions = {
		virgin = [false],
		link = [code, "missionary"],
	},
	lines = [
		" as [he1] [fucks1] [partners2] {^[body2]:[pussy2]}{^ from behind:}. ",
	]},
	
	insert = {
	conditions = {
		virgin = [false],
		link = [null, "doggyanal", "missionaryanal"],
	},
	lines = [
		" as [he1] {^slide[s/1]:push[es/1]} [himself1] {^down:deep} {^into:inside} [partners2] {^[body2]:[pussy2]}{^ from behind:}. ",
		" as [he1] {^begin:start}[s/1] [fucking1] {^[body2]:[pussy2]}{^ from behind:}. ",
	]},
	
},

react_3_sexv = {
	
	default = {
	conditions = {
	},
	lines = [
		" as [name1] [fucks1] [partner2] {^like [an /2]animal[/s2]:like a dog in heat}.",
	]},
	
},

}