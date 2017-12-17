extends Node

var parser = load("res://files/scripts/sexdescriptions.gd").new()

var participants = []
var givers = []
var takers = []
var turns = 0
var actions = []
var ongoingactions = []
var location

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
stress1 = load("res://files/buttons/icons/stress/2.png"),
stress2 = load("res://files/buttons/icons/stress/1.png"),
stress3 = load("res://files/buttons/icons/stress/3.png")
}


var selectedcategory = 'caress'
var categories = {caress = [], fucking = [], tools = [], SM = [], humiliation = [], other = []}


class member:
	var name
	var person
	var mood
	var submission
	var loyalty
	var lust = 0 setget lust_set
	var sens = 0 setget sens_set
	var lube = 0
	var pain = 0
	var exposure = 0
	var role
	var sex
	var orgasms = 0
	var lastaction
	
	var svagina = 0
	var smouth = 0
	var spenis = 0
	var sanus = 0
	var lewd
	
	var energy = 100
	
	var knowledge
	
	var giving = []
	var taking = []
	
	var vagina
	var penis
	var mouth
	var anus
	var tail
	var strapon
	var mode = 'normal'
	var consent = true
	
	func lust_set(value):
		lust = min(value, 1000)
	
	func sens_set(value):
		sens = min(value, 1000)
	
	func lube():
		if person.vagina != 'none':
			lube = lube + (sens/200)
			lube = min(5+lewd/20,lube)
	
	func actioneffect(acceptance, values):
		var lewdinput = 0
		var lustinput = 0
		var sensinput = 0
		var paininput = 0
		if values.has("lewd"):
			lewdinput = values.lewd
		if values.has("lust"):
			lustinput = values.lust
		if values.has('sens'):
			sensinput = values.sens
		if values.has('pain'):
			paininput = values.pain
		
		
		if acceptance == 'good':
			sensinput *= rand_range(1.1,1.4)
			lustinput *= 2
		elif acceptance == 'average':
			sensinput *= 1.1
			lustinput *= 1
		else:
			sensinput *= 0.6
			lustinput *= 0.3
			if values.has('pain') == false:
				person.stress += rand_range(5,10)
		
		if values.has('tags') && values.tags.has('punish'):
			if (person.obed < 90 || mode == 'forced') && (!person.traits.has('Masochist') && !person.traits.has('Likes it rough')):
				person.obed += values.obed
				person.stress += values.stress
				if person.effects.has("captured") && randf() >= values.obed/2:
					person.effects.captured.duration -= 1
				self.lust += lustinput/4
				self.sens += sensinput/4
			else:
				self.lewd += lewdinput
				self.lust += lustinput
				self.sens += sensinput
				if person.asser < 50 && randf() < 0.1:
					person.add_trait("Likes it rough")
				if !person.traits.has('Masochist'):
					person.stress += values.stress
			if randf() < 0.20 && lust >= 950:
				person.add_trait("Masochist")
		else:
			self.lewd += lewdinput
			self.lust += lustinput
			self.sens += sensinput
	

func _ready():
	for i in globals.dir_contents('res://files/scripts/actions'):
		if i.find('.gd') < 0:
			continue
		var newaction = load(i).new()
		categories[newaction.category].append(newaction)
	for i in get_node("Panel/HBoxContainer").get_children():
		i.connect("pressed",self,'changecategory',[i.get_name()])
	
	var i = 5
	if globals.player.name == '':
		while i > 0:
			i -= 1
			var slave = globals.newslave(globals.allracesarray[rand_range(0,globals.allracesarray.size())], 'random', 'random')
			var newmember = member.new()
			slave.obed = 90
			newmember.loyalty = slave.loyal
			newmember.submission = slave.obed
			newmember.person = slave
			newmember.sex = slave.sex
			newmember.name = slave.name_short()
			newmember.svagina = slave.sensvagina
			newmember.smouth = slave.sensmouth
			newmember.spenis = slave.senspenis
			newmember.sanus = slave.sensanal
			newmember.lewd = slave.lewdness
			participants.append(newmember)
		turns = 20
		changecategory('caress')
		clearstate()
		rebuildparticipantslist()

