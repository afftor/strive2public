extends Node

var slave #triggering slave
var slave2 #additional slave spot
var showntext
var buttons
var currentevent

var eventstext = {
play = ["During the morning you are visited by $name who seems to be desperate for your attention. After brief talk you realize that the young $race $child seems to be bored or even feeling lonely and hasn't matured enough to not completely rely on others. Perhaps, providing $him some attention might benefit $his well-being. ", "You spend couple of hours going through mansion's yard and surrounding forest while $name carelessly strolls around talking. After it's over $name addresses to you. \n\n— Thank you, $master, I had lots of fun!", "You introduce $name to one of the numerous tabletop games scattered around one of your cabinets. $He does not appear to be very interested at first, but eventually with your guidance $he grasps it and $he becomes completely immersed in it. After it's over, $child addresses you before resuming $his duty. \n\n— Thank you, $master, that was really fun!", "Deciding it’s a great day to start with some naughty stuff, you invite $name into a private room, in short time freeing $him from $his clothes. After spending some time exploring each other bodies, you finally relax next to an exhausted $child, satisfied from your activities. $His satisfied face gives you a shy smile as $he grabs your hand. ","You roughly send $name away announcing you have more important things to take care of. $He leaves clearly upset."],#options: play active games, play logic games, play lewd games, send $him off
spendtime = ["During the morning you are visited by $name who seems to be very bored and wonders if you would spend some time with $him. ", "You go for a date with $name to Wimborn and spend some time together. By the end of a date you have grown closer. ", "You and $name spend some time having a pleasant conversion. ", "Without further delay you drag $name to the private room spending rest of the morning pleasuring yourself with $his body.", "You roughly send $name away announcing you have more important things to take care of. $He leaves clearly upset."],#options: visit town, have intimate talk, fuck, send $him off
horny = ["During the morning you are visited by $name who seems to be very aroused and restless. $He gives you a long meaningful look, relaying $his overwhelming desire. ", "You embrace $name and give $him long lustful kiss which slowly shifts into a passionate session of carnal pleasure. Fully satisfied, $name leaves you to your work. ", "You order $name to control $his lust. $he does so but is clearly still aroused. You decide to keep eye on $him and force $him to stay around you for some time playing on his arousal and denying $him any relief making sure $he learns $his place.", "You roughly send $name away announcing you have more important things to take care of. $He leaves clearly upset and still horny."], #options: Accept, discipline, ignore
forestfind = ["As $name returns from $his work in the forests, $he announce you that $he brought a lost person. ", "You decide to make the newly found child your servant, to which $he meekly complies/which seems to agitate $him. You praise $name and continue on your daily plans. ","You send $child to the city to try find $his relatives. After some time your servants report that $child has been delivered to $his parents and they sent you their thanks and a small reward. ", "You order $name to take $child away from the mansion and you do not want to have anything to do with it. " ], #finds child/teen. options:keep them to yourself, send them to town, leave them to destiny
prositutebuyout = ["During the morning you are visited by a seemingly unknown man who proposes you sell him $name, whom he has been visiting at the brothel for last few days. Having fallen in love with $him, he offers you hefty sum of gold for $him. ", "You accept the offer and give up your ownership of $name. $He seems puzzled but the man is very grateful for your decision. ", "You decide to keep $name for yourself, as $he's more valuable while working for you. You send the man away.", "You bring $name to you and ask $him if he wishes to leave your estate and belong to the man. After some consideration $he agrees and you send them away./$He hastily rejects this offer and declares $he can only acknowledge you as $his master. "], #options: sell slave, reject, let slave decide
abortion = ["During the morning you are visited by $name who has a personal request. After a  brief explanation you realize $he wants to abort $his fetus being pessimistic about $his future life and hardship in slavery. ", "You decide to accept $name's request and provide $him with miscarriage potion. $He is scared but pleased with your approval of $his request. ", "You spend some time with $name reassuring $him and promising that both $he and child will have your support. Giving birth will not make $him any less useful to you. ", "You decide to dismiss $name rejecting $his demand. $He leaves clearly distressed. " ], #options: accept, reassure, ignore
vacation = ["During the morning you are visited by $name who has a personal request. $He asks you to give $him couple of days away from work so $he could visit $his friends and relatives outside/spend some time resting. $name says that $he has faithfully served you, $he also would like to have a rest once in awhile. ", "You grant $his request and after hearing $his words of gratitude, return to your business", "You tell $name, that you can't currently allow $him to skip $his work as it's very important, and instead offer $him some pocket money to spend. $name seems slightly disappointed, but taking your words seriously and after accepting your money, does not offer any visible hostility. ", "You refuse $name's demands, saying $he does not deserve any rest in first place and continue on your business leaving $him clearly distressed. "], #options: accept, give some money, refuse
accident = ["During the morning you receive a report that $name has accidentally broken a valuable object you have in your mansion. The replacement cost will have to be covered by yourself but you also have to decide on $his punishment. ", "No bad deed should go unpunished and you decide to personally administer a strict punishment. After long minutes of cries and pledges for mercy you let $name go, making sure $he learned the lesson for good. ", "After some consideration you decide to let the incident slip this time. $name looks really relieved and thanks you for your mercy. "], #options: punish, forgive
strangerdisrespect = ["During the morning you are visited by an unknown man, who appears to be a fairly well-known official and proclaims that your slave, $name acted disrespectfully towards him while in town. He demands compensation and your slave to be properly disciplined. ", "You bribe the official so he will forget $name's misbehavior, after which he leaves. $name approaches you and express $his deep gratitude for covering $his mistakes. ", "You decide that it would be best to let $name pay for $his wrongdoings personally. The man seems fairly happy with your decision and leaves with an unhappy $name by his side. ", "You tell the official it must be some mistake and you are not going to give him anything for wasting your time. As official leaves you wondering how badly it gonna hurt your reputation, but $name appears to be happy with your support. "], #options: compensate, let him use $name for a day, reject
escape = ["Early in the morning you receive a report that $name has recently been planning to escape. This is a serious issue and you should consider some measures to prevent this from happening again. ", "You call $name over and discuss $his motives. You tell $him that you are not going to harshly punish $him, but it is in his best interest to stay with you, as you promise to treat $him fairly. $name seemingly acknowledges your arguments and promises to act properly from now on. ", "You call $name over and administer a harsh punishment. Your treatment has left $him considerably more scared and obedient which should prevent further problems for the time being. ", "You decide to ignore the issue right now. This will likely encourage $name's actions and lower $his respect of you. "], #options: be forgiveful, be strict, pay no attention
kidnap = ["Early in the morning you receive a report that $name did not come back yesterday and according to few witnesses, may have been kidnapped. ", "You hastily initiate a rescue operation and with help of Mage's Order you find $name unharmed ", "You leave searches to your appointed headgirl, deciding $he should be able to take care of it. By the end of the day ","You decide to not spend any resources on searching $name. "], #options: Rush to search, leave it to the headgirl, do nothing
gift = ["During the morning you are visited by $name, who recently saw a very pretty piece of jewelry possessed by strange trader and making big eyes asks you to purchase it for $him while the trader is still around. ", "After some thoughts, you decide that spoiling your $child once in awhile is not really detrimental to $his behavior and send $him off with some gold. $name happily takes the money and thanks you for your generosity before running away. ", "You deny $name $his request making it clear that $he doesn't deserve such praise. Perhaps, another time if $he behaves properly. ", "After some consideration, you give $name a nasty smirk and tell $child, that if $he wants something from someone, $he should give something in return. "], #options: purchase, deny, make $him earn it
injure = ["During the early part of the day you receive a report that $name has injured $himself at work and is having some troubles moving around. After visiting and inspecting $him, you decide it’s nothing life threatening, but $name could use some rest. ", "You tell $name, that $he can take it easy for few days until $he gets better. $name is surprised with your attention and expresses $his gratitude. ", "You tell $name that $he can have a day off to rest and get better. $name warmly thanks you for your care. ", "You decide that $name's work is too important to let $him waste time laying around. $name acts stoically, even though $he hoped you would show a little bit of compassion. "], #options: let $name rest for 3 days, let $name rest for day, no rest
escapedslave = ["During the morning you receive a report that one of your servants has caught a trespasser on the mansion grounds. Apparently, it's a runaway slave who recently escaped from the town. You speak to the $child, $he tells you that he has been treated very badly by $his masters, which you confirm by numerous visible bruises. $He says $he couldn't find much food in past few days. ", "You offer $child the chance to join your household and be provided with food and shelter. You also promise to treat $him better than $his previous owners. With little options and an empty stomach, $he takes your offer, at least for now. $name now belongs to you.", "You order the escaped slave to be tied up tightly and return $him to town. After finding $his previous owners you manage to earn some gold for your service.", "You decide, that $child's life is of no interest to you. You threaten to punish $him greatly if you see $him again. "], #options: keep slave to yourself, return slave to city, act disinterested
teenagersflirt = ["As you stroll around the mansion, you spot $name being wooed over by few male teenagers. Apparently they find $him fairly attractive and are trying their best at flirting with $him. ", "Without much deliberation you appear before them and quickly indicate that $name belongs solely to you and they will be in big trouble if you see them again anywhere near your mansion. They swiftly retreat and $name thanks you for the help, showing some additional respect as $he does so. ", "You decide it would be amusing to make $name submit to a bunch of horny teens. You show up and tell $name that you demand $him responds to $his admirers in a most sincere way. The teenagers cheer at your commands and under pressure $name has no choice but to follow your order. Surrounded, $he's quickly freed of $his clothes and proceeds to give simultaneous blowjobs. ", "You decide to not waste your time and continue with your business. "], #options: Drive them away, Make $name serve them, Ignore
devotedevent = ["During the morning you are visited by $name, who tells you how $he talked one of the citizens, $he's familiar with, into offering $himself to you. You invite them over and inspect $him. \n$He tells you, how great the opinion of $name is of you, and how recent hardships have made $his life very complicated to the point, $he's ready to became a slave to have some stability and not die from starvation. ", "You accept $child's proposal and introduce $him to your household. ", "You reject the $child's offer telling that your current situation does not allow you to take just about anyone in. $He leaves with a disappointed look. "], #options: accept,reject
passiveevent = ["Walking through the mansion you spot how $name is being bullied and made fun of by couple of the other servants. $His meek personality apparently prevents $him from rebuking or putting an end to this treatment. ", "You approach the group and immediately put a stop to the verbal abuse. You harshly criticize the aggressors and explain that it is in their best interest not to pick on the others and you are not going to excuse any quarrels. They react with fright and remorse. After they leave $name expresses $his heartfelt appreciation. ", "Succumbing to the mob mentality you walk over to $name and passively observe the bullying with a smirk. Weak. Vulnerable. It strikes you that it might be fun to pay $name a visit later. To do it more. The servants seem to like you more now. ", "You decide it's not your business and move on your way. "], #options: defend $name, support bullying, ignore
masochistevent = ["During the morning you receive a report that $name has accidently broken one of the valuable pieces of clutter you have at your mansion. As you inspect it, apparently nothing really important was damaged, but $name acts like $he did it purposefully to aggravate you. You realize $he really seeks punishment. ", "No bad deed should go unpunished and you decide to personally administer a strict punishment. As you give $name some painful spanking and let $him go, you notice, that even though $he looks somewhat satisfied, $he's also acting way more excited and $his underwear is slightly stained. ", "Knowing just exactly what $name is waiting for, you tie $him up and actively aim for $his genitalia with light hits. As $he quickly gets wetter, you finish the punishment by penetrating $him with your $penis, making $him yelp in ecstasy. \n\nAfter you finish, you send a very satisfied $name back to $his duties and move on with your business. ", "As there was no real damage done and you don't really have time to deal with $name, you decide to drop whole issue and continue with your business. "], #options: punish, punish sexually, ignore
sluttyevent = ["Walking through the mansion you spot how $name advocates to $2name how $he should be more open to $his body and pleasure $he can get with it. Unsure about it, $2name gives $name a doubting look, but you can spot that conversation certainly interests $him and $he'll likely be swayed at least a bit into new thoughts. You decide there's no need for your intervention and continue on your way. "], #options: none
prudeevent = ["Walking through the mansion you spot $name advocating to $2name how $he should be a lot more thoughtful about $his actions and dress, as it's not proper behavior for them. Unsure about it, $2name gives $name a doubting look, but you can spot that conversation certainly had some effect on $him. You decide there's no reason to interfere now, but you might do something about prudish person later on. "], #options: none
fickleevent = ["As you stroll around the mansion, you spot $name openly flirting with a $sex stranger in a deserted place. Their conversation looks very passionate and it seems they are about to get wild. ", "You abruptly interrupt their affair and send the stranger away. As you scold $name, $he gives you unpleasant look. ", "Initially startled by your approach, both the stranger and $name still take up your offer and you indulge in a small passionate orgy over $name's body. ", "You decide to leave two lovebirds to their intrigues. "], #options shoo them away, have threesome, ignore 
pervertevent = ["Walking through the mansion you spot how $name distracts $2name from their work with various suggestive actions. As you subtly watch over them, you spot that $2name mostly tries to finish $2his work, but they both appear to be growing more aroused. ", "You show up and strictly order servants to get back to their duties. $name gives you gloomy look for interrupting them, while $2name looks somewhat relieved. ", "You show up and playfully order both servants to follow you to the private room. Once there, you go through what you saw, eventually making your followers blush badly. After getting them very excited, you finally move onto $2name while, ordering $name to undress everyone and join the fray. \n\nAfter the encounter is over, you spot that both servants have very satisfied looks on their faces. As you order them return to duty, you go on your business. ", "You decide the situation not worth your time and move on. "], #options: interrupt them, escalate the situation, ignore
}

