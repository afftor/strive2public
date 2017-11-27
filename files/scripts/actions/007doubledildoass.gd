extends Node

var category = 'fucking'
var code = 'doubledildoass'
var givers
var takers
var canlast = true
var givereffects = {lust = 50, sens = 20}
var targeteffects = {lust = 50, sens = 100}
var giverpart = 'anus'
var takerpart = 'anus'

func getname(state = null):
	return "Double Anal Dildo"

func getongoingname(givers, takers):
	return "[name1] and [name2] fuck each other's assholes with a double-ended dildo."

func getongoingdescription(givers, takers):
	return "[name1] and [name2] shake [their] hips as the dildo trusts in and out of [their] {^assholes:asses:butts}..."

func requirements():
	var valid = true
	if takers.size() != 1 || givers.size() != 1:
		valid = false
	return valid

func givereffect(member):
	var result
	var effects = {lust = 85, sens = 100, lewd = 4}
	if member.consent == true || (member.person.traits.find("Likes it rough") >= 0 && member.lewd >= 50) && member.lube >= 5:
		result = 'good'
	elif member.person.traits.find("Likes it rough") >= 0:
		result = 'average'
	else:
		result = 'bad'
	return [result, effects]

func takereffect(member):
	var result
	var effects = {lust = 85, sens = 100, lewd = 4}
	member.lube()
	if member.consent == true || (member.person.traits.find("Likes it rough") >= 0 && member.lewd >= 50) && member.lube >= 5:
		result = 'good'
	elif member.person.traits.find("Likes it rough") >= 0:
		result = 'average'
	else:
		result = 'bad'
	return [result, effects]

func initiate():
	var text = ''
	text += "[name1] insert[s/1] the double dildo up [his1] [ass1] and pushes it against [names2] [ass2], penetrating it..."
	return text

