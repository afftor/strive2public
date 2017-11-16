extends Node

var givers
var takers


#For expressions in brackets: 1 refers to givers, 2 refers to takers and checks if groups consist of 1 or more persons to pick up correct references. 
#[name1] and [name2] build name lists of those parties, while [name] refers to specific person from any side (generally used in reactions)
#expressions without brackets tend to refer only to specific person and build their description or pronounce parts. [body] will try to add some random adjectives depending on character's traits.
#[his], [he] etc will be replaced with female pronouns if referred character is not male
#[his1] can be also replaced with their and will refer to group


func decoder(text, tempgivers = null, temptakers = null):
	if tempgivers != null: givers = tempgivers
	if temptakers != null: takers = temptakers
	if takers.size() == 0:
		takers = givers
	
	text = text.replace('[is1]', is(1)).replace('[is2]',is(2))
	text = text.replace('[has1]', has(1)).replace('[has2]',has(2))
	text = text.replace('[name1]', name(1)).replace('[name2]', name(2))
	text = text.replace('[names1]', names(1)).replace('[names2]', names(2))
	text = text.replace('[he1]', he(1)).replace('[he2]', he(2))
	text = text.replace('[him1]', him(1)).replace('[him2]', him(2))
	text = text.replace('[himself1]', himself(1)).replace('[himself2]', himself(2))
	text = text.replace('[his1]', his(1)).replace('[his2]', his(2))
	#these are for nouns, format is (single/multiple(group))
	text = text.replace('[y/ies1]', 'ies' if givers.size() >= 2 else 'y').replace('[y/ies2]', 'ies' if takers.size() >= 2 else 'y')
	text = text.replace('[/s1]', 's' if givers.size() >= 2 else '').replace('[/s2]', 's' if takers.size() >= 2 else '')
	text = text.replace('[/es1]', 'es' if givers.size() >= 2 else '').replace('[/es2]', 'es' if takers.size() >= 2 else '')
	text = text.replace('[a /1]', '' if givers.size() >= 2 else 'a ').replace('[a /2]', '' if takers.size() >= 2 else 'a ')
	text = text.replace('[it1]', 'them' if givers.size() >= 2 else 'it').replace('[it2]', 'them' if takers.size() >= 2 else 'it')
	#these are for verbs, format is (single/multiple(group))
	text = text.replace('[ies/y1]', 'y' if givers.size() >= 2 or givers[0].person == globals.player else 'y').replace('[ies/y2]', 'y' if takers.size() >= 2 or takers[0].person == globals.player else 'y')
	text = text.replace('[s/1]', '' if givers.size() >= 2 or givers[0].person == globals.player else 's').replace('[s/2]', '' if takers.size() >= 2 or takers[0].person == globals.player else 's')
	text = text.replace('[es/1]', '' if givers.size() >= 2 or givers[0].person == globals.player else 'es').replace('[es/2]', '' if takers.size() >= 2 or takers[0].person == globals.player else 'es')
	text = text.replace('[is1]', 'are' if givers.size() >= 2 or givers[0].person == globals.player else 'is').replace('[is2]', 'are' if takers.size() >= 2 or takers[0].person == globals.player else 'is')
	text = text.replace('[am1]', 'are' if givers.size() >= 2 or givers[0].person == globals.player else 'am').replace('[am2]', 'are' if takers.size() >= 2 or takers[0].person == globals.player else 'am')
	text = text.replace('[has1]', 'have' if givers.size() >= 2 or givers[0].person == globals.player else 'has').replace('[has2]', 'have' if takers.size() >= 2 or takers[0].person == globals.player else 'has')
	text = text.replace('[was1]', 'were' if givers.size() >= 2 or givers[0].person == globals.player else 'was').replace('[was2]', 'were' if takers.size() >= 2 or takers[0].person == globals.player else 'was')
	#body parts and character descriptions
	text = text.replace('[partner1]', partner(givers)).replace('[partner2]', partner(takers))
	text = text.replace('[partners1]', partners(givers)).replace('[partners2]', partners(takers))
	text = text.replace('[body1]', 'bodies' if givers.size() >= 2 else body(givers[0])).replace('[body2]', 'bodies' if takers.size() >= 2 else body(takers[0]))
	text = text.replace('[pussy1]', 'pussies' if givers.size() >= 2 else pussy(givers[0])).replace('[pussy2]', 'pussies' if takers.size() >= 2 else pussy(takers[0]))
	text = text.replace('[penis1]', penis(givers)).replace('[penis2]', penis(takers))
	text = text.replace('[labia1]', 'labia' if givers.size() >= 2 else labia(givers[0])).replace('[labia2]', 'labia' if takers.size() >= 2 else labia(takers[0]))
	text = text.replace('[ass1]', ass(givers)).replace('[ass2]', ass(takers))
	text = text.replace('[anus1]', 'anuses' if givers.size() >= 2 else anus(givers[0])).replace('[anus2]', 'anuses' if takers.size() >= 2 else anus(takers[0]))
	
	#split parse results
	text = splitrand(text)
	
	#handle capitalization
	text = capitallogic(text)
	
	return text

