extends Node

var category = 'caress'
var code = 'caress'
var givers
var takers
var canlast = false
var givereffects = {lust = 50, sens = 0}
var targeteffects = {lust = 50, sens = 50}
var giverpart = ''
var takerpart = ''

func getname():
	return "Caress"

func getongoingname(givers, takers):
	return "[name1] stroking [name2] bod[%2y]."

func requirements():
	var valid = true
	if takers.size() < 1 || givers.size() < 1:
		valid = false
	return valid



func initiate():
	var text = ''
	text = "[name1] gently stroke[%1s] and caress[%1es] [name2]'s bod[%2y]"
	if givers.size() == 1 && takers.size() == 1:
		text += " while kissing [him2]"
	if takers.size() == 1:
		text = text.replace("bod[%2y]", '[body2]')
	text += '.\n'
	return text

func reaction(member):
	var text = ''
	var pleasure = member.sens
	if member.energy == 0:
		text = "[name] lies unconscious, trembling slightly."
	elif pleasure < 100:
		text = "[name] doesn't feel much pleasure from being caressed."
	elif pleasure < 300:
		text = "[name] starts to tremble from the pleasure of being caressed."
	elif pleasure < 1000:
		text = "[name] shivers from the pleasure of being caressed."
	elif pleasure < 3000:
		text = "[name] is in a clear state of pleasure, and begins panting."
	elif pleasure < 6000:
		text = "[name] feels intense pleasure from being caressed, and wraps [his] arms around partner's neck."
	else:
		text = "[name]'s [body] twists with pleasure as [he] begs for more."
	
	return text
