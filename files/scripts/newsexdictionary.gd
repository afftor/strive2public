extends Node

#shared lines for newtype actions
const shared_lines = {

main_1_sexv = {
		virgin_nice = {
	conditions = {
		virgin = [true],
		consent = [true],
	},
	lines = [
		"[names2] {^nethers:genitals} {^stretch to make room:widen to a new shape:offer some resistance}",
	]},
	
	virgin_mean = {
	conditions = {
		virgin = [true],
		consent = [false],
	},
	lines = [
		"[names2] {^nethers:genitals} {^stretch:permanently widen:offer resistance}",
	]},
	
	nice = {
	conditions = {
		virgin = [false],
		consent = [true],
	},
	lines = [
		"[name2] {^spread[s/2]:part[s/2]} [his2] thighs for [name1]",
	]},
	
	mean = {
	conditions = {
		virgin = [false],
		consent = [false],
	},
	lines = [
		"[name2] {^helplessly :fruitlessly :}struggle[s/2] against [name1]",
	]},
	
	default = {
	conditions = {
		virgin = [false],
	},
	lines = [
		"[names2] [labia2] {^envelop:wrap around:tug at} [names1] [penis1]",
	]},
	
},

main_1_sexa = {
	
	virgin_nice = {
	conditions = {
		virgin = [true],
		consent = [true],
	},
	lines = [
		"[names2] {^ass:butt}hole {^stretch[es/#2] to make room:widen[s/#2] to a new shape:offer[s/#2] some resistance}",
	]},
	
	virgin_mean = {
	conditions = {
		virgin = [true],
		consent = [false],
	},
	lines = [
		"[names2] {^ass:butt}hole {^stretch[es/#2]:permanently widen[s/#2]:offer[s/#2] resistance}",
	]},
	
	nice = {
	conditions = {
		virgin = [false],
		consent = [true],
	},
	lines = [
		"[name2] {^spread[s/2]:part[s/2]} [his2] thighs for [name1]",
	]},
	
	mean = {
	conditions = {
		virgin = [false],
		consent = [false],
	},
	lines = [
		"[name2] {^helplessly :fruitlessly :}struggle[s/2] against [name1]",
	]},
	
	default = {
	conditions = {
		virgin = [false],
	},
	lines = [
		"[names2] {^ass:butt}hole {^envelop[s/#2]:wrap[s/#2] around:tug[s/#2] at} [names1] [penis1]",
	]},
	
},

main_2_sexv = {
	
	virgin = {
	conditions = {
		virgin = [true],
	},
	lines = [
		" as [he1] {^rip:tear:break}[s/1] {^open:through} [partners2] hymen. ",
		" as [he1] {^take:claim}[s/1] [partners2] {^virginity:first time}. ",
		" as [he1] {^break[s/1] in:deflower[s/1]} [partners2] {^unused:virgin} puss[y/ies2]. ",
	]},
	
},

main_2_sexa = {
	
	virgin = {
	conditions = {
		virgin = [true],
	},
	lines = [
		" as [he1] {^take:claim}[s/1] [partners2] {^anal virginity:first time}. ",
		" as [he1] {^break[s/1] in:deflower[s/1]} [partners2] {^unused:virgin} {^ass:butt}hole[/s2]. ",
	]},
	
},

react_1_sex = {
	
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

react_2_sex = {

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

react_3_sexv = {
	
	default = {
	conditions = {
	},
	lines = [
		" as [names1] [penis1] {^fillls:slides in and out of:plows} [his2] [pussy2].",
		" as [names1] [penis1] {^massages:scrapes against:rubs against} the walls of [his2] [pussy2].",
		" as [his2] [pussy2] get[s/2] {^stretched:churned:massaged} by [names1] [penis1].",
	]},
	
},

react_3_sexa = {
	
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