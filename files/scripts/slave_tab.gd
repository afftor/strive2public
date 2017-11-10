
extends TabContainer

var slave
var tab
var jobdict = globals.jobs.jobdict

func _ready():
	for i in get_node("customization/tattoopanel/VBoxContainer").get_children():
		i.connect('pressed',self,'choosetattooarea',[i])
	set_process_input(true)
	for i in get_tree().get_nodes_in_group('slaverules'):
		i.connect("pressed", self, 'rulecheck', [i])

func _input(event):
	if get_tree().get_current_scene().get_node("screenchange/AnimationPlayer").is_playing() == true && get_tree().get_current_scene().get_node("screenchange/AnimationPlayer").get_current_animation() == "fadetoblack" || get_node("customization/clothes&relatives&customs/nicknamepanel").is_visible() :
		return
	if event.type == 1:
		var dict = {49 : 1, 50 : 2, 51 : 3, 52 : 4,53 : 5,54 : 6,55 : 7,56 : 8,}
		if event.scancode in [KEY_1,KEY_2,KEY_3,KEY_4]:
			var key = dict[event.scancode]
			if event.is_action_pressed(str(key)) == true && self.is_visible() == true && get_tree().get_current_scene().get_node("dialogue").is_hidden() == true:
				set_current_tab(key-1)

onready var nakedspritesdict = get_node("sexual").nakedspritesdict

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
	get_node("stats/statspanel").mode = 'full'
	get_node("stats/statspanel").show()
	namelabel.set_text(slave.name_short())
	var file = File.new()
	setdescriptpos()
	text = slave.description()
	get_node("inspect/slavedescript").set_bbcode(text)
	text = slave.status()
	get_node("inspect/statustext").set_bbcode(text)
	get_node("inspect/Panel 2/fullbody").set_texture(null)
	if nakedspritesdict.has(slave.unique):
		if slave.obed >= 50 || slave.stress < 10:
			get_node("inspect/Panel 2/fullbody").set_texture(globals.spritedict[nakedspritesdict[slave.unique].clothcons])
		else:
			get_node("inspect/Panel 2/fullbody").set_texture(globals.spritedict[nakedspritesdict[slave.unique].clothrape])
	elif slave.imagefull != null && File.new().file_exists(slave.imagefull) == true:
		get_node("inspect/Panel 2/fullbody").set_texture(load(slave.imagefull))
	if get_node("inspect/Panel 2/fullbody").get_texture() == null:
		get_node("inspect/Panel 2").set_hidden(true)
	get_node("stats/origins").set_text(slave.origins.capitalize())
	for i in get_node("stats/traits/traitlist").get_children():
		if i != get_node("stats/traits/traitlist/Label"):
			i.free()
	for i in slave.get_traits():
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
	if slave.imageportait != null || slave.imagefull != null:
		if slave.imageportait != null && File.new().file_exists(slave.imageportait) == true:
			get_node("inspect/portait").set_texture(load(slave.imageportait))
			get_node("inspect/portait").set_hidden(false)
			get_node("inspect/portaitpanel").set_hidden(false)
			get_node("inspect/AnimationPlayer").play("descriptportait")
		elif slave.imagefull != null && File.new().file_exists(slave.imagefull) == true:
			get_node("inspect/portait").set_texture(load(slave.imagefull))
			get_node("inspect/portait").set_hidden(false)
			get_node("inspect/portaitpanel").set_hidden(false)
			get_node("inspect/AnimationPlayer").play("descriptportait")
		else:
			slave.imageportait = null
			slave.imagefull = null
			get_node("inspect/portait").set_texture(null)
			get_node("inspect/portait").set_hidden(true)
			get_node("inspect/portaitpanel").set_hidden(true)
			get_node("inspect/AnimationPlayer").play("descriptfull")
	else:
		get_node("inspect/portait").set_texture(null)
		get_node("inspect/portait").set_hidden(true)
		get_node("inspect/portaitpanel").set_hidden(true)
		get_node("inspect/AnimationPlayer").play("descriptfull")

func rulecheck(button):
	slave.rules[button.get_name()] = button.is_pressed()





onready var descripttext = get_node("inspect/slavedescript")
onready var mouseoverdescript = false





func makeselectbuttons():
	sleeprooms()
	if slave.work == 'jailer':
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
	#var cloth = globals.clothes
	#var underwear = globals.underwear
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
		globals.player.energy -= 20
	elif confirm.get_meta('value') == 2:
		slave.brand = 'advanced'
		globals.player.energy -= 20
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
	globals.impregnation(slave)

