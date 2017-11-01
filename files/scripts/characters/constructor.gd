extends Node

var slave

func getrandomsex(slave):
	if globals.rules.male_chance > 0 && rand_range(0, 100) < globals.rules.male_chance:
		slave.sex = 'male'
	elif rand_range(0, 100) < globals.rules.futa_chance && globals.rules.futa == true:
		slave.sex = 'futanari'
	else:
		slave.sex = 'female'

func getage(age):
	var temp
	var agearray = ['teen']
	if globals.rules.children == true:
		agearray.append('child')
	if globals.rules.noadults == false:
		agearray.append('adult')
	if age == 'random' || agearray.find(age) < 0:
		age = agearray[rand_range(0,agearray.size())]
	return age

func newslave(race, age, sex, origins = 'slave'):
	var temp
	var temp2
	var slave = globals.slave.new()
	if race == 'randomcommon':
		race = globals.starting_pc_races[rand_range(0,globals.starting_pc_races.size())]
	elif race == 'randomany':
		race = globals.allracesarray[rand_range(0,globals.allracesarray.size())]
	slave.race = race
	slave.age = getage(age)
	slave.mindage = slave.age
	slave.sex = sex
	if slave.sex == 'random': getrandomsex(slave)
	for i in ['cour_base','conf_base','wit_base','charm_base']:
		slave.stats[i] = rand_range(35,65)
	slave.stats.dom_cur = rand_range(40,60)
	slave.id = OS.get_unix_time() + OS.get_ticks_msec() + round(rand_range(0,100))
	changerace(slave, 'Human')
	changerace(slave)
	slave.work = 'rest'
	slave.sleep = 'communal'
	slave.sexuals.actions.kiss = 0
	slave.sexuals.actions.massage = 0
	globals.assets.getsexfeatures(slave)
	if slave.race.find('Halfkin') >= 0 || (slave.race.find('Beastkin') >= 0 && globals.rules.furry == false):
		slave.race = slave.race.replace('Beastkin', 'Halfkin')
		slave.bodyshape = 'humanoid'
		slave.skincov = 'none'
		slave.arms = 'normal'
		slave.legs = 'normal'
		if rand_range(0,1) > 0.4:
			slave.eyeshape = 'normal'
	get_caste(slave, origins)
	for i in slave.sexuals.unlocks:
		var category = globals.sexscenes.categories[i]
		for ii in category.actions:
			slave.sexuals.actions[ii] = 0
	slave.memory = slave.origins
	slave.masternoun = globals.state.defaultmasternoun
	if rand_range(0,100) < 5:
		var spec = globals.specarray[rand_range(0,globals.specarray.size())]
		globals.currentslave = slave
		if globals.evaluate(globals.jobs.specs[spec].reqs) == true:
			slave.spec = spec
	slave.health = 100
	return slave

func changerace(slave, race = null):
	var races = globals.races
	var slaverace
	if race == null:
		slaverace = slave.race.replace('Halfkin','Beastkin')
	else:
		slaverace = race
	for i in races[slaverace]:
		if i in ['description', 'details']:
			continue
		if typeof(races[slaverace][i]) == TYPE_ARRAY:
			slave[i] = races[slaverace][i][rand_range(0,races[slaverace][i].size())]
		elif typeof(races[slaverace][i]) == TYPE_DICTIONARY:
			for k in (races[slaverace][i]):
				slave[i][k] = races[slaverace][i][k]
		else:
			slave[i] = races[slaverace][i]
	

func get_caste(slave, caste):
	var array = []
	var spin = 0
	slave.origins = caste
	if caste == 'slave':
		slave.cour -= rand_range(10,30)
		slave.conf -= rand_range(10,30)
		slave.wit -= rand_range(10,30)
		slave.charm -= rand_range(10,30)
		slave.beautybase = rand_range(5,40)
		slave.stats.obed_mod = 25
		if rand_range(0,10) >= 9:
			slave.level += 1
	elif caste == 'poor':
		slave.cour -= rand_range(5,15)
		slave.conf -= rand_range(5,15)
		slave.wit -= rand_range(5,15)
		slave.charm += rand_range(-5,15)
		slave.beautybase = rand_range(10,50)
		if rand_range(0,10) >= 8:
			slave.level += round(rand_range(0,2))
	elif caste == 'commoner':
		slave.cour += rand_range(-5,15)
		slave.conf += rand_range(-5,15)
		slave.wit += rand_range(-5,15)
		slave.charm += rand_range(-5,20)
		slave.beautybase = rand_range(25,65)
		if rand_range(0,10) >= 7:
			slave.level += round(rand_range(0,2))
	elif caste == 'rich':
		slave.cour += rand_range(5,20)
		slave.conf += rand_range(5,25)
		slave.wit += rand_range(5,20)
		slave.charm += rand_range(-5,15)
		slave.beautybase = rand_range(35,75)
		slave.stats.obed_mod = -20
		if rand_range(0,10) >= 5:
			slave.level += round(rand_range(0,3))
	elif caste == 'noble':
		slave.cour += rand_range(10,30)
		slave.conf += rand_range(10,30)
		slave.wit += rand_range(10,30)
		slave.charm += rand_range(10,30)
		slave.beautybase = rand_range(45,95)
		slave.stats.obed_mod = -40
		if rand_range(0,10) >= 4:
			slave.level += round(rand_range(0,3))
	
	slave.skillpoints += (slave.level-1)*3
	spin = slave.skillpoints
	array = ['sstr','sagi','smaf','send']
	while spin > 0:
		var temp = array[rand_range(0, array.size())]
		if rand_range(0,100) < 50 && slave[temp] < slave.stats[globals.maxstatdict[temp]]:
			slave[temp] += 1
			slave.skillpoints -= 1
		spin -= 1
	
	slave.add_trait(globals.origins.traits('any').name)
	if slave.traits.find("Fickle") >= 0:
		slave.sexuals.unlocks.append("swing")

func tohalfkin(slave):
	slave.legs = 'normal'
	slave.arms = 'normal'
	slave.skincov = 'none'
	slave.bodyshape = 'humanoid'