func startsequence(actors, mode = null, secondactors = []):
	participants.clear()
	get_node("Control").set_hidden(true)
	for slave in actors:
		var newmember = member.new()
		slave.lastinteractionday = globals.resources.day
		newmember.loyalty = slave.loyal
		newmember.submission = slave.obed
		newmember.person = slave
		newmember.sex = slave.sex
		newmember.name = slave.name_short()
		newmember.svagina = slave.sensvagina
		newmember.smouth = slave.sensmouth
		newmember.spenis = slave.senspenis
		newmember.sanus = slave.sensanal
		newmember.lewd = slave.lewdness
		participants.append(newmember)
	
	if mode == 'abuse':
		for slave in secondactors:
			var newmember = member.new()
			slave.lastinteractionday = globals.resources.day
			newmember.loyalty = slave.loyal
			newmember.submission = slave.obed
			newmember.person = slave
			newmember.sex = slave.sex
			newmember.name = slave.name_short()
			newmember.svagina = slave.sensvagina
			newmember.smouth = slave.sensmouth
			newmember.spenis = slave.senspenis
			newmember.sanus = slave.sensanal
			newmember.lewd = slave.lewdness
			newmember.mode = 'forced'
			newmember.consent = false
			participants.append(newmember)
	
	get_node("Panel/sceneeffects").set_bbcode("You bring selected participants into your bedroom. ")
	turns = 20
	changecategory('caress')
	clearstate()
	rebuildparticipantslist()
	

func clearstate():
	givers.clear()
	takers.clear()
	if givers.size() >= 1:
		givers.append(participants[0])
	#globals.player = participants[0] #for "You" testing

func changecategory(name):
	selectedcategory = name
	for i in get_node("Panel/HBoxContainer").get_children():
		if i.get_name() != name: i.set_pressed(false) 
		else: i.set_pressed(true)
	rebuildparticipantslist()

func rebuildparticipantslist():
	var newnode
	var effects
	for i in get_node("Panel/ScrollContainer/VBoxContainer").get_children() + get_node("Panel/GridContainer/GridContainer").get_children():
		if !i.get_name() in ['Panel', 'Button']:
			i.set_hidden(true)
			i.queue_free()
	for i in participants:
		newnode = get_node("Panel/ScrollContainer/VBoxContainer/Panel").duplicate()
		newnode.set_hidden(false)
		get_node("Panel/ScrollContainer/VBoxContainer").add_child(newnode)
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
		newnode.get_node("lube").set_texture(statsicons['lub' + str(clamp(ceil(i.lube/2), 1, 5))])
		newnode.get_node("stress").set_texture(statsicons['stress'+str(clamp(round(i.person.stress/33)+1,1,3))])
		newnode.get_node("stress").set_tooltip("Stress: " + str(floor(i.person.stress))+"%")
		newnode.get_node("give").connect("pressed",self,'switchsides',[newnode, 'give'])
		newnode.get_node("take").connect("pressed",self,'switchsides',[newnode, 'take'])
		
		
		if i.person == globals.player:
			newnode.get_node("mood").set_hidden(true)
			continue
		
		if i.person.obed < 90:
			newnode.get_node("mood").set("custom_colors/font_color", Color(1,i.person.obed/100,i.person.obed/100))
			newnode.get_node("mood").set_text("Rebellious")
		
		if i.mode == 'forced':
			newnode.get_node("mood").set("custom_colors/font_color", Color(1,i.person.obed/100,i.person.obed/100))
			newnode.get_node("mood").set_text("Forced")
		elif i.lust > 200:
			newnode.get_node("mood").set("custom_colors/font_color", Color(1,0.2,0.8))
			newnode.get_node("mood").set_text("Horny")
		else:
			newnode.get_node("mood").set_text("Neutral")
		
	var text = ''
	
	#check for double dildo scenes between participants
	var doubledildo = false
	var givercheck = false
	var takercheck = false
	
	for scene in ongoingactions:
		if scene.scene.code in ['doubledildo','doubledildoass','tribadism','frottage']:
			for i in givers:
				if scene.givers.has(i) || scene.takers.has(i):
					givercheck = true
			for i in takers:
				if scene.givers.has(i) || scene.takers.has(i):
					takercheck = true
		if givercheck && takercheck:
			doubledildo = true
			break
		else:
			givercheck = false
			takercheck = false
	
	for i in categories[selectedcategory]:
		i.givers = givers
		i.takers = takers
		if i.requirements() == false:
			continue
		elif doubledildo == true && i.category in ['caress','fucking'] && !i.code in ['doubledildo','doubledildoass','tribadism','frottage']:
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
	
	if givers.size() == 0:
		get_node("Panel/passbutton").set_disabled(true)
	else:
		get_node("Panel/passbutton").set_disabled(false)
	
	get_node("TextureFrame/Label").set_text(str(turns))
	
	get_node("Panel/sceneeffects1").set_bbcode(text)
	
	if turns == 0:
		endencounter()

