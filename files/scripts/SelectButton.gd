
extends Node
signal button_selected(value)
var height = 0

func create_select_button(array):
	get_node("Popup").set_hidden(true)
	var contsize = 0
	height = 0
	for i in get_node("Popup/Panel/ScrollContainer/VBoxContainer").get_children():
		i.queue_free()
	for i in array:
		var checkbox = CheckBox.new()
		checkbox.connect('pressed', self, 'checkbox_activate', [checkbox])
		checkbox.add_to_group('selectbuttons')
		checkbox.set_text(i.name)
		if i.state == 'disabled':
			checkbox.set_disabled(true)
		elif i.state == 'selected':
			checkbox.set_pressed(true)
			checkbox.set_disabled(true)
			get_node("Popup").get_parent().set_text(i.name)
		checkbox.set_meta('effect', i.effect)
		if i.has('bigtooltip'):
			checkbox.connect('mouse_enter', self, 'tooltipshow', [checkbox])
			checkbox.connect('mouse_exit', self, 'tooltiphide')
			checkbox.set_meta('tooltip', i.bigtooltip + "\n\n" +  i.tooltip)
		if i.has('fontcolor'):
			checkbox.set('custom_colors/font_color', i.fontcolor)
		get_node("Popup/Panel/ScrollContainer/VBoxContainer").add_child(checkbox)
		height += (checkbox.get_size().y*1.5)
		contsize += 1

func _on_SelectButton_pressed():
	get_node("Popup").popup()
	tooltiphide()
	var pos = get_node("Popup").get_parent().get_global_pos()
	pos.y = pos.y + get_node("Popup").get_parent().get_size().y
	get_node("Popup").set_global_pos(pos)
	var size = Vector2(get_node("Popup/Panel").get_size().x, get_node("Popup/Panel/ScrollContainer/VBoxContainer").get_size().y)
	get_node("Popup").set_size(size)
	if get_node("Popup").get_global_rect().clip(get_tree().get_current_scene().get_node('Navigation').get_global_rect()).size.y > 0:
		size = Vector2 ( size.x, size.y - get_node("Popup").get_global_rect().clip(get_tree().get_current_scene().get_node('Navigation').get_global_rect()).size.y)
		get_node("Popup").set_size(size)

func checkbox_activate(checkbox):
	for i in get_node("Popup/Panel/ScrollContainer/VBoxContainer").get_children():
		if i.is_pressed() == true && i.get_meta('effect') != checkbox.get_meta('effect'):
			i.set_pressed(false)
			i.set_disabled(false)
	checkbox.set_disabled(true)
	get_node("Popup").set_hidden(true)
	get_node("Popup").get_parent().set_text(checkbox.get_text())
	emit_signal('button_selected', checkbox.get_meta('effect'))

func tooltipshow(button):
	globals.showtooltip(button.get_meta('tooltip'))

func tooltiphide():
	globals.hidetooltip()



func _on_Popup_popup_hide():
	globals.hidetooltip()