var eventsdict = {
play = {function = 'play', reqs = "slave.age in ['teen', 'child'] && slave.mindage != 'adult'" },
spendtime = {function = 'spendtime', reqs = "slave.age in ['teen', 'adult'] && slave.mindage != 'child'" },
horny = {function = 'horny', reqs = "slave.lust >= 50 && slave.sexuals.unlocked == true" },
forestfind = {function = 'forestfind', reqs = "slave.work in ['forage','hunt']" },
prositutebuyout = {function = 'prositutebuyout', reqs = "slave.work in ['prostitution','escort']" },
abortion = {function = 'abortion', reqs = "slave.preg.duration >= 9 && slave.loyal < 40" },
vacation = {function = 'vacation', reqs = "slave.work != 'rest'" },
accident = {function = 'accident', reqs = "slave.sagi < 3"},
strangerdisrespect = {function = 'strangerdisrespect', reqs = "slave.conf > 35"},
escape = {function = 'escape', reqs = "slave.loyal < 15 && slave.obed < 60"},
kidnap = {function = 'kidnap', reqs = "slave.work in ['escort','prostitution','fucktoy','store','entertainer','assistant']"},
gift = {function = 'gift', reqs = "slave.obed >= 60"},
injure = {function = 'injure', reqs = "slave.work != 'rest'"},
escapedslave = {function = 'escapedslave', reqs = "slave.work != 'rest'"},
teenagersflirt = {function = 'teenagersflirt', reqs = "slave.beauty >= 40"},
devotedevent = {function = 'devotedevent', reqs = "slave.traits.has('Devoted')"},
passiveevent = {function = 'passiveevent', reqs = "slave.traits.has('Passive') && globals.slaves.size() > 6"},
masochistevent = {function = 'masochistevent', reqs = "slave.traits.has('Masochist')"},
sluttyevent = {function = 'sluttyevent', reqs = "slave.traits.has('Slutty') && globals.slaves.size() > 5"},
prudeevent = {function = 'prudeevent', reqs = "slave.traits.has('Prude') && globals.slaves.size() > 5"},
fickleevent = {function = 'fickleevent', reqs = "slave.traits.has('Fickle')"},
pervertevent = {function = 'pervertevent', reqs = "slave.traits.has('Pervert') && globals.slaves.size() > 5"},
}

