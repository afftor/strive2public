extends Node

var category = 'caress'
var code = 'fingering'
var givers
var takers
var canlast = true
var givereffects = {lust = 50, sens = 0}
var targeteffects = {lust = 50, sens = 100, pain = 10}
var giverpart = ''
var takerpart = 'anus'
var giverconsent = 'basic'
var takerconsent = 'any'

func getname(state = null):
	return "Ass Fingering"

func getongoingname(givers, takers):
	return "[name1] finger[s/1] [names2] ass[es/2]."

func getongoingdescription(givers, takers):
	return "[name1] thrust[s/1] [his1] fingers in and out of [names2] [anus2]."

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1 || givers.size() + takers.size() > 3:
		valid = false
	for i in takers:
		if i.vagina != null || i.person.vagina == 'none':
			valid = false
	return valid

func givereffect(member):
	var result
	var effects = {lust = 50, lewd = 2}
	if member.consent == true || (member.person.traits.find("Likes it rough") >= 0 && member.lewd >= 20):
		result = 'good'
	elif member.person.traits.find("Likes it rough") >= 0:
		result = 'average'
	else:
		result = 'bad'
	return [result, effects]

func takereffect(member):
	var result
	var effects = {lust = 75, sens = 100, lewd = 2}
	if member.consent == true || (member.person.traits.find("Likes it rough") >= 0 && member.lewd >= 20):
		result = 'good'
	elif member.person.traits.find("Likes it rough") >= 0:
		result = 'average'
	else:
		result = 'bad'
	return [result, effects]

func initiate():
	var text = ''
	if takers[0].lube > 5:
		text += "[name1] {^easily:effortlessly} {^get:work:slip:slide}[s/1] [his1] fingers into [names2] [anus2]"
	else:
		text += "[name1] {^slowly:carefully} {^get:work:slip:slide}[s/1] [his1] fingers into [names2] [anus2]"
	text += ", {^driving:pumping:pushing} [his1] fingers in and out."
	return text

func reaction(member):
	var text = ''
	if member.energy == 0:
		text = "[names2] [anus2] {^trembles:twitches}, {^responding:reacting} to {^the stimulation:[names1] fingers:[names1] caress} even in [his2] unconcious state."
	#elif member.consent == false:
		#TBD
	elif member.sens < 100:
		text = "[names2] [anus2] {^presents:gives} some resistance to {^the intrusion:[names1] fingers:[names1] caress}{^, still somewhat unprepared:, not yet fully prepared:}."
	elif member.sens < 300:
		text = "[names2] [anus2] {^begins:starts} to {^respond:react} to the {^sensation:feeling} of {^[names1] fingers:[names1] caress}."
	elif member.sens < 600:
		text = "[names2] [anus2] {^trembles:quivers} in {^response:reaction} to the {^sensation:feeling} of {^[names1] fingers:[names1] caress}, [his2] arousal {^made clear:apparent:clearly showing}."
	else:
		text = "[names2] [anus2] {^violently trembles:clenches:quivers} with every movement of [names1] fingers{^ as [he2] rapidly near[s/2] orgasm: as [he2] approach[es/2] orgasm: as [he2] edge[es/2] toward orgasm:}."
	return text