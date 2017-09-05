extends Node

var textnode = load('res://files/scripts/questtext.gd').new()
var emilystate = 0
var outside
#Mainquests


func gornpalace():
	var text = ''
	var state = true
	var buttons = []
	var sprite = null
	if globals.state.mainquest == 12:
		text = textnode.MainQuestGornPalace
		state = true
		globals.state.mainquest = 13
	elif globals.state.mainquest == 13:
		text = "You decide there's no point to return to Garthor withour bringing Ivran with you. "
	elif globals.state.mainquest == 14:
		text = "Garthor already told you to return tomorrow."
	elif globals.state.mainquest == 15:
		text = textnode.MainQuestGornPalaceReturn
		buttons = [['Execute','gornpalaceivran', 1],['Keep imprisoned','gornpalaceivran', 2],['Leave him to you','gornpalaceivran', 3],['Decide later','gornpalaceivran', 4]]
		state = false
	
	globals.get_tree().get_current_scene().dialogue(state, self, text, buttons, sprite)

var ivran

func gornpalaceivran(stage):
	var text
	var state = true
	var buttons = []
	var sprite = null
	
	if stage == 1:
		text = textnode.MainQuestGornIvranExecute + textnode.MainQuestGornAydaSolo
		globals.state.sidequests.ivran = 'killed'
		globals.state.mainquest = 16
		globals.get_tree().get_current_scene().get_node("explorationnode").zoneenter('gorn')
	elif stage == 2:
		text = textnode.MainQuestGornIvranImprison + textnode.MainQuestGornAydaSolo
		globals.state.sidequests.ivran = 'imprisoned'
		globals.state.mainquest = 16
		globals.get_tree().get_current_scene().get_node("explorationnode").zoneenter('gorn')
	elif stage == 3 && !globals.state.sidequests.ivran in ['tobetaken','tobealtered','potionreceived']:
		text = textnode.MainQuestGornIvranKeep
		globals.state.sidequests.ivran = 'tobetaken'
		globals.get_tree().get_current_scene().get_node("explorationnode").zoneenter('gorn')
	elif stage == 3 && globals.state.sidequests.ivran in ['tobetaken','tobealtered']:
		text = "Garthor refuses to give you Ivran as is. You should find his acquaintance. "
	elif stage == 3 && globals.state.sidequests.ivran == 'potionreceived':
		text = textnode.MainQuestGornIvranChange
		globals.state.sidequests.ivran = 'changed'
		globals.state.mainquest = 16
		ivran = globals.slavegen.newslave('Dark Elf', 'adult', 'female', 'rich')
		ivran.name = 'Ivran'
		ivran.surname = ''
		ivran.beauty = 75
		ivran.haircolor = 'brown'
		ivran.hairlength = 'shoulder'
		ivran.hairstyle = 'straight'
		ivran.tits.size = 'big'
		ivran.ass = 'average'
		ivran.skin = 'brown'
		ivran.eyecolor = 'amber'
		ivran.pussy.virgin = true
		ivran.pussy.first = 'none'
		ivran.stats.cour_base = 65
		ivran.stats.conf_base = 83
		ivran.stats.wit_base = 55
		ivran.stats.charm_base = 48
		ivran.height = 'tall'
		ivran.loyal = 0
		ivran.obed = 50
		ivran.stress = 60
		ivran.unique = 'Ivran'
		ivran.cleartraits()
		for i in ivran.skills.values():
			i.value = 0
		globals.get_tree().get_current_scene()._on_mansion_pressed()
		buttons = [['Continue','ivranname']]
		state = false
	elif stage == 4:
		globals.get_tree().get_current_scene().close_dialogue()
		return
	
	globals.get_tree().get_current_scene().dialogue(state, self, text, buttons, sprite)

func ivranname():
	globals.get_tree().get_current_scene().setname(ivran)
	globals.get_tree().get_current_scene().close_dialogue()
	
	globals.slaves = ivran



func gornivran():
	var text = textnode.MainQuestGornIvranFind
	var sprite
	var buttons = [['Attack','gornivranfight'],['Leave','gornivranleave']]
	globals.get_tree().get_current_scene().get_node("explorationnode").buildenemies("ivranquestenemy")
	globals.get_tree().get_current_scene().dialogue(false, self, text, buttons, sprite)

func gornivranfight():
	globals.get_tree().get_current_scene().close_dialogue()
	globals.get_tree().get_current_scene().get_node("explorationnode").launchonwin = 'gornivranwin'
	globals.get_tree().get_current_scene().get_node("combat").nocaptures = true
	globals.get_tree().get_current_scene().get_node("explorationnode").enemyfight()

func gornivranleave():
	globals.get_tree().get_current_scene().close_dialogue()

func gornivranwin():
	var text 
	var sprite
	var buttons = []
	text = textnode.MainQuestGornIvranWin
	globals.state.sidequests.ivran = ''
	globals.state.upcomingevents.append(({code = 'gornwaitday', duration = 1}))
	globals.state.mainquest = 14
	globals.get_tree().get_current_scene().get_node("explorationnode").zoneenter('gorn')
	globals.get_tree().get_current_scene().dialogue(true, self, text, buttons, sprite)

func gornwaitday():
	globals.state.mainquest = 15

func gornayda():
	var text = ''
	var state = true
	var sprite
	var buttons = []
	if globals.state.mainquest == 15 && !globals.state.sidequests.ivran in ['tobealtered','potionreceived']:
		text = textnode.MainQuestGornAydaIvran
		state = false
		buttons = [{name = 'Accept', function = 'gornaydaivran', args = 1}, {name = 'Reject',function = 'gornaydaivran', args = 2}]
	elif globals.state.mainquest == 15 && globals.state.sidequests.ivran == 'tobealtered':
		text = "Ayda asked you to provide her with someone of high magic affinity. "
		buttons = [{name = 'Select', function = 'gornaydaselect'}]
	else:
		if globals.state.sidequests.ayda == 0:
			text = textnode.MainQuestGornAydaFirstMeet
			globals.state.sidequests.ayda = 1
		else:
			text = textnode.GornAydaReturn
		if globals.state.sidequests.ayda == 1:
			buttons.append({name = 'Ask Ayda about herself', function = 'gornaydatalk', args = 1})
		elif globals.state.sidequests.ayda == 2:
			buttons.append({name = 'Ask Ayda about monster races',function = 'gornaydatalk', args = 2})

		elif globals.state.sidequests.ayda >= 3:
			buttons.append({name = "See Ayda's assortments", function = 'aydashop'})
	if globals.state.sidequests.yris == 4:
		buttons.append({name = "Ask about the found ointment", function = "gornaydatalk", args = 3})
	if state == true:
		buttons.append({name = "Leave", function = 'leaveayda'})
	outside.maintext.set_bbcode(globals.player.dictionary(text))
	outside.buildbuttons(buttons, self)

func leaveayda():
	globals.get_tree().get_current_scene().get_node("explorationnode").zoneenter('gorn')

func aydashop():
	outside.shopinitiate("aydashop")

func gornaydatalk(stage = 0):
	var text = ''
	var sprite
	var buttons = []
	
	if stage == 1:
		text = textnode.GornAydaTalk
		globals.state.sidequests.ayda = 2
	elif stage == 2:
		text = textnode.GornAydaTalkMonsters
		globals.state.sidequests.ayda = 3
	elif stage == 3:
		text = textnode.GornYrisAydaReport
		globals.state.sidequests.yris += 1
	
	buttons.append({name = "Continue", function = "gornayda"})
	
	outside.maintext.set_bbcode(globals.player.dictionary(text))
	outside.buildbuttons(buttons, self)


func gornaydaselect(slave = null):
	var text
	var state = true
	var sprite
	var buttons = []
	if slave == null:
		globals.get_tree().get_current_scene().selectslavelist(true, 'gornaydaselect', self, 'globals.currentslave.stats.maf_cur >= 4')
	else:
		text = textnode.MainQuestGornAydaIvranReturn
		globals.state.sidequests.ayda = 1
		slave.away.duration = 15
		slave.away.at = 'away'
		globals.state.sidequests.ivran = 'potionreceived'
		buttons.append({name = "Continue", function = "gornayda"})
		outside.maintext.set_bbcode(globals.player.dictionary(text))
		outside.buildbuttons(buttons, self)
		#globals.get_tree().get_current_scene().dialogue(state, self, text, buttons, sprite)
	

func gornaydaivran(stage = 0):
	var text
	var sprite
	var buttons = []
	var state = true
	if stage == 0:
		text = textnode.MainQuestGornAydaIvran
		state = false
		buttons = [['Accept','gornaydaivran',1], ['Reject','gornaydainvran',2]]
	elif stage == 1:
		text = textnode.MainQuestGornAydaIvranAccept
		globals.state.sidequests.ivran = 'tobealtered'
	elif stage == 2:
		text = textnode.MainQuestGornAydaIvranReject
	
	buttons.append({name = "Continue", function = "gornayda"})
	outside.maintext.set_bbcode(globals.player.dictionary(text))
	outside.buildbuttons(buttons, self)
	#globals.get_tree().get_current_scene().dialogue(state, self, text, buttons, sprite)


func undercitybosswin():
	var reward
	var text = ''
	var rewarddict = ['armorplate']
	reward = rewarddict[rand_range(0,rewarddict.size())]
	reward = globals.get_tree().get_current_scene().get_node("itemnode").createunstackable(reward)
	globals.state.unstackables[str(reward.id)] = reward
	if globals.state.mainquest == 24:
		text += "After defeating the awoken golem, you spend some time searching around, until one of the piles reveals an ancient looking documents. Being unable to read them due to magical protection and unknown language, you decide to bring it back to Melissa.\n\n[color=yellow]There might be some additional treasures, but you'd have to come for them next time. [/color] "
		globals.state.mainquest = 25
	else:
		pass
	if globals.state.lorefound.find('amberguardlog3') < 0:
		globals.state.lorefound.append('amberguardlog3')
		text += "[color=yellow]\n\nYou've found some old writings in the ruins. Does not look like what you came for, but you can read them later.[/color]"
	globals.get_tree().get_current_scene().get_node("explorationnode").zoneenter('undercityruins')
	text += "\n[color=green]After searching through the building ruins you managed to find 1 [color=aqua]" + reward.name + "[/color]. [/color]"
	globals.get_tree().get_current_scene().popup(text)