func getrandomevent(tempslave):
	var rval
	var eventarray = []
	for i in eventsdict.values():
		if evaluate(i.reqs) == true:
			eventarray.append(i.function)
	if eventarray.size() > 0:
		rval = eventarray[rand_range(0,eventarray.size())]
	else:
		print('No valid events')
	return rval

func evaluate(input):
	var script = GDScript.new()
	script.set_source_code("var slave \nfunc eval():\n\treturn " + input)
	script.reload()
	var obj = Reference.new()
	obj.set_script(script)
	obj.slave = slave
	return obj.eval()

func findfreeslave():
	var slavearray = []
	for i in globals.slaves:
		if i.sleep != 'farm' && i.sleep != 'jail' && i.away.duration == 0 && i != slave:
			slavearray.append(i)
	return slavearray[rand_range(0,slavearray.size())]

func dictionary():
	showntext = slave.dictionary(showntext)
	showntext = showntext.replace("$2", "$")
	if slave2 != null:
		showntext = slave2.dictionary(showntext)

func showevent():
	var button
	get_node("textpanel/dailyeventtext").set_bbcode(showntext)
	for i in get_node("buttonpanel/ScrollContainer/VBoxContainer").get_children():
		if i != get_node("buttonpanel/ScrollContainer/VBoxContainer/Button"):
			i.set_hidden(true)
			i.queue_free()
	if buttons == null:
		button = get_node("buttonpanel/ScrollContainer/VBoxContainer/Button").duplicate()
		get_node("buttonpanel/ScrollContainer/VBoxContainer").add_child(button)
		button.set_hidden(false)
		button.set_text("Continue")
		button.connect("pressed", self, 'finishevent')
		return
	for i in buttons:
		button = get_node("buttonpanel/ScrollContainer/VBoxContainer/Button").duplicate()
		get_node("buttonpanel/ScrollContainer/VBoxContainer").add_child(button)
		button.set_hidden(false)
		button.set_text(slave.dictionary(i[0]))
		button.connect("pressed", self, currentevent, [i[1]])
	if slave.imageportait != null:
			if File.new().file_exists(slave.imageportait) == true:
				get_node("textpanel/portrait").set_texture(load(slave.imageportait))
			else:
				slave.imageportait = null
				get_node("textpanel/portrait").set_texture(null)

