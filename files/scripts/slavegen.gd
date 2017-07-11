
extends Node


static func getRaceFunction(name):
	var text
	var temp
	var script = GDScript.new()
	temp = name
	if (temp.find('Beastkin ') >= 0 || temp.find('Halfkin') >= 0 || temp.find(' ') >= 0):
		temp = temp.replace('Beastkin ', '')
		temp = temp.replace('Halfkin ', '')
		temp = temp.replace(' ', '')
	text = 'var text2 = globals.races.Race' + temp + '()' 
	script.set_source_code(text)
	script.reload()
	var obj = Node.new()
	obj.set_script(script)
	text = obj.text2
	return text

static func newslave(race, age, sex, origins = 'slave'):
	var temp
	var temp2
	var slave = globals.slave.new()
	if race == 'randomcommon':
		race = globals.starting_pc_races[rand_range(0,globals.starting_pc_races.size())]
	elif race == 'randomany':
		race = globals.allracesarray[rand_range(0,globals.allracesarray.size())]
	if age == 'random':
		temp2 = ['child','teen','adult']
		age = temp2[rand_range(0,3)]
	if age == 'child' && globals.rules.children == false:
		temp2 = ['teen','adult']
		age = temp2[rand_range(0,2)]
	elif age == 'adult' && globals.rules.noadults == true:
		temp2 = ['child','teen']
		age = temp2[rand_range(0,2)]
	slave.race = race
	slave.age = age
	if globals.rules.children == false:
		slave.mindage = 'adult'
	else:
		slave.mindage = age
	slave.sex = sex
	if (slave.sex == 'random'):
		slave.sex = globals.assets.getRandomSex()
	slave.fetch(globals.assets.getRandomName(slave))
	slave.stats = {
		str_cur = 0,
		str_max = 0,
		str_mod = 0,
		str_base = 0,
		agi_cur = 0, 
		agi_max = 0,
		agi_mod = 0,
		agi_base = 0,
		maf_cur = 0,
		maf_max = 0,
		maf_mod = 0,
		maf_base = 0,
		end_base = 0,
		end_cur = 0,
		end_mod = 0,
		end_max = 0,
		cour_cur = 0,
		cour_max = 100,
		cour_base = rand_range(35,65),
		conf_cur = 0,
		conf_max = 100,
		conf_base = rand_range(35,65),
		wit_cur = 0,
		wit_max = 100,
		wit_base = rand_range(35,65),
		charm_cur = 0,
		charm_max = 100,
		charm_base = rand_range(35,65),
		obed_cur = 0,
		obed_max = 100,
		obed_min = 0,
		obed_mod = 0,
		stress_cur = 0,
		stress_max = 150,
		stress_min = 0,
		stress_mod = 0,
		dom_cur = rand_range(40,60),
		dom_max = 100,
		dom_min = 0,
		tox_cur = 0,
		tox_max = 100,
		tox_min = 0,
		lust_cur = 0,
		lust_max = 100,
		lust_min = 0,
		lust_mod = 0,
		health_cur = 0,
		health_max = 35,
		health_base = 35,
		energy_cur = 75,
		energy_max = 100,
		energy_mod = 0,
		armor_cur = 0,
		armor_max = 0,
		armor_base = 0,
		loyal_cur = 0,
		loyal_mod = 0,
		loyal_max = 100,
		loyal_min = 0,
	}
	slave.id = OS.get_unix_time() + OS.get_ticks_msec() + round(rand_range(0,100))
	slave.hairlength = globals.assets.getHairLengthBase(slave)
	slave.nickname = ''
	slave.fetch(getRaceFunction(race))
	temp = {
	face = {beauty = round(rand_range(1, 100)), appeal = round(rand_range(1,100))},
	relatives = {father = -1, mother = -1, siblings = [], children =[]},
	brand = 'none',
	preg = getPregnancy(slave['sex'], slave['age']),
	work = 'rest',
	ability = ['attack','protect'],
	abilityactive = ['attack','protect'],
	level = {xp=0, value=1, skillpoints = 1, skillpointsbought = 0},
	sleep = 'communal',
	hairstyle = globals.assets.getRandomHairStyle(slave),
	}
	slave.sexuals.actions.kiss = 0
	slave.sexuals.actions.massage = 0
	slave.fetch(temp)
	slave.fetch(globals.assets.getSexFeatures(slave))
	if slave.pussy.virgin == true:
		slave.pussy.first = 'none'
		if rand_range(0,1) >= 0.7:
			slave.sexuals.unlocks.append('petting')
			if rand_range(0,1) >= 0.5:
				slave.sexuals.unlocks.append('oral')
		
	elif slave.sex != 'male':
		slave.pussy.first = 'unknown'
		slave.sexuals.unlocks.append('petting')
		slave.sexuals.unlocks.append('vaginal')
		if rand_range(0,1) >= 0.5:
			slave.sexuals.unlocks.append('oral')
	if slave.race.find('Halfkin') >= 0 || (slave.race.find('Beastkin') >= 0 && globals.rules['furry'] == false):
		slave.race = slave.race.replace('Beastkin', 'Halfkin')
		slave.bodyshape = 'humanoid'
		slave.skincov = 'none'
		slave.arms = 'normal'
		slave.legs = 'normal'
		if rand_range(0,1) > 0.4:
			slave.eyeshape = 'normal'
	slave.origins = ''
	get_caste(slave, origins)
	getsexactions(slave)
