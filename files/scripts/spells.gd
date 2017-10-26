
extends Node

var slave
var main

func _init():
	globals.spelldict = spelllist

func spellsynchronize():
	for i in globals.state.spelllist:
		if i.learned == true:
			globals.spelldict[i].learned = true
			print('spellsynchroned')



var spelllist = {
mindread = {
	code = 'mindread',
	name = 'Mind Reading',
	description = 'Enhances your mind to be more cunning towards others. Allows to get accurate information about other characters. ',
	effect = 'mindreadeffect',
	manacost = 3,
	req = 0,
	price = 100,
	personal = true,
	combat = true,
	learned = false,
	type = 'control',
	flavor = "Reading other person's thoughts hardly worth the effort: way too often they are just chaotic streams changing one after another. Netherless, you can grasp some understanding how others think by devoting your time to them. ",
	},
sedation = {
	code = 'sedation',
	name = 'Sedation',
	description = "Eases target's stress and improves low obedience.",
	effect = 'sedationeffect',
	manacost = 10,
	req = 0,
	price = 200,
	personal = true,
	combat = true,
	learned = false,
	type = 'control',
	flavor = "Ability to calm down another person is invaluable in many situations. ",
	},
heal = {
	code = 'heal',
	name = 'Heal',
	description = 'Heals physical wounds. ',
	effect = 'healeffect',
	manacost = 10,
	req = 0,
	price = 200,
	personal = true,
	combat = true,
	learned = false,
	type = 'defensive',
	flavor = "Regeneration is a part of every living being.",
	},
dream = {
	code = 'dream',
	name = 'Dream',
	description = 'Puts target into deep, restful sleep. ',
	effect = 'dreameffect',
	manacost = 20,
	req = 0,
	price = 350,
	personal = true,
	combat = false,
	learned = false,
	type = 'control',
	},
entrancement = {
	code = 'entrancement',
	name = 'Entrancement',
	description = 'Makes target more susceptible to suggestions and easier to acquire various kinks.',
	effect = 'entrancementeffect',
	manacost = 15,
	req = 10,
	price = 400,
	personal = true,
	combat = false,
	learned = false,
	type = 'control',
	},
fear = {
	code = 'fear',
	name = 'Fear',
	description = 'Invokes subconscious feel of terror onto the targer. Can be effective punishment. ',
	effect = 'feareffect',
	manacost = 10,
	req = 0,
	price = 250,
	personal = true,
	combat = false,
	learned = false,
	type = 'control',
	},
domination = {
	code = 'domination',
	name = 'Domination',
	description = 'Attempts to overwhelm  the target′s mind and instill unwavering obedience. May cause irreversible mental trauma. ',
	effect = 'dominationeffect',
	manacost = 40,
	req = 10,
	price = 500,
	personal = true,
	combat = false,
	learned = false,
	type = 'control',
	},
mutate = {
	code = 'mutate',
	name = 'Mutation',
	description = 'Enforces mutation onto targe. Results may vary drastically. ',
	effect = 'mutateeffect',
	manacost = 15,
	req = 2,
	price = 400,
	personal = true,
	combat = false,
	learned = false,
	type = 'utility',
	},
barrier = {
	code = 'barrier',
	name = 'Barrier',
	description = "Creates a magical barrier around target, raising it's armor. ",
	effect = '',
	manacost = 12,
	req = 1,
	price = 200,
	personal = false,
	combat = true,
	learned = false,
	type = 'defensive',
	},
shackle = {
	code = 'shackle',
	name = 'Shackle',
	description = "Ties single target to ground making escape impossible. ",
	effect = '',
	manacost = 10,
	req = 1,
	price = 200,
	personal = false,
	combat = true,
	learned = false,
	type = 'utility',
	},
acidspit = {
	code = 'acidspit',
	name = 'Acid Spit',
	description = "Turns your saliva into highly potent corrosive substance for a short time. \nDeals spell damage to single target enemy and recudes it's armor. ",
	effect = '',
	manacost = 5,
	req = 2,
	price = 400,
	personal = false,
	combat = true,
	learned = false,
	type = 'offensive',
	},
mindblast = {
	code = 'mindblast',
	name = 'Mind Blast',
	description = "Simple mind attack which can be utilized in combat. While not terribly effective on its own, can eventually break the enemy. \nDeals spell damage to single target enemy. ",
	effect = '',
	manacost = 3,
	req = 1,
	price = 100,
	personal = false,
	combat = true,
	learned = false,
	type = 'offensive',
	},
invigorate = {
	code = 'invigorate',
	name = 'Invigorate',
	description = "Restores caster's and target's energy by using mana and target body's potential. Builds up target's stress. Can be used in wild. ",
	effect = 'invigorateeffect',
	manacost = 5,
	req = 2,
	price = 300,
	personal = true,
	combat = false,
	learned = false,
	type = 'utility',
	},
summontentacle = {
	code = 'summontentacle',
	name = 'Summon Tentacle',
	description = 'Summons naughty tentacles from the otherworld for a short time.',
	effect = 'tentacleeffect',
	manacost = 35,
	req = 10,
	price = 650,
	personal = true,
	combat = false,
	learned = false,
	type = 'utility',
	}
	}

