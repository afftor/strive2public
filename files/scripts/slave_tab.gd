
extends TabContainer

var slave
var desc = load('res://files/scripts/description.gd')
var tab
var jobdict = globals.jobs.jobdict

func _ready():
	set_process_input(true)
	for i in get_tree().get_nodes_in_group('slaverules'):
		i.connect("pressed", self, 'rulecheck', [i])

func _input(event):
	if get_tree().get_current_scene().get_node("screenchange/AnimationPlayer").is_playing() == true && get_tree().get_current_scene().get_node("screenchange/AnimationPlayer").get_current_animation() == "fadetoblack" || get_node("customization/clothes&relatives&customs/nicknamepanel").is_visible() || get_node("inspect/portait/Panel").is_visible():
		return
	if event.type == 1:
		var dict = {49 : 1, 50 : 2, 51 : 3, 52 : 4,53 : 5,54 : 6,55 : 7,56 : 8,}
		if event.scancode in [KEY_1,KEY_2,KEY_3,KEY_4,KEY_5]:
			var key = dict[event.scancode]
			if event.is_action_pressed(str(key)) == true && self.is_visible() == true && get_tree().get_current_scene().get_node("dialogue").is_hidden() == true:
				set_current_tab(key-1)


func _on_slave_tab_visibility_changed():
	var label
	var text = ""
	var namelabel = get_tree().get_current_scene().get_node("MainScreen/namelabel")
	if is_hidden() == true:
		namelabel.set_hidden(true)
		return
	slave = globals.slaves[get_tree().get_current_scene().currentslave]
	if slave.sleep == 'jail':
		tab = 'prison'
		get_tree().get_current_scene().background_set('jail')
	else:
		tab = null
		get_tree().get_current_scene().background_set('mansion')
	if OS.get_name() != "HTML5" && globals.rules.fadinganimation == true:
		yield(get_tree().get_current_scene(), 'animfinished')
	
	namelabel.set_hidden(false)
	globals.currentslave = slave
	get_node("stats/statspanel").slave = slave
	get_node("actions").slave = slave
	get_node("stats/statspanel").mode = 'full'
	get_node("stats/statspanel").show()
	namelabel.set_text(slave.name_short())
	var file = File.new()
	setdescriptpos()
	var text = slave.description_full()
	get_node("inspect/slavedescript").set_bbcode(text)
	text = desc.getSlaveStatus(slave)
	get_node("inspect/statustext").set_bbcode(text)
	find_node('origins').set_text(slave.origins.capitalize())
	for i in get_node("stats/traits/traitlist").get_children():
		if i != get_node("stats/traits/traitlist/Label"):
			i.free()
	for i in slave.traits.values():
		label = get_node("stats/traits/traitlist/Label").duplicate()
		get_node("stats/traits/traitlist").add_child(label)
		label.set_hidden(false)
		label.set_text(i.name)
		label.connect("mouse_enter", self, 'traittooltip', [i])
		label.connect("mouse_exit", self, 'traittooltiphide')
	for i in get_node("stats/abilities/abilitylist").get_children():
		if i != get_node("stats/abilities/abilitylist/Label"):
			i.set_hidden(true)
			i.free()
	for i in slave.ability:
		var abil = globals.abilities.abilitydict[i]
		if !abil.learnable:
			continue
		label = get_node("stats/abilities/abilitylist/Label").duplicate()
		get_node("stats/abilities/abilitylist").add_child(label)
		label.set_hidden(false)
		label.set_text(abil.name)
		label.connect("mouse_enter", self, 'abilitytooltip', [abil])
		label.connect("mouse_exit", self, 'traittooltiphide')
	get_node("stats/abilinfo").set_bbcode(text)
	for i in get_node("customization/rules").get_children():
		if i.is_in_group('advrules'):
			if slave.brand == 'advanced':
				i.set_hidden(false)
			else:
				i.set_hidden(true)
	makeselectbuttons()
	regulationdescription()
	for i in get_tree().get_nodes_in_group("slaverules"):
		if slave.rules.has(i.get_name()):
			i.set_pressed(slave.rules[i.get_name()])
	get_node("stats/workbutton").set_text(jobdict[slave.work].name)
	get_node("customization/clothes&relatives&customs/brandbutton/").set_text(slave.brand.capitalize())
	if globals.state.branding == 0:
		find_node('brandbutton').set_disabled(true)
	else:
		find_node('brandbutton').set_disabled(false)
	text = "Health : " + str(round(slave.health)) + '/' + str(round(slave.stats.health_max)) + '\nEnergy : ' + str(round(slave.energy)) + '/' + str(round(slave.stats.energy_max)) + '\nLevel : '+str(slave.level) + '\nExp : '+str(round(slave.xp))+'\nSkillpoints : '+str(slave.skillpoints)
	get_node("stats/levelinfo").set_bbcode(text)
	if slave.spec == null:
		get_node("stats/spec").set_text("None")
	else:
		get_node("stats/spec").set_text(globals.jobs.specs[slave.spec].name)
	for i in get_tree().get_nodes_in_group('prisondisable'):
		if tab == 'prison':
			i.set_hidden(true)
		else:
			i.set_hidden(false)
	get_node("customization/hairstyle").set_text(slave.hairstyle)
	if tab == 'prison':
		return
	if globals.state.mansionupgrades.mansionparlor >= 1:
		get_node("customization/tattoo").set_disabled(false)
		get_node("customization/piercing").set_disabled(false)
		get_node("customization/tattoo").set_tooltip("")
		get_node("customization/piercing").set_tooltip("")
	else:
		get_node("customization/tattoo").set_disabled(true)
		get_node("customization/piercing").set_disabled(true)
		get_node("customization/tattoo").set_tooltip("Unlock Beauty Parlor to access Tattoo options. ")
		get_node("customization/piercing").set_tooltip("Unlock Beauty Parlor to access Piercing options. ")
	if globals.state.tutorial.slave == false:
		globals.state.tutorial.slave = true
		get_tree().get_current_scene().get_node("tutorialnode").slaveinitiate()