func frostfordcityhall(stage = 0):
	var text 
	var state = true
	var sprite
	var buttons = []
	if globals.state.sidequests.has('zoe') == false:
		globals.state.sidequests.zoe = 0
	if stage == 0:
		if globals.state.mainquest == 28:
			text = textnode.MainQuestFrostfordCityhall
			globals.state.mainquest = 28.1
		elif globals.state.mainquest == 29:
			text = textnode.MainQuestFrostfordCityhallReturn
			globals.state.mainquest = 30
			if globals.state.reputation.frostford >= 20:
				state = false
				buttons.append({text = "Continue", function = "frostfordcityhall", args = 1})
		elif globals.state.mainquest == 30:
			text = textnode.MainQuestFrostfordCityhallReturn2
			if globals.state.sidequests.zoe == 0:
				text += "\n\n[color=yellow]You might discover new way to solve this if your Frostford reputation will get better.[/color]"
			state = false
			buttons.append({text = "Fire Theron", function = 'frostfordcityhall', args = 5})
			buttons.append({text = "Leave", function = 'frostfordcityhall', args = 4})
		elif globals.state.mainquest == 31:
			text = textnode.MainQuestFrostfordTheronZoeReturn
			globals.state.mainquest = 32
		elif globals.state.mainquest == 33:
			text = textnode.MainQuestFrostfordZoeAliveReturn
			state = false
			buttons.append({text = "Invite Zoe to join you", function = "frostfordcityhall", args = 7})
			buttons.append({text = "Say her goodbye", function = "frostfordcityhall", args = 8})
			globals.state.decisions.append("zoesaved")
			globals.state.mainquest = 36
			if globals.state.decisions.find('zoeselfsacrifice') >= 0:
				text += "[color=aqua]When you offered your life for me... that was very unexpected, and I wish I could pay you back some day."
		elif globals.state.mainquest == 34:
			text = textnode.MainQuestFrostfordZoeDeadReturn
			globals.state.decisions.append("zoedied")
			globals.state.mainquest = 36
		elif globals.state.mainquest == 35:
			text = textnode.MainQuestFrostfordForestWinReturn
			globals.state.decisions.append("dryaddefeated")
			globals.state.mainquest = 36
	elif stage == 1:
		text = textnode.MainQuestFrostfordCityhallZoe
		state = false
		globals.charactergallery.zoe.unlocked = true
		buttons.append({text = 'Accept', function = "frostfordcityhall", args = 2})
		buttons.append({text = 'Refuse', function = "frostfordcityhall", args = 3})
	elif stage == 2:
		text = textnode.MainQuestFrostfordCityhallZoeAccept
		globals.state.sidequests.zoe = 1
	elif stage == 3:
		text = textnode.MainQuestFrostfordCityhallZoeRefuse
		globals.state.sidequests.zoe = 100
	elif stage == 4:
		globals.get_tree().get_current_scene().close_dialogue()
		return
	elif stage == 5:
		text = textnode.MainQuestFrostfordCityhallFireTheron
		state = false
		buttons.append({text = "Continue", function = "frostfordcityhall", args = 6})
	elif stage == 6:
		text = textnode.MainQuestFrostfordCityhallFireTheron2
		state = true
		globals.state.decisions.append("theronfired")
		globals.resources.day += 1
		globals.state.mainquest = 36
	elif stage == 7:
		text = textnode.MainQuestFrostfordZoeJoin
		var slave = zoemake()
		globals.slaves = slave
	elif stage == 8:
		text = textnode.MainQuestFrostfordZoeLeave
	globals.get_tree().get_current_scene().get_node("explorationnode").zoneenter('frostford')
	globals.get_tree().get_current_scene().dialogue(state, self, text, buttons, sprite)

func frostforddryad():
	var text 
	var sprite
	var state = true
	var buttons = []
	if globals.state.mainquest == 28.1:
		text = textnode.MainQuestFrostfordForest
		globals.state.mainquest = 29
	elif globals.state.mainquest == 30:
		if globals.state.sidequests.zoe < 1 || globals.state.sidequests.zoe == 100:
			text = textnode.MainQuestFrostfordForestReturn
			if globals.state.sidequests.zoe == 0:
				text += "\n\n[color=yellow]You might discover new way to solve this if your Frostford reputation will get better.[/color]"
			state = true
			buttons.append({text = "Fight", function = 'dryadfight', args = 0})
		else:
			text = textnode.MainQuestFrostfordForestReturnWithZoe
			state = false
			buttons.append({text = 'Continue', function = "frostforddryadzoe", args = 0})
	elif globals.state.mainquest == 32:
		if globals.itemdict.natureessenceing.amount >= 15 && globals.itemdict.fluidsubstanceing.amount >= 5 && globals.resources.food >= 500:
			globals.itemdict.natureessenceing.amount -= 15
			globals.itemdict.fluidsubstanceing.amount -= 5
			globals.resources.food -= 500
			text = textnode.MainQuestFrostfordForestReturnZoe
			buttons.append({text = "Fight", function = 'dryadfight', args = 2})
			state = false
		else:
			text = "You don't have everything Zoe asked you to bring. "
	globals.get_tree().get_current_scene().get_node("explorationnode").zoneenter('frostfordoutskirts')
	globals.get_tree().get_current_scene().dialogue(state, self, text, buttons, sprite)

func frostforddryadzoe(stage = 0):
	var text 
	var sprite
	var state = true
	var buttons = []
	if stage == 0:
		text = textnode.MainQuestFrostfordForestReturnWithZoe2
		globals.state.mainquest = 31
	globals.get_tree().get_current_scene().dialogue(state, self, text, buttons, sprite)

func dryadfight(stage = 0):
	var text 
	var sprite
	var buttons = []
	if stage == 0:
		text = textnode.MainQuestFrostfordForestFight
		buttons.append({text = "Continue", function = 'dryadfight', args = 1})
		globals.get_tree().get_current_scene().dialogue(false, self, text, buttons, sprite)
	elif stage == 1:
		globals.get_tree().get_current_scene().close_dialogue()
		globals.get_tree().get_current_scene().get_node("explorationnode").buildenemies("frostforddryadquest")
		globals.get_tree().get_current_scene().get_node("explorationnode").launchonwin = 'dryadfightwin'
		globals.get_tree().get_current_scene().get_node("combat").nocaptures = true
		globals.get_tree().get_current_scene().get_node("explorationnode").enemyfight()
	elif stage == 2:
		globals.get_tree().get_current_scene().close_dialogue()
		globals.get_tree().get_current_scene().get_node("explorationnode").buildenemies("frostfordzoequest")
		globals.get_tree().get_current_scene().get_node("explorationnode").launchonwin = 'zoefightwin'
		globals.get_tree().get_current_scene().get_node("combat").nocaptures = true
		globals.get_tree().get_current_scene().get_node("explorationnode").enemyfight()
		

func dryadfightwin():
	var text  = ''
	var sprite
	var buttons = []
	text = textnode.MainQuestFrostfordForestWin
	globals.state.mainquest = 35
	globals.get_tree().get_current_scene().get_node("explorationnode").zoneenter('frostfordoutskirts')
	globals.get_tree().get_current_scene().dialogue(true, self, text, buttons, sprite)

func zoefightwin(stage = 0):
	var state = false
	var text  = ''
	var sprite
	var buttons = []
	text = textnode.MainQuestFrostfordForestReturnZoeWin
	globals.get_tree().get_current_scene().get_node("explorationnode").zoneenter('frostfordoutskirts')
	buttons.append({text = "Select party member", function = 'zoechooseslave', args = null})
	buttons.append({text = "Refuse", function = "zoerefusehelp", args = 0})
	globals.get_tree().get_current_scene().dialogue(state, self, text, buttons, sprite)

func zoechooseslave(slave = null):
	var state = false
	var text  = ''
	var sprite
	var buttons = []
	text = textnode.MainQuestFrostfordForestReturnZoeWin
	if slave == null:
		globals.get_tree().get_current_scene().selectslavelist(false, 'zoechooseslave', self, 'true', true, true)
	else:
		if slave == globals.player:
			buttons.append({text = "Sacrifice self", function = 'zoesacrifice', args = slave})
		else:
			buttons.append({text = "Sacrifice " + slave.name_short(), function = 'zoesacrifice', args = slave})
	buttons.append({text = "Select party member", function = 'zoechooseslave', args = null})
	buttons.append({text = "Refuse", function = "zoerefusehelp", args = 0})
	globals.get_tree().get_current_scene().dialogue(state, self, text, buttons, sprite)

func zoerefusehelp(stage = 0):
	var state = true
	var text = textnode.MainQuestFrostfordZoeDie
	var sprite
	var buttons = []
	text += "\n\n" + textnode.MainQuestFrostfordZoeHostage
	
	globals.state.mainquest = 34
	globals.get_tree().get_current_scene().dialogue(state, self, text, buttons, sprite)

func zoesacrifice(slave):
	var state = true
	var text  = ''
	var sprite
	var buttons = []
	var condition
	var zoealive = false
	if slave == globals.player:
		condition = 'self'
		globals.state.decisions.append('zoeselfsacrifice')
		zoealive = true
	else:
		if slave.send + slave.smaf < 6:
			condition = 'bad'
		elif slave.send + slave.smaf < 8:
			condition = 'medium'
		else:
			condition = 'strong' 
	if condition == 'self':
		text = textnode.MainQuestFrostfordZoeSelf
	elif condition == 'bad':
		text = textnode.MainQuestFrostfordZoeWeak
	elif condition == 'medium':
		text = textnode.MainQuestFrostfordZoeMed
		zoealive = true
	elif condition == 'strong':
		text = textnode.MainQuestFrostfordZoeStrong
		zoealive = true
	
	if zoealive == true:
		globals.state.mainquest = 33
		text += textnode.MainQuestFrostfordZoeAlive
	else:
		globals.state.mainquest = 34
	
	text = slave.dictionary(text) + "\n\n" + textnode.MainQuestFrostfordZoeHostage
	globals.get_tree().get_current_scene().dialogue(state, self, text, buttons, sprite)


func zoemake():
	var slave = globals.slavegen.newslave('Beastkin Wolf', 'teen', 'female', 'noble')
	slave.name = 'Zoe'
	slave.surname = ''
	slave.beauty = 45
	slave.haircolor = 'brown'
	slave.hairlength = 'shoulder'
	slave.hairstyle = 'straight'
	slave.tits.size = 'average'
	slave.ass = 'average'
	slave.skin = 'fair'
	slave.eyecolor = 'red'
	slave.pussy.virgin = true
	slave.pussy.first = 'none'
	slave.stats.cour_base = 45
	slave.stats.conf_base = 55
	slave.stats.wit_base = 87
	slave.stats.charm_base = 66
	slave.height = 'average'
	slave.furcolor = 'gray'
	slave.obed = 90
	slave.loyal = 25
	slave.sexuals.unlocks = []
	slave.cleartraits()
	slave.smaf += 1
	return slave

#Sidequests

func calievent1():
	var cali = null
	for i in globals.slaves:
		if i.unique == 'Cali':
			cali = i
	if cali == null:
		globals.state.sidequests.cali = 100
	elif (cali.stress >= 65 && cali.loyal < 25) || cali.obed < 30:
		if cali.sleep == 'jail' || cali.sleep == 'farm' || cali.brand == 'advanced':
			cali.cour = rand_range(5,15)
			cali.conf = rand_range(5,15)
			cali.wit = rand_range(5,15)
			cali.charm = rand_range(5,15)
			globals.get_tree().get_current_scene().dialogue(true,self,'Unable to escape, Cali breaks down by harsh living conditions. It does not seem like she has any interest in looking for her family anymore. ')
			globals.state.sidequests.cali = 101
		else:
			globals.get_tree().get_current_scene().dialogue(true,self,'Unable to bear with your treatment, Cali escaped from mansion.')
			globals.slaves.erase(cali)
			globals.state.sidequests.cali = 100
	else:
		globals.state.sidequests.cali = 13
		return '\n[color=yellow]Cali seems to be concerned about something, maybe you should ask what’s wrong.[/color]'

