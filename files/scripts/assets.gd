
extends Node

 


static func getRandomName(slave):
	if slave.race == 'Human':
		slave.surname = getRandomHumanSurname()
		if slave.sex != 'male':
			slave.name = getRandomHumanFName()
		else:
			slave.name = getRandomHumanMName()
	elif slave.race == 'Elf'|| slave.race == 'Dark Elf' || slave.race == 'Drow':
		if slave.sex != 'male':
			slave.name = getRandomFElfName()
		else:
			slave.name = getRandomMElfName()
		slave.surname = getRandomElfSurname()
	elif slave.race.find('Beastkin') >= 0 || (slave.race.find('Halfkin') >= 0 && rand_range(0,1) > 0.6) :
		if slave.sex != 'male':
			slave.name = getRandomHumanFName()
		else:
			slave.name = getRandomHumanMName()
		slave.surname = getRandomFurrySurname()
	elif slave.race == 'Orc'|| slave.race == 'Goblin':
		if slave.sex != 'male':
			slave.name = getRandomFOrcName()
		else:
			slave.name = getRandomMOrcName()
		slave.surname = getRandomOrcSurname()
	elif slave.race == 'Demon':
		if slave.sex != 'male':
			slave.name = getRandomFDemonName()
		else:
			slave.name = getRandomMDemonName()
		slave.surname = getRandomHumanSurname()
	else:
		if slave.sex != 'male':
			slave.name = getRandomHumanFName()
		else:
			slave.name = getRandomHumanMName()
		slave.surname = getRandomHumanSurname()


func getrandomage():
	var text = []
	if globals.rules.children == true:
		text.append('child')
	
	if globals.rules.teens == true:
		text.append('teen')
	
	if globals.rules.adults == true:
		text.append('adult')
	
	return getrandomfromarray(text)


func getsexfeatures(slave):
	var temp
	var dick = false
	var pussy = false
	if slave.race.find("Beastkin") >= 0 && globals.rules.furrynipples == true:
		slave.titsextra = 3
	if slave.sex == 'male':
		dick = true
		if slave.age == 'child':
			temp = ['flat']
		else:
			temp = ['flat','masculine']
		slave.asssize = getrandomfromarray(temp)
		slave.titssize = getrandomfromarray(temp)
	else:
		pussy = true
		if slave.sex == 'futanari':
			dick = true
		if slave.age == 'child':
			temp = ['flat','flat','small','small','small','average']
		elif slave.age == 'teen':
			temp = ['flat','small','small','average','average','big']
		else:
			temp = ['flat','small','average','big','huge']
		slave.asssize = getrandomfromarray(temp)
		slave.titssize = getrandomfromarray(temp)
	if dick == true:
		if slave.age in ['child','teen']:
			temp = ['small','average']
		else:
			temp = ['small','average','big']
		slave.penis = getrandomfromarray(temp)
		if slave.sex == 'male' || globals.rules.futaballs == true:
			slave.balls = getrandomfromarray(temp)
		else:
			slave.balls = 'none'
	else:
		slave.penis = 'none'
		slave.balls = 'none'
	if pussy == true:
		slave.vagina = 'normal'
	else:
		slave.vagina = 'none'
		slave.preg.has_womb = false
	
	if slave.penis != 'none' && slave.race.find('Beastkin') >= 0:
		if slave.race.find('Cat') >= 0:
			slave.penistype = 'feline'
		elif slave.race.find('Fox') >= 0 || slave.race.find('Wolf') >= 0:
			slave.penistype = 'canine'
	if slave.penis != 'none' && slave.race.find('Centaur') >= 0:
		slave.penistype = 'equine'
	getheight(slave)
	gethair(slave)
	getname(slave)

func getname(slave):
	var text = slave.race.to_lower()+slave.sex.replace("futanari",'female')
	if !globals.racefile.names.has(text):
		text = 'human'+slave.sex.replace("futanari",'female')
	slave.name = getrandomfromarray(globals.names[text])

func getheight(slave):
	if slave.bodyshape == 'shortstack':
		slave.height = 'tiny'
	else:
		if slave.age == 'child':
			slave.height = getrandomfromarray(['petite', 'short'])
		elif slave.age == 'teen':
			slave.height = getrandomfromarray(['petite', 'short', 'average', 'tall'])
		else:
			slave.height = getrandomfromarray(['short', 'average', 'tall', 'towering'])

func gethair(slave):
	if slave.sex == 'male':
		slave.hairlength = getrandomfromarray(['ear','ear','ear','neck','neck','shoulder'])
		slave.hairstyle = getrandomfromarray(['straight', 'straight', 'straight', 'straight', 'ponytail'])
	else:
		if slave.age == 'child':
			slave.hairlength = getrandomfromarray(['ear','neck','shoulder'])
		elif slave.age == 'teen':
			slave.hairlength = getrandomfromarray(['ear','neck','shoulder','waist'])
		else:
			slave.hairlength = getrandomfromarray(['ear','neck','shoulder','waist','hips'])
		
		if slave.hairlength != 'short' && rand_range(0,10) < 6:
			slave.hairstyle = getrandomfromarray(['ponytail', 'twintails', 'braid', 'two braids', 'bun'])
		else:
			slave.hairstyle = 'straight'

func getrandomfromarray(array):
	return array[rand_range(0,array.size())]






