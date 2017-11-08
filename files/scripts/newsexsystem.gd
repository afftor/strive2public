extends Node

var parser = load("res://files/scripts/sexdescriptions.gd").new()

var participants = []
var givers = []
var takers = []
var turns = 0
var actions = []
var ongoingactions = []

var sexicons = {
female = load("res://files/buttons/sexicons/female.png"),
male = load("res://files/buttons/sexicons/male.png"),
futanari = load("res://files/buttons/sexicons/futa.png"),
}
var statsicons = {
lub1 = load("res://files/buttons/sexicons/lub1.png"),
lub2 = load("res://files/buttons/sexicons/lub2.png"),
lub3 = load("res://files/buttons/sexicons/lub3.png"),
lub4 = load("res://files/buttons/sexicons/lub4.png"),
lub5 = load("res://files/buttons/sexicons/lub5.png"),
lust1 = load("res://files/buttons/sexicons/lust1.png"),
lust2 = load("res://files/buttons/sexicons/lust2.png"),
lust3 = load("res://files/buttons/sexicons/lust3.png"),
lust4 = load("res://files/buttons/sexicons/lust4.png"),
lust5 = load("res://files/buttons/sexicons/lust5.png"),
sens1 = load("res://files/buttons/sexicons/sens1.png"),
sens2 = load("res://files/buttons/sexicons/sens2.png"),
sens3 = load("res://files/buttons/sexicons/sens3.png"),
sens4 = load("res://files/buttons/sexicons/sens4.png"),
sens5 = load("res://files/buttons/sexicons/sens5.png"),
}


var selectedcategory = 'caress'
var categories = {caress = [], fucking = [], tools = [], SM = [], humiliation = [], other = []}


func _ready():
	for i in globals.dir_contents('res://files/scripts/actions'):
		if i.find('.gd') < 0:
			continue
		var newaction = load(i).new()
		categories[newaction.category].append(newaction)
	for i in get_node("Panel/HBoxContainer").get_children():
		i.connect("pressed",self,'changecategory',[i.get_name()])
	
	turns = 20
	var i = 5
	while i > 0:
		i -= 1
		var slave = globals.newslave(globals.allracesarray[rand_range(0,globals.allracesarray.size())], 'random', 'random')
		var newmember = member.new()
		newmember.loyalty = slave.loyal
		newmember.submission = slave.obed
		newmember.person = slave
		newmember.sex = slave.sex
		newmember.name = slave.name_short()
		newmember.svagina = slave.sensvagina
		newmember.smouth = slave.sensmouth
		newmember.spenis = slave.senspenis
		newmember.sanus = slave.sensanal
		newmember.lewdness = slave.lewdness
		participants.append(newmember)
	changecategory('caress')
	clearstate()
	rebuildparticipantslist()

func clearstate():
	givers.clear()
	takers.clear()
	givers.append(participants[0])
	globals.player = participants[0] #for "You" testing

func changecategory(name):
	selectedcategory = name
	for i in get_node("Panel/HBoxContainer").get_children():
		if i.get_name() != name: i.set_pressed(false) 
		else: i.set_pressed(true)
	rebuildparticipantslist()