#choose randomly from str in {^str:str:str}
#does not support nesting
func splitrand(text):
	while text.find("{^") >= 0:
		var temptext = text.substr(text.find("{^"), text.find("}")+1 - text.find("{^"))
		text = text.replace(temptext, temptext.split(":")[rand_range(0, temptext.split(":").size())].replace("{^", "").replace("}",""))
	return text

#capitalize the first letter in text and those after strings in the array clookfor
#ignores flags inside "[" and "]"
func capitallogic(text):
	var clookfor = ["\n",". ","! "]
	var clookat = [0]
	var cplace
	for i in clookfor:
		cplace = 0
		while text.find(i, cplace) >= 0:
			clookat.append(text.find(i, cplace) + i.length())
			cplace = text.find(i, cplace + i.length() + 1)
	for i in clookat:
		if text.substr(i, 1) == "[":
				i = text.find("]", i) + 1
		if i < text.length():
			text = text.left(i) + text.substr(i, 1).to_upper() + text.right(i + 1)
	return text


func dictionary(member, text):
	if member.person == globals.player:
		text = text.replace('[name]', '[color=yellow]' + 'you' + '[/color]' if givers.find(member) >= 0 else '[color=aqua]' + 'you' + '[/color]')
	else:
		text = text.replace('[name]', '[color=yellow]' + member.name + '[/color]' if givers.find(member) >= 0 else '[color=aqua]' + member.name + '[/color]')
	if member.person == globals.player:
		text = text.replace('[his]', 'you')
	else:
		text = text.replace('[his]', 'his' if member.person.sex == 'male' else 'her')
	text = text.replace('[body]', body(member))
	return text


func is(group):
	group = getgroupfromnumber(group)
	if group.size() == 1 && group[0].person != globals.player:
		return 'is'
	else:
		return 'are'

func has(group):
	group = getgroupfromnumber(group)
	if group.size() == 1 && group[0].person != globals.player:
		return 'has'
	else:
		return 'have'

func he(group):
	group = getgroupfromnumber(group)
	for i in group:
		if i.person == globals.player:
			if group.size() == 1:
				return 'you'
			elif group.size() == 2:
				return '{^you both:you each}'
			else:
				return '{^you all:you each}'
	if group.size() == 1:
		if group[0].sex == 'male':
			return 'he'
		else:
			return 'she'
	elif group.size() == 2:
		return '{^they both:they}'
	else:
		return 'they'

func himself(group):
	group = getgroupfromnumber(group)
	for i in group:
		if i.person == globals.player:
			if group.size() == 1:
				return 'yourself'
			else:
				return 'yourselves'
	if group.size() == 1:
		if group[0].sex == 'male':
			return 'himself'
		else:
			return 'herself'
	else:
		return 'themselves'

func his(group):
	group = getgroupfromnumber(group)
	for i in group:
		if i.person == globals.player:
			return 'your'
	if group.size() == 1:
		if group[0].sex == 'male':
			return 'his'
		else:
			return 'her'
	else:
		return 'their'