func calirun():
	var cali = null
	for i in globals.slaves:
		if i.unique == 'Cali':
			cali = i
	globals.slaves.erase(cali)
	globals.get_tree().get_current_scene().dialogue(true,self,'During the night Cali has escaped from the mansion in unknown direction.')

func calitalk0():
	var sprite = [['calineutral','pos1', 'opac']]
	var text
	var buttons = null
	var cali
	var state = true

	for i in globals.slaves:
		if i.unique == "Cali":
			cali = i

	if globals.state.sidequests.cali == 13:
		cali.tags.append('noescape')
		text = textnode.CaliTalkRequest
		buttons = [['Offer to look into it','calitalk1',1],['Dismiss her concerns','calitalk1',2]]
	elif globals.state.sidequests.cali == 12:
		cali.tags.append('noescape')
		text = textnode.CaliTalkHelp
		globals.state.sidequests.cali = 14
	elif globals.state.sidequests.cali == 22:
		text = textnode.CaliTalk2
		buttons = [['Take her with you','calitalk2',1],['Decline her offer','calitalk2',2]]
	if buttons != null:
		state = false
	
	globals.get_tree().get_current_scene().dialogue(state, self, text, buttons, sprite)

func calitalk1(response): # 1 - agree, 2 - refuse
	var sprite
	if response == 1:
		globals.state.sidequests.cali = 14
		sprite = [['calihappy','pos1']]
		for i in globals.slaves:
			if i.unique == 'Cali':
				i.loyal += 10
		globals.get_tree().get_current_scene().dialogue(true,self, textnode.CaliTalkAccept, null, sprite)
	elif response == 2:
		globals.state.sidequests.cali = 100
		sprite = [['calineutral','pos1']]
		globals.get_tree().get_current_scene().dialogue(true,self, textnode.CaliTalkRefuse, null, sprite)
		globals.state.upcomingevents.append({code = 'calirun', duration = 1})

func calitalk2(response): # 1 - accept, 2 - refuse
	var sprite
	if response == 1:
		globals.state.sidequests.cali = 23
		sprite = [['calihappy','pos1']]
		globals.get_tree().get_current_scene().dialogue(true,self, textnode.CaliTalk2Accept, null, sprite)
	elif response == 2:
		sprite = [['calineutral','pos1']]
		globals.state.sidequests.cali = 24
		globals.get_tree().get_current_scene().dialogue(true,self, textnode.CaliTalk2Refuse, null, sprite)

func caliproposal(stage = 0):
	var sprite = [['calineutral','pos1', 'opac']]
	var text
	var buttons = null
	var cali
	var state = true
	for i in globals.slaves:
		if i.unique == 'Cali':
			cali = i
	if cali == null:
		globals.state.sidequests.cali = 100
		return
	if cali.pussy.virgin == false || cali.loyal <= 50:
		return
	if cali.away.duration != 0:
		globals.state.upcomingevents.append({code = 'caliproposal', duration = cali.away.duration})
	
	if stage == 0:
		text = textnode.CaliProposal
		buttons = [["Accept Cali's feelings",'caliproposal',1],['Stay friends','caliproposal',2]]
		state = false
	elif stage == 1:
		sprite = [['calinakedhappy','pos1']]
		text = textnode.CaliAcceptProposal
		globals.charactergallery.cali.scenes[0].unlocked = true
		globals.charactergallery.cali.nakedunlocked = true
		if globals.player.penis.number >= 1:
			cali.pussy.virgin = false
			cali.pussy.first = 'you'
			cali.sexuals.unlocks.append("vaginal")
			cali.metrics.vag += 1
			text += textnode.CaliProposalSexMale
		cali.loyal += 25
		cali.obed += 50
		cali.sexuals.unlocked = true
		cali.metrics.sex += 1
		cali.metrics.orgasm += 1
		cali.metrics.partners.append(globals.player.id)
		cali.unlocksexuals()
	elif stage == 2:
		sprite = [['calineutral','pos1']]
		text = textnode.CaliDenyProposal



	globals.get_tree().get_current_scene().dialogue(state, self, text, buttons, sprite)

func calibar():
	var buttons = []
	var text = ''
	var sprite
	if globals.state.sidequests.cali == 14:
		sprite = [['calineutral','pos1', 'opac']]
		text = textnode.CaliBarEntrance
		globals.state.sidequests.calibarsex = 'none'
		globals.state.sidequests.cali = 15
	elif globals.state.sidequests.cali == 15:
		sprite = [['calineutral','pos1']]
		text = textnode.CaliBarRepeat
	elif globals.state.sidequests.cali == 16:
		sprite = [['calineutral','pos1']]
		text = textnode.CaliBarLastpay
	if !globals.state.sidequests.calibarsex in ['disliked','liked','sebastianfinish'] && globals.resources.gold >= 500:
		buttons.append(['Pay 500 gold for information', 'calibar1', 1])
	if !globals.state.sidequests.calibarsex in ['disliked','liked','agreed','forced','sebastianfinish']:
		buttons.append(['Talk to Cali', 'calibar1', 2])
	if globals.state.sidequests.calibarsex in ['disliked','liked','sebastianfinish'] && globals.resources.gold >= 100:
		buttons.append(['Pay 100 gold for information', 'calibar1', 3])
	if globals.state.sidequests.calibarsex == 'sebastian':
		buttons.append(["Show Jason Sebastian's note", 'calibar1', 9])
	if globals.state.sidequests.calibarsex in ['agreed','forced']:
		buttons.append(['Let him fuck Cali', 'calibar1',5])
	if globals.state.sidequests.cali == 17:
		sprite = [['calineutral','pos1']]
		text = textnode.CaliBarLeave
		globals.get_tree().get_current_scene().dialogue(true, self, text, buttons, sprite)
		return
	buttons.append(['Excuse yourself and leave', 'calibar1', 4])

	globals.get_tree().get_current_scene().dialogue(false,self, text, buttons, sprite)

func calibar1(value):
	var cali = null
	for i in globals.slaves:
		if i.unique == 'Cali':
			cali = i
	var buttons = []
	var text = ''
	var sprite = [['calineutral','pos1']]
	if value == 1:
		globals.resources.gold -= 500
		text = textnode.CaliBarPay500
		globals.state.sidequests.cali = 17
		buttons.append(['Leave', 'calibar1', 4])
	elif value == 2:
		text = textnode.CaliBarTalk
		buttons.append(["Tell her it's the only way", 'calibar1', 6])
		if globals.state.sidequests.calibarsex != 'reject':
			text += "\n\n[color=yellow]— What? You are not trying to make me... — she cringes — He's disgusting, have you seen how he looks at me?[/color]\n\nCali looks completely repulsed by the whole suggestion, but perhaps you could change her mind. With the right word here and there she may open to the idea."
			buttons.append(["Try talk her into it", 'calibar1', 7])
		else:
			text += "\n\n[color=yellow— I don’t know what to do… Maybe there’s another way?[/color] "
		buttons.append(["Agree and don't press the issue further", 'calibar1', 8])
	elif value == 3:
		globals.resources.gold -= 100
		text = textnode.CaliBarPay100
		globals.state.sidequests.cali = 17
		buttons.append(['Leave', 'calibar1', 4])
	elif value == 4:
		text = textnode.CaliBarLeave
		globals.get_tree().get_current_scene().dialogue(true, self, text, buttons, sprite)
		globals.get_tree().get_current_scene().get_node("outside").backstreets()
		return
	elif value == 5:
		if globals.state.sidequests.calibarsex == 'agreed':
			text = textnode.CaliBarFuckWilling
			globals.state.sidequests.calibarsex = 'liked'
			cali.sexuals.affection += round(rand_range(3,5))
			cali.metrics.sex += 1
			cali.metrics.vag += 1
			cali.metrics.randompartners += 1
			cali.metrics.orgasm += 1
			globals.state.sidequests.cali = 17
			cali.lust -= 15
			cali.loyal -= 5
			cali.energy = -50
			cali.pussy.virgin = false
			cali.add_trait(globals.origins.trait('Fickle'))
		elif globals.state.sidequests.calibarsex == 'forced':
			text = textnode.CaliBarFuckUnwilling
			cali.metrics.sex += 1
			cali.metrics.vag += 1
			cali.metrics.randompartners += 1
			cali.metrics.roughsex += 1
			cali.loyal -= 50
			cali.obed -= 60
			cali.stress += 75
			cali.health = -15
			cali.energy = -50
			cali.pussy.virgin = false
			globals.state.sidequests.calibarsex = 'disliked'
		globals.state.sidequests.cali = 16
		buttons.append(['Continue','calibar'])
	elif value == 6:
		text = textnode.CaliBarForce
		cali.loyal -= 30
		cali.obed -= 30
		globals.state.sidequests.calibarsex = 'forced'
		buttons.append(['Return','calibar'])
	elif value == 7:
		if cali.lust > 50 && cali.sexuals.unlocked == true:
			text = textnode.CaliBarPersuadeSuccess
			globals.state.sidequests.calibarsex = 'agreed'
			buttons.append(['Return','calibar'])
		else:
			text = textnode.CaliBarPersuadeFail
			sprite = [['caliangry1','pos1']]
			globals.state.sidequests.calibarsex = 'reject'
			cali.loyal -= 10
			cali.obed -= 15
			buttons.append(['Return','calibar1', 2])
	elif value == 8:
		text = textnode.CaliBarDeny
		buttons.append(['Return','calibar'])
	elif value == 9:
		text = textnode.CaliBarUseSebastian
		globals.state.sidequests.calibarsex = 'sebastianfinish'
		buttons.append(['Return','calibar'])
	globals.get_tree().get_current_scene().dialogue(false, self, text, buttons, sprite)

func calivillage():
	globals.get_tree().get_current_scene().dialogue(true,self,globals.player.dictionaryplayer(textnode.CaliVillageEnter1))
	globals.state.sidequests.cali = 18
	globals.get_tree().get_current_scene().get_node("explorationnode").zoneenter('shaliq')

func calivillage2():
	var text = ''
	var buttons = []
	var state = false
	if globals.state.sidequests.cali == 20:
		text = textnode.CaliVillageEnter2
		state = true
	elif globals.state.sidequests.cali == 21:
		text = textnode.CaliVillageEnter3
		buttons.append(['Gratefully accept','calivillage3', 1])
		buttons.append(['Respectfully decline','calivillage3', 2])
	globals.state.sidequests.cali = 22
	globals.get_tree().get_current_scene().dialogue(state,self,text,buttons)

func calivillage3(stage):
	var text = ""
	if stage == 1:
		text = textnode.CaliVillageAcceptReward
		globals.resources.gold += 300
	elif stage == 2:
		text = textnode.CaliVillageRefuseReward
		globals.resources.upgradepoints += 4
	globals.get_tree().get_current_scene().dialogue(true,self,text)