func traittooltip(trait):
	globals.showtooltip(slave.dictionary(trait.description))

func abilitytooltip(ability):
	globals.showtooltip(ability.description)

func traittooltiphide():
	globals.hidetooltip()

func _on_childhood_mouse_exit():
	globals.hidetooltip()


func joblist():
	get_tree().get_current_scene().get_node("joblist").joblist()

func _on_statistics_pressed():
	buildmetrics()

func _on_statsclose_pressed():
	get_node("stats/statistics/Popup").set_hidden(true)

func buildmetrics():
	var text = ""
	get_node("stats/statistics/Popup").popup()
	text += "[center]Personal achievments[/center]\n"
	text += "In your possession: " + str(slave.metrics.ownership) + " day"+globals.fastif(slave.metrics.ownership == 1, '','s')+";\n"
	text += "Spent in jail: " + str(slave.metrics.jail) + " day"+globals.fastif(slave.metrics.jail == 1, '','s')+";\n"
	text += "Worked in brothel: " + str(slave.metrics.brothel) + " day"+globals.fastif(slave.metrics.brothel == 1, '','s')+";\n"
	text += "Won battles: " + str(slave.metrics.win) + " time"+globals.fastif(slave.metrics.win == 1, '','s')+";\n"
	text += "Captured enemies: " + str(slave.metrics.capture) + " enem"+globals.fastif(slave.metrics.capture == 1, 'y','ies')+";\n"
	text += "Earned gold: " + str(slave.metrics.goldearn) + " piece"+globals.fastif(slave.metrics.goldearn == 1, '','s')+";\n"
	text += "Earned food: " + str(slave.metrics.foodearn) + " unit"+globals.fastif(slave.metrics.foodearn == 1, '','s')+";\n"
	text += "Produced mana: " + str(slave.metrics.manaearn) + " mana;\n"
	text += "Used items: " + str(slave.metrics.item) + " time"+globals.fastif(slave.metrics.item == 1, '','s')+";\n"
	text += "Affected by spells: " + str(slave.metrics.spell) + " time"+globals.fastif(slave.metrics.spell == 1, '','s')+";\n"
	text += "Modified in lab: " + str(slave.metrics.mods) + " time"+globals.fastif(slave.metrics.mods == 1, '','s')+";\n"
	get_node("stats/statistics/Popup/statstext").set_bbcode(text)
	text = "[center]Sexual achievments[/center]\n"
	text += "Had intimacy: " + str(slave.metrics.sex) + " time"+globals.fastif(slave.metrics.sex == 1, '','s')+";\n"
	text += "Which ended in orgasm: " + str(slave.metrics.orgasm) + " time"+globals.fastif(slave.metrics.orgasm == 1, '','s')+";\n"
	if slave.pussy.has == true:
		text += "Vaginal penetrations: " + str(slave.metrics.vag)+";\n"
	text += "Anal penetrations: " + str(slave.metrics.anal)+";\n"
	text += "Gave oral: " + str(slave.metrics.oral) + " time"+globals.fastif(slave.metrics.oral == 1, '','s')+";\n"
	text += "Was forced: " + str(slave.metrics.roughsex) + " time"+globals.fastif(slave.metrics.roughsex == 1, '','s')+";\n"
	text += slave.dictionary("Of those $he liked: ") + str(slave.metrics.roughsexlike) + " time"+globals.fastif(slave.metrics.roughsexlike == 1, '','s')+";\n"
	text += "Had partners: " + str(slave.metrics.partners.size() + slave.metrics.randompartners) + " partner"+globals.fastif(slave.metrics.partners.size() == 1, '','s')+";\n"
	if slave.preg.has_womb == true:
		text += "Was pregnant: " + str(slave.metrics.preg) + " time"+globals.fastif(slave.metrics.preg == 1, '','s')+";\n"
		text += "Gave birth: " + str(slave.metrics.birth) + " time"+globals.fastif(slave.metrics.birth == 1, '','s')+";\n"
	text += "Participated in threesomes: " + str(slave.metrics.threesome) + " time"+globals.fastif(slave.metrics.threesome == 1, '','s')+";\n"
	text += "Participated in orgies: " + str(slave.metrics.orgy) + " time"+globals.fastif(slave.metrics.orgy == 1, '','s')+";\n"
	get_node("stats/statistics/Popup/statssextext").set_bbcode(text)

