
extends Node


var slavenew = {race = 'Human', sex = 'male', age = 'teen'}
var slavetemp = globals.slave.new()


func _on_NewGamePanel_draw():
	globals.dicttoclass(slavetemp, slavenew)
	get_node("PlayerGender").clear()
	get_node("PlayerGender").add_item('male')
	if (globals.rules['futa'] == true):
		get_node("PlayerGender").add_item('futanari')
	get_node("PlayerGender").add_item('female')
	get_node("PCNameLine").set_text('John')
	get_node("PCSurnameLine").set_text('Smith')
	get_node("PlayerRace").clear()
	get_node("PlayerRace/PlayerRaceInfo").set_bbcode(globals.dictionary.getRaceDescription(slavetemp['race']))
	for i in globals.starting_pc_races:
		if ((i.find('Beastkin') >= 0 && globals.rules['furry'] == true) || i.find('Beastkin') < 0):
			get_node("PlayerRace").add_item(i)
			if i == slavetemp['race']:
				get_node("PlayerRace").select(get_node("PlayerRace").get_item_count()-1)
	get_node("PlayerAge").add_item('Young') 
	get_node("PlayerAge").add_item('Middle-aged') 


func _on_PlayerAge_item_selected( ID ):
	if (ID == 0):
		slavetemp['age'] = 'teen'
	elif (ID == 1):
		slavetemp['age'] = 'adult'


func _on_PlayerConfirmButton_pressed():
	slavetemp = globals.slavegen.newslave(slavetemp['race'], slavetemp['age'], slavetemp['sex'])
	var text1 = get_tree().get_nodes_in_group('PCCustoms')
	for i in text1:
		i.clear()
	get_node("PlayerCustomizations").show()
	get_node("PlayerCustomizations/PCHairColor").set_text(slavetemp['haircolor'])
	get_node("PlayerCustomizations/PCEyeColor").set_text(slavetemp['eyecolor'])
	var text = ['short', 'average', 'tall', 'towering'] ### height array
	for i in text:
		get_node("PlayerCustomizations/PCHeight").add_item(i)
		if i == slavetemp['height']:
			get_node("PlayerCustomizations/PCHeight").select(get_node("PlayerCustomizations/PCHeight").get_item_count()-1)
	if (slavetemp['sex'] == 'male'): ### hairstyle array
		text = ['straight', 'ponytail']
	else:
		text = ['straight', 'ponytail', 'twintails', 'braid', 'twobraids', 'bun']
	for i in text:
		get_node("PlayerCustomizations/PCHairstyle").add_item(i)
		if (i == slavetemp['hairstyle']):
			get_node("PlayerCustomizations/PCHairstyle").select(get_node("PlayerCustomizations/PCHairstyle").get_item_count()-1)
	if (slavetemp['sex'] == 'male'): ### tits
		text = ['flat', 'masculine']
	else:
		text = ['flat', 'small', 'average', 'big', 'huge']
	for i in text:
		get_node("PlayerCustomizations/PCChest").add_item(i)
		if (i == slavetemp['tits']['size']):
			get_node("PlayerCustomizations/PCChest").select(get_node("PlayerCustomizations/PCChest").get_item_count()-1)
	if (slavetemp['sex'] == 'male'): ### rear
		text = ['flat', 'masculine']
	else:
		text = ['flat', 'small', 'average', 'big', 'huge']
	for i in text:
		get_node("PlayerCustomizations/PCButt").add_item(i)
		if (i == slavetemp['ass']):
			get_node("PlayerCustomizations/PCButt").select(get_node("PlayerCustomizations/PCButt").get_item_count()-1)
	if (slavetemp['sex'] == 'female'): ### penis
		text = ['none']
	else:
		text = ['small', 'average', 'big']
	for i in text:
		get_node("PlayerCustomizations/PCPenis").add_item(i)
		if (i == slavetemp['penis']['size']):
			get_node("PlayerCustomizations/PCPenis").select(get_node("PlayerCustomizations/PCPenis").get_item_count()-1)
	if (slavetemp['sex'] == 'male'): ### hair length
		text = ['ear', 'neck']
	else:
		text = ['ear', 'neck', 'shoulder', 'waist', 'ass']
	for i in text:
		get_node("PlayerCustomizations/PCHairLength").add_item(i)
		if (i == slavetemp['hairlength']):
			get_node("PlayerCustomizations/PCHairLength").select(get_node("PlayerCustomizations/PCHairLength").get_item_count()-1)
	if (slavetemp['race'] == 'Orc'): ### SkinColor
		text = ['green']
	elif (slavetemp['race'] == 'Dark Elf'):
		text = ['tan', 'brown', 'dark']
	else:
		text = [ 'pale', 'fair', 'olive', 'tan' ]
	for i in text:
		get_node("PlayerCustomizations/PCSkin").add_item(i)
		if (i == slavetemp['skin']):
			get_node("PlayerCustomizations/PCSkin").select(get_node("PlayerCustomizations/PCSkin").get_item_count()-1)







func _on_PCHairColor_text_changed( text ):
	slavetemp['haircolor'] = text

func _on_PCEyeColor_text_changed( text ):
	slavetemp['eyecolor'] = text


func _on_PlayerGender_item_selected( ID ):
	slavetemp['sex'] = get_node("PlayerGender").get_item_text( ID )

func _on_PCChest_item_selected( ID ):
	slavetemp['tits']['size'] = get_node("PlayerCustomizations/PCChest").get_item_text( ID )

func _on_PCButt_item_selected( ID ):
	slavetemp['ass'] = get_node("PlayerCustomizations/PCButt").get_item_text( ID )

func _on_PCPenis_item_selected( ID ):
	slavetemp['penis'] = get_node("PlayerCustomizations/PCPenis").get_item_text( ID )

func _on_PCHairLength_item_selected( ID ):
	slavetemp['hairlength'] = get_node("PlayerCustomizations/PCHairLength").get_item_text( ID )

func _on_PCHairstyle_item_selected( ID ):
	slavetemp['hairstyle'] = get_node("PlayerCustomizations/PCHairstyle").get_item_text( ID )

func _on_PCHeight_item_selected( ID ):
	slavetemp['height'] = get_node("PlayerCustomizations/PCHeight").get_item_text( ID )

func _on_PCSkin_item_selected( ID ):
	slavetemp['skin'] = get_node("PlayerCustomizations/PCSkin").get_item_text( ID )

func _on_PlayerRace_item_selected( ID ):
	slavetemp['race'] = get_node("PlayerRace").get_item_text( ID )
	get_node("PlayerRace/PlayerRaceInfo").set_bbcode(globals.dictionary.getRaceDescription(slavetemp['race']))


func _on_PCNameLine_text_changed( text ):
	slavetemp['name'] = text
	