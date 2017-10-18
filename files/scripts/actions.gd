
extends Node

var slave
var player

func _on_actions_visibility_changed():
	if get_parent().is_hidden() == true:
		return
	var tab = get_parent().tab
	var text
	player = globals.player
	slave = get_parent().slave
	get_node("punishroom/Popup/Panel/punishtext").set_bbcode(slave.dictionary(get_node("punishroom/Popup/Panel/punishtext").get_bbcode()))









#########################










