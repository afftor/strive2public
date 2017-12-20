extends Node

const category = 'other'
const code = 'wait'
var givers
var takers
const canlast = false
const givereffects = {lust = 0, sens = 0}
const targeteffects = {lust = 0, sens = 0, pain = 0}
const giverpart = ''
const takerpart = ''
const virginloss = false
const giverconsent = 'any'
const takerconsent = 'any'


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
