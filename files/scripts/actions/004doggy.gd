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
	elif (!givers[0].penis in [takers[0].vagina, takers[0].anus] && (takers[0].vagina != null || givers[0].penis != null)) || takers[0].person.vagina == 'none':
		valid = false
	return valid

func getname(state = null):
	return "Doggy Style"

func getongoingname(givers, takers):
	return "[name1] fuck[s/1] [name2] in doggy style."

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

const initiate = ['a1','a2']

const ongoing = ['b1','b2']

const reaction = ['c1','c2','c3']

var links = [code, "doggyanal", "missionary", "missionaryanal"]

const act_lines = {

a1 = {
	
	holeswap = {
	conditions = {
		link = ["doggyanal"],
	},
	lines = [
		"[name1] {^pull:remove}[s/1] [his1] [penis1] from [names2] [anus2]",
		"[name1] {^slip:slide}[s/1] [himself1] out from [names2] [anus2]",
	]},
	
	repeat_nice = {
	conditions = {
		link = [code],
		consent = [true],
	},
	lines = [
		"[name1] {^hold[s/1]:secure[s/1]:stead[ies/y1]} [name2] by [his2] {^hips:waist[/s2]}",
		"[name1] {^squeeze:hold:grab}[s/1] [names2] {^ass:butt}cheeks",
	]},
	
	repeat_mean = {
	conditions = {
		link = [code],
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

a2 = {
	
	swap_nice = {
	conditions = {
		link = ["missionary"],
		consent = [true],
	},
	lines = [
		"{^ before continuing to:, beginning again to:, proceeding to once again} {^hammer into:pound:fuck} [his2] [pussy2]{^ from behind:}. ",
		"{^ before continuing to:, beginning again to:, proceeding to once again} {^pump:pound} [his1] [penis1] {^in and out of:deep into} [his2] [pussy2]. ",
	]},
	
	swap_mean = {
	conditions = {
		link = ["missionary"],
		consent = [false],
	},
	lines = [
		"{^ before continuing to:, beginning again to:, proceeding to once again} {^agressively :roughly :savagely :}{^hammer into:pound:fuck} [his2] [pussy2]{^ from behind:}. ",
		"{^ before continuing to:, beginning again to:, proceeding to once again} {^agressively :roughly :savagely :}{^pump:pound:slam} [his1] [penis1] {^in and out of:deep into} [his2] [pussy2]. ",
	]},
	
	repeat_nice = {
	conditions = {
		link = [code],
		consent = [true],
	},
	lines = [
		"{^,: while: all the while} continuing to {^hammer into:pound:fuck} [his2] [pussy2]{^ from behind:}. ",
		"{^,: while: all the while} continuing to {^pump:pound} [his1] [penis1] {^in and out of:deep into} [his2] [pussy2]. ",
	]},
	
	repeat_mean = {
	conditions = {
		link = [code],
		consent = [false],
	},
	lines = [
		"{^,: while: all the while} continuing to {^agressively :roughly :savagely :}{^hammer into:pound:fuck} [his2] [pussy2]{^ from behind:}. ",
		"{^,: while: all the while} continuing to {^agressively :roughly :savagely :}{^pump:pound:slam} [his1] [penis1] {^in and out of:deep into} [his2] [pussy2]. ",
	]},
	
	insert = {
	conditions = {
		link = [null, "doggyanal", "missionaryanal"],
	},
	lines = [
		", {^adjusting:rolling} [his2] hips forward to expose [his2] [pussy2]. ",
		", {^pressing:pushing} [his2] upper body downward to expose [his2] [pussy2]. ",
		", {^aligning:lining up} [his1] [penis1] with the {^enterance:mouth} of [his2] [pussy2]. ",
		", {^probing:pressing} {^the tip of :}[his1] [penis1] into the {^enterance:mouth} of [his2] [pussy2]. ",
	]},
	
},

b1 = {
	
	virgin_nice = {
	conditions = {
		virgin = [true],
		consent = [true],
	},
	lines = [
		"[names2] {^nethers:genitals} {^stretch to make room:widen to a new shape:offer some resistance} as [name1]",
		"[name2] {^brace[s/2] [himself2]:steels [his2] resolve:stare[s/2] back with wide eyes} as [name1]",
	]},
	
	virgin_mean = {
	conditions = {
		virgin = [true],
		consent = [false],
	},
	lines = [
		"[names2] {^nethers:genitals} {^stretch:permanently widen:offer resistance} as [name1]",
		"[name2] {^brace[s/2] [himself2]:reels with shock:stare[s/2] back with horror} as [name1]",
	]},
	
	nice = {
	conditions = {
		virgin = [false],
		consent = [true],
	},
	lines = [
		"[name2] {^spread[s/2]:part[s/2]} [his2] thighs for [name1] as [he1]",
		"[name2] {^stare:glance:look}[s/2] {^back:backward} {^over [his2] shoulder :}at [name1] as [he1]",
	]},
	
	mean = {
	conditions = {
		virgin = [false],
		consent = [false],
	},
	lines = [
		"[name2] {^helplessly :fruitlessly :}struggle[s/2] against [name1] as [he1]",
		"[name2] {^helplessly :fruitlessly :}tr[ies/y2] to {^crawl:move} away as [name1]",
	]},
	
	default = {
	conditions = {
	},
	lines = [
		"[names2] [labia2] {^envelop:wrap around:spread apart for:tug at} [names1] [penis1] as [he1]",
	]},
	
},

b2 = {
	
	virgin = {
	conditions = {
		virgin = [true],
	},
	lines = [
		" {^rip:tear:break}[s/1] {^open:through} [partners2] hymen. ",
		" {^take:claim}[s/1] [partners2] {^virginity:first time}. ",
		" {^break[s/1] in:deflower[s/1]} [partners2] {^unused:virgin} puss[y/ies2]. ",
	]},
	
	repeat = {
	conditions = {
		virgin = [false],
		link = [code, "missionary"],
	},
	lines = [
		" {^slide[s/1]:push[es/1]} [himself1] in and out of [partners2] {^[body2]:[pussy2]}. ",
		" {^plunge:pummel:hammer}[s/1] {^deep :}{^into:inside} [partners2] {^[body2]:[pussy2]}. ",
	]},
	
	insert = {
	conditions = {
		virgin = [false],
		link = [null, "doggyanal", "missionaryanal"],
	},
	lines = [
		" {^slide[s/1]:push[es/1]} [himself1] {^down:deep} {^into:inside} [partners2] {^[body2]:[pussy2]}. ",
		" {^begin:start}[s/1] {^pumping:plunging} in and out of [partners2] {^[body2]:[pussy2]}. ",
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
		" as [name1] {^screw:plow:fuck}[s/1] [partner2] {^from behind:like [an /2]animal[/s2]}.",
		" as [names1] [penis1] {^fillls:slides in and out of:plows} [his2] [pussy2].",
		" as [names1] [penis1] {^massages:scrapes against:rubs against} the walls of [his2] [pussy2].",
		" as [his2] [pussy2] get[s/2] {^stretched:churned:massaged} by [names1] [penis1].",
	]},
	
},

}