var calibanditcampstage = 0 #0 - nothing, 1 - poisoned mead, 2 - dominated, 3 - both

func calibanditcamp():
	var text = ''
	var buttons = []
	if calibanditcampstage == 0:
		text = "You find your way to the Bandit Camp. As you carefully scout out the situation you realize that there’s probably more here than you can easily handle at once.  Two bandits are in the center of the camp arguing over who gets to be to rape the terrified girl tied up near them. Two more are drinking heavily from an open cask of mead, and one more is making a slow circuit of the camp, keeping a close eye on the surrounding woods. "
	elif calibanditcampstage == 1:
		text = "As you carefully scout out the situation you realize that there’s probably more here than you can easily handle at once.  Two bandits are in the center of the camp arguing over who gets to be to rape the terrified girl tied up near them.  Two bandits are lying in a drunken stupor near the mead cask and one more is making a slow circuit of the camp, keeping a close eye on the surrounding woods."
	elif calibanditcampstage == 2:
		text = "As you carefully scout out the situation you realize that there’s probably more here than you can easily handle at once. A bandit is examining the captive girl with interest, while another is trying to bandage up a nasty body wound. Two more are drinking heavily from an open cask of mead, and and the body of a stabbed bandit lies dead near the center of the camp."
	elif calibanditcampstage == 3:
		text = "As you carefully scout out the situation you realize that there’s probably more here than you can easily handle at once. A bandit is examining the captive girl with interest, while another is trying to bandage up a nasty stomach wound. Two bandits are lying in a drunken stupor near the mead cask and the body of a stabbed bandit lies dead near the center of the camp."
	if globals.get_tree().get_current_scene().get_node("explorationnode").scout.wit >= 70 && calibanditcampstage != 1 && calibanditcampstage != 3 && globals.get_tree().get_current_scene().get_node("explorationnode").scout != globals.player:
		buttons.append(["Poison the bandit’s mead", 'calibanditcampaction', 1])
	if globals.spelldict.domination.learned == true && calibanditcampstage != 2 && calibanditcampstage != 3 && globals.spelldict.domination.manacost <= globals.resources.mana:
		buttons.append(["Dominate the wandering sentry", 'calibanditcampaction', 2])
		globals.resources.mana -= globals.spelldict.domination.manacost
	buttons.append(['Attack the camp', 'calibanditcampattack'])
	globals.get_tree().get_current_scene().dialogue(false,self,text,buttons)


func calibanditcampaction(action):
	var buttons = []
	var text = ''
	if action == 1:
		text = textnode.CaliPoisonBandits
		if calibanditcampstage == 2:
			calibanditcampstage = 3
		elif calibanditcampstage == 0:
			calibanditcampstage = 1
	elif action == 2:
		text = textnode.CaliDominateBandits
		if calibanditcampstage == 1:
			calibanditcampstage = 3
		elif calibanditcampstage == 0:
			calibanditcampstage = 2
	buttons.append(['Continue', 'calibanditcamp'])
	globals.get_tree().get_current_scene().dialogue(false,self,text,buttons)


func calibanditcampattack():
	var main = globals.get_tree().get_current_scene()
	var text = "You decide it’s time to attack and charge the camp with your group. "
	if calibanditcampstage == 0:
		main.get_node("explorationnode").buildenemies("banditshard")
	elif calibanditcampstage == 1 || calibanditcampstage == 2:
		main.get_node("explorationnode").buildenemies("banditsmedium")
	elif calibanditcampstage == 3:
		main.get_node("explorationnode").buildenemies("banditseasy")
	var buttons = [["Continue", 'calibanditcampfight']]
	main.dialogue(false,self,text,buttons)

func calibanditcampfight():
	globals.get_tree().get_current_scene().close_dialogue()
	globals.get_tree().get_current_scene().get_node("explorationnode").launchonwin = 'calibanditcampwin'
	globals.get_tree().get_current_scene().get_node("combat").nocaptures = true
	globals.get_tree().get_current_scene().get_node("explorationnode").enemyfight()

func calibanditcampwin():
	var buttons = []
	buttons.append(['Return the girl', 'calibanditcampchoice', 1])
	buttons.append(['Kidnap the girl', 'calibanditcampchoice', 2])
	if globals.spelldict.entrancement.learned == true && globals.spelldict.entrancement.manacost <= globals.resources.mana:
		buttons.append(['Seduce the girl', 'calibanditcampchoice', 3])
		globals.resources.mana -= globals.spelldict.entrancement.manacost
	globals.get_tree().get_current_scene().dialogue(false,self,textnode.CaliBanditCampVictory,buttons)

func calibanditcampchoice(choice):
	var texttemp
	var slave = globals.slavegen.newslave('Human', 'teen', 'female', 'commoner')
	slave.name = 'Tia'
	slave.surname = 'Fallton'
	slave.beauty = 75
	slave.haircolor = 'brown'
	slave.hairlength = 'waist'
	slave.hairstyle = 'straight'
	slave.tits.size = 'small'
	slave.ass = 'small'
	slave.skin = 'fair'
	slave.eyecolor = 'blue'
	slave.pussy.virgin = true
	slave.pussy.first = 'none'
	slave.stats.cour_base = 23
	slave.stats.conf_base = 31
	slave.stats.wit_base = 55
	slave.stats.charm_base = 82
	slave.height = 'short'
	slave.cleartraits()
	for i in slave.skills.values():
		i.value = 0
	if choice == 1:
		texttemp = textnode.CaliReturnGirl
		globals.state.sidequests.cali = 21
	elif choice == 2:
		texttemp = textnode.CaliKidnapGirl
		slave.obed += -100
		slave.sleep = 'jail'
		globals.get_tree().get_current_scene().get_node("explorationnode").enemycapture(slave)
		globals.state.sidequests.cali = 20
	elif choice == 3:
		texttemp = textnode.CaliSeduceGirl
		slave.obed += 75
		slave.loyal += 20
		globals.slaves = slave
		globals.state.sidequests.cali = 20
	globals.get_tree().get_current_scene().dialogue(true,self,texttemp)
	globals.get_tree().get_current_scene()._on_mansion_pressed()
	globals.resources.energy = -100

func calislavercamp():
	var cali = null
	var text = ""
	var buttons = []
	var state
	var sprite
	for i in globals.state.playergroup:
		if globals.state.findslave(i).unique == 'Cali':
			cali = globals.state.findslave(i)
	if globals.state.sidequests.cali == 23 && cali == null:
		text = "You said that you would bring Cali along to help, you’ll need her as a companion."
		state = true
	elif globals.state.sidequests.cali == 23:
		text = textnode.CaliSlaversTaken
		state = false
		buttons.append(['Continue', 'calislaver', 1])
		sprite = [['calineutral','pos1','opac']]
	elif globals.state.sidequests.cali == 24:
		text = textnode.CaliSlaversLeft
		state = false
		if globals.resources.gold >= 100:
			buttons.append(['Pay the fee','calislavercamppay',1])
		buttons.append(['Walk away','calislavercamppay',2])
	globals.get_tree().get_current_scene().dialogue(state,self,text, buttons, sprite)



func calislavercamppay(choice):
	var text = ''
	var buttons = []
	var state = true
	if choice == 1:
		globals.resources.gold -= 100
		state = false
		text = textnode.CaliSlaversPay
		buttons.append(['Ask about buying', 'calislaver',2])
		buttons.append(['Attack','calislaver',5])
		globals.get_tree().get_current_scene().dialogue(state, self, text, buttons)
	elif choice == 2:
		globals.get_tree().get_current_scene().close_dialogue()

func calislaver(choice):
	var text = ""
	var buttons = []
	var sprite
	if choice == 1:
		text = textnode.CaliSlaversOffer
		sprite = [['calineutral','pos1']]
		buttons.append(['Sell Cali', 'calislaver',3])
		buttons.append(['Decline','calislaver',4])
		buttons.append(['Attack','calislaver',5])
	elif choice == 2:
		text = textnode.CaliSlaversNoOffer
		buttons.append(['Leave', 'calislaver',6])
	elif choice == 3:
		sprite = [['caliangry1','pos1']]
		text = textnode.CaliSlaverSell
		for i in globals.slaves:
			if i.unique == 'Cali':
				globals.slaves.erase(i)
		globals.resources.gold += 350
		buttons.append(['Leave', 'calislaver',7])
	elif choice == 4:
		text = textnode.CaliSlaverNoSell
		buttons.append(['Leave', 'calislaver',6])
	elif choice == 5:
		globals.get_tree().get_current_scene().close_dialogue()
		globals.get_tree().get_current_scene().get_node("explorationnode").buildenemies("CaliBossSlaver")
		globals.get_tree().get_current_scene().get_node("combat").nocaptures = true
		globals.get_tree().get_current_scene().get_node("explorationnode").launchonwin = 'calislaverscampwin'
		globals.get_tree().get_current_scene().get_node("explorationnode").enemyfight()
		return
	elif choice == 6:
		globals.get_tree().get_current_scene().close_dialogue()
		globals.state.sidequests.cali = 25
		globals.get_tree().get_current_scene().get_node("explorationnode").zoneenter('wimbornoutskirts')
		return
	elif choice == 7:
		globals.get_tree().get_current_scene().close_dialogue()
		globals.state.sidequests.cali = 100
		globals.get_tree().get_current_scene().get_node("explorationnode").zoneenter('wimbornoutskirts')
		return
	globals.get_tree().get_current_scene().dialogue(false, self, text, buttons, sprite)


func calislaverscampwin():
	var cali = null
	var text = ""
	var buttons = []
	var state
	var sprite
	for i in globals.state.playergroup:
		if globals.state.findslave(i).unique == 'Cali':
			cali = globals.state.findslave(i)
	if cali != null:
		sprite = [['calihappy','pos1']]
		text = textnode.CaliSlaversFightWinTogether
	else:
		text = textnode.CaliSlaversFightWinWithout
	globals.state.sidequests.cali = 25
	globals.get_tree().get_current_scene().dialogue(true, self, globals.player.dictionaryplayer(text), null, sprite)
	globals.get_tree().get_current_scene().get_node("explorationnode").zoneenter('wimbornoutskirts')


func calistraybandit():
	var cali = null
	var text = ""
	var buttons = []
	var state
	for i in globals.state.playergroup:
		if globals.state.findslave(i).unique == 'Cali':
			cali = globals.state.findslave(i)
	if cali == null:
		globals.get_tree().get_current_scene().popup("You should probably bring Cali along for this, she could confirm if this is in fact the bandit that captured her.")
		return
	globals.get_tree().get_current_scene().close_dialogue()
	globals.get_tree().get_current_scene().get_node("explorationnode").buildenemies("CaliStrayBandit")
	globals.get_tree().get_current_scene().get_node("combat").nocaptures = true
	globals.get_tree().get_current_scene().get_node("explorationnode").launchonwin = 'calistraybanditwin'
	globals.get_tree().get_current_scene().get_node("explorationnode").enemyfight()