#	var temp = ['cour_base', 'conf_base', 'wit_base', 'charm_base', 'str_base', 'agi_base', 'maf_base', 'end_base']
#	for i in temp:
#		temp2 = i.replace('_base', '_cur')
#		slave.stats[temp2] = slave.stats[i]
	slave.stats.health_max = 35 + slave.stats.end_cur*25
	slave.health = 100
	slave.memory = slave.origins
	if rand_range(0,100) < 5:
		var spec = globals.specarray[rand_range(0,globals.specarray.size())]
		globals.currentslave = slave
		if globals.evaluate(globals.jobs.specs[spec].reqs) == true:
			slave.spec = spec
#	for i in globals.specarray[rand_range(0,globals.specarray.size())]:
#		globals.currentslave = slave
#		var spec = globals.jobs.specs[i]
#		if globals.evaluate(i.reqs) == true:
#			slave.spec = globals.jobs.specs[i.code].code
	return slave

static func getsexactions(slave):
	var category
	for i in slave.sexuals.unlocks:
		category = globals.sexscenes.categories[i]
		for ii in category.actions:
			slave.sexuals.actions[ii] = 0


static func get_caste(slave, caste):
	var array = []
	var spin = 0
	slave.origins = caste
	if caste == 'slave':
		slave.cour -= rand_range(10,30)
		slave.conf -= rand_range(10,30)
		slave.wit -= rand_range(10,30)
		slave.charm -= rand_range(10,30)
		slave.face.beauty = rand_range(5,40)
		slave.stats.obed_mod = 25
		if rand_range(0,10) > 6:
			spin = 1
	elif caste == 'poor':
		slave.cour -= rand_range(5,15)
		slave.conf -= rand_range(5,15)
		slave.wit -= rand_range(5,15)
		slave.charm += rand_range(-5,15)
		slave.face.beauty = rand_range(10,50)
		if rand_range(0,10) > 4:
			spin = 2
	elif caste == 'commoner':
		slave.cour += rand_range(-5,15)
		slave.conf += rand_range(-5,15)
		slave.wit += rand_range(-5,15)
		slave.charm += rand_range(-5,20)
		slave.face.beauty = rand_range(25,65)
		spin = 3
	elif caste == 'rich':
		slave.cour += rand_range(5,20)
		slave.conf += rand_range(5,25)
		slave.wit += rand_range(5,20)
		slave.charm += rand_range(-5,15)
		slave.face.beauty = rand_range(35,75)
		slave.stats.obed_mod = -20
		spin = 4
	elif caste == 'noble':
		slave.cour += rand_range(10,30)
		slave.conf += rand_range(10,30)
		slave.wit += rand_range(10,30)
		slave.charm += rand_range(10,30)
		slave.face.beauty = rand_range(45,95)
		slave.stats.obed_mod = -40
		spin = 5
	while spin > 0:
		array = ['sstr','sagi','smaf','send']
		
		if rand_range(0,100) < 85:
			
			slave[array[rand_range(0, array.size())]] += 1
			spin -= 1
	slave.add_trait(globals.origins.traits('any'))
	if slave.traits.has("Fickle") == true:
		slave.sexuals.unlocks.append("swing")


static func getPregnancy(sex, age):
	var rval = {}
	rval.duration = 0
	rval.baby = ''
	if (sex == 'male'):
		rval['has_womb'] = false
		rval['fertility'] = 0
	else:
		rval['has_womb'] = true
		if (age == 'child'): 
			rval['fertility'] = 10
		else:
			rval['fertility'] = 20
	return rval