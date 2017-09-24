extends Popup

var slave 
var jobdict = globals.jobs.jobdict

func sortjobs(first,second):
	if first.order < second.order:
		return true
	else:
		return false


func joblist():
	slave = globals.currentslave
	var array = []
	var basic = get_node("jobs/VBoxContainer")
	for i in basic.get_children():
		if i != get_node("jobs/VBoxContainer/Button"):
			i.set_hidden(true)
			i.queue_free()
	get_node("tooltiptext").set_bbcode("")
	popup()
	for i in jobdict.values():
		array.append(i)
	array.sort_custom(self, 'sortjobs')
	for i in array:
		if globals.evaluate(i.unlockreqs) == true:
			var newbutton = get_node("jobs/VBoxContainer/Button").duplicate()
			var locked
			for k in globals.state.portals.values():
				if i.tags.find(k.code) >= 0 && k.enabled == false && globals.state.location != k.code:
					locked = true
			if locked == true:
				continue
			newbutton.set_hidden(false)
			newbutton.set_text(i.name)
			basic.add_child(newbutton)
			if slave.work == i.code:
				basic.move_child(newbutton,0)
			#dict[i.type].add_child(newbutton)
			if slave.work == i.code:
				newbutton.set('custom_colors/font_color', Color(0,1,0,1))
			if globals.evaluate(i.reqs) == false:
				newbutton.set_disabled(true)
				newbutton.set_tooltip(slave.dictionary("$name is not suited for this work"))
			if i.tags.find('sex') >= 0 && i.code != 'fucktoy':
				if !globals.currentslave.bodyshape in ['humanoid', 'bestial', 'shortstack']:
					newbutton.set_disabled(true)
					newbutton.set_tooltip(slave.dictionary("This occupation only allows humanoid slaves. "))
				elif slave.tags.find('nosex') >= 0:
					newbutton.set_disabled(true)
					newbutton.set_tooltip(slave.dictionary("$name refuses to participate in sexual activities at this moment. "))
				elif slave.traits.has("Monogamous") || slave.traits.has("Prude"):
					newbutton.set_disabled(true)
					newbutton.set_tooltip(slave.dictionary("$name refuses to whore $himself."))
			if i.tags.find('social') >= 0:
				if slave.traits.has('Uncivilized') || slave.traits.has('Regressed'):
					newbutton.set_disabled(true)
					newbutton.set_tooltip(slave.dictionary("$name is not suited to work in social circles. "))
			if i.tags.find("management") >= 0:
				if slave.traits.has("Passive"):
					newbutton.set_disabled(true)
					newbutton.set_tooltip(slave.dictionary("$name is not suited for leading roles. "))
					
		
			if i.maxnumber >= 1:
				var counter = 0
				for tempslave in globals.slaves:
					if tempslave.work == i.code:
						counter += 1
				if counter >= i.maxnumber:
					newbutton.set_disabled(true)
					newbutton.set_tooltip("You can't assign anymore people to this occupation")
			newbutton.set_meta("job", i)
			newbutton.connect('pressed', self, 'choosejob', [newbutton])
			newbutton.connect("mouse_enter",self,'jobtooltipshow',[newbutton])
			#newbutton.connect("mouse_exit",self,'jobtooltiphide')

func choosejob(button):
	slave.work = button.get_meta('job').code
	_on_jobcancel_pressed()
	get_tree().get_current_scene().slavepanel._on_slave_tab_visibility_changed()
	if get_tree().get_current_scene().get_node("slavelist").is_visible():
		get_tree().get_current_scene().slavelist()

func jobtooltipshow(button):
	var job = button.get_meta('job')
	var text = '[center]' + job.name + '[/center]\n' + job.description
	if job.location in ['wimborn','gorn','frostford']:
		text += "\n\nWork town: " + job.location.capitalize()
		for i in globals.state.reputation:
			if i == job.location:
				text += "\nAffiliation: " + get_parent().reputationword(globals.state.reputation[i])
	get_node("tooltiptext").set_bbcode(slave.dictionary(text))
	

func _on_jobcancel_pressed():
	set_hidden(true)