func finishevent():
	set_hidden(true)
	get_parent().nextdayevents()

######################EVENTS


func play(stage = 0):
	var tempbuttons
	showntext = slave.dictionary(eventstext[currentevent][stage])
	if stage == 0:
		tempbuttons = [['Play Active Games (-25 energy)', 1], ['Play Logic Games (-25 energy)',2], ['Play Lewd Games (-25 energy)', 3], ['Send $him off',4]]
	if stage == 1:
		slave.cour += rand_range(0,10)
		slave.conf += rand_range(0,10)
		slave.loyal += rand_range(10,15)
		slave.stress += -rand_range(15,25)
	elif stage == 2:
		slave.wit += rand_range(0,10)
		slave.charm += rand_range(0,10)
		slave.loyal += rand_range(10,15)
		slave.obed += rand_range(15,25)
	elif stage == 3:
		slave.sexuals.affection += round(rand_range(2,4))
		slave.lust = rand_range(15,25)
		globals.resources.mana += rand_range(2,3)
		if slave.race == "Drow":
			globals.resources.mana += 1
	elif stage == 4:
		slave.loyal += -rand_range(5,10)
		slave.obed += -rand_range(15,25)
	if stage != 0 && stage != 4:
		globals.player.energy = -25
	buttons = tempbuttons
	showevent()