func setdescriptpos():
	if slave.imageportait != null:
		if File.new().file_exists(slave.imageportait) == true:
			get_node("inspect/portait").set_texture(load(slave.imageportait))
			get_node("inspect/portaitpanel").set_hidden(false)
			get_node("inspect/AnimationPlayer").play("descriptportait")
		else:
			slave.imageportait = null
			get_node("inspect/portait").set_texture(null)
			get_node("inspect/portaitpanel").set_hidden(true)
			get_node("inspect/AnimationPlayer").play("descriptfull")
	else:
		get_node("inspect/portait").set_texture(null)
		get_node("inspect/portaitpanel").set_hidden(true)
		get_node("inspect/AnimationPlayer").play("descriptfull")

func rulecheck(button):
	slave.rules[button.get_name()] = button.is_pressed()





onready var descripttext = get_node("inspect/slavedescript")
onready var mouseoverdescript = false





func makeselectbuttons():
	sleeprooms()
	#clothlist()
	#underwearlist()
	if slave.work == 'companion':
		get_node("stats/workbutton").set_text('Companion')
	elif slave.work == 'jailer':
		get_node("stats/workbutton").set_text('Jailer')
	elif slave.work == 'headgirl':
		get_node("stats/workbutton").set_text('Headgirl')
	elif slave.work == 'farmmanager':
		get_node("stats/workbutton").set_text('Farm Manager')
	elif slave.work == 'labassist':
		get_node("stats/workbutton").set_text('Lab Assistant')
	


func _on_childhood_mouse_enter():
	var slave = globals.slaves[get_tree().get_current_scene().currentslave]
	var text = ''
	for i in globals.originsarray:
		if i == slave.origins:
			text += '[color=green] ' + i.capitalize() + '[/color]'
		else:
			text += i.capitalize()
		if i != 'noble':
			text += ' - '
	text += '\n\n' + globals.dictionary.getOriginDescription(slave)
	descripttext.set_as_toplevel(false)
	globals.showtooltip(text)



func _on_courfield_mouse_enter():
	find_node('courval').set_hidden(false)
	globals.showtooltip(globals.statsdescript.cour)

func _on_courfield_mouse_exit():
	find_node('courval').set_hidden(true)
	globals.hidetooltip()

