
extends Node

#func _init():
	#globals.effectdict = effectlist


var effectlist = {
captured = {code = 'captured', obed_max = -50, duration = 5},
stimulated = {code = 'stimulated',lust_mod = 50,duration = 1},
numbed = {code = 'numbed',lust_mod = -50,duration = 1},
entranced =  {code = 'entranced', duration = 1},
augmentfur = {code = 'augmentfur', armor_cur = 2, armor_base = 2},
augmentscales = {code = 'augmentscales', armor_cur = 2, armor_base = 2},
augmentstr = {code = 'augmentstr', str_max = 2},
augmentagi = {code = 'augmentagi', agi_max = 2},
}