func spendtime(stage = 0):
	var tempbuttons
	showntext = slave.dictionary(eventstext[currentevent][stage])
	if stage == 0:
		tempbuttons = [['Visit Town (-25 energy)', 1], ['Have intimate talk (-25 energy)',2], ['Sex (-25 energy)', 3], ['Send $him off',4]]
	if stage == 1:
		slave.cour += rand_range(0,10)
		slave.conf += rand_range(0,10)
		slave.loyal += rand_range(10,15)
		slave.obed += rand_range(15,25)
	elif stage == 2:
		slave.wit += rand_range(0,10)
		slave.charm += rand_range(0,10)
		slave.loyal += rand_range(10,15)
		slave.stress += -rand_range(15,25)
	elif stage == 3:
		slave.sexuals.affection += round(rand_range(2,5))
		slave.lust = -rand_range(15,25)
		globals.resources.mana += rand_range(3,5)
		if slave.race == "Drow":
			globals.resources.mana += 1
	elif stage == 4:
		slave.loyal += -rand_range(5,10)
		slave.obed += -rand_range(15,25)
	if stage != 0 && stage != 4:
		globals.player.energy = -25
	buttons = tempbuttons
	showevent()

func horny(stage = 0):
	var tempbuttons
	showntext = slave.dictionary(eventstext[currentevent][stage])
	if stage == 0:
		tempbuttons = [['Accept (-25 energy)', 1], ['Discipline (-25 energy)',2], ['Ignore ', 3]]
	if stage == 1:
		slave.lust = -rand_range(15,25)
		slave.loyal += rand_range(5,10)
		slave.stress += -rand_range(15,25)
		slave.sexuals.affection += round(rand_range(2,5))
		globals.resources.mana += rand_range(3,5)
		if slave.race == "Drow":
			globals.resources.mana += 1
	elif stage == 2:
		slave.obed += rand_range(20,35)
		slave.lust = rand_range(15,25)
	elif stage == 3:
		slave.obed += -rand_range(25,35)
		slave.loyal += -rand_range(5,10)
	if stage != 0 && stage != 3:
		globals.player.energy = -25
	buttons = tempbuttons
	showevent()

func forestfind(stage = 0):
	var tempbuttons
	var age = ['child','teen']
	var origins = ['slave','poor','commoner']
	if stage == 0:
		slave2 = globals.slavegen.newslave(globals.wimbornraces[rand_range(0,globals.wimbornraces.size())], age[rand_range(0, age.size())], 'random', origins[rand_range(0, origins.size())])
		showntext = slave.dictionary(eventstext[currentevent][stage])
		showntext += slave2.description_small() + " What would you like to do with $him?"
		tempbuttons = [[slave2.dictionary('Imprison the $child'), 1], [slave2.dictionary('Return $him to town (-25 energy)'),2], [slave2.dictionary("Don't bother with $him"), 3]]
	if stage == 1:
		showntext = slave2.dictionary(eventstext[currentevent][stage])
		globals.get_tree().get_current_scene().get_node("explorationnode").enemycapture(slave2)
	elif stage == 2:
		showntext = slave2.dictionary(eventstext[currentevent][stage])
		globals.resources.gold += rand_range(50,100)
		slave.loyal += rand_range(5,10)
		globals.player.energy = -25
	elif stage == 3:
		showntext = slave.dictionary(eventstext[currentevent][stage])
		slave.loyal += -rand_range(5,10)
	buttons = tempbuttons
	showevent()

var price

func prositutebuyout(stage = 0):
	var tempbuttons
	showntext = slave.dictionary(eventstext[currentevent][stage])
	if stage == 0:
		price = slave.calculateprice() * 1.5
		showntext += "[color=yellow]You are offered " + str(round(price)) + slave.dictionary(" gold for $name. [/color]")
		tempbuttons = [['Sell $name', 1], ['Reject',2], ['Let $name decide.', 3]]
	if stage == 1:
		globals.slaves.remove(globals.slaves.find(slave))
		globals.resources.gold += price
	elif stage == 2:
		slave.loyal += rand_range(10,15)
		slave.obed += rand_range(15,25)
	elif stage == 3:
		if slave.loyal < 25:
			showntext += slave.dictionary("After some consideration $he agrees and you send them away.")
			globals.slaves.remove(globals.slaves.find(slave))
			globals.resources.gold += price
		else:
			showntext += slave.dictionary("$He hastily rejects this offer and declares $he can only acknowledge you as $his master.")
			slave.loyal += rand_range(10,15)
	buttons = tempbuttons
	showevent()

