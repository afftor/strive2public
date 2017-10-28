extends Node

var newraces = {}
var newbodyparts = {
#partexample = {variablexample = "descriptionexample"}
}

func _ready():
	for i in newbodyparts:
		for k in newbodyparts[i]:
			if globals.description.descriptions.has(i):
				globals.description.descriptions[i][k] = newbodyparts[i][k]
			else:
				print("Invalid piece for description: " + i)
		print(globals.description.descriptions[i])