func him(group):
	group = getgroupfromnumber(group)
	for i in group:
		if i.person == globals.player:
			if group.size() == 1:
				return 'you'
			elif group.size() == 2:
				return '{^you both:both of you}'
			else:
				return '{^you all:all of you}'
	if group.size() == 1:
		if group[0].sex == 'male':
			return 'him'
		else:
			return 'her'
	elif group.size() == 2:
		return '{^them both:them}'
	else:
		return 'them'

func name(group):
	group = getgroupfromnumber(group)
	var text = ''
	for i in group:
		if group == givers:
			text += '[color=yellow]'
			if i.person == globals.player:
				text += 'you'
			else:
				text += i.name
			text += '[/color]'
			if i != givers.back() && givers.find(i) != givers.size()-2:
				text += ', '
			elif givers.find(i) == givers.size()-2:
				text += ' and '
		else:
			text += '[color=aqua]'
			if i.person == globals.player:
				text += 'you'
			else:
				text += i.name
			text += '[/color]'
			if i != takers.back() && takers.find(i) != takers.size()-2:
				text += ', '
			elif takers.find(i) == takers.size()-2:
				text += ' and '
	return text

func names(group):
	group = getgroupfromnumber(group)
	var text = ''
	for i in group:
		if group == givers:
			text += '[color=yellow]'
			if i.person == globals.player:
				if group.size() == 1:
					text += 'your'
				else:
					text += 'you'
			else:
				text += i.name
			text += '[/color]'
			if i != givers.back() && givers.find(i) != givers.size()-2:
				text += ', '
			elif givers.find(i) == givers.size()-2:
				text += ' and '
		else:
			text += '[color=aqua]'
			if i.person == globals.player:
				if group.size() == 1:
					text += 'your'
				else:
					text += 'you'
			else:
				text += i.name
			text += '[/color]'
			if i != takers.back() && takers.find(i) != takers.size()-2:
				text += ', '
			elif takers.find(i) == takers.size()-2:
				text += ' and '
	if group.size() > 1 or (group.size() > 0 && group[0].person != globals.player):
		text += "'s"
	return text