func rebuildparticipantslist():
	var newnode
	for i in get_node("Panel/VBoxContainer").get_children() + get_node("Panel/GridContainer/GridContainer").get_children():
		if !i.get_name() in ['Panel', 'Button']:
			i.set_hidden(true)
			i.queue_free()
	for i in participants:
		newnode = get_node("Panel/VBoxContainer/Panel").duplicate()
		newnode.set_hidden(false)
		get_node("Panel/VBoxContainer").add_child(newnode)
		newnode.get_node("name").set_text(i.person.dictionary('$name'))
		newnode.get_node("name").connect("pressed",self,"slavedescription",[i])
		if givers.find(i) >= 0:
			newnode.get_node("give").set_pressed(true)
		elif takers.find(i) >= 0:
			newnode.get_node("take").set_pressed(true)
		newnode.set_meta("slave", i)
		newnode.get_node("sex").set_texture(sexicons[i.person.sex])
		newnode.get_node("sex").set_tooltip(i.person.sex)
		newnode.get_node("lust").set_texture(statsicons['lust' + str(max(1,ceil(i.lust/200)))])
		newnode.get_node("sens").set_texture(statsicons['sens' + str(max(1,ceil(i.sens/200)))])
		newnode.get_node("lube").set_texture(statsicons['lub' + str(max(1,ceil(i.lube/2)))])
		newnode.get_node("give").connect("pressed",self,'switchsides',[newnode, 'give'])
		newnode.get_node("take").connect("pressed",self,'switchsides',[newnode, 'take'])
	var text = ''
	for i in categories[selectedcategory]:
		i.givers = givers
		i.takers = takers
		if i.requirements() == false:
			continue
		newnode = get_node("Panel/GridContainer/GridContainer/Button").duplicate()
		get_node("Panel/GridContainer/GridContainer").add_child(newnode)
		newnode.set_hidden(false)
		newnode.set_text(i.getname())
		newnode.connect("pressed",self,'startscene',[i])
		if i.canlast == true:
			newnode.get_node("continue").set_hidden(false)
			newnode.get_node("continue").connect("pressed",self,'startscenecontinue',[i])
	for i in givers:
		text += '[color=yellow]' + i.name + '[/color], '
	if givers.size() == 0:
		text += '[...] '
	text += 'will do it ... to '
	for i in takers:
		text += '[color=aqua]' + i.name + '[/color], '
	if takers.size() == 0:
		text += "[...]"
	else:
		text = text.substr(0, text.length() -2)+ '. '
	text += "\n\n"
	for i in ongoingactions:
		text += decoder(i.scene.getongoingname(i.givers,i.takers), i.givers, i.takers) + ' [url='+str(ongoingactions.find(i))+'][Interrupt][/url]\n'
	
	
	
	
	get_node("Panel/sceneeffects1").set_bbcode(text)

func slavedescription(member):
	get_node("Panel/sceneeffects").set_bbcode(member.person.description())

func switchsides(panel, side):
	var slave = panel.get_meta('slave')
	givers.erase(slave)
	takers.erase(slave)
	if slave.role == side:
		slave.role = 'none'
	else:
		slave.role = side
	if slave.role == 'give':
		givers.append(slave)
	elif slave.role == 'take':
		takers.append(slave)
	rebuildparticipantslist()

func startscene(scenescript, cont = false):
	var textdict = {mainevent = '', repeats = '', orgasms = ''}
	var effect = 0
	var pain = 0
	scenescript.givers = givers
	scenescript.takers = takers
	
	textdict.mainevent = decoder(scenescript.initiate(), givers, takers)
	
	if scenescript.has_method('reaction'):
		for i in takers:
			textdict.mainevent += '\n' + decoder(scenescript.reaction(i), givers, [i])
	
	var sceneexists = false
	for i in ongoingactions:
		if i.givers == givers && i.takers == takers && i.scene == scenescript:
			sceneexists = true
		else:
			textdict.repeats += '\n' + decoder(i.scene.getongoingdescription(givers, takers), i.givers, i.takers)
	
	var dict = {scene = scenescript, takers = [] + takers, givers = [] + givers}
	
	for i in givers:
		if scenescript.giverpart != '':
			if i[scenescript.giverpart] != null:
				stopongoingaction(i[scenescript.giverpart])
			i[scenescript.giverpart] = dict
	for i in takers:
		if scenescript.takerpart != '':
			if i[scenescript.takerpart] != null:
				stopongoingaction(i[scenescript.takerpart])
			i[scenescript.takerpart] = dict
	
	for i in givers: #Lust - mental desire, sens - physical excitement, pain - physical refusal, exposure - mental refusal, lewdness - mental anticipation
		if scenescript.givereffects.has('pain'):
			pain = max(0, scenescript.givereffects.pain-i.lube*5)
		else:
			pain = 0
		var value = max(scenescript.givereffects.sens/2, scenescript.givereffects.sens - i.pain/4) - pain 
		
		if scenescript.giverpart != '':
			i['s'+scenescript.giverpart] += clamp(value/50,0.2,5)
			value = value*max(1,i['s'+scenescript.giverpart]/100)
		if i.sens + value < i.sens:
			i.lust += scenescript.givereffects.lust/2
		else:
			i.lust += scenescript.givereffects.lust + i.lewd/25
		i.sens += value
	for i in takers:
		if scenescript.targeteffects.has('pain'):
			pain = max(0, scenescript.targeteffects.pain-i.lube*5)
		else:
			pain = 0
		var value = max(scenescript.targeteffects.sens/2, scenescript.targeteffects.sens - i.pain/4) - pain 
		
		if scenescript.takerpart != '':
			i['s'+scenescript.takerpart] += clamp(value/50,0.2,5)
			value = value*max(1,i['s'+scenescript.takerpart]/100)
		if i.sens + value < i.sens:
			i.lust += scenescript.targeteffects.lust/2
		else:
			i.lust += scenescript.targeteffects.lust + i.lewd/25
		i.sens += value
	for i in participants:
		if i.sens >= 1000:
			textdict.orgasms += '\n' + orgasm(i)
		if i in givers+takers:
			i.lastaction = dict
		elif not i.lastaction in ongoingactions:
			i.lastaction = null
	
	if cont == true && sceneexists == false: 
		ongoingactions.append(dict)
		
	else:
		for i in givers:
			if scenescript.giverpart != '':
				i[scenescript.giverpart] = null
		for i in takers:
			if scenescript.takerpart != '':
				i[scenescript.takerpart] = null
	
	get_node("Panel/sceneeffects").set_bbcode(textdict.mainevent + textdict.repeats + textdict.orgasms)
	rebuildparticipantslist()