func _on_conffield_mouse_enter():
	find_node('confval').set_hidden(false)
	globals.showtooltip(globals.statsdescript.conf)


func _on_conffield_mouse_exit():
	find_node('confval').set_hidden(true)
	globals.hidetooltip()

func _on_witfield_mouse_enter():
	find_node('witval').set_hidden(false)
	globals.showtooltip(globals.statsdescript.wit)

func _on_witfield_mouse_exit():
	find_node('witval').set_hidden(true)
	globals.hidetooltip()

func _on_charmfield_mouse_enter():
	find_node('charmval').set_hidden(false)
	globals.showtooltip(globals.statsdescript.charm)

func _on_charmfield_mouse_exit():
	find_node('charmval').set_hidden(true)
	globals.hidetooltip()




##############Regulation screen



func regulationdescription():
	var cloth = globals.clothes
	var underwear = globals.underwear
	var text
	if !jobdict.has(slave.work):
		slave.work = 'rest'
	text = slave.dictionary(jobdict[slave.work].workline + '\n')
	if slave.brand == 'none':
		text = text + '[color=red]Currently, $he is not branded. [/color]\n'
	elif slave.brand == 'basic':
		text = text + 'On $his neck you can recognize the magic [color=green]brand[/color] you left on $him.\n'
	elif slave.brand == 'advanced':
		text = text + 'On $his neck you can spot the complex symbol of your [color=green]refined brand[/color].\n'
	if slave.gear.costume != null && slave.gear.costume != 'clothcommon':
		text += "$He wears [color=green]" + globals.state.unstackables[slave.gear.costume].name + '[/color]'
		if slave.gear.armor != null:
			text += " with [color=green]" + globals.state.unstackables[slave.gear.armor].name + "[/color] on top of it.\n"
		else:
			text += ".\n"
	elif slave.gear.costume == null && slave.gear.armor != null:
		text += "$He wears only suit of [color=green]" + globals.state.unstackables[slave.gear.armor].name + "[/color] without any additional clothing under it. \n"
	elif slave.gear.costume == null:
		text += "$He [color=yellow]does not wear any upper clothing[/color] while at mansion.\n"
	if slave.gear.underwear != null && slave.gear.underwear != 'underwearplain':
		text += " " 
	#text = text + "$He wears [color=green]" + slave.gear.costume + '[/color] and [color=green]' + slave.gear.underwear + '[/color] on beneath.\n'
	if slave.sleep == 'communal':
		text = text + 'At the night $he will be sleeping with others at [color=yellow]communal room[/color].\n'
	elif slave.sleep == 'personal':
		text = text + 'At the night $he will be resting at [color=green]personal room[/color].\n'
	elif slave.sleep == 'your':
		text = text + 'At the night $he will be warming [color=purple]your bed[/color].\n'
	return find_node('regulationdescript').set_bbcode(slave.dictionary(text))

func _on_SelectButtonSleep_button_selected( value ):
	var oldsleep = slave.sleep
	slave.sleep = value
	if slave.sleep == 'jail':
		get_tree().get_current_scene()._on_jailbutton_pressed()
		get_parent().get_parent().rebuild_slave_list()
		return
	if oldsleep == 'jail':
		if globals.state.playergroup.find(slave.id):
			globals.state.playergroup.erase(slave.id)
		if slave.work == 'jailer':
			globals.state.jailer = -1
		elif slave.work == 'labassist':
			globals.state.labassist = -1
		elif slave.work == 'farmmanager':
			globals.state.farmmanager = -1
		slave.work = 'rest'
		get_tree().get_current_scene()._on_mansion_pressed()
		get_tree().get_current_scene().rebuild_slave_list()
	regulationdescription()


func _on_SelectButtonClothes_button_selected( value ):
	slave.gear.clothes = globals.clothes[value]
	regulationdescription()


func _on_SelectButtonUnderwear_button_selected( value ):
	slave.gear.underwear = globals.underwear[value]
	regulationdescription()




###########Brand popup window