#this could be added to the race dictionaries instead
const racenames = {
	Human = {
		single = "human",
		plural = "humans",
		singlepos = "human's",
		pluralpos = "humans'"
	},
	Elf = {
		single = "elf",
		plural = "elves",
		singlepos = "elf's",
		pluralpos = "elves'"
	},
	'Dark Elf' : {
		single = "elf",
		plural = "elves",
		singlepos = "elf's",
		pluralpos = "elves'"
	},
	Drow = {
		single = "elf",
		plural = "elves",
		singlepos = "elf's",
		pluralpos = "elves'"
	},
	Orc = {
		single = "orc",
		plural = "orcs",
		singlepos = "orc's",
		pluralpos = "orcs'"
	},
	Gnome = {
		single = "gnome",
		plural = "gnomes",
		singlepos = "gnome's",
		pluralpos = "gnomes'"
	},
	Goblin = {
		single = "goblin",
		plural = "goblins",
		singlepos = "goblin's",
		pluralpos = "goblins'"
	},
	Fairy = {
		single = "gnome",
		plural = "gnomes",
		singlepos = "gnome's",
		pluralpos = "gnomes'"
	},
	Seraph = {
		single = "seraph",
		plural = "seraphs",
		singlepos = "seraph's",
		pluralpos = "seraphs'"
	},
	Demon = {
		single = "demon",
		plural = "demon's",
		singlepos = "demon's",
		pluralpos = "demons'"
	},
	Dryad = {
		single = "dryad",
		plural = "dryads",
		singlepos = "dryad's",
		pluralpos = "dryads'"
	},
	Dragonkin = {
		single = "dragon",
		plural = "dragons",
		singlepos = "dragon's",
		pluralpos = "dragons'"
	},
	Taurus = {
		single = "taurus",
		plural = "tauruses",
		singlepos = "taurus'",
		pluralpos = "tauruses'"
	},
	Slime = {
		single = "slime",
		plural = "slimes",
		singlepos = "slime's",
		pluralpos = "slimes'"
	},
	Lamia = {
		single = "lamia",
		plural = "lamias",
		singlepos = "lamia's",
		pluralpos = "lamias'"
	},
	Harpy = {
		single = "harpy",
		plural = "harpies",
		singlepos = "harpy's",
		pluralpos = "harpies'"
	},
	Arachna = {
		single = "arachna",
		plural = "arachnas",
		singlepos = "arachna's",
		pluralpos = "arachnas'"
	},
	Centaur = {
		single = "centaur",
		plural = "centaurs",
		singlepos = "centaur's",
		pluralpos = "centaurs'"
	},
	Nereid = {
		single = "nereid",
		plural = "nereids",
		singlepos = "nereid's",
		pluralpos = "nereids'"
	},
	Scylla = {
		single = "scylla",
		plural = "scyllas",
		singlepos = "scylla's",
		pluralpos = "scyllas'"
	},
	"Beastkin Cat" : {
		single = "cat",
		plural = "cats",
		singlepos = "cat's",
		pluralpos = "cats'"
	},
	"Beastkin Fox" : {
		single = "fox",
		plural = "foxes",
		singlepos = "fox's",
		pluralpos = "foxes'"
	},
	"Beastkin Wolf" : {
		single = "wolf",
		plural = "wolves",
		singlepos = "wolf's",
		pluralpos = "wolves'"
	},
	"Beastkin Bunny" : {
		single = "bunny",
		plural = "bunnies",
		singlepos = "bunny's",
		pluralpos = "bunnies'"
	},
	"Beastkin Tanuki" : {
		single = "tanuki",
		plural = "tanukis",
		singlepos = "tanuki's",
		pluralpos = "tanukis'"
	},
	"Halfkin Cat" : {
		single = "cat",
		plural = "cats",
		singlepos = "cat's",
		pluralpos = "cats'"
	},
	"Halfkin Fox" : {
		single = "fox",
		plural = "foxes",
		singlepos = "fox's",
		pluralpos = "foxes'"
	},
	"Halfkin Wolf" : {
		single = "wolf",
		plural = "wolves",
		singlepos = "wolf's",
		pluralpos = "wolves'"
	},
	"Halfkin Bunny" : {
		single = "bunny",
		plural = "bunnies",
		singlepos = "bunny's",
		pluralpos = "bunnies'"
	},
	"Halfkin Tanuki" : {
		single = "tanuki",
		plural = "tanukis",
		singlepos = "tanuki's",
		pluralpos = "tanukis'"
	}
}


func partner(group):
	var array1 = []
	var array2 = []
	var marray1 = null
	var marray2 = null
	var tarray = []
	var boygirl = ''
	for i in group:
		if i.person == globals.player && group.size() == 1:
			return "you"
		var mp = i.person
		array1 = []
		array2 = []
		#age
		if mp.age == 'child':
			array1 += ["small","young","adolescent"]
			array2 += ["child"] if group.size() == 1 else ["children"]
		elif mp.age == 'teen':
			array1 += ['young','adolescent']
			array2 += ["teen"] if group.size() == 1 else ["teens"]
		else:
			array1 += ['mature', 'adult']
		#personality
		if mp.cour < 40:
			array1 += ['shy','meek']
		if mp.charm > 60:
			array1 += ['charming']
		if mp.wit > 80:
			array1 += ['clever']
		if mp.conf > 65:
			array1 += ['proud','haughty']
		if mp.height in ['petite','shortstack']:
			array1 += ["tiny","petite","small"]
		elif mp.height in ['tall', 'towering']:
			array1 += ["huge","tall","large"]
		if i.lust > 300:
			array1 += ['horny', 'excited']
		#boy/girl
		if mp.sex == 'male':
			boygirl = 'boy' if group.size() == 1 else 'boys'
		else:
			boygirl = 'girl' if group.size() == 1 else 'girls'
		array2 += [boygirl]
		#race
		for i in racenames:
			if i == mp.race:
				array2 += [racenames[i].single + ' ' + boygirl]
				if group.size() >= 2:
					array2 += [racenames[i].plural]
		#for multiple people, only incude shared
		if marray1 == null:
			marray1 = array1
			marray2 = array2
		else:
			tarray = [] + marray1
			for i in tarray:
				if not array1.has(i):
					marray1.erase(i)
			tarray = [] + marray2
			for i in tarray:
				if not array2.has(i):
					marray2.erase(i)
	#assures correct return values
	if marray1 == []:
		if marray2 == []:
			return "the diverse group"
		else:
			return "the " + getrandomfromarray(marray2)
	elif marray2 == []:
		return "the " + getrandomfromarray(marray1) + " group"
	else:
		return "the " + getrandomfromarray(marray1) + " " + getrandomfromarray(marray2)