func _on_slavedescript_meta_clicked( meta ):
	if meta == 'race':
		get_tree().get_current_scene().showracedescript(slave)
	elif globals.state.descriptsettings.has(meta):
		globals.state.descriptsettings[meta] = !globals.state.descriptsettings[meta]
	_on_slave_tab_visibility_changed()


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

#Tattoos

var tattoosdescript = { #this goes like : start + tattoo theme + end + tattoo description: I.e On $his face you see a notable nature themed tattoo, depicting flowers and vines
face = {start = "On $his cheek you see a notable ", end = " themed tattoo, depicting"},
chest = {start = "$His chest is decorated with a", end = " tattoo, portraying"},
waist = {start = "On lower part of $his back, you spot a ", end = " tattooed image of "},
arms = {start = "$His arm has a skillfully created ", end = " image of "},
legs = {start = "$His ankle holds a piece of ", end = " art, representing"},
ass = {start = "$His butt has a large ", end = " themed image showing "},
}

var tattoooptions = {
none = {name = 'none', descript = "", applydescript = "Select a theme for future tattoo"},
nature = {name = 'nature', descript = " flowers and vines", function = "naturetattoo", applydescript = "Nature thematic tattoo will increase $name's beauty. "},
tribal = {name = 'tribal',descript = " totemic markings and symbols", function = "tribaltattoo", applydescript = "Tribal thematic tattoo will increase $name's scouting performance. "},
degrading = {name = 'derogatory', descript = " rude words and lewd drawings", function = "degradingtattoo",  applydescript = "Derogatory tattoo will promote $name's lust and enforce obedience. "},
animalistic = {name = 'beastly', descript = " realistic beasts and insects", function = "animaltattoo", applydescript = "Animalistic tattoo will boost $name's energy regeneration. "},
magic = {name = "energy", descript = " empowering patterns and runes", function = "manatattoo", applydescript = "Magic tattoo will increase $name's Magic Affinity. "},
}

var tattoolevels = {
nature = {
1 : {bonusdescript = "+5 Beauty", effect = 'nature1'},
2 : {bonusdescript = "+10 Beauty", effect = 'nature2'},
3 : {bonusdescript = "+15 Beauty", effect = 'nature3'},
highest = "+15 Beauty",
},
tribal = {
1 : {bonusdescript = "+3 Awareness", effect = 'tribal1'},
2 : {bonusdescript = "+6 Awareness", effect = 'tribal2'},
3 : {bonusdescript = "+9 Awareness", effect = 'tribal3'},
highest = "+9 Awareness",
},
degrading = {
1 : {bonusdescript = "+5 Lust and Obedience per day", effect = 'degrading1'},
2 : {bonusdescript = "+10 Lust and Obedience per day", effect = 'degrading2'},
3 : {bonusdescript = "+15 Lust and Obedience per day", effect = 'degrading3'},
4 : {bonusdescript = "+20 Lust and Obedience per day", effect = 'degrading4'},
highest = "+20 Lust and Obedience per day",
},
animalistic = {
1 : {bonusdescript = "+8 Energy per day", effect = 'animalistic1'},
2 : {bonusdescript = "+16 Energy per day", effect = 'animalistic2'},
3 : {bonusdescript = "+24 Energy per day", effect = 'animalistic3'},
highest = "+24 Energy per day",
},
magic = {
1 : {bonusdescript = "+0 Magic Affinity", effect = 'magic1'},
2 : {bonusdescript = "+1 Magic Affinity", effect = 'magic2'},
3 : {bonusdescript = "+1 Magic Affinity", effect = 'magic3'},
4 : {bonusdescript = "+1 Magic Affinity", effect = 'magic4'},
5 : {bonusdescript = "+2 Magic Affinity", effect = 'magic5'},
highest = '+2 Magic Affinity',
},
}

var tattoodict = {
none = {value = 0, code = 'none'},
nature = {value = 1, code = 'nature'},
tribal = {value = 2, code = 'tribal'},
degrading = {value = 3, code = 'degrading'},
animalistic = {value = 4, code = 'animalistic'},
magic = {value = 5, code = 'magic'},
}

var selectedpart = ''
var slavetattoos = {}
var tattootheme = 'none'

