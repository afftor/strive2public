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
	return "[name1] rest[s/1] for a bit and wait[s/1]... "