func abortion(stage = 0):
	var tempbuttons
	showntext = slave.dictionary(eventstext[currentevent][stage])
	var price
	if stage == 0:
		if globals.itemdict.miscariagepot.amount >= 1:
			tempbuttons.append(['Give miscarriage potion', 1])
		if globals.resources.gold >= 50:
			tempbuttons.append(["Take $name to the slaver's guild for abortion",2])
		tempbuttons.append(['Reassure (-25 energy)',3])
		tempbuttons.append(['Ignore', 4])
	if stage == 1:
		slave.preg.baby = null
		slave.preg.duration = 0
		globals.itemdict.miscariagepot.amount = -1
		slave.obed += rand_range(10,20)
	elif stage == 2:
		slave.preg.baby = null
		slave.preg.duration = 0
		globals.resources.gold -= 50
		slave.obed += rand_range(15,25)
		slave.steres = rand_range(15,25)
	elif stage == 3:
		slave.loyal += rand_range(10,15)
		slave.stress += -rand_range(10,20)
		globals.player.energy = -25
	elif stage == 4:
		slave.loyal += -rand_range(10,15)
		slave.stress += rand_range(20,40)
		slave.obed += -rand_range(20,40)
	buttons = tempbuttons
	showevent()

func vacation(stage = 0):
	var tempbuttons
	showntext = slave.dictionary(eventstext[currentevent][stage])
	if stage == 0:
		tempbuttons = [['Accept', 1], ["Refuse", 3]]
		if globals.resources.gold >= 50:
			tempbuttons.insert(1, ['Give some pocket money instead (-50 gold)',2])
	if stage == 1:
		slave.away.duration = 4
		slave.loyal += rand_range(10,15)
	elif stage == 2:
		globals.resources.gold -= 50
		slave.loyal += rand_range(5,10)
		slave.obed += rand_range(10,15)
	elif stage == 3:
		slave.loyal += -rand_range(5,10)
		slave.stress += rand_range(10,20)
	buttons = tempbuttons
	showevent()

func accident(stage = 0):
	var tempbuttons
	showntext = slave.dictionary(eventstext[currentevent][stage])
	if stage == 0:
		tempbuttons = [['Punish (-25 energy)', 1], ["Forgive", 2]]
		globals.resources.gold -= 50
	if stage == 1:
		globals.player.energy = -25
		slave.obed += rand_range(20,35)
		slave.punish.expect = true
		slave.punish.strength = 3
	elif stage == 2:
		slave.loyal += rand_range(3,6)
	buttons = tempbuttons
	showevent()

func strangerdisrespect(stage = 0):
	var tempbuttons
	showntext = slave.dictionary(eventstext[currentevent][stage])
	if stage == 0:
		tempbuttons = [["Let him use $name for a day",2], ["Reject", 3]]
		if globals.resources.gold >= 100:
			tempbuttons.insert(0, ['Compensate', 1])
	if stage == 1:
		globals.resources.gold -= 100
		slave.loyal += rand_range(10,20)
	elif stage == 2:
		slave.away.duration = 1
		slave.loyal += -rand_range(10,15)
		slave.obed += -rand_range(15,25)
	elif stage == 3:
		globals.state.reputation.wimborn -= rand_range(3,5)
		slave.obed += rand_range(10,20)
		slave.stress += rand_range(15,30)
	buttons = tempbuttons
	showevent()

func escape(stage = 0):
	var tempbuttons
	showntext = slave.dictionary(eventstext[currentevent][stage])
	if stage == 0:
		tempbuttons = [["Be forgiveful (-25 energy)",1],["Be strict (-25 energy)",2], ["Ignore", 3]]
	if stage == 1:
		slave.loyal += rand_range(7,15)
		slave.obed += rand_range(10,15)
		globals.player.energy = -25
	elif stage == 2:
		slave.obed += rand_range(20,35)
		slave.stress += rand_range(15,25)
		slave.loyal += rand_range(3,7)
		globals.player.energy = -25
	elif stage == 3:
		slave.obed += -rand_range(10,25)
	buttons = tempbuttons
	showevent()

func kidnap(stage = 0):
	var tempbuttons
	showntext = slave.dictionary(eventstext[currentevent][stage])
	if stage == 0:
		slave.stress += rand_range(35,60)
		tempbuttons = [["Rush to the searches(-25 energy)", 1], ["Do nothing", 3]]
		if slave.brand != 'none':
			showntext += "Finding a branded person shouldn't be too hard if you start right away. "
		else:
			showntext += "Finding an unbranded person might prove very difficult, especially if something bad happened to $him. "
		var headgirl
		for i in globals.slaves:
			if i.work == 'headgirl' && i.away.duration == 0:
				headgirl = i
				break
		if headgirl != null:
			tempbuttons.insert(1, ["Leave searches to the Headgirl",2])
			slave2 = headgirl
	if stage == 1:
		slave.loyal += rand_range(10,20)
		slave.obed += rand_range(10,15)
		slave.stress += -25
		if slave.brand != 'none':
			showntext +=  "in couple of hours."
			globals.player.energy = -25
		else:
			showntext += "by the end of the day."
			globals.player.energy = -25
	elif stage == 2:
		if slave.brand != 'none':
			slave.loyal += rand_range(5,10)
			showntext += " $name is returned to you unharmed. "
		else:
			globals.slaves.remove(globals.slaves.find(slave))
			showntext += " there's no news or signs of $name's location and you have no faith $he will appear again. "
	elif stage == 3:
		globals.slaves.remove(globals.slaves.find(slave))
	buttons = tempbuttons
	showevent()