func partners(group):
	var array1 = []
	var array2 = []
	var marray1 = null
	var marray2 = null
	var tarray = []
	var boygirl = ''
	for i in group:
		if i.person == globals.player && group.size() == 1:
			return "your"
		var mp = i.person
		array1 = []
		array2 = []
		#age
		if mp.age == 'child':
			array1 += ["small","young","adolescent"]
			array2 += ["child's"] if group.size() == 1 else ["childrens'"]
		elif mp.age == 'teen':
			array1 += ['young','adolescent']
			array2 += ["teen's"] if group.size() == 1 else ["teens'"]
		else:
			array1 += ['mature', 'adult']
		#personality
		if mp.cour < 40:
			array1 += ['shy','meek']
		if mp.charm > 60:
			array1 += ['charming']
		if mp.wit > 80:
			array1 += ['clever']
		if mp.conf > 65:
			array1 += ['proud','haughty']
		if mp.height in ['petite','shortstack']:
			array1 += ["tiny","petite","small"]
		elif mp.height in ['tall', 'towering']:
			array1 += ["huge","tall","large"]
		if i.lust > 300:
			array1 += ['horny', 'excited']
		#boy/girl
		if mp.sex == 'male':
			boygirl = "boy's" if group.size() == 1 else "boys'"
		else:
			boygirl = "girl's" if group.size() == 1 else "girls'"
		array2 += [boygirl]
		#race
		for i in racenames:
			if i == mp.race:
				array2 += [racenames[i].single + ' ' + boygirl]
				if group.size() >= 2:
					array2 += [racenames[i].pluralpos]
				else:
					array2 += [racenames[i].singlepos]
		#for multiple people, only incude shared
		if marray1 == null:
			marray1 = array1
			marray2 = array2
		else:
			tarray = [] + marray1
			for i in tarray:
				if not array1.has(i):
					marray1.erase(i)
			tarray = [] + marray2
			for i in tarray:
				if not array2.has(i):
					marray2.erase(i)
	#assures correct return values
	if marray1 == []:
		if marray2 == []:
			return "the diverse group's"
		else:
			return "the " + getrandomfromarray(marray2)
	elif marray2 == []:
		return "the " + getrandomfromarray(marray1) + " group's"
	else:
		return "the " + getrandomfromarray(marray1) + " " + getrandomfromarray(marray2)


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

func penis(group):
	var array1 = []
	var array2 = []
	var marray1 = null
	var marray2 = null
	var tarray = []
	for i in group:
		array1 = []
		array2 = ['cock','dick','penis'] if group.size() == 1 else ['cocks','dicks','penises']
		var mp = i.person
		#size/age descriptors
		if mp.penis == 'small':
			array1 += ["tiny","small","petite"]
			if mp.age == 'child':
				array1 += ["immature"]
		elif mp.penis == 'average':
			array1 += ["average-sized","decently-sized"]
			if mp.age == 'child':
				array1 += ["well-developed","adult-like"]
		elif mp.penis == 'big':
			array1 += ["big","sizeable","thick","girthy","impressively large"]
			if mp.age == 'child':
				array1 += ["overgrown","surprisingly large"]
		#penistype descriptors
		if mp.penistype == 'feline':
			array1 += ['barbed']
		elif mp.penistype == 'canine':
			array1 += ['knotted','tapered']
		elif mp.penistype == 'equine':
			array1 += ['flared','long']
			array2 += ['horse cock','horse dick']
		#other descriptors
		if mp.penis == 'none':
			array2 = ['strap-on','shaft'] if group.size() == 1 else ['strap-ons','shafts']
		elif mp.sex == 'male':
			array2 += ['manhood'] if group.size() == 1 else ['manhoods']
		elif mp.sex == 'futanari':
			array1 += ['futa']
		#for multiple people, only incude shared
		if marray1 == null:
			marray1 = array1
			marray2 = array2
		else:
			tarray = [] + marray1
			for i in tarray:
				if not array1.has(i):
					marray1.erase(i)
			tarray = [] + marray2
			for i in tarray:
				if not array2.has(i):
					marray2.erase(i)
	#50% of time do not use descriptors
	if  randf() < 0.5 || marray1 == []:
		return getrandomfromarray(marray2)
	else:
		return getrandomfromarray(marray1) + " " + getrandomfromarray(marray2)


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

