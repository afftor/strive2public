extends Node

var category = 'fucking'
var code = 'missionary'
var givers
var takers
var canlast = true
var givereffects = {lust = 50, sens = 100}
var targeteffects = {lust = 50, sens = 100, pain = 20}
var giverpart = 'penis'
var takerpart = 'vagina'

#additional action data
var virginloss = true

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

func getongoingdescription(givers, takers):
	return output(['b1','b2'])

func initiate():
	return output(['a1','a2','b1','b2'])

func reaction(member):
	return output(['c1','c2'])

func output(valid_lines):
	#internal
	var output = ''
	var consent = true
	var virgin = true
	var virginpart = null
	var virginsource = null
	var link = null
	var checks = []
	
	#virginity assignments
	if giverpart == 'penis':
		if takerpart == 'vagina':
			virginpart = 'vagvirgin'
			virginsource = takers
		elif takerpart == 'anus':
			virginpart = 'assvirgin'
			virginsource = takers
	elif takerpart == 'penis':
		if giverpart == 'vagina':
			virginpart = 'vagvirgin'
			virginsource = givers
		elif giverpart == 'anus':
			virginpart = 'assvirgin'
			virginsource = givers
	#assign virginity check
	for i in virginsource:
		if i.person[virginpart] == false:
			virgin = false
	if virgin:
		print(virgin)
		checks += ['virgin']
	#assign consent
	for i in takers:
		if i.consent == false:
			consent = false
	#link with ongoingactions
	if givers[0][giverpart] != null:
		link = givers[0][giverpart].scene.code
		for i in givers:
			if i[giverpart] != givers[0][giverpart]:
				link = null
				break
		for i in takers:
			if i[takerpart] != givers[0][giverpart]:
				link = null
				break
	#link with lastaction
	if link == null && givers[0].lastaction != null:
		link = givers[0].lastaction.scene.code
		for i in givers+takers:
			if i.lastaction != givers[0].lastaction:
				link = null
				break
	if link != null:
		checks += [link]
	checks += ['none']
	
	#build the output
	for i in valid_lines:
		if !i in act_lines:
			continue
		for j in checks:
			if j in act_lines[i]:
				if consent == false && act_lines[i][j].has("mean"):
					output += act_lines[i][j].mean[rand_range(0,act_lines[i][j].mean.size())]
					break
				elif act_lines[i][j].has("nice"):
					output += act_lines[i][j].nice[rand_range(0,act_lines[i][j].nice.size())]
					break
				elif act_lines[i][j] != []:
					output += act_lines[i][j][rand_range(0,act_lines[i][j].size())]
					break
	
	#remove virginity if relevant
	if virginloss:
		for i in virginsource:
			i.person[virginpart] = false

	return output

const act_lines = {

a1 = {
	none = {
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
	none = {
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
	none = [
	"[names2] [labia2] {^envelop:wrap around:spread apart for} [names1] [penis1] as [he1]",
	"[name2] {^hold[s/2] onto:hug[s/2]:wrap[s/2] [his2] legs around} [name1] as [he1]",
	]
},

b2 = {
	virgin = [
	" {^rip:tear:break}[s/1] {^open:through} [partners2] hymen. ",
	" {^take:claim}[s/1] [partners2] {^virginity:first time}. ",
	" deflower[s/1] [partner2]. ",
	],
	none = [
	" {^slide[s/1]:push[es/1]} [himself1] deep into {^[partners2] [body2]:[partner2]}. ",
	" {^begin:start}[s/1] {^pumping:plunging} in and out of {^[partners2] [body2]:[partner2]}. ",
	],
},

c1 = {
	none = [
	"[names2] [body2] twitch[es/2]",
	],
},

c2 = {
	none = [
	" as [his2] [pussy2] get[s/2] stretched by [names1] [penis1].",
	],
},

}