
extends HBoxContainer

func slavetabopen():
	var slavetab = get_tree().get_current_scene().get_node("MainScreen/slave_tab")
	get_tree().get_current_scene().get_node("MainScreen/slave_tab/sexual").partner = null
	get_tree().get_current_scene().hide_everything()
	get_tree().get_current_scene().currentslave = int(get_meta('pos'))
	if globals.slaves[get_tree().get_current_scene().currentslave].sleep == 'jail':
		slavetab.tab = 'prison'
		get_tree().get_current_scene().background_set('jail')
	else:
		slavetab.tab = null
		get_tree().get_current_scene().background_set('mansion')
	if OS.get_name() != "HTML5" && globals.rules.fadinganimation == true:
		yield(get_tree().get_current_scene(), 'animfinished')
	slavetab.set_hidden(false)

func _on_inspect_pressed():
	slavetabopen()
	get_tree().get_current_scene().find_node('slave_tab').set_current_tab(1)
	#var slave = globals.slaves[get_tree().get_current_scene().currentslave]
	#slave.add_effect(get_tree().get_current_scene().get_node("itemnode").stimulated, true)
	#print(globals.slaves[int(get_meta('pos'))].effects)

func _on_actions_pressed():
	slavetabopen()
	get_tree().get_current_scene().find_node('slave_tab').set_current_tab(3)


func _on_stats_pressed():
	slavetabopen()
	get_tree().get_current_scene().find_node('slave_tab').set_current_tab(0)

func _on_regulations_pressed():
	slavetabopen()
	get_tree().get_current_scene().find_node('slave_tab').set_current_tab(2)



func _on_cast_spell_pressed():
	slavetabopen()
	if OS.get_name() != "HTML5" && globals.rules.fadinganimation == true:
		yield(get_tree().get_current_scene(), 'animfinished')
	get_tree().get_current_scene().find_node('slave_tab').set_current_tab(4)



func _on_upbutton_pressed():
	var pos = get_meta('pos')
	if pos != 0:
		globals.slaves.insert(pos-1, globals.slaves[pos])
		globals.slaves.remove(pos+1)
		get_tree().get_current_scene().rebuild_slave_list()


func _on_downbutton_pressed():
	var pos = get_meta('pos')
	if pos < globals.slaves.size()-1:
		globals.slaves.insert(pos+2, globals.slaves[pos])
		globals.slaves.remove(pos)
		get_tree().get_current_scene().rebuild_slave_list()

func _on_topbutton_pressed():
	var pos = get_meta('pos')
	if pos != 0:
		globals.slaves.insert(0, globals.slaves[pos])
		globals.slaves.remove(pos+1)
		get_tree().get_current_scene().rebuild_slave_list()

func _on_bottombutton_pressed():
	var pos = get_meta('pos')
	if pos < globals.slaves.size()-1:
		globals.slaves.insert(globals.slaves.size(), globals.slaves[pos])
		globals.slaves.remove(pos)
		get_tree().get_current_scene().rebuild_slave_list()