func mindreadeffect():
	var spell = globals.spelldict.mindread
	var text = ''
	globals.resources.mana -= spell.manacost
	text = "You peer into $name's soul. $He is of " + slave.origins + " origins. \nObedience: " + str(round(slave.obed)) + ', Stress: '+ str(round(slave.stress)) + ', Loyalty: ' + str(round(slave.loyal)) + ', Lust: '+ str(round(slave.lust)) + ', Courage: ' + str(round(slave.cour)) + ', Confidence: ' + str(round(slave.conf)) + ', Wit: '+ str(round(slave.wit)) + ', Charm: ' + str(round(slave.charm)) + ", Toxicity: " + str(floor(slave.toxicity)) + ", Dominance: " + str(floor(slave.dom)) 
	text += "\nStrength: " + str(slave.sstr) + ", Agility: " + str(slave.sagi) + ", Magic Affinity: " + str(slave.smaf) + ", Endurance: " + str(slave.send)
	text += "\nBase Beauty: " + str(slave.beautybase) + ', Temporal Beauty: ' + str(slave.beautytemp)
	if slave.effects.has('captured') == true:
		text = text + "\n$name doesn't accept $his new life in your domain. Strength : " + str(slave.effects.captured.duration)
	if slave.praise > 0:
		text = text + '\n$name is still upbeat from you praising $him.'
	if slave.punish.expect == true:
		text = text + '\n$name still strongly fears your punishment.'
	if slave.traits.size() >= 0:
		text += '\n$name has corresponding traits:'
		for i in slave.traits.values():
			text += ' ' +i.name
		text += '.'
	if slave.preg.duration > 0:
		text += "\nPregnancy: " + str(slave.preg.duration)
	text = slave.dictionary(text)
	main.dialogue(true, self, text)

func sedationeffect():
	var spell = globals.spelldict.sedation
	globals.resources.mana -= spell.manacost
	if slave.effects.has('sedated'):
		main.popup(slave.dictionary("You cast Sedation spell on the $name but it appears $he is already under its effect. "))
		return
	slave.add_effect(globals.effectdict.sedated)
	slave.stress -= rand_range(20,30) + globals.player.smaf*6
	if slave.obed < 40:
		slave.obed += rand_range(20,30)
	main.popup(slave.dictionary('You cast Sedation spell on the $name and $he relaxes a bit.'))
	main.rebuild_slave_list()

func healeffect():
	var text = ''
	var spell = globals.spelldict.heal
	globals.resources.mana -= spell.manacost
	if slave.health < slave.stats.health_max:
		slave.health += rand_range(20,30) + globals.player.smaf*5
		if globals.player != slave:
			text = "After you finish casting the spell, $name's wounds close up. "
			if slave.loyal < 20:
				slave.loyal += rand_range(2,4)
				slave.obed += rand_range(10,15)
				text += '$He looks somewhat surprised at your kind treatment and grows bit closer to you. '
		else:
			text = "After you finish casting the healing spell, your wounds close up. "
	else:
		text = "It does not seems like $name was injured in first place. "
	main.popup(slave.dictionary(text))
	main.rebuild_slave_list()

func dreameffect():
	var text = ''
	var spell = globals.spelldict.dream
	globals.resources.mana -= spell.manacost
	slave.away.duration = 1
	slave.energy = slave.stats.energy_max
	slave.stress -= rand_range(25,50)
	text = 'You cast sleep on $name, putting $him into deep rest until the next day. '
	main.popup(slave.dictionary(text))
	main.rebuild_slave_list()


