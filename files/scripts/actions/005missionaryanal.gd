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

func requirements():
	var valid = true
	if takers.size() != 1 || givers.size() != 1:
		valid = false
	elif !givers[0].penis in [takers[0].vagina, takers[0].anus] && (takers[0].anus != null || givers[0].penis != null || givers[0].person.penis == 'none'):
		valid = false
	return valid

func getname(state = null):
	if givers[0].person.penis == 'none':
		return "Missionary Pegging"
	else:
		return "Missionary Anal"

func getongoingname(givers, takers):
	return "[name1] fuck[s/1] [names2] ass[/es2] in the missionary position."

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

const initiate = ['a1','a2']

const ongoing = ['b1','b2']

const reaction = ['c1','c2','c3']

var links = [code]

const act_lines = {

a1 = {
	
	repeat_nice = {
	conditions = {
		link = [code],
		consent = [true],
	},
	lines = [
		"[name1] {^hold:lift}[s/1] [names2] legs{^ over [his2] head: apart}",
		"[name1] {^hug:hold:embrace}[s/1] [name2]",
	]},
	
	repeat_mean = {
	conditions = {
		link = [code],
		consent = [false],
	},
	lines = [
		"[name1] {^roughly :}{^pull[s/1]:spread[s/1]:hold[s/1]} [names2] legs{^ over [his2] head: apart}",
		"[name1] {^pin[s/1]:hold[s/1]} [name2] down",
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

a2 = {
	
	repeat_nice = {
	conditions = {
		link = [code],
		consent = [true],
	},
	lines = [
		", continuing to {^hammer into:pound:fuck} [his2] [anus2]{^ from above:}. ",
		", continuing to {^pump:pound} [his1] [penis1] {^in and out of:down into:deep inside} [his2] [anus2]. ",
	]},
	
	repeat_mean = {
	conditions = {
		link = [code],
		consent = [false],
	},
	lines = [
		", continuing to {^agressively :roughly :savagely :}{^hammer into:pound:fuck} [his2] [anus2]{^ from above:}. ",
		", continuing to {^agressively :roughly :savagely :}{^pump:pound:slam} [his1] [penis1] {^in and out of:down into:deep inside} [his2] [anus2]. ",
	]},
	
	insert_nice = {
	conditions = {
		link = [null],
		consent = [true],
	},
	lines = [
		", {^spreading:parting} [his2] thighs to expose [his2] [anus2]. ",
		", {^aligning:lining up} [his1] [penis1] with the {^enterance:mouth} of [his2] [anus2]. ",
	]},
	
	insert_mean = {
	conditions = {
		link = [null],
		consent = [false],
	},
	lines = [
		", {^pulling:holding} apart [his2] thighs to expose [his2] [anus2]. ",
		", {^probing:pressing} [his1] [penis1] into the {^enterance:mouth} of [his2] [anus2]. ",
	]},
	
},

b1 = {
	
	virgin = {
	conditions = {
		virgin = [true],
	},
	lines = [
		"[names2] {^rear enterance:backside} {^stretch[es/#2] to make room:widen[s/#2] to a new shape:offer[s/#2] some resistance} as [name1]",
		"[name2] {^brace[s/2] [himself2]:steels [his2] resolve:stare[s/2] down with wide eyes} as [name1]",
	]},
	
	nice = {
	conditions = {
		virgin = [false],
		consent = [true],
	},
	lines = [
		"[names2] sphincter {^envelop[s/#2]:wrap[s/#2] around:spread[s/#2] apart for} [names1] [penis1] as [he1]",
		"[name2] {^hold[s/2] onto:hug[s/2]:wrap[s/2] [his2] legs around} [name1] as [he1]",
	]},
	
	mean = {
	conditions = {
		virgin = [false],
		consent = [false],
	},
	lines = [
		"[names2] sphincter {^envelop[s/#2]:wrap[s/#2] around:spread[s/#2] apart for [names1] [penis1] as [he1]",
		"[name2] {^struggle[s/2] against:push[es/2] against} [name1] as [he1]",
	]},
	
},

b2 = {
	
	virgin = {
	conditions = {
		virgin = [true],
	},
	lines = [
		" {^take:claim}[s/1] [partners2] {^anal virginity:first time}. ",
		" {^break[s/1] in:deflower[s/1]} [partners2] {^unused:virgin} {^ass:butt}hole[/s2]. ",
	]},
	
	repeat = {
	conditions = {
		virgin = [false],
		link = [code],
	},
	lines = [
		" {^slide[s/1]:push[es/1]} [himself1] in and out of [partners2] {^[body2]:[anus2]}. ",
		" {^plunge:pummel:hammer}[s/1] {^deep :}{^into:inside} [partners2] {^[body2]:[anus2]}. ",
	]},
	
	insert = {
	conditions = {
		virgin = [false],
		link = [null],
	},
	lines = [
		" {^slide[s/1]:push[es/1]} [himself1] {^down:deep} {^into:inside} [partners2] {^[body2]:[anus2]}. ",
		" {^begin:start}[s/1] {^pumping:plunging} in and out of [partners2] {^[body2]:[anus2]}. ",
	]},
	
},

c1 = {
	
	arousal_3_nice = {
	conditions = {
		consent = [true],
		arousal = [4,5],
	},
	lines = [
		"[name2] hold[s/2] on as tightly as [he2] can",
		"[name2] {^cr[ies/y2] out:moans} {^wildly:passionately} with each thrust",
		"[name2] can hardly contain [himself2]",
	]},
	
	arousal_3_mean = {
	conditions = {
		consent = [false],
		arousal = [4,5],
	},
	lines = [
		"[names2] hips move with a mind of their own",
		"[name2] {^doesn't even try:completely forget[s/2]} to hold[s/2] in [his2] voice",
		"[name2] cling[s/2] to [his2] last {^vestiges:bits} of self-control",
	]},
	
	arousal_2_nice = {
	conditions = {
		consent = [true],
		arousal = [3],
	},
	lines = [
		"[names2] hips move on their own",
		"[name2] moan[s/2] loudly",
		"[name2] cr[ies/y2] out with each thrust",
	]},
	
	arousal_2_mean = {
	conditions = {
		consent = [false],
		arousal = [3],
	},
	lines = [
		"[names2] [body2] {^quiver[s/2]:twitch[es/2]}",
		"[name2] can't help but moan",
		"[name2] inadvertently cr[ies/y2] out",
	]},
	
	arousal_1_nice = {
	conditions = {
		consent = [true],
		arousal = [2],
	},
	lines = [
		"[names2] [body2] {^quiver[s/2]:twitch[es/2]}",
		"[name2] moan[s/2]",
		"[name2] cr[ies/y2] out",
	]},
	
	arousal_1_mean = {
	conditions = {
		consent = [false],
		arousal = [2],
	},
	lines = [
		"[name2] let[s/2] out {^quiet:muffled} noises",
		"[name2] trie[s/2] to look away",
		"[name2] twitch[es/2]",
	]},
	
	arousal_0_nice = {
	conditions = {
		consent = [true],
		arousal = [1],
	},
	lines = [
		"[name2] let[s/2] out {^quiet:muffled} noises",
		"[name2] twitch[es/2]",
		"[name2] softly moan[s/2]",
	]},
	
	arousal_0_mean = {
	conditions = {
		consent = [false],
		arousal = [1],
	},
	lines = [
		"[name2] clench[es/2] [his2] teeth",
		"[name2] tenses[s/2] up",
		"[name2] look[s/2] away in indignation",
	]},
	
},

c2 = {

	arousal_3_nice = {
	conditions = {
		consent = [true],
		arousal = [4,5],
	},
	lines = [
		", {^rapidly:quickly} {^nearing:approaching:edging toward} {^orgasm:[his2] climax:[his2] peak}",
		", on the verge of {^orgasm:climax}",
		"",
	]},
	
	arousal_3_mean = {
	conditions = {
		consent = [false],
		arousal = [4,5],
	},
	lines = [
		", {^having fallen:helpless:powerless} in the face of [his2] rapidly approaching {^orgasm:climax}",
		", trying {^desperately:with futility} to stave off [his2] {^orgasm:climax}",
		"",
	]},
	
	arousal_2_nice = {
	conditions = {
		consent = [true],
		arousal = [3],
	},
	lines = [
		", [his2] {^enjoyment:pleasure:satisfaction} {^clearly :}{^showing:evident}",
		", the {^pleasure:sensations} inside [him2] becoming too much to {^bear:take}",
		"",
	]},
	
	arousal_2_mean = {
	conditions = {
		consent = [false],
		arousal = [3],
	},
	lines = [
		", having lost [his2] composure",
		", feeling very aroused in spite of [himself2]",
		"",
	]},
	
	arousal_1_nice = {
	conditions = {
		consent = [true],
		arousal = [2],
	},
	lines = [
		", [his2] {^enjoyment:pleasure:satisfaction} building",
		", pleasure {^building:welling up} inside [him2]",
		"",
	]},
	
	arousal_1_mean = {
	conditions = {
		consent = [false],
		arousal = [2],
	},
	lines = [
		", [his2] composure starting to {^crack:fail:wane}",
		", beginning to feel aroused in spite of [himself2]",
		"",
	]},
	
	arousal_0_nice = {
	conditions = {
		consent = [true],
		arousal = [1],
	},
	lines = [
		", {^still adjusting:getting adjusted:far from orgasm}",
		", only just beginning to enjoy [himself2]",
		"",
	]},
	
	arousal_0_mean = {
	conditions = {
		consent = [false],
		arousal = [1],
	},
	lines = [
		", trying to {^resist:compose [himself2]:ignore what's happening}",
		", feeling {^ashamed:demeaned}",
		"",
	]},
	
},

c3 = {
	
	default = {
	conditions = {
	},
	lines = [
		" as [names1] [penis1] {^fillls:slides in and out of:plows} [his2] [anus2].",
		" as [names1] [penis1] {^massages:scrapes against:rubs against} the walls of [his2] [anus2].",
		" as [his2] [anus2] get[s/2] {^stretched:churned:massaged} by [names1] [penis1].",
	]},
	
},

}