func ass(group):
	var array1 = []
	var array2 = []
	var marray1 = null
	var marray2 = null
	var tarray = []
	for i in group:
		array1 = []
		array2 = ["ass","butt","backside","rear"] if group.size() == 1 else ["asses","butts","backsides","rears"]
		var mp = i.person
		#size/age descriptors
		if mp.asssize == 'flat':
			array1 += ["flat","compact"]
			if mp.age == 'teen':
				array1 += ["tiny","developing","child-like"]
			elif mp.age == 'child':
				array1 += ["tiny","developing","undeveloped","immature"]
		elif mp.asssize == 'small':
			array1 += ["small","compact"]
			if mp.age == 'teen':
				array1 += ["developing"]
			elif mp.age == 'child':
				array1 += ["undeveloped","immature"]
		elif mp.asssize == 'average':
			array1 += ["round","well-rounded","shapely"]
			if mp.age == 'teen':
				array1 += ["well-developed"]
			elif mp.age == 'child':
				array1 += ["well-developed","impressively large"]
		elif mp.asssize == 'big':
			array1 += ["big","sizeable","plump","hefty"]
			if mp.age == 'teen':
				array1 += ["well-developed","impressively large"]
			elif mp.age == 'child':
				array1 += ["overgrown","surprisingly large"]
		elif mp.asssize == 'huge':
			array1 += ["huge","massive","fat","meaty","gigantic","enormous"]
			if mp.age == 'teen':
				array1 += ["well-developed","surprisingly large"]
			elif mp.age == 'child':
				array1 += ["overgrown","shockingly large"]
		#bodytype descriptors
		if mp.bodyshape == 'jelly':
			array1 += ["gelatinous","slimy","gooey"]
		elif mp.bodyshape == 'halfhorse':
			array1 += ["equine","hairy"]
			array2 += ["hindquarters"]
		elif mp.bodyshape == 'halfspider':
			array1 += ["chitinous","spider"]
			array2 = ["abdomen","butt"] if group.size() == 1 else ["abdomens","butts"]
		elif mp.skincov == 'full_body_fur':
			array1 += ["furry","hairy"]
		#beauty descriptors
		if mp.beauty_get() >= 50:
			if mp.age == 'child':
				array1 += ["cute","cute","flawless","perfect"]
			elif mp.age == 'teen':
				array1 += ["cute","beautiful","flawless","perfect"]
			else:
				array1 += ["seductive","beautiful","flawless","perfect"]
		#for multiple people, only incude shared
		if marray1 == null:
			marray1 = array1
			marray2 = array2
		else:
			tarray = [] + marray1
			for i in tarray:
				if not array1.has(i):
					marray1.erase(i)
			tarray = [] + marray2
			for i in tarray:
				if not array2.has(i):
					marray2.erase(i)
	#30% of time do not use descriptors
	if  randf() < 0.3 || marray1 == []:
		return getrandomfromarray(marray2)
	else:
		return getrandomfromarray(marray1) + " " + getrandomfromarray(marray2)

func anus(member):
	var array = []
	var array2 = ["anus","asshole","butthole","rectum"]
	if member.person.assvirgin == true:
		array += ["virgin","virginal","unused"]
	if member.person.age != 'adult':
		array += ["pink","youthful"]
	else:
		array += ["rosy","mature"]
	return getrandomfromarray(array) + " " + getrandomfromarray(array2)


func getgroupfromnumber(number):
	if number == 1:
		return givers
	else:
		return takers

func getrandomfromarray(array):
	if array != []:
		return array[rand_range(0, array.size())]
	else:
		print("empty array passed to getrandomfromarray(array)")
		return ""