func _on_brandbutton_pressed():
	var confirm = get_node("customization/clothes&relatives&customs/brandbutton/brandpopup/confirm")
	confirm.set_hidden(true)
	find_node('brandingtext').set_hidden(true)
	find_node('enhbrandingtext').set_hidden(true)
	find_node('brandremovetext').set_hidden(true)
	find_node('remove').set_hidden(true)
	get_node("customization/clothes&relatives&customs/brandbutton/brandpopup").popup()
	if slave.brand == 'basic' || slave.brand == 'advanced':
		find_node('brandremovetext').set_hidden(false)
		if globals.resources.mana >= 5:
			find_node('remove').set_hidden(false)
	if slave.brand == 'none' && globals.state.branding >= 1:
		find_node('brandingtext').set_hidden(false)
		if globals.resources.mana >= 10 && globals.player.energy >= 20:
			confirm.set_hidden(false)
			confirm.set_meta('value', 1)
		else:
			confirm.set_hidden(true)
	elif slave.brand == 'basic' && globals.state.branding == 2:
		find_node('enhbrandingtext').set_hidden(false)
		if globals.resources.mana >= 15:
			confirm.set_hidden(false)
			confirm.set_meta('value', 2)

func _on_cancel_pressed():
	find_node('brandpopup').set_hidden(true)


func _on_confirm_pressed():
	var confirm = find_node('confirm')
	var popup = find_node('brandpopup')
	popup.set_hidden(true)
	if confirm.get_meta('value') == 1:
		slave.brand = 'basic'
		slave.stress = 15 + slave.conf/5 - slave.loyal/10
		get_tree().get_current_scene().popup(slave.dictionary('You perform a Ritual of Branding on $name. As symbols are engraved onto $his neck, $he yelps in pain. \n\nWith this you put serious claim on $his future life: $He will be unable to raise a hand against you and will be far less tempted to escape. '))
		globals.resources.mana -= 10
		globals.player.energy = -20
	elif confirm.get_meta('value') == 2:
		slave.brand = 'advanced'
		globals.player.energy = -20
		globals.resources.mana -= 15
	_on_slave_tab_visibility_changed()


func _on_remove_pressed():
	find_node('brandpopup').set_hidden(true)
	slave.brand = 'none'
	globals.resources.mana -= 5
	_on_slave_tab_visibility_changed()


##############Sleep

func sleeprooms():
	var beds = globals.count_sleepers()
	var yourbed = find_node('bedcount')
	var sleepoptions = find_node('SelectButtonSleep')
	var dict = {}
	var count = 0
	var array = []
	#communal room button
	dict[count] = {}
	dict[count].name = 'Communal Room'
	dict[count].tooltip = slave.dictionary('$name will be sleeping with the others')
	if slave.sleep == 'communal':
		dict[count].state = 'selected'
	else:
		dict[count].state = 'enabled'
	dict[count].effect = 'communal'
	dict[count].bigtooltip = "[color=aqua]Communal room[/color] is shared by all servants, not terrible, but hardly appealing. If communal room is overcrowded, it will make residents unhappy. "
	array.append(dict[count])
	count += 1
	#personal
	dict[count] = {}
	dict[count].name = 'Personal Room'
	dict[count].tooltip = slave.dictionary('$name will have personal room')
	if slave.sleep == 'personal':globals.state.mansionupgrades.mansionbed
		dict[count].state = 'selected'
	elif beds.personal >= globals.state.mansionupgrades.mansionpersonal:
		dict[count].state =  'disabled'
		dict[count].tooltip = 'You have no more available personal rooms'
	else:
		dict[count].state = 'enabled'
	dict[count].effect = 'personal'
	dict[count].bigtooltip = "[color=aqua]Personal rooms[/color] are fairly modest, but provide some private time and help with the rest."
	array.append(dict[count])
	count += 1
#your
	dict[count] = {}
	dict[count].name = 'Your Bed'
	dict[count].tooltip = slave.dictionary('$name will be sleeping with you')
	if slave.sleep == 'your':
		dict[count].state = "selected"
	elif beds.your_bed == globals.state.mansionupgrades.mansionbed:
		dict[count].state = "disabled"
	elif slave.loyal + slave.obed < 130 || slave.tags.find('nosex') >= 0:
		dict[count].state = "disabled" 
		dict[count].tooltip = slave.dictionary("$name refuses to sleep with you")
	else:
		dict[count].state = "enabled"
	dict[count].effect = "your"
	dict[count].bigtooltip = "Sharing [color=aqua]Your bed[/color] will help loyalty growth but will impose penalty if servant does not like your company."
	array.append(dict[count])
	count += 1