func gift(stage = 0):
	var tempbuttons
	showntext = slave.dictionary(eventstext[currentevent][stage])
	if stage == 0:
		if globals.resources.gold < 50:
			tempbuttons = [["Deny", 2]]
		else:
			tempbuttons = [["Comply (-50 gold)",1],["Deny",2], ["Make $name earn it (-25 energy)", 3]]
	if stage == 1:
		slave.loyal += rand_range(5,10)
		slave.obed += rand_range(10,15)
		globals.resources.gold -= 50
	elif stage == 2:
		slave.obed += -rand_range(20,35)
		slave.loyal += -rand_range(2,5)
	elif stage == 3:
		if slave.sexuals.unlocked == false:
			slave.obed += -rand_range(20,40)
			slave.loyal += -rand_range(5,10)
			showntext += slave.dictionary("$name is disgusted by your implications and leaves infuriated. ")
		else:
			showntext += slave.dictionary("You spread your legs and bare your crotch, inviting $name over to which $he readily responds. After couple pleasant minutes of $name's eager mouth work you pass $him the requested money and return to your work. ")
			slave.obed += rand_range(10,25)
			slave.lust = rand_range(10,15)
			slave.sexuals.affection += round(rand_range(1,3))
			globals.resources.gold -= 50
			globals.resources.mana += rand_range(3,6)
			if slave.race == "Drow":
				globals.resources.mana += 1
			globals.player.energy = -25
	buttons = tempbuttons
	showevent()

func injure(stage = 0):
	var tempbuttons
	showntext = slave.dictionary(eventstext[currentevent][stage])
	if stage == 0:
		slave.health = -slave.stats.health_max/3
		tempbuttons = [["Let $name rest for 3 days",1],["Let $name rest for a day",2], ["No rest", 3]]
	if stage == 1:
		slave.loyal += rand_range(7,15)
		slave.obed += rand_range(10,15)
		slave.health = slave.stats.health_max
		slave.away.duration = 3
	elif stage == 2:
		slave.loyal += rand_range(5,10)
		slave.away.duration = 1
		slave.health = slave.stats.health_max/6
	elif stage == 3:
		slave.stress += rand_range(10,25)
		slave.loyal += -rand_range(5,10)
		slave.obed += -rand_range(15,35)
	buttons = tempbuttons
	showevent()

func escapedslave(stage = 0):
	var tempbuttons
	var age = ['adult','teen']
	var origins = ['slave','poor']
	if stage == 0:
		slave2 = globals.slavegen.newslave(globals.wimbornraces[rand_range(0,globals.wimbornraces.size())], age[rand_range(0, age.size())], 'random', origins[rand_range(0, origins.size())])
		tempbuttons = [[slave2.dictionary("Keep $him to yourself"),1],[slave2.dictionary("Return $him to the city (-25 energy)"),2], ["Ignore", 3]]
	if stage == 1:
		globals.slaves = slave2
	elif stage == 2:
		globals.resources.gold += rand_range(50,150)
		globals.player.energy = -25
	elif stage == 3:
		slave.obed += rand_range(5,10)
	showntext = slave2.dictionary(eventstext[currentevent][stage])
	buttons = tempbuttons
	showevent()

func teenagersflirt(stage = 0):
	var tempbuttons
	showntext = slave.dictionary(eventstext[currentevent][stage])
	if stage == 0:
		tempbuttons = [["Drive them away (-25 energy)",1],["Let $name serve them (-25 energy)",2], ["Ignore", 3]]
	if stage == 1:
		globals.player.energy = -25
		slave.loyal += rand_range(7,15)
		slave.obed += rand_range(10,15)
	elif stage == 2:
		globals.player.energy = -25
		slave.metrics.randompartners += round(rand_range(3,5))
		slave.metrics.sex += 1
		if (slave.sexuals.actions.has('pussy') || slave.sexuals.actions.has('ass') ) && slave.traits.has("Monogamous") == false:
			globals.resources.mana += rand_range(5,10)
			if slave.race == "Drow":
				globals.resources.mana += 2
			slave.loyal += -rand_range(5,10)
			showntext += slave.dictionary("Getting caught up in the action, $name gets on all fours and lets one of the boys take $him from behind. ")
			
			if slave.pussy.has == true:
				slave.metrics.vag += round(rand_range(1,3))
			if slave.sexuals.actions.has('ass'):
				slave.metrics.anal += round(rand_range(1,2))
		else:
			showntext += slave.dictionary("$name greatly distressed with situation but having no ways out $he only keeps grudge against you. ")
			slave.stress += rand_range(15,25)
			slave.loyal += -rand_range(10,20)
			slave.obed += -rand_range(30,50)
		showntext += slave.dictionary("After short time the boys shower the $child in semen. Satisfied with your hospitality, they leave happy. ")
		globals.resources.mana += rand_range(3,6)
		if slave.race == "Drow":
			globals.resources.mana += 1
	elif stage == 3:
		pass
	buttons = tempbuttons
	showevent()