func calistraybanditwin():
	var sprite = [['calineutral','pos1','opac']]
	globals.get_tree().get_current_scene().get_node("explorationnode").zoneenter('wimbornoutskirts')
	globals.get_tree().get_current_scene().dialogue(true,self,globals.player.dictionaryplayer(textnode.CaliStrayBanditWin), null, sprite)
	globals.state.sidequests.cali = 26
	if globals.state.sidequests.calibarsex in ['none','sebastianfinish']:
		globals.state.upcomingevents.append({code = 'caliproposal', duration = 1})


func calireturnhome():
	var text = ""
	var buttons = []
	var state
	var sprite
	if globals.state.sidequests.caliparentsdead == true:
		text = globals.player.dictionaryplayer(textnode.CaliBadEnd)
		sprite = [['caliangry1','pos1','opac']]
		buttons.append(['Let her be','calireturnhome1',1])
		buttons.append(['Comfort her','calireturnhome1',2])
	else:
		text = globals.player.dictionaryplayer(textnode.CaliGoodEnd)
		sprite = [['calihappy','pos1','opac']]
		buttons.append(['Tell them no reward is necessary','caligoodend',1])
		buttons.append(['Tell them anything would be fine','caligoodend',2])
		buttons.append(['Ask if Cali could continue working for you','caligoodend',3])
	globals.get_tree().get_current_scene().dialogue(false,self,text,buttons,sprite)


func calireturnhome1(choice):
	var text = ""
	var buttons = []
	var cali = null
	var sprite = [['calihappy','pos1']]
	for i in globals.slaves:
		if i.unique == 'Cali':
			cali = i
	if choice == 1:
		text = textnode.CaliBadEndStay
	else:
		text = textnode.CaliBadEndComfort
		cali.loyal += 10
		cali.obed += 20
	buttons.append(['Offer to let her stay with you','calibadend',1])
	buttons.append(['Tell her to be your slave','calibadend',2])
	buttons.append(['Tell her to become your plaything','calibadend',3])
	buttons.append(['Leave her alone','calibadend',4])
	globals.get_tree().get_current_scene().dialogue(false,self,globals.player.dictionaryplayer(text),buttons,sprite)

func calibadend(choice):
	var text = ''
	var cali = null
	for i in globals.slaves:
		if i.unique == 'Cali':
			cali = i

	var sprite = [['calineutral','pos1']]
	if choice == 1:
		cali.loyal += 100
		cali.conf = -20
		text = textnode.CaliStay
	elif choice == 2:
		text = textnode.CaliSlave
		cali.obed += 100
		cali.conf = -20
	elif choice == 3:
		if cali.loyal >= 50:
			cali.obed += 100
			cali.sexuals.affection = 1000
			for i in ['cour','conf','wit','charm']:
				cali[i] = -100
				cali[i] = rand_range(5,15)
			text = textnode.CaliPlaythingSuccess
		else:
			text = textnode.CaliPlaythingFailure
			globals.resources.gold += 150
			globals.slaves.erase(cali)
			globals.state.playergroup.erase(cali.id)

	elif choice == 4:
		text = textnode.CaliLeave
		globals.state.playergroup.erase(cali.id)
		globals.slaves.erase(cali)
	
	globals.resources.upgradepoints += 10
	globals.get_tree().get_current_scene().get_node("explorationnode").zoneenter('wimbornoutskirts')
	globals.get_tree().get_current_scene().dialogue(true,self,globals.player.dictionaryplayer(text),null,sprite)
	globals.state.sidequests.cali = 102


func caligoodend(choice):
	var text = ''
	var cali = null
	for i in globals.slaves:
		if i.unique == 'Cali':
			cali = i
	var sprite = [['calihappy','pos1']]
	if choice == 1:
		text = textnode.CaliGoodEndNoReward
		cali.away.at = 'hidden'
		cali.away.duration = -1
		globals.state.upcomingevents.append({code = 'calireturn', duration = 7})
	elif choice == 2:
		text = textnode.CaliGoodEndReward
		globals.itemdict.hairgrowthpot.amount += 3
		globals.itemdict.stimulantpot.amount += 2
		globals.itemdict.oblivionpot.amount += 1
		globals.itemdict.youthingpot.amount += 1
		globals.slaves.erase(cali)
	elif choice == 3:
		text = textnode.CaliGoodEndKeep
		cali.add_trait(globals.origins.trait('Pliable'))
		cali.loyal += 100
		globals.get_tree().get_current_scene()._on_mansion_pressed()
	if choice != 3:
		globals.get_tree().get_current_scene().get_node("explorationnode").zoneenter('wimbornoutskirts')
	globals.resources.upgradepoints += 15
	globals.get_tree().get_current_scene().dialogue(true,self,globals.player.dictionaryplayer(text),null,sprite)
	globals.state.sidequests.cali = 103

func calireturn():
	var cali = null
	for i in globals.slaves:
		if i.unique == 'Cali':
			cali = i
	var sprite = [['calihappy','pos1']]
	cali.away.at = 'none'
	cali.away.duration = 0
	cali.add_trait(globals.origins.trait('Clingy'))
	globals.get_tree().get_current_scene().dialogue(true,self,globals.player.dictionaryplayer(textnode.CaliGoodEndNoRewardReturn),null,sprite)
	globals.get_tree().get_current_scene()._on_mansion_pressed()


func caliparentsdie():
	globals.state.sidequests.caliparentsdead = true

func sexscene(value):
	var text = ''
	var sprite = []
	if value == 'emilyshowersex':
		text = textnode.EmilyShowerSex
		sprite = [['emilynakedhappy','pos1']]
	elif value == 'showerrape':
		text = textnode.EmilyShowerRape
		sprite = [['emilynakedneutral','pos1']]
	elif value == 'tishaemilysex':
		text = globals.questtext.TishaEmilySex
		sprite = [['tishanakedhappy', 'pos1'], ['emilynakedhappy','pos2']]
	elif value == 'tishablackmail':
		text = textnode.TishaEmilyBrandCompensation
		sprite = [['tishanakedneutral','pos1']]
	elif value == 'tishareward':
		sprite = [['tishanakedhappy', 'pos1']]
		text = textnode.TishaSexSceneStart + '\n\n' + textnode.TishaSexSceneEnd
	elif value == "calivirgin":
		sprite = [['calinakedhappy','pos1']]
		text = textnode.CaliAcceptProposal + '\n' + textnode.CaliProposalSexMale
	elif value == 'yrisblowjob':
		text = textnode.GornYrisAccept1
	elif value == 'yrissex':
		text = textnode.GornYrisAccept2
	elif value == 'yrissex2':
		text = textnode.GornYrisAccept3
	elif value == "chloemana":
		sprite = [['chloeshy2','pos1']]
		text = textnode.ChloeShaliqTakeMana
	elif value == 'chloeforest':
		sprite = [['chloenakedshy', 'pos1']]
		text = textnode.ChloeGroveFound + '\n\n' + textnode.ChloeGroveSex
	elif value == "aynerispunish":
		text = textnode.AynerisPunish1
	elif value == "aynerissex":
		text = textnode.AynerisPunish2
	globals.get_tree().get_current_scene().dialogue(true,self,text,[],sprite)

func emilymansion(stage = 0):
	var text = ""
	var state = true
	var sprite
	var buttons = []
	var emily
	for i in globals.slaves:
		if i.unique == 'Emily':
			emily = i
	if stage == 0:
		text = textnode.EmilyMansion
		sprite = [['emilyhappy','pos1','opac']]
		state = false
		if globals.itemdict.aphrodisiac.amount > 0:
			buttons.append({text = 'Spike her with aphrodisiac',function = 'emilymansion',args = 1})
		else:
			buttons.append({text = 'Spike her with aphrodisiac',function = 'emilymansion',args = 1, disabled = true})
		buttons.append({text = 'Assault her after bath', function = 'emilymansion', args = 2})
		buttons.append({text = "Just wait", function = "emilymansion", args = 3})
	elif stage == 1:
		globals.itemdict.aphrodisiac.amount -= 1
		text = textnode.EmilyShowerSex
		sprite = [['emilynakedhappy','pos1']]
		emily.sexuals.unlocked = true
		emily.sexuals.unlocks.append('vaginal')
		emily.sexuals.unlocks.append('petting')
		emily.tags.erase('nosex')
		emily.pussy.virgin = false
		emily.pussy.first = 'you'
		emily.metrics.orgasm += 1
		emily.metrics.vag += 1
		emily.metrics.partners.append(globals.player.id)
		emily.stress += 50
		emily.loyal += 15
		emily.lust += 50
		globals.charactergallery.emily.scenes[0].unlocked = true
		globals.charactergallery.emily.nakedunlocked = true
	elif stage == 2:
		text = textnode.EmilyShowerRape
		sprite = [['emilynakedneutral','pos1']]
		emily.tags.erase('nosex')
		emily.sexuals.unlocked = true
		emily.stress += 100
		emily.pussy.virgin = false
		emily.pussy.first = 'you'
		emily.metrics.vag += 1
		emily.metrics.partners.append(globals.player.id)
		emily.obed = 0
		globals.charactergallery.emily.scenes[1].unlocked = true
		globals.charactergallery.emily.nakedunlocked = true
		globals.state.upcomingevents.append({code = 'emilyescape', duration = 2})
	elif stage == 3:
		text = textnode.EmilyMansion2
		sprite = [['emily2happy','pos1','opac']]
	globals.state.sidequests.emily = 6
	globals.get_tree().get_current_scene().dialogue(state,self,text,buttons,sprite)
	globals.get_tree().get_current_scene()._on_mansion_pressed()

func emilyescape():
	var emily
	for i in globals.slaves:
		if i.unique == 'Emily':
			emily = i
	if emily != null:
		if emily.brand == 'none':
			globals.slaves.erase(emily)
			globals.get_tree().get_current_scene().dialogue(true,self,'During the night Emily has escaped from the mansion in unknown direction.')

func tishaappearance():
	var emily = null
	var buttons = []
	var sprite
	for i in globals.slaves:
		if i.unique == 'Emily':
			emily = i
	if emily == null:
		return
	var text = textnode.TishaEncounter
	sprite = [['emily2normal','pos2','opac2'],['tishaangry','pos1','opac']]
	globals.charactergallery.tisha.unlocked = true
	if emily.loyal >= 25:
		text += textnode.TishaEmilyLoyal
		sprite = [['emily2happy','pos2','opac2'],['tishashocked','pos1','opac']]
		emilystate = 'loyal'
		buttons.append(['Make Emily leave', 'tishadecision', 1])
		buttons.append(['Make Emily stay', 'tishadecision', 2])
	elif emily.brand != 'none':
		emilystate = 'brand'
		text += textnode.TishaEmilyBranded
		[['emily2normal','pos2','opac2'],['tishaangry','pos1','opac']]
		buttons.append(['Release Emily', 'tishadecision', 3])
		buttons.append(['Keep Emily', 'tishadecision', 4])
		buttons.append(['Offer Tisha to take her place', 'tishadecision', 5])
	else:
		text += textnode.TishaEmilyUnloyal
		emilystate = 'unloyal'
		buttons.append(['Let them leave', 'tishadecision', 6])
		if globals.resources.gold >= 50 && globals.resources.food >= 50:
			buttons.append(['Help them with gold and provision', 'tishadecision', 7])		
		else:
			buttons.append({text = 'Help them with gold and provisions',function = 'tishadecision',args = 7, disabled = true})
		buttons.append(['Ask for compensation', 'tishadecision', 8])
	globals.get_tree().get_current_scene().dialogue(false,self,text,buttons,sprite)