func slavedescription(member):
	get_parent().popup(member.person.descriptionsmall())

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
	var pain = 0
	var effects
	scenescript.givers = givers
	scenescript.takers = takers
	
	for i in givers:
		if i.person == globals.player:
			continue
		if scenescript.giverconsent != 'any' && ((i.mode == 'forced' || i.person.obed < 90) && !i.person.traits.has('Masochist') && !i.person.traits.has('Likes it rough') ):
			get_node("Panel/sceneeffects").set_bbcode(i.person.dictionary("$name refused to do [color=yellow]" + scenescript.getname() + '[/color] (low obedience)'))
			return
		elif scenescript.giverconsent == 'advanced' && i.lewd < 50:
			get_node("Panel/sceneeffects").set_bbcode(i.person.dictionary("$name refused to do [color=yellow]" + scenescript.getname() + '[/color] (low lewdness)'))
			return
	for i in takers:
		if i.person == globals.player:
			continue
		if scenescript.takerconsent != 'any' && ((i.mode == 'forced' || i.person.obed < 90) && !i.person.traits.has('Masochist') && !i.person.traits.has('Likes it rough')  ):
			get_node("Panel/sceneeffects").set_bbcode(i.person.dictionary("$name refused to do [color=yellow]" + scenescript.getname() + '[/color] (low obedience)'))
			return
		elif scenescript.takerconsent == 'advanced' && i.lewd < 50:
			get_node("Panel/sceneeffects").set_bbcode(i.person.dictionary("$name refused to do [color=yellow]" + scenescript.getname() + '[/color] (low lewdness)'))
			return
	
	if scenescript.code in ['doubledildo','doubledildoass','tribadism']:
		for i in ongoingactions:
			if i.scene.category == 'fucking' && (i.givers.has(givers[0]) || i.takers.has(givers[0]) || i.givers.has(takers[0]) || i.takers.has(takers[0])):
				stopongoingaction(i)
	if scenescript.code == 'strapon':
		cont = true
	
	
	#temporary support for scenes converted to centralized output and those not
	#should be unified in the future
	var centralized = false
	if scenescript.has_method('initiate'):
		textdict.mainevent = decoder(scenescript.initiate(), givers, takers)
	else:
		centralized = true
		textdict.mainevent = output(scenescript, scenescript.initiate, givers, takers) + output(scenescript, scenescript.ongoing, givers, takers)
		
	turns -= 1
	
	if centralized == false:
		if scenescript.has_method('reaction'):
			for i in takers:
				textdict.mainevent += '\n' + decoder(scenescript.reaction(i), givers, [i])
	elif scenescript.reaction != null:
			for i in takers:
				textdict.mainevent += '\n' + output(scenescript, scenescript.reaction, givers, [i])
	
	if centralized == true:
		#remove virginity if relevant
		if scenescript.virginloss == true:
			for i in givers:
				if scenescript.giverpart == 'vagina':
					i.person.vagvirgin = false
				elif scenescript.giverpart == 'anus':
					i.person.assvirgin = false
			for i in takers:
				if scenescript.takerpart == 'vagina':
					i.person.vagvirgin = false
				elif scenescript.takerpart == 'anus':
					i.person.assvirgin = false
	
	
	
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
	
	for i in givers: 
		if scenescript.has_method('givereffect'):
			effects = scenescript.givereffect(i)
			i.actioneffect(effects[0], effects[1])
		i.lube()
		
	for i in takers:
		if scenescript.has_method('takereffect'):
			effects = scenescript.takereffect(i)
			i.actioneffect(effects[0], effects[1])
		i.lube()
	
	var sceneexists = false
	for i in ongoingactions:
		if i.givers == givers && i.takers == takers && i.scene == scenescript:
			sceneexists = true
		elif i.scene.has_method('getongoingdescription'):
			textdict.repeats += '\n' + decoder(i.scene.getongoingdescription(i.givers, i.takers), i.givers, i.takers)
		else:
			textdict.repeats += '\n' + output(i.scene, i.scene.ongoing, i.givers, i.takers)
	textdict.repeats = textdict.repeats.replace("[color=yellow]", '').replace('[color=aqua]', '').replace('[/color]','')
	
	for i in ongoingactions:
		if i.scene.has_method("givereffect"):
			for member in i.givers:
				effects = i.scene.givereffect(member)
				member.actioneffect(effects[0], effects[1])
		if i.scene.has_method("takereffect"):
			for member in i.takers:
				effects = i.scene.takereffect(member)
				member.actioneffect(effects[0], effects[1])
	
	
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
	
	
	
	get_node("Panel/sceneeffects").set_bbcode(textdict.mainevent + "\n" + textdict.repeats + "\n" + textdict.orgasms)
	rebuildparticipantslist()