func invigorateeffect():
	var text = ''
	var spell = globals.spelldict.invigorate
	globals.resources.mana -= spell.manacost
	slave.energy += slave.stats.energy_max/2
	slave.stress += rand_range(25,35)-globals.player.smaf*4
	globals.player.energy += 50
	main.popup(slave.dictionary("You cast Invigorate on $name. Your and $his energy is partly restored. $His stress has increased. "))

func entrancementeffect():
	var text = ''
	var spell = globals.spelldict.entrancement
	var exists = false
	globals.resources.mana -= spell.manacost
	if slave.effects.has('entranced') == false:
		text = "Light gradually fades from $name's eyes, and $his gaze becomes downcast. $He seems ready to accept whatever you tell $him. "
		slave.add_effect(globals.effectdict.entranced)
	else:
		text = "It seems, $name is already entranced. "
	main.popup(slave.dictionary(text))

func feareffect():
	var text = "You grab hold of $name's shoulders and hold $his gaze. At first, $he’s calm, but the longer you stare into $his eyes, the more $he trembles in fear. Soon, panic takes over $his stare. "
	var spell = globals.spelldict.fear
	globals.resources.mana -= spell.manacost
	if slave.cour > 30 && rand_range(1,100) < 20:
		slave.cour -= rand_range(5,10)
	if slave.obed < 85 && slave.punish.expect == false:
		slave.obed += rand_range(25,50)
		text = text + "$name's looks changed considerably as your punishment made its point for $him."
		slave.punish.expect = true
		if slave.race == 'Human':
			slave.punish.strength = 10
		else:
			slave.punish.strength = 5
		slave.stress += rand_range(15,20)
		slave.loyal += -5
	elif slave.obed < 85 && slave.punish.expect == true:
		slave.obed += rand_range(35,70)
		text = text + "$name quickly excused $himself and begged for your forgiveness, realizing rightfulnes of your actions. "
		if slave.race == 'Human':
			slave.punish.strength = 10
		else:
			slave.punish.strength = 5
		slave.stress += rand_range(10,15)
	elif slave.obed >= 85:
		text = text + '$name reacts disturbingly to your punishment, as $he does not seems to believe $he offended you rightly.'
		slave.stress += 45
		slave.cour -= rand_range(5,10)
	if slave.effects.has('captured') == true:
		text += "\n[color=green]$name becomes less rebellious towards you.[/color]"
		slave.effects.captured.duration -= 1+globals.player.smaf
	main.popup(slave.dictionary(text))
	main.rebuild_slave_list()

func dominationeffect():
	var text = ''
	var spell = globals.spelldict.domination
	globals.resources.mana -= spell.manacost
	if rand_range(0,100) < 20 && globals.player.smaf < 5:
		text = "Your spell badly damages $name's mind as $he twiches and yells under its' effect."
		slave.cour -= rand_range(1,25)
		slave.conf -= rand_range(1,25)
		slave.wit -= rand_range(1,25)
		slave.charm -= rand_range(1,25)
	else:
		if slave.wit + slave.conf > rand_range(100,175):
			text = '$name managed to resist influence of your spell. $His disposition towards you worsened. '
			slave.loyal += -rand_range(15,25)
			slave.obed += -rand_range(25,50)
		else:
			text = 'Your spell greatly affected $name and $he became way more submissive towards you.  '
			slave.loyal += rand_range(25,50)
			slave.obed += 100
			if slave.effects.has('captured') == true:
				text += "\n[color=green]$name becomes less rebellious towards you.[/color]"
				slave.effects.captured.duration -= 3+(1*globals.player.smaf)
	main.popup(slave.dictionary(text))
	main.rebuild_slave_list()

func tentacleeffect():
	main.popup('This spell is WIP, Sorry.')

func sortspells(first, second):
	if first.name >= second.name:
		return false
	else:
		return true

func mutateeffect():
	globals.resources.mana -= spelllist.mutate.manacost
	mutate(2)
	get_parent().rebuild_slave_list()

