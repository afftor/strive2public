extends Node

var category = 'other'
var code = 'wait'
var givers
var takers
var canlast = false
var givereffects = {lust = 0, sens = 0}
var targeteffects = {lust = 0, sens = 0, pain = 0}
var giverpart = ''
var takerpart = ''

func getname(state = null):
	return "Wait"

func getongoingname(givers, takers):
	return ""

func getongoingdescription(givers, takers):
	return ""

func requirements():
	var valid = true
	if givers.size() < 1:
		valid = false
	return valid



func initiate():
	var text = ''
	text += "[name1] rest[%1s] and observe[%1s] others... "

	return text