func tishadecision(number):
	var emily
	var tisha
	var buttons = []
	var state = true
	var sprite = []
	sprite = [['emily2normal','pos2'],['tishaangry','pos1']]
	for i in globals.slaves:
		if i.unique == 'Emily':
			emily = i
		elif i.unique == 'Tisha':
			tisha = i
	var text = ''
	if number == 1:
		text = textnode.TishaEmilyLeave
		buttons.append(['Let them leave', 'tishadecision', 6])
		if globals.resources.gold >= 50 && globals.resources.food >= 50:
			buttons.append(['Help them with gold and provision', 'tishadecision', 7])		
		else:
			buttons.append({text = 'Help them with gold and provisions',function = 'tishadecision',args = 7, disabled = true})
			state = false
	elif number == 2:
		sprite = [['emily2normal','pos2'],['tishashocked','pos1']]
		text = textnode.TishaEmilyStay
	elif number == 3:
		globals.slaves.erase(emily)
		text = textnode.TishaEmilyLeaveFree
	elif number == 4:
		text = "You send Tisha off as you hold all the rights over Emily now. Having no choice, she curses you and leaves. "
	elif number == 5:
		text = textnode.TishaEmilyBrandCompensation
		sprite = [['tishanakedneutral','pos1']]
		globals.charactergallery.tisha.scenes[1].unlocked = true
		globals.charactergallery.tisha.nakedunlocked = true
		buttons.append(['Go with your word and release Emily', 'tishadecision', 10])
		buttons.append(['Keep Emily anyway', 'tishadecision', 9])
		text += "\n\n[color=green]You've earned 15 mana.\n\nTisha now belongs to you. [/color]"
		globals.resources.mana += 15
		state = false
		var slave = maketisha()
		globals.slaves = slave
	elif number == 6:
		text = textnode.TishaEmilyLeaveFree
		if emilystate == 'loyal':
			emily.away.at = 'hidden'
			emily.away.duration = -1
			emily.obed -= 20
			globals.state.upcomingevents.append({code = 'emilyreturn', duration = 5})
			globals.state.sidequests.emily = 10
		else:
			globals.slaves.erase(emily)
	elif number == 7:
		text = textnode.TishaEmilyLeaveHelp
		sprite = [['emily2normal','pos2'],['tishaneutral','pos1']]
		emily.away.at = 'hidden'
		emily.away.duration = -1
		emily.loyal += 15
		globals.state.upcomingevents.append({code = 'emilyreturn', duration = 5})
		globals.resources.food -= 50
		globals.resources.gold -= 50
		globals.state.reputation.wimborn += 5
		globals.state.sidequests.emily = 11
	elif number == 8:
		sprite = [['tishaangry','pos1']]
		text = textnode.TishaEmilyCompensation
		text += "\n\n[color=green]You've earned 15 mana. [/color]"
		globals.slaves.erase(emily)
		globals.resources.mana += 15
	elif number == 9:
		text = textnode.TishaEmilyKeepEmily
		sprite = [['tishashocked','pos1']]
		emily.loyal += -100
		emily.obed += -50
		tisha.obed += -75
		var effect = globals.effectdict.captured
		effect.duration = 15
		globals.state.reputation.wimborn -= 20
		emily.add_effect(effect)
		emily.tags.erase('nosex')
		tisha.add_effect(effect)
	elif number == 10:
		text = textnode.TishaEmilyReleaseEmily
		sprite = [['emily2normal','pos2'],['tishaneutral','pos1']]
		globals.state.reputation.wimborn -= 10
		tisha.obed += 50
		globals.slaves.erase(emily)
	globals.get_tree().get_current_scene().rebuild_slave_list()
	globals.get_tree().get_current_scene().dialogue(state,self,text,buttons,sprite)


func maketisha():
	var slave = globals.slavegen.newslave('Human', 'teen', 'female', 'commoner')
	slave.name = 'Tisha'
	slave.surname = 'Hale'
	slave.unique = 'Tisha'
	slave.beauty = 80
	slave.haircolor = 'auburn'
	slave.hairlength = 'waist'
	slave.hairstyle = 'braid'
	slave.tits.size = 'big'
	slave.ass = 'average'
	slave.skin = 'fair'
	slave.eyecolor = 'gray'
	slave.pussy.virgin = false
	slave.pussy.first = 'unknown'
	slave.stats.cour_base = 65
	slave.stats.conf_base = 58
	slave.stats.wit_base = 39
	slave.stats.charm_base = 71
	slave.height = 'average'
	slave.relatives.father = -1
	slave.relatives.mother = 2
	slave.imageportait = "res://files/images/tisha/tishaportrait.png"
	slave.cleartraits()
	return slave


func emilyreturn():
	var emily
	var sprite = [['emily2happy','pos1','opac']]
	for i in globals.slaves:
		if i.unique == 'Emily':
			emily = i
	emily.away.at = 'none'
	emily.away.duration = 0
	var text = textnode.EmilyReturn
	if globals.state.sidequests.emily == 10:
		text += "Tisha probably thinks you are not a bad person after all."
	else:
		text += "I think she was really surprised that you still helped us, even with her being angry and taking me away… "
	text += "If I can, can I still stay at your place, $master?[/color]\n\nYou welcome Emily back and she excuses herself, returning to her previous duties. "
	emily.loyal += 10
	emily.obed += 80
	globals.state.upcomingevents.append({code = 'tishadisappear', duration = round(rand_range(9,14))})
	globals.get_tree().get_current_scene().dialogue(true,self,globals.player.dictionaryplayer(text), null, sprite)
	globals.get_tree().get_current_scene()._on_mansion_pressed()


func tishadisappear(stage = 0):
	var emily
	var buttons = []
	var sprite
	var text = ""
	var state = false
	for i in globals.slaves:
		if i.unique == 'Emily':
			emily = i
	if emily == null:
		return
	if stage == 0:
		sprite = [['emily2worried','pos1','opac']]
		text = textnode.EmilyTishaDisappear
		buttons.append(['Agree to help', 'tishadisappear', 1])
		buttons.append(['Deny', 'tishadisappear', 2])
		buttons.append(['Ask for additional service', 'tishadisappear', 3])
	if stage == 1:
		sprite = [['emily2happy','pos1']]
		text = textnode.TishaDisappearAgree
		globals.state.sidequests.emily = 12
		emily.loyal += 15
		emily.obed += 20
		state = true
	elif stage == 2:
		sprite = [['emily2worried','pos1']]
		text = textnode.TishaDisappearDeny
		globals.state.sidequests.emily = 100
		emily.obed += -30
		emily.loyal += -20
		emily.stress += 40
		state = true
	elif stage == 3:
		sprite = [['emily2worried','pos1']]
		text = textnode.TishaDisappearUnlock
		globals.state.sidequests.emily = 12
		emily.loyal += -10
		emily.sexuals.unlocked = true
		emily.tags.erase('nosex')
		state = true
	globals.get_tree().get_current_scene().dialogue(state,self,text,buttons,sprite)
	globals.get_tree().get_current_scene()._on_mansion_pressed()

func tishadorms(stage=0):
	var emily
	var buttons = []
	var text = ""
	var state = false
	var sprite = null

	for i in globals.state.playergroup:
		if globals.state.findslave(i).unique == 'Emily':
			emily = globals.state.findslave(i)
	if stage == 0:
		text = textnode.TishaVisitArchives
		state = true
		buttons.append(['Move to Dorms', 'tishadorms', 1])
	if stage == 1:
		text = textnode.TishaDorms
		if emily != null:
			sprite = [['emily2worried','pos1']]
			text += textnode.TishaDormsEmilyPresent
			text += textnode.TishaDormsInfo
			globals.state.sidequests.emily = 13
			state = true
		else:
			if globals.spelldict.domination.learned == true && globals.spelldict.domination.manacost <= globals.resources.mana:
				buttons.append(['Cast Domination', 'tishadorms', 2])
			buttons.append(['Threaten', 'tishadorms', 3])
			if globals.resources.gold >= 50:
				buttons.append(['Bribe', 'tishadorms', 4])
	elif stage == 2:
		globals.resources.mana -= globals.spelldict.domination.manacost
		text = textnode.TishaDormsDominate
		text += textnode.TishaDormsInfo
		state = true
	elif stage == 3:
		text = textnode.TishaDormsThreat
		text += textnode.TishaDormsInfo
		state = true
	elif stage == 4:
		globals.resources.gold -= 50
		text = textnode.TishaDormsBribe
		text += textnode.TishaDormsInfo
		state = true
	if stage >= 2:
		globals.state.sidequests.emily = 13
		globals.get_tree().get_current_scene().get_node("outside").mageorder()
	globals.get_tree().get_current_scene().dialogue(state,self,text,buttons)

func tishabackstreets(stage = 0):
	var emily
	var buttons = []
	var text = ""
	var state = false
	var main = globals.get_tree().get_current_scene()

	if stage == 0:
		text = textnode.TishaBackstreets
		buttons.append(['Fight', 'tishabackstreets', 1])
		buttons.append(['Leave', 'tishabackstreets', 2])
	elif stage == 1:
		main.get_node("explorationnode").buildenemies("tishaquestenemy")
		globals.get_tree().get_current_scene().close_dialogue()
		globals.get_tree().get_current_scene().get_node("explorationnode").launchonwin = 'tishabackstreetswin'
		globals.get_tree().get_current_scene().get_node("combat").nocaptures = true
		globals.get_tree().get_current_scene().get_node("explorationnode").enemyfight()
		return
	elif stage == 2:
		main.close_dialogue()
		globals.get_tree().get_current_scene().get_node("outside").backstreets()
		return

	globals.get_tree().get_current_scene().dialogue(state,self,text,buttons)

func tishabackstreetswin():
	var text = ""
	globals.state.sidequests.emily = 14
	text = textnode.TishaBackstreetsAftercombat
	globals.get_tree().get_current_scene().dialogue(true,self,text)
	globals.get_tree().get_current_scene().get_node("outside").backstreets()

