extends Node

var participants = []
var givers = []
var takers = []
var turns
var actions = []

var selectedcategory = 'caress'
var categories = {caress = [], fucking = [], tools = [], SM = [], humiliation = [], other = []}


func _ready():
	for i in globals.dir_contents('res://files/scripts/actions'):
		var newaction = load(i).new()
		categories[newaction.category].append(newaction)
	for i in get_node("Panel/HBoxContainer").get_children():
		i.connect("pressed",self,'changecategory',[i.get_name()])
	
	turns = 20
	var i = 5
	while i > 0 :
		i -= 1
		var slave = globals.newslave(getrandomfromarray(globals.allracesarray), 'random', 'female')
		var newmember = member.new()
		newmember.person = slave
		newmember.sex = slave.sex
		newmember.name = slave.name_short()
		participants.append(newmember)
	changecategory('caress')
	rebuildparticipantslist()


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
		if givers.find(i) >= 0:
			newnode.get_node("give").set_pressed(true)
		elif takers.find(i) >= 0:
			newnode.get_node("take").set_pressed(true)
		newnode.set_meta("slave", i)
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
	get_node("Panel/sceneeffects1").set_bbcode(text)


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

func startscene(scenescript):
	scenescript.givers = givers
	scenescript.takers = takers
	var text = decoder(scenescript.initiate())
	if scenescript.has_method('reaction'):
		for i in takers:
			text += '\n' + decoder(dictionary(i, scenescript.reaction(i)))
	get_node("Panel/sceneeffects").set_bbcode(text)


class member:
	var name
	var person
	var mood
	var submission
	var loyalty
	var lust = 0
	var sens
	var lube = 0
	var role
	var sex
	
	var energy = 100
	
	var knowledge
	
	var caress = 0
	var mouth = 0
	var boobs = 0
	var pussy = 0
	var ass = 0
	var cock = 0
	var clit = 0
	
func dictionary(member, text):
	text = text.replace('[name]', '[color=yellow]' + member.name + '[/color]' if givers.find(member) >= 0 else '[color=aqua]' + member.name + '[/color]')
	text = text.replace('[his]', 'his' if member.person.sex == 'male' else 'her')
	text = text.replace('[body]', body(member))
	return text


#For expressions in brackets: 1 refers to givers, 2 refers to takers and checks if groups consist of 1 or more persons to pick up correct references. 
#[name1] and [name2] build name lists of those parties, while [name] refers to specific person from any side (generally used in reactions)
#expressions without brackets tend to refer only to specific person and build their description or pronounce parts. [body] will try to add some random adjectives depending on character's traits.
#[his], [he] etc will be replaced with female pronouns if referred character is not male
#[his1] can be also replaced with their and will refer to group

func decoder(text):
	var reg = RegEx.new()
	text = text.replace('[is1]', is(1)).replace('[is2]',is(2))
	text = text.replace('[has1]', has(1)).replace('[has2]',has(2))
	text = text.replace('[name1]', names(1)).replace('[name2]', names(2))
	text = text.replace('[him1]', him(1)).replace('[him2]', him(2))
	text = text.replace('[his1]', his(1)).replace('[his2]', his(2))
	text = text.replace('[%1y]', 'y' if givers.size() == 1 else 'ies').replace('[%2y]', 'y' if takers.size() == 1 else 'ies')
	text = text.replace('[%1s]', 's' if givers.size() == 1 else '').replace('[%2s]', 's' if takers.size() == 1 else '')
	text = text.replace('[%1es]', 'es' if givers.size() == 1 else '').replace('[%2es]', 'es' if takers.size() == 1 else '')
	
	#experimental
	text = text.replace('[body1]', body(givers[0])).replace('[body2]', body(takers[0]))
	
	return text


func is(group):
	group = getgroupfromnumber(group)
	if group.size() == 1:
		return 'is'
	else:
		return 'are'

func has(group):
	group = getgroupfromnumber(group)
	if group.size() == 1:
		return 'has'
	else:
		return 'have'

func his(group):
	group = getgroupfromnumber(group)
	if group.size() == 1:
		if group[0].sex == 'male':
			return 'his'
		else:
			return 'her'
	else:
		return 'their'

func him(group):
	group = getgroupfromnumber(group)
	if group.size() == 1:
		if group[0].sex == 'male':
			return 'him'
		else:
			return 'her'
	else:
		return 'their'

func names(group):
	group = getgroupfromnumber(group)
	var text = ''
	for i in group:
		if group == givers:
			text += '[color=yellow]' + i.name + '[/color]'
			if i != givers.back() && givers.find(i) != givers.size()-2:
				text += ', '
			elif givers.find(i) == givers.size()-2:
				text += " and "
		else:
			text += '[color=aqua]' + i.name + '[/color]'
			if i != takers.back() && takers.find(i) != takers.size()-2:
				text += ', '
			elif takers.find(i) == takers.size()-2:
				text += " and "
	#text = text.substr(0, text.length() -2)+ ''
	return text


func body(member):
	var array = ['']
	var person = member.person
	if person.age == 'child':
		array += ["small", "petite", "slender", "dainty"]
	elif person.height in ['shortstack','petite']:
		array += ["small","petite","shorty"]
	if person.age in ['adult','teen']:
		array += ["well-rounded","voluptuous","seductive","curvaceous","shapely"]
	#add later# array += ["sexy","seductive","lovely","erotic","alluring","captivating","enticing"]
	
	return getrandomfromarray(array) + ' body'

func getgroupfromnumber(number):
	if number == 1:
		return givers
	else:
		return takers

func getrandomfromarray(array):
	return array[rand_range(0, array.size())]