extends Node

var category = 'fucking'
var code = 'doubledildo'
var givers
var takers
var canlast = true
var givereffects = {lust = 50, sens = 20}
var targeteffects = {lust = 50, sens = 100}
var giverpart = 'vagina'
var takerpart = 'vagina'

func getname(state = null):
	return "Double Dildo"

func getongoingname(givers, takers):
	return "[name1] and [name2] fuck each other with a double-ended dildo."

func getongoingdescription(givers, takers):
	return "[name1] and [name2] shake [their] hips as the dildo trusts in and out of them..."

func requirements():
	var valid = true
	if takers.size() != 1 || givers.size() != 1:
		valid = false
	else:
		for i in givers:
			if i.vagina != null || i.person.vagina == 'none' :
				valid = false
		for i in takers:
			if i.vagina != null || i.person.vagina == 'none' :
				valid = false
	return valid

func givereffect(member):
	var result
	var effects = {lust = 80, sens = 110, lewd = 4}
	if member.consent == true || (member.person.traits.find("Likes it rough") >= 0 && member.lewd >= 50):
		result = 'good'
	elif member.person.traits.find("Likes it rough") >= 0:
		result = 'average'
	else:
		result = 'bad'
	return [result, effects]

func takereffect(member):
	var result
	var effects = {lust = 80, sens = 110, lewd = 4}
	member.lube()
	if member.consent == true || (member.person.traits.find("Likes it rough") >= 0 && member.lewd >= 50):
		result = 'good'
	elif member.person.traits.find("Likes it rough") >= 0:
		result = 'average'
	else:
		result = 'bad'
	return [result, effects]

func initiate():
	var text = ''
	text += "[name1] insert[s/1] the double dildo and shake[s/1] [his1] hips, rougly fucking [himself1] and [name2] with it..."
	return text