#prison
	dict[count] = {}
	dict[count].name = "Jail"
	dict[count].tooltip = "Servant will be confined in your jail"
	if slave.sleep == 'jail':
		dict[count].state = "selected"
	elif beds.jail >= globals.state.mansionupgrades.jailcapacity:
		dict[count].state = "disabled"
		dict[count].tooltip = "Your jail is full"
	else:
		dict[count].state = "enabled"
	dict[count].effect = 'jail'
	dict[count].bigtooltip = 'Choosing [color=aqua]Jail[/color] will put servant into confinement where they will be isolated from others and unable to escape.'
	dict[count].fontcolor = Color(1, 0, 0, 1)
	array.append(dict[count])
	sleepoptions.create_select_button(array)






######Clothes
func clothlist():
	var cloth = globals.clothes
	var clothoptions = find_node('SelectButtonClothes')
	var dict = {}
	var count = 0
	var array = []
	for i in cloth:
		dict[count] = {}
		dict[count].name = i.name
		dict[count].effect = count
		dict[count].bigtooltip = i.tooltip
		if slave.gear.clothes.code == i.code:
			dict[count].state = 'selected'
		else:
			dict[count].state = 'enabled'
		array.append(dict[count])
		count += 1
	clothoptions.create_select_button(array)

func underwearlist():
	var cloth = globals.underwear
	var clothoptions = find_node('SelectButtonUnderwear')
	var dict = {}
	var count = 0
	var array = []
	for i in cloth:
		dict[count] = {}
		dict[count].name = i.name
		dict[count].effect = count
		dict[count].bigtooltip = i.tooltip
		if slave.gear.underwear.code == i.code:
			dict[count].state = 'selected'
		else:
			dict[count].state = 'enabled'
		array.append(dict[count])
		count += 1
	
	clothoptions.create_select_button(array)



func _on_impregnate_pressed():
	get_tree().get_current_scene().impregnation(slave)

func _on_slavedescript_meta_clicked( meta ):
	get_tree().get_current_scene().showracedescript(slave)



func _on_relativesbutton_pressed():
	get_node("customization/clothes&relatives&customs/relativespanel").popup()
	var mother = slave.relatives.mother
	var father = slave.relatives.father
	var id = slave.id
	var parentslist = get_node("customization/clothes&relatives&customs/relativespanel/parentscontainer/parentscontainer")
	var siblingslist = get_node("customization/clothes&relatives&customs/relativespanel/siblingscontainer/siblingscontainer")
	var childrenlist = get_node("customization/clothes&relatives&customs/relativespanel/childrencontainer/childrencontainer")
	var newlabel
	for i in parentslist.get_children():
		if i != parentslist.get_node('Label'):
			i.set_hidden(true)
			i.queue_free()
	for i in siblingslist.get_children():
		if i != siblingslist.get_node('Label'):
			i.set_hidden(true)
			i.queue_free()
	for i in childrenlist.get_children():
		if i != childrenlist.get_node('Label'):
			i.set_hidden(true)
			i.queue_free()
	############PARENTS
	newlabel = parentslist.get_node("Label").duplicate()
	parentslist.add_child(newlabel)
	newlabel.set_hidden(false)
	if mother == -1:
		newlabel.set_text('Mother - unknown')
	else:
		var found = false
		if globals.player.id == mother:
			found = true
			mother = globals.player
			newlabel.set_text('Mother - You')
		if typeof(mother) == 2 || typeof(mother) == 3:
			for i in globals.slaves:
				if i.id == slave.relatives.mother && i != slave:
					mother = i
					found = true
					newlabel.set_text(i.dictionary('Mother - $name, $race'))
			if found == false:
				newlabel.set_text('Mother - unknown')
	newlabel = parentslist.get_node("Label").duplicate()
	newlabel.set_hidden(false)
	parentslist.add_child(newlabel)
	if father == -1:
		newlabel.set_text('Father - unknown')
	else:
		var found = false
		if globals.player.id == father:
			found = true
			father = globals.player
			newlabel.set_text('Father - You')
		if typeof(father) == 2 || typeof(father) == 3:
			for i in globals.slaves:
				if i.id == slave.relatives.father:
					father = i
					found = true
					newlabel.set_text(i.dictionary('Father - $name, $race'))
			if found == false:
				newlabel.set_text('Father - unknown')
	####### Siblings
	if slave.relatives.mother == globals.player.relatives.mother || slave.relatives.father == globals.player.relatives.father || slave.relatives.mother == globals.player.relatives.father ||slave.relatives.mother == globals.player.relatives.father:
		newlabel = siblingslist.get_node("Label").duplicate()
		newlabel.set_hidden(false)
		siblingslist.add_child(newlabel)
		newlabel.set_text(globals.player.dictionary("You ($name $surname, $sibling)"))
	for i in globals.slaves:
		var found = false
		if i != slave && i.relatives.mother != -1:
			if (i.relatives.mother == slave.relatives.mother|| i.relatives.mother == slave.relatives.father) :
				found = true
		if i != slave && i.relatives.father != -1:
			if (i.relatives.father == slave.relatives.mother || i.relatives.father == slave.relatives.father) :
				found = true
		if found == true:
			newlabel = siblingslist.get_node("Label").duplicate()
			newlabel.set_hidden(false)
			siblingslist.add_child(newlabel)
			newlabel.set_text(i.dictionary("$name - $sibling, $race"))
	#children
	for i in globals.slaves:
		if i.relatives.mother == slave.id || i.relatives.father == slave.id:
			newlabel = childrenlist.get_node("Label").duplicate()
			newlabel.set_hidden(false)
			childrenlist.add_child(newlabel)
			newlabel.set_text(i.dictionary("$name $sex $race"))