#Effects: pleasure, excitement, pain, deviancy, obedience 

func startscenecontinue(scenescript):
	startscene(scenescript, true)


var sexdict = load("res://files/scripts/newsexdictionary.gd").new()

#centralized output processing
#category currently assumed to be 'fucking', will expland with further conversions
func output(scenescript, valid_lines, givers, takers):
	var shared_lines = sexdict.shared_lines
	var giverpart = scenescript.giverpart
	var takerpart = scenescript.takerpart
	var act_lines = scenescript.act_lines
	var virginloss = scenescript.virginloss
	var links = scenescript.links
	#internal
	var linearray = []
	var output = ''
	var virginpart = null
	var virginsource = null
	#checks
	var checks = {
		link = null,
		consent = true,
		virgin = true,
		arousal = 1,
		lube = 1,
		lust = 1,
	}
	
	#link with ongoingactions
	if givers[0][giverpart] != null:
		if givers[0][giverpart].scene.code in links:
			checks.link = givers[0][giverpart].scene.code
			for i in givers:
				if i[giverpart] != givers[0][giverpart]:
					checks.link = null
					break
			for i in takers:
				if i[takerpart] != givers[0][giverpart]:
					checks.link = null
					break
	#link with lastaction
	if checks.link == null && givers[0].lastaction != null:
		if givers[0].lastaction.scene.code in links:
			checks.link = givers[0].lastaction.scene.code
			for i in givers+takers:
				if i.lastaction != givers[0].lastaction:
					checks.link = null
					break
	#virginity assignments
	if giverpart == 'penis':
		if takerpart == 'vagina':
			virginpart = 'vagvirgin'
			virginsource = takers
		elif takerpart == 'anus':
			virginpart = 'assvirgin'
			virginsource = takers
	elif takerpart == 'penis':
		if giverpart == 'vagina':
			virginpart = 'vagvirgin'
			virginsource = givers
		elif giverpart == 'anus':
			virginpart = 'assvirgin'
			virginsource = givers
	#assign virginity check
	for i in virginsource:
		if i.person[virginpart] == false:
			checks.virgin = false
	#assign consent
	for i in takers:
		if i.mode == 'forced':
			checks.consent = false
	#based on screen values, subject to adjustment
	if takers.size() == 1:
		checks.arousal = int(clamp(ceil(takers[0].sens/200), 1, 5))
		checks.lube = int(clamp(ceil(takers[0].lube/2), 1, 5))
		checks.lust = int(clamp(ceil(takers[0].lust/200), 1, 5))
	
	#build the output
	var drop = false
	for i in valid_lines:
		linearray = []
		if i in act_lines:
			for j in act_lines[i]:
				drop = false
				for k in act_lines[i][j].conditions:
					if checks.has(k) && !act_lines[i][j].conditions[k].has(checks[k]):
						drop = true
						break
				if drop == false:
					linearray += act_lines[i][j].lines
		if i in shared_lines:
			for j in shared_lines[i]:
				drop = false
				for k in shared_lines[i][j].conditions:
					if checks.has(k) && !shared_lines[i][j].conditions[k].has(checks[k]):
						drop = true
						break
				if drop == false:
					linearray += shared_lines[i][j].lines
		if linearray.size() > 0:
			output += linearray[randi()%linearray.size()]
	
	return decoder(output, givers, takers)


