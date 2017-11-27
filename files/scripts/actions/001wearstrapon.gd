extends Node

var category = 'fucking'
var code = 'strapon'
var givers
var takers
var canlast = false
var givereffects = {lust = 0, sens = 0}
var targeteffects = {lust = 0, sens = 0, pain = 0}
var giverpart = 'strapon'
var takerpart = ''

func getname(state = null):
	return "Wear Strapon"

func getongoingname(givers, takers):
	return "[name1] wears a strapon"

func getongoingdescription(givers, takers):
	return ""

func requirements():
	var valid = true
	if givers.size() < 1:
		valid = false
	for i in givers:
		if i.person.penis != 'none' || i.strapon != null:
			valid = false
	return valid


func initiate():
	if givers.size() < 2:
		return "[name1] put[s/1] on a strap-on dildo. "
	else:
		return "[name1] put[s/1] on strap-on dildos. "