func _on_relativesclose_pressed():
	get_node("customization/clothes&relatives&customs/relativespanel").set_hidden(true)

var portaitsbuilt = false
var portraitspath = "user://portraits/"
var portaitsfolder ='file://' + OS.get_data_dir() + '/portraits'

func _on_changeportait_pressed():
	if get_node("inspect/portait/Panel/racelock").is_pressed() == false:
		get_node("inspect/portait/Panel/search").set_hidden(false)
		get_node("inspect/portait/Panel/search").set_text("")
	else:
		get_node("inspect/portait/Panel/search").set_hidden(true)
	get_node("inspect/portait/Panel").popup()
	if portaitsbuilt == false:
		portaitsbuilt = true
		buildportaitlist()


func _on_reloadlist_pressed():
	buildportaitlist()

func buildportaitlist():
	var dir = Directory.new()
	if dir.dir_exists(portraitspath) == false:
		dir.make_dir(portraitspath)
	for i in get_node("inspect/portait/Panel/ScrollContainer/GridContainer").get_children():
		if i != get_node("inspect/portait/Panel/ScrollContainer/GridContainer/Button"):
			i.set_hidden(true)
			i.free()
	for i in globals.dir_contents(portraitspath):
		if i.find('.jpg') < 0 && i.find(".png") < 0:
			continue
		var node = get_node("inspect/portait/Panel/ScrollContainer/GridContainer/Button").duplicate()
		get_node("inspect/portait/Panel/ScrollContainer/GridContainer").add_child(node)
		node.get_node("pic").set_texture(load(portraitspath + i))
		node.connect('pressed', self, 'setportrait', [i])
		node.get_node("Label").set_text(i.replacen('.jpg','').replacen('.png','').replacen('female','F').replacen('male','M'))
		node.set_meta("type", i)
	resort()


func resort():
	var strictsearch = get_node("inspect/portait/Panel/racelock").is_pressed()
	var gender = slave.sex
	var race = slave.race
	var counter = 0
	if gender == 'futanari':
		gender = 'female'
	if race.find('Beastkin') >= 0:
		race = 'beastkin'
	elif race.find('Halfkin') >= 0:
		race = 'halfkin'
	
	
	
	for i in get_node("inspect/portait/Panel/ScrollContainer/GridContainer").get_children():
		i.set_hidden(true)
		if i == get_node("inspect/portait/Panel/ScrollContainer/GridContainer/Button"):
			continue
		if strictsearch == true:
			if i.get_meta('type').findn(race) < 0 || i.get_meta('type').findn(gender) < 0:
				continue 
		if strictsearch == false && get_node("inspect/portait/Panel/search").get_text() != '' && i.get_node("Label").get_text().findn(get_node("inspect/portait/Panel/search").get_text()) < 0:
			continue
		i.set_hidden(false)
		counter += 1
	if counter < 1:
		get_node("inspect/portait/Panel/noimagestext").set_hidden(false)
	else:
		get_node("inspect/portait/Panel/noimagestext").set_hidden(true)

