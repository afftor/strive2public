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
    elif (!givers[0].penis in [takers[0].vagina, takers[0].anus] && (takers[0].vagina != null || givers[0].penis != null)) || takers[0].person.vagina == 'none':
        valid = false
    return valid

func getname(state = null):
	return "Missionary"

func getongoingname(givers, takers):
	return "[name1] fuck[s/1] [name2] in the missionary position."

const initiate = ['a1','a2']

const ongoing = ['b1','b2']

const reaction = ['c1','c2','c3']

const act_lines = {

a1 = {
	default = {
		nice = [
		"[name1] {^gently :}{^lay:set}[s/1] [name2] down{^ on [his2] back:}",
		"[name1] {^roll:shift}[s/1] [name2] onto [his2] back",
		],
		mean = [
		"[name1] {^roughly :}{^push[es/1]:pin[s/1]:hold[s/1]} [name2] down{^ on [his2] back:}",
		"[name1] {^toss[es/1]:throw[s/1]} [name2] onto [his2] back",
		],
	},
},

a2 = {
	default = {
		nice = [
		", {^spreading:parting} [his2] thighs to expose [his2] [pussy2]. ",
		", {^aligning:lining up} [his1] [penis1] with the {^enterance:mouth} of [his2] [pussy2]. ",
		],
		mean = [
		", {^pulling:holding} apart [his2] thighs to expose [his2] [pussy2]. ",
		", {^probing:pressing} [his1] [penis1] into the {^enterance:mouth} of [his2] [pussy2]. ",
		],
	},
},

b1 = {
	virgin = [
	"[names2] {^nethers:genitals} {^stretch to make room:widen to a new shape:offer some resistance} as [name1]",
	"[name2] {^brace[s/2] [himself2]:steels [his2] resolve:stare[s/2] down with wide eyes} as [name1]",
	],
	default = [
	"[names2] [labia2] {^envelop:wrap around:spread apart for} [names1] [penis1] as [he1]",
	"[name2] {^hold[s/2] onto:hug[s/2]:wrap[s/2] [his2] legs around} [name1] as [he1]",
	]
},

b2 = {
	virgin = [
	" {^rip:tear:break}[s/1] {^open:through} [partners2] hymen. ",
	" {^take:claim}[s/1] [partners2] {^virginity:first time}. ",
	" {^break[s/1] in:deflower[s/1]}[s/1] [partners2] {^unused:virgin} puss[y/ies2]. ",
	],
	default = [
	" {^slide[s/1]:push[es/1]} [himself1] deep into [partners2] {^[body2]:[pussy2]}. ",
	" {^begin:start}[s/1] {^pumping:plunging} in and out of [partners2] {^[body2]:[pussy2]}. ",
	],
},

c1 = {
	sens750 = {
		mean = [
		"[names2] hips move with a mind of their own",
		"[name2] {^doesn't even try:completely forget[s/2]} to hold[s/2] in [his2] voice",
		"[name2] lose[s/2] ",
		],
		nice = [
		"[name2] hold[s/2] on as tightly as [he2] can",
		"[name2] {^cr[ies/y2] out:moans} {^wildly:passionately} with each thrust",
		"[name2] can hardly contain [his2] pleasure",
		],
	},
	sens500 = {
		mean = [
		"[names2] [body2] {^quiver[s/2]:twitch[es/2]}",
		"[name2] can't help but moan",
		"[name2] inadvertently cr[ies/y2] out",
		],
		nice = [
		"[names2] hips move on their own",
		"[name2] moan[s/2] loudly",
		"[name2] cr[ies/y2] out with each thrust",
		],
	},
	sens250 = {
		mean = [
		"[name2] let[s/2] out {^quiet:muffled} noises",
		"[name2] trie[s/2] to look away",
		"[name2] twitch[es/2]",
		],
		nice = [
		"[names2] [body2] {^quiver[s/2]:twitch[es/2]}",
		"[name2] moan[s/2]",
		"[name2] cr[ies/y2] out",
		],
	},
	default = {
		mean = [
		"[name2] clench[es/2] [his2] teeth",
		"[name2] tenses[s/2] up",
		"[name2] look[s/2] away in indignation",
		],
		nice = [
		"[name2] let[s/2] out {^quiet:muffled} noises",
		"[name2] twitch[es/2]",
		"[name2] softly moan[s/2]",
		],
	},
},
c2 = {
	sens750 = {
		mean = [
		", {^having lost:helpless:powerless} in the face of [his2] rapidly approaching {^orgasm:climax}",
		", trying {^desperately:with futility} to stave of [his2] {^orgasm:climax}",
		"",
		],
		nice = [
		", {^rapidly:quickly} {^nearing:approaching:edging toward} {^orgasm:[his2] climax:[his2] peak}",
		", on the verge of {^orgasm:climax}",
		"",
		],
	},
	sens500 = {
		mean = [
		", having lost [his2] composure",
		", feeling very aroused in spite of [himself2]",
		"",
		],
		nice = [
		", [his2] {^enjoyment:pleasure:satisfaction} {^clearly :}{^showing:evident}",
		", the {^pleasure:sensations} inside [him2] becoming too much to {^bear:take}",
		"",
		],
	},
	sens250 = {
		mean = [
		", [his2] composure starting to {^crack:fail:wane}",
		", beginning to feel aroused in spite of [himself2]",
		"",
		],
		nice = [
		", [his2] {^enjoyment:pleasure:satisfaction} building",
		", pleasure {^building:welling up} inside [him2]",
		"",
		],
	},
	default = {
		mean = [
		", trying to {^resist:compose [himself2]:ignore what's happening}",
		", feeling {^ashamed:demeaned}",
		"",
		],
		nice = [
		", {^still adjusting:getting adjusted:far from orgasm}",
		", only just beginning to enjoy [himself2]",
		"",
		],
	},
},

c3 = {
	default = [
	" as [names1] [penis1] {^fillls:slides in and out of:plows} [his2] [pussy2].",
	" as [names1] [penis1] {^massages:scrapes against:rubs against} the walls of [his2] [pussy2].",
	" as [his2] [pussy2] get[s/2] {^stretched:churned:massaged} by [names1] [penis1].",
	],
},

}


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

func initiate():
	var text = ''
	text = "[name1] lay[s/1] [name2] down on [his2] back, parting [his2] thighs to expose [his2] [pussy2]. [names2] [labia2] envelop [names1] [penis1] as [he1]"
	if takers[0].person.vagvirgin == true:
		text += " rip[s/1] open [partners2] hymen."
		takers[0].person.vagvirgin = false
	else:
		text += " push[es/1] [his1] [penis1] deep into [partners2] [pussy2]."
	text += " [names2] bod[y/ies2] twitch[es/2] as [his2] [pussy2] get[s/2] stretched by [names1] [penis1]."
	return text