func mutate(power=2, silent = false):
	var array = ['height','tits','ass','penis','balls','penistype','skin','skincov','eyecolor','eyeshape','haircolor','hairlength','ears','tail','wings','horns','beauty','lactation','nipples','lust','amnesia','pregnancy']
	var line
	var text = "Raw magic in $name's body causes $him to uncontrollably mutate. \n\n"
	var temp
	while power >= 1:
		slave.stress += rand_range(5,15)
		line = array[rand_range(0,array.size())]
		if line == 'height':
			text += "$name's height has changed. "
			slave.height = globals.heightarray[rand_range(0,globals.heightarray.size())]
		elif line == 'tits':
			text += "$name's chest size has changed. "
			slave.tits.size = globals.sizearray[rand_range(0,globals.sizearray.size())]
		elif line == 'ass':
			text += "$name's butt size has changed. "
			slave.ass = globals.sizearray[rand_range(0,globals.sizearray.size())]
		elif line == 'penis':
			if slave.penis.number < 1:
				slave.penis.number = 1
				slave.penis.size = 'small'
				text += "$name has grown a dick. "
			else:
				text += "$name's dick size has changed. "
				slave.penis.size = globals.genitaliaarray[rand_range(0,globals.genitaliaarray.size())]
		elif line == 'penistype':
			if slave.penis.number < 1:
				power += 1
			else:
				text += "$name's dick shape has changed. "
				slave.penis.type = globals.penistypearray[rand_range(0,globals.penistypearray.size())]
		elif line == "balls":
			if slave.balls == 'none':
				slave.balls = 'small'
				text += "$name has grown a scrotum. "
			else:
				slave.balls = globals.genitaliaarray[rand_range(0,globals.genitaliaarray.size())]
				text += "$name's scrotum size has changed. "
		elif line == 'skin':
			text += "$name's skin color has changed. "
			slave.skin = globals.assets.getRandomSkinColorAny()
		elif line == 'skincov':
			text += "$name's skin coverage has changed. "
			slave.skincov = globals.skincovarray[rand_range(0,globals.skincovarray.size())]
			slave.furcolor = globals.assets.getRandomFurColor()
		elif line == 'eyecolor':
			text += "$name's eye color has changed. "
			slave.eyecolor = globals.assets.getRandomAnyEyeColor()
		elif line == "eyeshape":
			text += "$name's pupil shape has changed. "
			if slave.eyeshape == 'normal':
				slave.eyeshape = 'slit'
			else:
				slave.eyeshape = 'normal'
		elif line == "haircolor":
			text += "$name's hair color has changed. "
			slave.haircolor = globals.assets.getRandomHairAnyColor()
		elif line == "hairlength":
			if globals.hairlengtharray.find(slave.hairlength) < 4:
				slave.hairlength = globals.hairlengtharray[globals.hairlengtharray.find(slave.hairlength) + 1]
				text += "$name's hair has grown. "
			else:
				power += 1 
		elif line == "horn":
			if slave.horns == 'none':
				text += "$name has grown a pair of horns. "
			else:
				text += "$name's horns have changed in shape. " 
			slave.horns = globals.assets.getRandomHorns()
		elif line == "tail":
			if slave.tail == 'none':
				text += "$name has grown a tail. "
			else:
				text += "$name's tail has changed in shape. " 
			slave.tail = globals.alltails[rand_range(0,globals.alltails.size())]
		elif line == "wings":
			if slave.wings == 'none':
				text += "$name has grown a pair of wings. "
			else:
				text += "$name's wings has changed in shape. " 
			slave.wings = globals.allwings[rand_range(0, globals.allwings.size())]
		elif line == "ears":
			text += "$name's ears shape has changed. "
			slave.ears = globals.allears[rand_range(0, globals.allears.size())]
		elif line == "beauty":
			text += "$name's face has drastically changed. "
			slave.beautybase = round(rand_range(10, 90))
		elif line == "lactation":
			if slave.tits.lactation == false:
				text += "$name's breats started secreting milk. "
				slave.tits.lactation = true
			else:
				power += 1
		elif line == "nipples":
			text += "Additional nipples has sprouted on $name's torse. "
			slave.tits.extrapairs = round(rand_range(1,4))
		elif line == "pregnancy":
			if slave.preg.has_womb == true:
				text += "It seems some new life has began in $name. "
				slave.preg.fertility = 100
				get_parent().impregnation(slave, null, true)
			else:
				power += 1
		elif line == "amnesia":
			text += "$name's cognitive abilities have worsened. "
			slave.wit -= rand_range(10,25)
		elif line == "lust":
			text += "$name's lust has greatly increased. "
			slave.lust = rand_range(40,80)
		power -= 1
	slave.toxicity = -rand_range(15,30)
	if silent == false:
		main.popup(slave.dictionary(text))
	else:
		return slave.dictionary(text)