func _on_applybutton_pressed():
	slave.tattooshow[selectedpart] = !get_node("customization/tattoopanel/invisible").is_pressed()
	if get_node("customization/tattoopanel/tattoooptions").is_disabled():
		return
	elif tattootheme == 'none':
		return
	elif globals.itemdict.magicessenceing.amount < 1 || globals.itemdict.supply.amount < 1:
		get_tree().get_current_scene().infotext("[color=red]Not enough resources[/color]")
		return
	else:
		globals.itemdict.magicessenceing.amount -= 1
		globals.itemdict.supply.amount -= 1
	slave.tattoo[selectedpart] = tattootheme
	counttattoos()
	var tattooDict = {currentlevel = slavetattoos[slave.tattoo[selectedpart]]}
	if tattoolevels[tattootheme].has(tattooDict.currentlevel-1) && tattoolevels[tattootheme].has(tattooDict.currentlevel):
		slave.add_effect(globals.effectdict[tattoolevels[tattootheme][tattooDict.currentlevel-1].effect],true)
	if tattoolevels[tattootheme].has(tattooDict.currentlevel):
		slave.add_effect(globals.effectdict[tattoolevels[tattootheme][tattooDict.currentlevel].effect])
	for i in get_node("customization/tattoopanel/VBoxContainer").get_children():
		if i.get_name() == selectedpart:
			choosetattooarea(i)
	_on_slave_tab_visibility_changed()

func _on_tattoo_pressed():
	get_node("customization/tattoopanel").popup()
	tattootheme = 'none'
	selectedpart = ''
	counttattoos()
	get_node("customization/tattoopanel/tattoooptions").set_hidden(true)
	get_node("customization/tattoopanel/RichTextLabel").set_bbcode("Select body part to work on")
	for i in get_node("customization/tattoopanel/VBoxContainer").get_children():
		i.set_pressed(false)
		if i.get_name() in ['legs','arms']:
			if i.get_name() == 'legs' && slave.legs in ['webbed','fur_covered','normal','scales']:
				i.set_disabled(false)
			elif i.get_name() == 'arms' && slave.arms in ['webbed','fur_covered','normal','scales']:
				i.set_disabled(false)
			else:
				i.set_disabled(true)

func counttattoos():
	slavetattoos = {none = 0,nature = 0, tribal = 0, degrading = 0, animalistic = 0, magic = 0}
	for i in slave.tattoo:
		slavetattoos[slave.tattoo[i]] += 1

func choosetattooarea(button):
	var area = button.get_name()
	var text = ''
	selectedpart = str(area)
	for i in get_node("customization/tattoopanel/VBoxContainer").get_children():
		if i == button:
			i.set_pressed(true)
		else:
			i.set_pressed(false)
	get_node("customization/tattoopanel/tattoooptions").set_hidden(false)
	get_node("customization/tattoopanel/tattoooptions").select(tattoodict[slave.tattoo[area]].value)
	if get_node("customization/tattoopanel/tattoooptions").get_selected() == 0:
		text += "$name currently has no tattoos on $his " + area + ". "
		get_node("customization/tattoopanel/tattoooptions").set_disabled(false)
	else:
		get_node("customization/tattoopanel/tattoooptions").set_disabled(true)
		text += "$name has a [color=aqua]" + tattoooptions[slave.tattoo[area]].name + '[/color] tattoo on $his ' + area + '. '
		text += "\n[color=aqua]Apply to change visibility[/color]"
	get_node("customization/tattoopanel/RichTextLabel").set_bbcode(slave.dictionary(text))

func _on_tattooclose_pressed():
	get_node("customization/tattoopanel").set_hidden(true)


func _on_tattoooptions_item_selected( ID ):
	for i in tattoodict.values():
		if i.value == get_node("customization/tattoopanel/tattoooptions").get_selected():
			tattootheme = i.code
	var text = slave.dictionary(tattoooptions[tattootheme].applydescript)
	if tattootheme != 'none':
		text += "\n\n"
		if slavetattoos[tattootheme] > 0:
			text += "Current Level: " + str(slavetattoos[tattootheme])
			if tattoolevels[tattootheme].has(slavetattoos[tattootheme]):
				text += "\nCurrent Bonus: " + tattoolevels[tattootheme][slavetattoos[tattootheme]].bonusdescript
			else:
				text += "\nCurrent Bonus: " + tattoolevels[tattootheme].highest
		if tattoolevels[tattootheme].has(slavetattoos[tattootheme]+1):
			text += "\nNext Bonus: " + tattoolevels[tattootheme][slavetattoos[tattootheme]+1].bonusdescript
		else:
			text += "\n[color=yellow]No additional effects. [/color]"
	get_node("customization/tattoopanel/RichTextLabel").set_bbcode(text)