func tishagornguild(stage = 0):
	var buttons = []
	var text = ""
	var state = false
	var sprite 

	if stage == 0:
		sprite = [['tishaangry', 'pos1', 'opac']]
		if globals.state.sidequests.emily == 14:
			text = textnode.TishaGornGuild
			globals.state.sidequests.emily = 15
		else:
			text = textnode.TishaGornGuildRevisit
		if globals.resources.gold >= 500:
			buttons.append(['Pay', 'tishagornguild', 1])
		else:
			buttons.append({text = 'Pay',function = 'tishagornguild',args = 1, disabled = true})
		buttons.append(['Leave', 'tishagornguild', 2])
	elif stage == 1:
		text = textnode.TishaGornPay
		sprite = [['tishaneutral', 'pos1']]
		globals.resources.gold -= 500
		buttons.append(['Brand', 'tishagornguild', 3])
		buttons.append(['Refuse', 'tishagornguild', 4])
	elif stage == 2:
		globals.get_tree().get_current_scene().close_dialogue()
		globals.get_tree().get_current_scene().get_node("outside").slaveguild('gorn')
		return
	elif stage == 3:
		text = textnode.TishaGornBrand
		sprite = [['tishashocked', 'pos1']]
		globals.state.sidequests.emily = 101
		var slave = maketisha()
		slave.brand = 'basic'
		globals.slaves = slave
		state = true
		globals.get_tree().get_current_scene().get_node("outside").slaveguild('gorn')
	elif stage == 4:
		sprite = [['tishaneutral', 'pos1']]
		text = textnode.TishaGornRefuseBrand
		buttons.append(['Continue', 'tishagornguild', 5])
	elif stage == 5:
		sprite = [['tishaneutral', 'pos1']]
		globals.get_tree().get_current_scene()._on_mansion_pressed()
		if OS.get_name() != "HTML5" && globals.rules.fadinganimation == true:
			yield(globals.get_tree().get_current_scene(), 'animfinished')
		text = textnode.TishaAfterGorn
		buttons.append(['Ask for money', 'tishagornguild', 6])
		buttons.append(['Have sex', 'tishagornguild', 7])
		buttons.append(["Don't ask for anything", 'tishagornguild', 8])
	elif stage == 6:
		sprite = [['tishaneutral', 'pos1']]
		text = textnode.TishaAskPayment
		globals.state.sidequests.emily = 17
		globals.state.upcomingevents.append({code = "tishapay", duration = 7})
		state = true
	elif stage == 7:
		sprite = [['tishanakedhappy', 'pos1']]
		text = textnode.TishaSexSceneStart
		globals.charactergallery.tisha.nakedunlocked = true
		globals.charactergallery.tisha.scenes[1].unlocked = true
		if globals.player.penis.number > 0:
			text += "\n\n" + textnode.TishaSexSceneEnd
		globals.resources.mana += 10
		buttons.append(['Offer Tisha work for you', 'tishagornguild', 9])
		buttons.append(['Not bother her', 'tishagornguild', 10])
	elif stage == 8:
		sprite = [['tishanakedhappy', 'pos1']]
		globals.charactergallery.tisha.nakedunlocked = true
		globals.charactergallery.tisha.scenes[1].unlocked = true
		text = textnode.TishaRefusePayment + textnode.TishaSexSceneStart
		globals.resources.mana += 10
		if globals.player.penis.number > 0:
			text += "\n\n" + textnode.TishaSexSceneEnd
		buttons.append(['Offer Tisha work for you', 'tishagornguild', 9])
		buttons.append(['Not bother her', 'tishagornguild', 10])
	elif stage == 9:
		for i in globals.slaves:
			if i.unique == "Emily":
				i.tags.erase('nosex')
		text = textnode.TishaOfferJob
		sprite = [['tishanakedhappy', 'pos1']]
		var slave = maketisha()
		slave.sexuals.unlocked = true
		slave.sexuals.unlocks.append('petting')
		slave.sexuals.unlocks.append('oral')
		slave.sexuals.unlocks.append('vaginal')
		slave.unlocksexuals()
		slave.obed += 90
		slave.loyal += 15
		globals.slaves = slave
		state = true
		globals.state.sidequests.emily = 16
		globals.resources.upgradepoints += 10
		for i in globals.slaves:
			if i.unique == 'Emily':
				i.sexuals.unlocked = true
				i.tags.erase("nosex")
	elif stage == 10:
		sprite = [['tishaneutral', 'pos1']]
		for i in globals.slaves:
			if i.unique == "Emily":
				i.tags.erase('nosex')
		text = textnode.TishaLeave
		state = true
		globals.state.sidequests.emily = 16
		globals.resources.upgradepoints += 10

	globals.get_tree().get_current_scene().dialogue(state,self,text,buttons, sprite)

func tishapay():
	var text = "At the morning you receive a delivery: nice sum of gold from Tisha, who you helped previously. "
	globals.resources.gold += 500
	globals.get_tree().get_current_scene().popup(text)

func emilytishasex(stage = 0):
	var text
	var state
	var buttons = []
	var emily
	var tisha
	var sprite = []
	if stage == 0:
		text = globals.questtext.TishaEmilySex
		sprite = [['tishanakedhappy', 'pos1'], ['emilynakedhappy','pos2']]
		for i in globals.slaves:
			if i.unique == 'Emily':
				emily = i
			elif i.unique == 'Tisha':
				tisha = i
		emily.metrics.sex += 1
		tisha.metrics.sex += 1
		emily.metrics.partners.append(tisha.id)
		tisha.metrics.partners.append(emily.id)
		emily.away.duration = 7
		tisha.away.duration = 7
		state = false
		buttons.append(['Continue', "emilytishasex",1])
		globals.resources.mana += 25
		globals.charactergallery.emily.scenes[2].unlocked = true
		globals.charactergallery.tisha.scenes[2].unlocked = true
		globals.charactergallery.emily.nakedunlocked = true
		globals.charactergallery.tisha.nakedunlocked = true
	elif stage == 1:
		sprite = [['tishahappy', 'pos1'], ['emily2happy','pos2']]
		text = globals.questtext.TishaEmilySex2
		state = true
	globals.get_tree().get_current_scene().dialogue(state,self,text,buttons, sprite)

#Chloe

func chloeforest(stage = 0):
	var text = ''
	var state = false
	var sprite = [['chloehappy', 'pos1']]
	var buttons = []
	if stage == 0:
		sprite = [['chloeneutral', 'pos1', 'opac']]
		if globals.state.sidequests.chloe == 1:
			chloeforest(3)
			return
		else:
			var havegnomemember = false
			for i in globals.state.playergroup:
				var slave = globals.state.findslave(i)
				if slave.race == 'Gnome':
					havegnomemember = true
			if havegnomemember == false:
				text = textnode.ChloeEncounter
				if globals.spelldict.sedation.learned == true && globals.spelldict.sedation.manacost < globals.resources.mana:
					buttons.append({text = 'Cast Sedation',function = 'chloeforest',args = 1, disabled = false})
				elif globals.spelldict.sedation.learned == true:
					buttons.append({text = 'Cast Sedation',function = 'chloeforest',args = 1, disabled = true, tooltip = 'Not enough mana'})
				else:
					buttons.append({text = "You have no other available options yet",function = 'chloeforest',args = 1, disabled = true})
			else:
				text = textnode.ChloeEncounterGnome
				buttons.append({text = 'Talk with her',function = 'chloeforest',args = 2, disabled = true, tooltip = 'Not enough mana'})
			buttons.append({text = 'Leave her alone',function = 'chloeforest',args = 6})
	
	
	
	elif stage == 1:
		globals.resources.mana -= globals.spelldict.sedation.manacost
		text = textnode.ChloeSedate + textnode.ChloeEncounterTalk
		globals.state.sidequests.chloe = 1
		buttons.append({text = 'Lead her to the Shaliq',function = 'chloeforest',args = 4})
		buttons.append({text = "Tell her you can't help",function = 'chloeforest',args = 5})
	elif stage == 2:
		text = textnode.ChloeEncounterTalk
		globals.state.sidequests.chloe = 1
		buttons.append({text = 'Lead her to the Shaliq',function = 'chloeforest',args = 4})
		buttons.append({text = "Tell her you can't help",function = 'chloeforest',args = 5})
	elif stage == 3:
		text = textnode.ChloeEncounterRepeat
		buttons.append({text = 'Lead her to the Shaliq',function = 'chloeforest',args = 4})
		buttons.append({text = "Tell her you can't help",function = 'chloeforest',args = 5})
	elif stage == 4:
		text = textnode.ChloeEncounterHelp
		buttons.append({text = 'Proceed to Shaliq with Chloe',function = 'chloeforest',args = 7})
	elif stage == 5:
		text = textnode.ChloeEncounterRefuse
		buttons.append({text = 'Continue',function = 'chloeforest',args = 6})
	elif stage == 6:
		globals.get_tree().get_current_scene().get_node("explorationnode").zoneenter('forest')
		globals.get_tree().get_current_scene().close_dialogue()
		return
	elif stage == 7:
		text = textnode.ChloeShaliq
		globals.state.sidequests.chloe = 2
		globals.get_tree().get_current_scene().get_node("explorationnode").zoneenter('shaliq')
		buttons.append({text = 'Leave',function = 'chloevillage',args = 0})
	globals.get_tree().get_current_scene().dialogue(state,self,text,buttons,sprite)

func chloevillage(stage = 0):
	var text = ''
	var state = true
	var sprite = [['chloehappy2', 'pos1','opac']]
	var buttons = []
	if stage == 0:
		globals.get_tree().get_current_scene().get_node("explorationnode").zoneenter('shaliq')
		globals.get_tree().get_current_scene().close_dialogue()
		return
	elif stage == 1:
		text = textnode.ChloeShaliqOffer
		globals.charactergallery.chloe.unlocked = true
		globals.state.sidequests.chloe = 3
		state = false
		if globals.resources.mana >= 25:
			buttons.append({text = 'Agree',function = 'chloevillage',args = 3})
		else:
			buttons.append({text = 'Agree',function = 'chloevillage',args = 3, disabled = true})
		buttons.append({text = 'Leave',function = 'chloevillage',args = 0})
	elif stage == 2:
		text = textnode.ChloeShaliqReturn
		state = false
		if globals.resources.mana >= 25:
			buttons.append({text = 'Agree',function = 'chloevillage',args = 3})
		else:
			buttons.append({text = 'Agree',function = 'chloevillage',args = 3, disabled = true})
		buttons.append({text = 'Leave',function = 'chloevillage',args = 0})
	elif stage == 3:
		sprite = [['chloeshy2', 'pos1']]
		globals.charactergallery.chloe.scenes[0].unlocked = true
		globals.resources.mana -= 25
		globals.state.sidequests.chloe = 4
		globals.spelldict.entrancement.learned = true
		globals.state.upcomingevents.append({code = 'chloemissing', duration = 7})
		if globals.abilities.abilitydict.has('entrancement') == true:
			globals.player.ability.append('entrancement')
		if globals.player.penis.number >= 1:
			text = textnode.ChloeShaliqTakeMana
		else:
			text = "Chloe gleams with joy, happily smiling as she runs off to put her new possession away.\n\n[color=aqua]You have learned the Entrancement Spell.[/color]"
		globals.get_tree().get_current_scene().get_node("explorationnode").zoneenter('shaliq')
	elif stage == 4:
		if globals.state.sidequests.chloe == 4:
			text = textnode.ChloeShaliqBusy
		elif globals.state.sidequests.chloe == 5:
			text = textnode.ChloeShaliqMissing
			sprite = []
			globals.state.sidequests.chloe = 6
		elif globals.state.sidequests.chloe == 6:
			sprite = []
			text = textnode.ChloeShaliqMissingRepeat
	elif stage == 5:
		if globals.state.sidequests.chloe == 7:
			text = textnode.ChloeVillageHelp
			globals.state.sidequests.chloe = 8
			[['chloeshy2', 'pos1','opac']]
		elif globals.state.sidequests.chloe == 8:
			text = textnode.ChloeHelpReturn
		elif globals.state.sidequests.chloe == 9:
			globals.state.sidequests.chloe = 10
			globals.resources.upgradepoints += 10
			if globals.state.decisions.find('chloeaphrodisiac') >= 0:
				text = textnode.ChloeAphrodisiac
				sprite = [['chloeshy2', 'pos1']]
				state = false
				globals.state.reputation.wimborn -= 20
				buttons.append({text = 'Sell her to brothel',function = 'chloevillage',args = 6})
				buttons.append({text = 'Keep her to self',function = 'chloevillage',args = 7})
			if globals.state.decisions.find('chloeamnesia') >= 0:
				text = textnode.ChloeAmnesia
				globals.state.reputation.wimborn -= 10
				var chloe = chloemake()
				chloe.loyal += 25
				globals.slaves = chloe
			if globals.state.decisions.find('chloecure') >= 0:
				text = textnode.ChloeCure
				globals.spelldict.domination.learned = true
				text += "\n\n[color=aqua]You've learned Domination spell[/color]"
	elif stage == 6:
		text = textnode.ChloeBrothel
		sprite = [['chloenakedhappy', 'pos1']]
		globals.resources.gold += 500
	elif stage == 7:
		text = textnode.ChloeTakeSelf
		var chloe = chloemake()
		chloe.loyal += 25
		chloe.sexuals.affection += 250
		chloe.add_trait(globals.origins.trait('Sex-crazed'))
		sprite = [['chloehappy2', 'pos1']]
		globals.slaves = chloe
	elif stage == 8:
		if globals.state.decisions.find('chloecure') >= 0:
			text = textnode.ChloeVisit
		else:
			text = textnode.ChloeEmpty
	globals.get_tree().get_current_scene().dialogue(state,self,text,buttons,sprite)

