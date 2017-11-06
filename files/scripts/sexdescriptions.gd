extends Node

var givers
var takers


#For expressions in brackets: 1 refers to givers, 2 refers to takers and checks if groups consist of 1 or more persons to pick up correct references. 
#[name1] and [name2] build name lists of those parties, while [name] refers to specific person from any side (generally used in reactions)
#expressions without brackets tend to refer only to specific person and build their description or pronounce parts. [body] will try to add some random adjectives depending on character's traits.
#[his], [he] etc will be replaced with female pronouns if referred character is not male
#[his1] can be also replaced with their and will refer to group


func decoder(text, tempgivers = null, temptakers = null):
	var reg = RegEx.new()
	if tempgivers != null: givers = tempgivers
	if temptakers != null: takers = temptakers
	if takers.size() == 0:
		takers = givers
	text = text.replace('[is1]', is(1)).replace('[is2]',is(2))
	text = text.replace('[has1]', has(1)).replace('[has2]',has(2))
	text = text.replace('[name1]', names(1)).replace('[name2]', names(2))
	text = text.replace('[he1]', he(1)).replace('[he]', he(2))
	text = text.replace('[him1]', him(1)).replace('[him2]', him(2))
	text = text.replace('[his1]', his(1)).replace('[his2]', his(2))
	text = text.replace('[%1y]', 'y' if givers.size() == 1 else 'ies').replace('[%2y]', 'y' if takers.size() == 1 else 'ies')
	text = text.replace('[%1s]', 's' if givers.size() == 1 else '').replace('[%2s]', 's' if takers.size() == 1 else '')
	text = text.replace('[%1es]', 'es' if givers.size() == 1 else '').replace('[%2es]', 'es' if takers.size() == 1 else '')
	
	text = text.replace('[partner1]', partner(givers[0])).replace('[partner2]', partner(takers[0]))
	text = text.replace('[body1]', body(givers[0])).replace('[body2]', body(takers[0]))
	text = text.replace('[pussy1]', pussy(givers[0])).replace('[pussy2]', pussy(takers[0]))
	text = text.replace('[penis1]', penis(givers[0])).replace('[penis2]', penis(takers[0]))
	text = text.replace('[labia1]', labia(givers[0])).replace('[labia2]', labia(takers[0]))
	text = text.replace('[ass1]', ass(givers[0])).replace('[ass2]', ass(takers[0]))
	text = text.replace('[anus1]', anus(givers[0])).replace('[anus2]', anus(takers[0]))
	
	#checkrepeats
	while text.find("{^") >= 0:
		var temptext = text.substr(text.find("{^"), text.find("}")+1 - text.find("{^"))
		text = text.replace(temptext, temptext.split(":")[rand_range(0, temptext.split(":").size())].replace("{^", "").replace("}",""))
	return text

func dictionary(member, text):
	text = text.replace('[name]', '[color=yellow]' + member.name + '[/color]' if givers.find(member) >= 0 else '[color=aqua]' + member.name + '[/color]')
	text = text.replace('[his]', 'his' if member.person.sex == 'male' else 'her')
	text = text.replace('[body]', body(member))
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

func he(group):
	group = getgroupfromnumber(group)
	if group.size() == 1:
		if group[0].sex == 'male':
			return 'he'
		else:
			return 'she'
	else:
		return 'they'

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

func partner(member):
	var array = []
	var array2 = []
	var person = member.person
	if person.age == 'child':
		array += ["small","young","adolescent"]
	elif person.age == 'teen':
		array += ['young','adolescent']
	else:
		array += ['mature', 'adult']
	
	if person.cour < 40:
		array += ['shy','meek']
	if person.charm > 60:
		array += ['charming']
	if person.wit > 80:
		array += ['clever']
	if person.conf > 65:
		array += ['proud','haughty']
	if person.height in ['petite','shortstack']:
		array += ["tiny", "petite"]
	if member.lust > 300:
		array += ['horny', 'excited']
	
	if person.sex == 'male':
		array2 += ['boy']
	else:
		array2 += ['girl']
	if person.race.find('Beastkin') >= 0 || person.race.find('Halfkin') >= 0:
		array2.append(person.race.replace("Beastkin ", '').replace("Halfkin ", '').to_lower() + person.dictionary(' $child')) 
	elif person.race == 'Dragonkin':
		array2.append('dragon' + person.dictionary(' $child'))
	elif person.race in ['Drow','Dark Elf']:
		array2.append('elf' + person.dictionary(' $child'))
	elif person.race in ['Human','Goblin','Gnome','Orc','Lamia','Arachna','Slime','Demon']:
		array2.append(person.race.to_lower() + person.dictionary(' $child'))
	
	
	return getrandomfromarray(array) + " " + getrandomfromarray(array2)



func body(member):
	var array = []
	var person = member.person
	if person.age == 'child':
		array += ["small", "petite", "slender", "dainty"]
	elif person.height in ['shortstack','petite']:
		array += ["small","petite","shorty"]
	if person.age in ['adult','teen']:
		array += ["well-rounded","voluptuous","seductive","curvaceous","shapely"]
	if person.bodyshape == 'jelly':
		array += ["transparent", "jelly", "gelatinous"]
	elif person.bodyshape == 'halfhorse':
		array += ["equine"]
	elif person.bodyshape == "halfspider":
		array += ["arachnid"]
	if person.skincov == 'full_body_fur':
		array += ["furry","fluffy","fur-covered"]
	#add later# array += ["sexy","seductive","lovely","erotic","alluring","captivating","enticing"]
	
	return getrandomfromarray(array) + ' body'

func penis(member):
	var array = ['cock','dick','shaft','manhood']
	if member.person.penis == 'none':
		array = ['strap-on']
	return getrandomfromarray(array)


func pussy(member):
	var array = []
	var array2 = ["vagina","pussy","cunt","slit"]
	var person = member.person
	if person.vagvirgin == true:
		array += ["virgin","virginal","unused"]
	if person.pubichair == 'clean':
		if person.age == 'child':
			array += ["smooth","hairless","pubeless","bald"]
		else:
			array += ["smoothly shaved","hairless","pubeless","shaved"]
	if person.age == 'child':
		array += ["childish","immature","undeveloped"]
	elif person.age == 'teen':
		array += ["girlish","youthful","undeveloped"]
	else:
		array += ["womanly","mature","developed"]
	
	
	return getrandomfromarray(array) + " " + getrandomfromarray(array2)

func labia(member):
	var array = ["labia","pussy lips","genitals","folds"]
	return getrandomfromarray(array)

func ass(member):
	var array = ["ass","butt","backside","rear"]
	return getrandomfromarray(array)

func anus(member):
	var array = []
	if member.person.assvirgin == true:
		array += ["virgin","virginal","unused"]
	if member.person.age != 'adult':
		array += ["pink","youthful","developing"]
	else:
		array += ["rosy","mature","developed"]
	var array2 = ["anus","asshole","butthole","rectum"]
	return getrandomfromarray(array) + " " + getrandomfromarray(array2)


func getgroupfromnumber(number):
	if number == 1:
		return givers
	else:
		return takers

func getrandomfromarray(array):
	return array[rand_range(0, array.size())]