#Piercing


var piercingdict = {
earlobes = {name = 'earlobes', options = ['earrings', 'stud'], requirement = null, id = 1},
eyebrow = {name = 'eyebrow', options = ['stud'], requirement = null, id = 2},
nose = {name = 'nose', options = ['stud', 'ring'], requirement = null, id = 3},
lips = {name = 'lips', options = ['stud', 'ring'], requirement = null, id = 4},
tongue = {name = 'tongue', options = ['stud'], requirement = null, id = 5},
navel = {name = 'navel', options = ['stud'], requirement = null, id = 6},
nipples = {name = 'nipples', options = ['ring', 'stud', 'chain'], requirement = 'lewdness', id = 7},
clit = {name = 'clit', options = ['ring', 'stud'], requirement = 'lewdness, pussy', id = 8},
labia = {name = 'labia', options = ['ring', 'stud'], requirement = 'lewdness, pussy', id = 9},
penis = {name = 'penis', options = ['ring', 'stud'], requirement = 'lewdness, penis', id = 10},
}

func _on_piercing_pressed():
	get_node("customization/piercingpanel").popup()
	for i in get_node("customization/piercingpanel/ScrollContainer/VBoxContainer").get_children():
		if i != get_node("customization/piercingpanel/ScrollContainer/VBoxContainer/piercingline"):
			i.set_hidden(true)
			i.queue_free()
	if slave.sexuals.unlocked == true:
		get_node("customization/piercingpanel/piercestate").set_text(slave.dictionary('$name does not seems to mind you pierce $his private places.'))
	else:
		get_node("customization/piercingpanel/piercestate").set_text(slave.dictionary('$name refuses to let you pierice $his private places'))
	
	for i in piercingdict:
		if slave.piercing.has(i) == false:
			slave.piercing[i] = null
	
	var array = []
	for i in piercingdict.values():
		array.append(i)
	array.sort_custom(self, 'idsort')
	
	
	for ii in array:
		if ii.requirement == null || (slave.sexuals.unlocked == true&& ii.requirement == 'lewdness') || (slave.penis != 'none' && slave.sexuals.unlocked == true && ii.id == 10) || (slave.vagina == 'normal' && slave.sexuals.unlocked == true && (ii.id == 8 || ii.id == 9)):
			var newline = get_node("customization/piercingpanel/ScrollContainer/VBoxContainer/piercingline").duplicate()
			newline.set_hidden(false)
			get_node("customization/piercingpanel/ScrollContainer/VBoxContainer").add_child(newline)
			newline.get_node("placename").set_text(ii.name.capitalize())
			for i in ii.options:
				newline.get_node("pierceoptions").add_item(i)
				if slave.piercing[ii.name] == i:
					newline.get_node("pierceoptions").select(newline.get_node("pierceoptions").get_item_count()-1)
			newline.get_node('pierceoptions').set_meta('pierce', ii.name)
			newline.get_node("pierceoptions").connect("item_selected", self, 'pierceselect', [newline.get_node("pierceoptions").get_meta('pierce')])

func idsort(first, second):
	if first.id < second.id:
		return true
	else:
		return false

func pierceselect(ID, node):
	if ID == 0:
		slave.piercing[node] = 'pierced'
	else:
		slave.piercing[node] = piercingdict[node].options[ID-1]
	_on_piercing_pressed()

func _on_closebutton_pressed():
	get_node("customization/piercingpanel").set_hidden(true)


func _on_hairstyle_item_selected( ID ):
	slave = globals.currentslave
	var hairstyles = ['straight','ponytail', 'twintails', 'braid', 'two braids', 'bun']
	slave.hairstyle = hairstyles[ID]
	get_parent()._on_slave_tab_visibility_changed()


func _on_useitem_pressed():
	get_tree().get_current_scene()._on_inventory_pressed("slave")

func _on_image_pressed():
	get_tree().get_current_scene().imageselect("body", slave)


func _on_portrait_pressed():
	get_tree().get_current_scene().imageselect("portrait", slave)




func _on_bodybutton_pressed():
	if get_node("inspect/Panel 2/fullbody").get_texture() != null:
		get_node("inspect/Panel 2").set_hidden(!get_node("inspect/Panel 2").is_hidden())