func setportrait(path):
	slave.imageportait = (portraitspath + path)
	get_node("inspect/portait/Panel").set_hidden(true)
	_on_slave_tab_visibility_changed()
	get_tree().get_current_scene().rebuild_slave_list()



func _on_cancelportait_pressed():
	get_node("inspect/portait/Panel").set_hidden(true)


func _on_racelock_pressed():
	_on_changeportait_pressed()
	resort()


func _on_search_text_changed( text ):
	resort()

func _on_removeportrait_pressed():
	slave.imageportait = null
	get_node("inspect/portait/Panel").set_hidden(true)
	_on_slave_tab_visibility_changed()
	get_tree().get_current_scene().rebuild_slave_list()

func _on_reverseportrait_pressed():
	if slave.unique != null:
		if slave.unique == 'Cali':
			slave.imageportait = 'res://files/images/cali/caliportrait.png'
		elif slave.unique == 'Emily':
			slave.imageportait = "res://files/images/emily/emilyportrait.png"
		elif slave.unique == 'Tisha':
			slave.imageportait = "res://files/images/tisha/tishaportrait.png"
		elif slave.unique == 'Chloe':
			slave.imageportait = "res://files/images/chloe/chloeportrait.png"
		elif slave.unique == 'Yris':
			slave.imageportait = "res://files/images/yris/yrisportrait.png"
		elif slave.unique == 'Maple':
			slave.imageportait = "res://files/images/maple/mapleportrait.png"
		get_node("inspect/portait/Panel").set_hidden(true)
		_on_slave_tab_visibility_changed()
		get_tree().get_current_scene().rebuild_slave_list()



func _on_addcustom_pressed():
	get_node("inspect/portait/Panel/FileDialog").popup()

func _on_FileDialog_file_selected( path ):
	var dir = Directory.new()
	var path2 = path.substr(path.find_last('/'), path.length()-path.find_last('/'))
	dir.copy(path, portraitspath + path2)
	buildportaitlist()


func _on_openfolder_pressed():
	OS.shell_open(portaitsfolder)


func _on_nickname_pressed():
	get_node("customization/clothes&relatives&customs/nicknamepanel").popup()

func _on_nickaccept_pressed():
	get_node("customization/clothes&relatives&customs/nicknamepanel").set_hidden(true)
	slave.nickname = get_node("customization/clothes&relatives&customs/nicknamepanel/nickline").get_text()
	get_tree().get_current_scene().rebuild_slave_list()
	_on_slave_tab_visibility_changed()




func _on_description_pressed():
	get_node("customization/clothes&relatives&customs/descriptpopup").popup()
	get_node("customization/clothes&relatives&customs/descriptpopup/TextEdit").set_text(slave.customdesc)


func _on_confirmdescript_pressed():
	slave.customdesc = get_node("customization/clothes&relatives&customs/descriptpopup/TextEdit").get_text()
	get_node("customization/clothes&relatives&customs/descriptpopup").set_hidden(true)
	_on_slave_tab_visibility_changed()


func _on_gear_pressed():
	get_tree().get_current_scene().get_node("paperdoll").slave = slave
	get_tree().get_current_scene().get_node("paperdoll").showup()


func _on_spec_mouse_enter():
	var text 
	if slave.spec == null:
		text = "Specialization can provide special abilities and effects and can be trained at Slave's Guild. "
	else:
		var spec = globals.jobs.specs[slave.spec]
		text = "[center]" + spec.name + '[/center]\n'+ spec.descript + "\n[color=aqua]" +  spec.descriptbonus + '[/color]'
	globals.showtooltip(text)



func _on_spec_mouse_exit():
	globals.hidetooltip()