func startscenecontinue(scenescript):
	startscene(scenescript, true)

func orgasm(member):
	member.sens = member.sens/3
	var scene
	var text
	var temptext
	var penistext
	var vaginatext
	member.orgasms += 1
	#vagina present
	if member.person.vagina != 'none':
		member.lube += rand_range(1,2)
		#vagina in use, find scene
		if member.vagina != null:
			scene = member.vagina
			#vagina in giver slot
			if scene.givers.find(member) >= 0:
				if randf() < 0.4:
					vaginatext = "[name1] feel[s/1] a {^sudden :intense ::}{^jolt of electricity:warmth:wave of pleasure} and [his1]"
				else:
					vaginatext = "[names1]"
				if scene.scene.takerpart == 'penis':
					vaginatext += " [pussy1] {^squeezes:writhes around:clamps down on} [names2] [penis2] as [he1] reach[es/1] {^climax:orgasm}."
				else:
					vaginatext += " [pussy1] {^convulses:twitches:quivers} {^in euphoria:in exstacy:with pleasure} as [he1] reach[es/1] {^climax:orgasm}."
				vaginatext = decoder(vaginatext, [member], scene.takers)
			#vagina is in taker slot
			elif scene.takers.find(member) >= 0:
				if randf() < 0.4:
					vaginatext = "[name2] feel[s/2] a {^sudden :intense ::}{^jolt of electricity:warmth:wave of pleasure} and [his2]"
				else:
					vaginatext = "[names2]"
				if scene.scene.giverpart == 'penis':
					vaginatext += " [pussy2] {^squeezes:writhes around:clamps down on} [names1] [penis1] as [he2] reach[es/2] {^climax:orgasm}."
				else:
					vaginatext += " [pussy2] {^convulses:twitches:quivers} {^in euphoria:in exstacy:with pleasure} as [he2] reach[es/2] {^climax:orgasm}."
				vaginatext = decoder(vaginatext, scene.givers, [member])
			#no default conditon
	#penis present
	if member.person.penis != 'none':
		#penis in use, find scene
		if member.penis != null:
			scene = member.penis
			#penis in giver slot
			if scene.givers.find(member) >= 0:
				if randf() < 0.4:
					penistext = "[name1] feel[s/1] a wave of {^pleasure:euphoria:heat} {^run:course} through [his1] [penis1] and [his1]"
				else:
					penistext = "[names1] hips {^buck:thrust:jerk} forward and a {^thick :hot :}{^jet:load:batch} of"
				if scene.scene.takerpart == '':
					penistext += " {^semen:seed:cum} {^pours onto:shoots onto:falls to} the {^ground:floor} as [he1] ejaculate[s/1]."
				elif ['anus','vagina','mouth'].has(scene.scene.takerpart):
					temptext = scene.scene.takerpart.replace('anus', '[anus2]').replace('vagina','[pussy2]')
					penistext += " {^semen:seed:cum} {^pours:flows:pumps} into [names2] " + temptext + " as [he1] ejaculate[s/1]."
					if scene.scene.takerpart == 'vagina':
						for i in scene.takers:
							globals.impregnation(i.person, member.person)
				penistext = decoder(penistext, [member], scene.takers)
			#penis in taker slot
			elif scene.takers.find(member) >= 0:
				if randf() < 0.4:
					penistext = "[name2] feel[s/2] a wave of {^pleasure:euphoria:heat} {^run:course} through [his2] [penis2] and [his2]"
				else:
					penistext = "[names2] hips {^buck:thrust:jerk} forward and a {^thick :hot :}{^jet:load:batch} of"
				if scene.scene.code == 'handjob':
					penistext += " {^semen:seed:cum} {^sprays onto:shoots all over:covers} [names1] face[/s1] as [he2] ejaculate[s/2]."
				elif scene.scene.giverpart == '':
					penistext += " {^semen:seed:cum} {^pours onto:sprays onto:falls to} the {^ground:floor} as [he2] ejaculate[s/2]."
				elif ['anus','vagina','mouth'].has(scene.scene.giverpart):
					temptext = scene.scene.giverpart.replace('anus', '[anus1]').replace('vagina','[pussy1]')
					penistext += " {^semen:seed:cum} {^pours:flows:pumps} into [names1] " + temptext + " as [he2] ejaculate[s/2]."
					if scene.scene.giverpart == 'vagina':
						for i in scene.givers:
							globals.impregnation(i.person, member.person)
				penistext = decoder(penistext, scene.givers, [member])
		#orgasm without penis, secondary ejaculation
		else:
			if randf() < 0.4:
				penistext = "[name2] {^twist:quiver:writhe}[s/2] in {^pleasure:euphoria:extacy} as"
			else:
				penistext = "[name2] {^can't hold back any longer:reach[es/2] [his2] limit} and"
			penistext += " {^a jet of :a rope of :}{^semen:cum} {^fires:squirts:shoots} from {^the tip of :}[his2] {^neglected :throbbing ::}[penis2]."
			penistext = decoder(penistext, null, [member])
	if vaginatext != null && penistext != null:
		text = vaginatext + " " + penistext
	elif penistext != null:
		text = penistext
	elif vaginatext != null:
		text = vaginatext
	#final default condition
	else:
		if randf() < 0.4:
			temptext = "[name2] feel[s/2] a {^sudden :intense ::}{^jolt of electricity:warmth:wave of pleasure} and [his2]"
		else:
			temptext = "[names2]"
		temptext += " {^entire :whole :}body {^twists:quivers:writhes} in {^pleasure:euphoria:extacy} as [he2] reach[es/2] {^climax:orgasm}."
		text = decoder(temptext, null, [member])
	return "[color=#ff5df8]" + text + "[/color]"


class member:
	var name
	var person
	var mood
	var submission
	var loyalty
	var lust = 0
	var sens = 0
	var lube = 0
	var pain = 0
	var lewd = 0
	var exposure = 0
	var role
	var sex
	var orgasms = 0
	var lastaction
	var consent = true
	
	var svagina
	var smouth
	var spenis
	var sanus
	var lewdness
	
	var energy = 100
	
	var knowledge
	
	var giving = []
	var taking = []
	
	var vagina
	var penis
	var mouth
	var anus

func decoder(text, givers, takers):
	return parser.decoder(text, givers, takers)


func _on_sceneeffects1_meta_clicked( meta ):
	stopongoingaction(meta)

func stopongoingaction(meta):
	var action
	if typeof(meta) == TYPE_STRING:
		action = ongoingactions[int(meta)]
	elif typeof(meta) == TYPE_DICTIONARY:
		action = meta
	for i in action.givers:
		if action.scene.giverpart != '':
			i[action.scene.giverpart] = null
	for i in action.takers:
		i[action.scene.takerpart] = null
	ongoingactions.erase(action)
	rebuildparticipantslist()



func _on_passbutton_pressed():
	clearstate()
	startscene(categories.other[0])