func orgasm(member):
	member.sens = member.sens/4
	var scene
	var text
	var temptext
	var penistext
	var vaginatext
	var anustext
	member.orgasms += 1
	if participants.size() == 2 && member.person != globals.player:
		member.person.loyal += rand_range(1,4)
	elif member.person != globals.player:
		member.person.loyal += rand_range(1,2)
	#anus in use, find scene
	if member.anus != null:
		scene = member.anus
		#anus in giver slot
		if scene.givers.find(member) >= 0:
			if randf() < 0.4:
				anustext = "[name1] feel[s/1] a {^sudden :intense ::}{^jolt of electricity:warmth:wave of pleasure} inside [him1] and [his1]"
			else:
				anustext = "[names1]"
			if scene.scene.takerpart == 'penis':
				anustext += " [anus1] {^squeezes:writhes around:clamps down on} [names2] [penis2] as [he1] reach[es/1] {^climax:orgasm}."
			else:
				anustext += " [anus1] {^convulses:twitches:quivers} {^in euphoria:in exstacy:with pleasure} as [he1] reach[es/1] {^climax:orgasm}."
			anustext = decoder(anustext, [member], scene.takers)
		#anus is in taker slot
		elif scene.takers.find(member) >= 0:
			if randf() < 0.4:
				anustext = "[name2] feel[s/2] a {^sudden :intense ::}{^jolt of electricity:warmth:wave of pleasure} inside [him2] and [his2]"
			else:
				anustext = "[names2]"
			if scene.scene.giverpart == 'penis':
				anustext += " [anus2] {^squeezes:writhes around:clamps down on} [names1] [penis1] as [he2] reach[es/2] {^climax:orgasm}."
			else:
				anustext += " [anus2] {^convulses:twitches:quivers} {^in euphoria:in exstacy:with pleasure} as [he2] reach[es/2] {^climax:orgasm}."
			anustext = decoder(anustext, scene.givers, [member])
		#no default conditon
	#vagina present
	if member.person.vagina != 'none':
		member.lube()
		#vagina in use, find scene
		if member.vagina != null:
			scene = member.vagina
			#vagina in giver slot
			if scene.givers.find(member) >= 0:
				if randf() < 0.4:
					vaginatext = "[name1] feel[s/1] a {^sudden :intense ::}{^jolt of electricity:warmth:wave of pleasure} inside [him1] and [his1]"
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
					vaginatext = "[name2] feel[s/2] a {^sudden :intense ::}{^jolt of electricity:warmth:wave of pleasure} inside [him2] and [his2]"
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
					penistext = "[name1] feel[s/1] {^a wave of:an intense} {^pleasure:euphoria} {^run through:course through:building in} [his1] [penis1] and [his1]"
				else:
					penistext = "[name1] {^thrust:jerk}[s/1] [his1] hips forward and a {^thick :hot :}{^jet:load:batch} of"
				if scene.scene.takerpart == '':
					penistext += " {^semen:seed:cum} {^pours onto:shoots onto:falls to} the {^ground:floor} as [he1] ejaculate[s/1]."
				elif ['anus','vagina','mouth'].has(scene.scene.takerpart):
					temptext = scene.scene.takerpart.replace('anus', '[anus2]').replace('vagina','[pussy2]')
					penistext += " {^semen:seed:cum} {^pours:shoots:pumps:sprays} into [names2] " + temptext + " as [he1] ejaculate[s/1]."
					if scene.scene.takerpart == 'vagina':
						for i in scene.takers:
							globals.impregnation(i.person, member.person)
				penistext = decoder(penistext, [member], scene.takers)
			#penis in taker slot
			elif scene.takers.find(member) >= 0:
				if randf() < 0.4:
					penistext = "[name2] feel[s/2] {^a wave of:an intense} {^pleasure:euphoria} {^run through:course through:building in} [his2] [penis2] and [his2]"
				else:
					penistext = "[name2] {^thrust:jerk}[s/2] [his2] hips forward and a {^thick :hot :}{^jet:load:batch} of"
				if scene.scene.code in ['handjob','titjob']:
					penistext += " {^sticky:white:hot} {^semen:seed:cum} {^sprays onto:shoots all over:covers} [names1] face[/s1] as [he2] ejaculate[s/2]."
				elif scene.scene.code == 'tailjob':
					penistext += " {^sticky:white:hot} {^semen:seed:cum} {^sprays onto:shoots all over:covers} [names1] tail[/s1] as [he2] ejaculate[s/2]."
				elif scene.scene.giverpart == '':
					penistext += " {^semen:seed:cum} {^pours onto:shoots onto:falls to} the {^ground:floor} as [he2] ejaculate[s/2]."
				elif ['anus','vagina','mouth'].has(scene.scene.giverpart):
					temptext = scene.scene.giverpart.replace('anus', '[anus1]').replace('vagina','[pussy1]')
					penistext += " {^semen:seed:cum} {^pours:shoots:pumps:sprays} into [names1] " + temptext + " as [he2] ejaculate[s/2]."
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
	if vaginatext != null:
		if anustext != null:
			if penistext != null:
				text = vaginatext + " " + anustext + " " + penistext
			else:
				text = vaginatext + " " + anustext
		elif penistext != null:
			text = vaginatext + " " + penistext
		else:
			text = vaginatext
	elif anustext != null:
		if penistext != null:
			text = anustext + " " + penistext
		else:
			text = anustext
	elif penistext != null:
		text = penistext
	#final default condition
	else:
		if randf() < 0.4:
			temptext = "[name2] feel[s/2] a {^sudden :intense ::}{^jolt of electricity:heat:wave of pleasure} and [his2]"
		else:
			temptext = "[names2]"
		temptext += " {^entire :whole :}body {^twists:quivers:writhes} in {^pleasure:euphoria:extacy} as [he2] reach[es/2] {^climax:orgasm}."
		text = decoder(temptext, null, [member])
	return "[color=#ff5df8]" + text + "[/color]"

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
		if action.scene.takerpart != '':
			i[action.scene.takerpart] = null
	ongoingactions.erase(action)
	rebuildparticipantslist()