func devotedevent(stage = 0):
	var tempbuttons
	var origins = ['slave','poor', 'commoner']
	showntext = slave.dictionary(eventstext[currentevent][stage])
	if stage == 0:
		slave2 = globals.slavegen.newslave(globals.wimbornraces[rand_range(0,globals.wimbornraces.size())], 'random', 'random', origins[rand_range(0, origins.size())])
		showntext += '\n' + slave2.description_small()
		tempbuttons = [["Accept",1],["Reject",2]]
	if stage == 1:
		showntext = slave2.dictionary(eventstext[currentevent][stage])
		globals.slaves = slave2
	elif stage == 2:
		showntext = slave2.dictionary(eventstext[currentevent][stage])
		slave2 = null
	buttons = tempbuttons
	showevent()

func passiveevent(stage = 0):
	var tempbuttons
	showntext = slave.dictionary(eventstext[currentevent][stage])
	if stage == 0:
		tempbuttons = [["Defend $name (-25 energy)",1],["Support Bullying (-25 energy)",2], ["Ignore", 3]]
	if stage == 1:
		slave.loyal += rand_range(7,15)
		slave.obed += rand_range(10,20)
		globals.player.energy = -25
	elif stage == 2:
		slave.loyal += -rand_range(10,20)
		slave.obed += -rand_range(15,30)
		globals.player.energy = -25
	elif stage == 3:
		slave.stress += rand_range(25,50)
	buttons = tempbuttons
	showevent()

func masochistevent(stage = 0):
	var tempbuttons
	showntext = slave.dictionary(eventstext[currentevent][stage])
	if stage == 0:
		tempbuttons = [["Punish $name (-25 energy)",1],["Punish $name sexually (-25 energy)",2], ["Ignore", 3]]
	if stage == 1:
		slave.lust = rand_range(5,10)
		slave.obed += rand_range(15,25)
		slave.loyal += rand_range(3,6)
		globals.player.energy = -25
	elif stage == 2:
		slave.lust = -rand_range(15,25)
		slave.obed += rand_range(15,25)
		slave.loyal += rand_range(10,15)
		get_parent().impregnation(slave, globals.player)
	elif stage == 3:
		slave.loyal += -rand_range(5,10)
		slave.obed += -rand_range(15,35)
	buttons = tempbuttons
	showevent()

func sluttyevent(stage = 0):
	var tempbuttons
	slave2 = findfreeslave()
	showntext = eventstext[currentevent][stage]
	dictionary()
	buttons = tempbuttons
	showevent()

func prudeevent(stage = 0):
	var tempbuttons
	slave2 = findfreeslave()
	showntext = eventstext[currentevent][stage]
	dictionary()
	buttons = tempbuttons
	showevent()

func fickleevent(stage = 0):
	var tempbuttons
	if stage == 0:
		tempbuttons = [["Shoo them away (-25 energy)",1],["Have threesome (-25 energy)",2], ["Ignore", 3]]
	if stage == 1:
		slave.loyal += -rand_range(7,15)
		slave.obed += -rand_range(10,20)
		slave.lust = rand_range(15,25)
		globals.player.energy = -25
	elif stage == 2:
		slave.loyal += rand_range(5,10)
		slave.sexuals.unlocked == true
		get_parent().impregnation(slave)
		slave.lust = -rand_range(10,20)
		globals.player.energy = -25
		globals.resources.mana += rand_range(4,10)
		if slave.race == "Drow":
			globals.resources.mana += 2
	elif stage == 3:
		slave.lust = -rand_range(10,20)
	buttons = tempbuttons
	showntext = eventstext[currentevent][stage]
	dictionary()
	showevent()

func pervertevent(stage = 0):
	var tempbuttons
	if stage == 0:
		slave2 = findfreeslave()
		tempbuttons = [["Interrupt them (-25 energy)",1],["Escalate the situtation (-25 energy)",2], ["Ignore", 3]]
	if stage == 1:
		slave.loyal += -rand_range(5,10)
		slave2.loyal += rand_range(5,10)
		slave.obed += -rand_range(10,20)
		globals.player.energy = -25
	elif stage == 2:
		slave.loyal += rand_range(5,10)
		slave.lust = -rand_range(10,20)
		slave2.obed += -rand_range(10,30)
		slave2.lust = -rand_range(10,15)
		globals.player.energy = -25
		globals.resources.mana += rand_range(5,10)
		if slave.race == "Drow":
			globals.resources.mana += 2
	buttons = tempbuttons
	showntext = eventstext[currentevent][stage]
	dictionary()
	showevent()