func chloemissing():
	globals.state.sidequests.chloe = 5

func chloegrove(stage = 0):
	var text = ''
	var state = false
	var sprite = [['chloenakedhappy', 'pos1','opac']]
	var buttons = []
	
	if stage == 0:
		globals.state.sidequests.chloe = 7
		globals.charactergallery.chloe.nakedunlocked = true
		text = textnode.ChloeGroveFound
		buttons.append({text = 'Have sex with Chloe',function = 'chloegrove',args = 1})
		buttons.append({text = 'Masturbate Chloe',function = 'chloegrove',args = 2})
	elif stage in [1,2]:
		if stage == 1:
			sprite = [['chloenakedshy', 'pos1']]
			globals.charactergallery.chloe.scenes[1].unlocked = true
			text = textnode.ChloeGroveSex
		elif stage == 2:
			text = textnode.ChloeGroveMasturbate
		globals.resources.mana += 15
		sprite = [['chloenakedneutral', 'pos1']]
		buttons.append({text = 'Continue',function = 'chloegrove',args = 3})
	elif stage == 3:
		globals.get_tree().get_current_scene().close_dialogue()
		globals.get_tree().get_current_scene().get_node("explorationnode").zoneenter('shaliq')
		
		return
		
	
	globals.get_tree().get_current_scene().dialogue(state,self,text,buttons,sprite)

func chloealchemy(stage = 0):
	var buttons = []
	var text = 'As you prepare to make the required antidote, your experience says you can take advantage of the situation. Perhaps you could try adding some additional potion for differnt effect, providing you have them. '
	if stage == 0:
		buttons.append(['Make an antidote for Chloe','chloealchemy',1])
		if globals.itemdict.amnesiapot.amount >= 1:
			buttons.append({text = 'Mix antidote with amnesia potion', function = 'chloealchemy', args = 2})
		else:
			buttons.append({text = 'Mix antidote with amnesia potion', function = 'chloealchemy', args = 2, disabled = true, tooltip = 'Amnesia Potion Required'})
		if globals.itemdict.aphrodisiac.amount >= 1 && globals.itemdict.stimulantpot.amount >= 1: 
			buttons.append({text = 'Replace antidote with high grade stimulant', function = 'chloealchemy', args = 3})
		else:
			buttons.append({text = 'Replace antidote with high grade stimulant', function = 'chloealchemy', args = 3, disabled = true, tooltip = 'Aphrodisiac and Stimulant Required'})
	elif stage == 1:
		globals.state.decisions.append("chloecure")
	elif stage == 2:
		globals.state.decisions.append("chloeamnesia")
		globals.itemdict.amnesiapot.amount -= 1
	elif stage == 3:
		globals.state.decisions.append("chloeaphrodisiac")
		globals.itemdict.aphrodisiac.amount -= 1
		globals.itemdict.stimulantpot.amount -= 1
	if stage in [1,2,3]:
		text = 'After half-hour you finish preparations and now can return back to Chloe.'
		globals.state.sidequests.chloe = 9
	globals.get_tree().get_current_scene().dialogue(true, self, text, buttons)



func chloemake():
	var chloetemp = globals.slavegen.newslave('Gnome', 'adult', 'female', 'commoner')
	chloetemp.name = 'Chloe'
	chloetemp.unique = 'Chloe'
	chloetemp.surname = ''
	chloetemp.tits.size = 'average'
	chloetemp.ass = 'big'
	chloetemp.beautybase = 60
	chloetemp.hairlength = 'shoulder'
	chloetemp.height = 'tiny'
	chloetemp.haircolor = 'red'
	chloetemp.eyecolor = 'green'
	chloetemp.skin = 'fair'
	chloetemp.hairstyle = 'ponytail'
	chloetemp.pussy.virgin = false
	chloetemp.pussy.first = 'unknown'
	chloetemp.relatives.father = -1
	chloetemp.relatives.mother = -1
	chloetemp.sexuals.affection += 10
	chloetemp.imageportait = 'res://files/images/chloe/chloeportrait.png'
	chloetemp.stats.cour_base = 57
	chloetemp.stats.conf_base = 34
	chloetemp.stats.wit_base = 77
	chloetemp.stats.charm_base = 51
	chloetemp.cleartraits()
	chloetemp.obed += 90
	return chloetemp

func aynerisforest(stage = 0):
	var state = false
	var text = ''
	var buttons = []
	var sprites = []
	if stage == 0:
		if globals.state.sidequests.ayneris == 0:
			text = textnode.AynerisMeet1
		elif globals.state.sidequests.ayneris in [1,2]:
			text = textnode.AynerisMeet2
			if globals.state.sidequests.ayneris == 1:
				text += "\n\n[color=yellow]— It's him again! You thought you could get away after defeating me? This time you won't be so lucky. [/color]"
			else:
				text += "\n\n[color=yellow]— It's you, bastard! After what you did, you dare come here again? Get him! [/color]"
		buttons.append({text = 'Fight', function = 'aynerisforest', args = 1})
	elif stage == 1:
		if globals.state.sidequests.ayneris == 0:
			globals.get_tree().get_current_scene().get_node("explorationnode").buildenemies("ayneris1")
		else:
			globals.get_tree().get_current_scene().get_node("explorationnode").buildenemies("ayneris2")
		globals.get_tree().get_current_scene().close_dialogue()
		globals.get_tree().get_current_scene().get_node("explorationnode").launchonwin = 'ayneriswin'
		globals.get_tree().get_current_scene().get_node("combat").nocaptures = true
		globals.get_tree().get_current_scene().get_node("explorationnode").enemyfight()
		return
	elif stage == 2:
		text = textnode.AynerisPunish1
		globals.charactergallery.ayneris.scenes[0].unlocked = true
		globals.state.sidequests.ayneris = 2
		globals.resources.mana += 10
		state = true
	elif stage == 3:
		text = textnode.AynerisLeave
		state = true
	elif stage == 4:
		text = textnode.AynerisPunish2
		globals.charactergallery.ayneris.scenes[1].unlocked = true
		globals.state.sidequests.ayneris = 3
		globals.state.upcomingevents.append({code = 'aynerisnextstage', duration = 3})
		globals.resources.mana += 15
		state = true
	globals.get_tree().get_current_scene().dialogue(state, self, text, buttons, sprites)

func ayneriswin():
	var state = false
	var text = ''
	var buttons = []
	var sprites = []
	globals.get_tree().get_current_scene().get_node("explorationnode").zoneenter("amberguardforest")
	if globals.state.sidequests.ayneris == 0:
		globals.charactergallery.ayneris.unlocked = true
		globals.state.sidequests.ayneris = 1
		text = textnode.AynerisWin1
		buttons.append({text = 'Punish', function = 'aynerisforest', args = 2})
		buttons.append({text = 'Leave', function = 'aynerisforest', args = 3})
	elif globals.state.sidequests.ayneris in [1,2]:
		text = textnode.AynerisWin2
		if globals.state.sidequests.ayneris == 1:
			buttons.append({text = 'Punish', function = 'aynerisforest', args = 2})
		else:
			buttons.append({text = 'Punish', function = 'aynerisforest', args = 4})
		buttons.append({text = 'Leave', function = 'aynerisforest', args = 3})
		
	globals.get_tree().get_current_scene().dialogue(state, self, text, buttons, sprites)

func aynerismarket(stage = 0):
	var state = true
	var text = ''
	var buttons = []
	var sprites = []
	if stage == 0:
		state = false
		text = textnode.AynerisMeet3
		buttons.append({text = 'Accept', function = 'aynerismarket', args = 1})
		buttons.append({text = 'Refuse', function = 'aynerismarket', args = 2})
	elif stage == 1:
		text = textnode.AynerisOfferJoin
		var slave = aynerismake()
		globals.slaves = slave
		globals.state.sidequests.ayneris = 5
	elif stage == 2:
		text = textnode.AynerisIgnore
		globals.state.sidequests.ayneris = 6
		
	globals.get_tree().get_current_scene().dialogue(state, self, text, buttons, sprites)

func aynerisnextstage():
	globals.state.sidequests.ayneris += 1

func aynerismake():
	var slave = globals.slavegen.newslave('Elf', 'teen', 'female', 'noble')
	slave.name = 'Ayneris'
	slave.unique = 'Ayneris'
	slave.surname = ''
	slave.tits.size = 'average'
	slave.ass = 'average'
	slave.beautybase = 65
	slave.hairlength = 'waist'
	slave.height = 'average'
	slave.haircolor = 'blond'
	slave.eyecolor = 'blue'
	slave.skin = 'fair'
	slave.hairstyle = 'straight'
	slave.pussy.virgin = false
	slave.pussy.first = 'you'
	slave.sexuals.unlocked = true
	slave.relatives.father = -1
	slave.relatives.mother = -1
	slave.sexuals.affection += 10
	slave.stats.cour_base = 65
	slave.stats.conf_base = 88
	slave.stats.wit_base = 51
	slave.stats.charm_base = 48
	slave.cleartraits()
	slave.level = 2
	slave.sagi = 2
	slave.sstr = 1
	slave.skillpoints = 2
	slave.add_trait(globals.origins.trait('Masochist'))
	slave.obed += 90
	return slave
