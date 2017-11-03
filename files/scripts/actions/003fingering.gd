extends Node

var category = 'caress'
var code = 'fingering'
var givers
var takers
var canlast = true
var givereffects = {lust = 50, sens = 0}
var targeteffects = {lust = 50, sens = 100, pain = 10}
var giverpart = ''
var takerpart = 'vagina'

func getname(state = null):
	return "Fingering"

func getongoingname(givers, takers):
	return "[name1] finger[%1s] [name2]'s pussy."

func getongoingdescription(givers, takers):
	return "[name1] thrusts [his1] fingers in and out of [name2] [pussy2]. "

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1 || givers.size() + takers.size() > 2:
		valid = false
	for i in takers:
		if i.vagina != null:
			valid = false
	return valid



func initiate():
	var text = ''
	if takers[0].person.vagvirgin == true:
		text += "[name1] inserts [his1] fingers into [name2] [pussy2], and can feel [his2] hymen..."
	elif takers[0].lube > 5:
		text += "[name1] easily slips [his1] fingers into [name2] drenched [pussy2]..."
	else:
		text += "[name1] slowly gets [his1] fingers inside [name2] [pussy2]..."
	return text


func reaction(member):
	var text = ''
	var pleasure = member.sens
	if member.energy == 0:
		text += "[name] moans unconsciously from the vaginal stimulation."
	elif pleasure < 300:
		text += "[name] still isn't ready for this, and winces with pain from the vaginal stimulation."
	elif pleasure < 1000:
		text += "[name] isn't quite comfortable with the vaginal stimulation but is showing signs of pleasure."
	elif pleasure < 3000:
		text += "[name] makes a lovely moan of pleasure from the vaginal stimulation."
	elif pleasure < 6000:
		text += "[name] rocks %HIS_HER(LOCAL:1)% hips with desire for more vaginal stimulation."
	elif pleasure < 10000:
		text += "[name] cries out in pleasure from the vagina stimulation, and shakes [his] hips for more."
	else:
		text += "[name] trembles and moans, completely overwhelmed by the vaginal stimulation."

	
	return text