func _on_passbutton_pressed():
	startscene(categories.other[0])

func _on_stopbutton_pressed():
	endencounter()

func endencounter():
	var mana = 0
	var totalmana = 0
	var text = ''
	for i in participants:
		i.person.lewdness = i.lewd
		i.person.lust = i.lust/10
		text += i.person.dictionary("$name: Orgasms - ") + str(i.orgasms) 
		if i.orgasms >= 1:
			if i.person.stats.maf_cur*20 > rand_range(0,100) && i.person.getessence() != null:
				text += ", Ingredient gained: [color=yellow]" + globals.itemdict[i.person.getessence()].name + "[/color]"
				globals.itemdict[i.person.getessence()].amount += 1
			mana += round(i.orgasms*3 + rand_range(1,2))
		else:
			mana += round(rand_range(1,2))
		if i.person.race == 'Dark Elf':
			mana = round(mana*1.2)
		if i.person.spec == 'nympho':
			mana += 2
		if i.person == globals.player:
			mana /= 2
		totalmana = mformula(mana, totalmana)
		text += "\n"
	totalmana = round(totalmana)
	text += "\nEarned mana: " + str(totalmana)
	
	globals.resources.mana += totalmana 
	
	get_node("Control").set_hidden(false)
	get_node("Control/Panel/RichTextLabel").set_bbcode(text)

func mformula(gain, mana):
    return mana + gain * max(0, mana/(mana-300)+1)


func _on_finishbutton_pressed():
	set_hidden(true)
	get_parent()._on_mansion_pressed()
