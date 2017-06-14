extends Node

var spritedict = {
sprite1 = load('res://files/images/1character/11.png')
}

var textdict = {
introduction = [
{sprite = 'sprite1',text = "Hehe"}
],
basicstext = [
{sprite = 'sprite1', text = 'Hi!'},
],
}











var scripttext = {
1 : "This is your main mansion screen. Here you can navigate through your rooms and slaves in your possession. Right now you only have one slave, let's go through $him. ",
1.1 : "Slave list showcases your present servants. You can interact and inspect them with buttons and see their status on the right. ",
2 : "Buttons represent tabs on the slave screen. In the stats screen you can observe all important stats and skills and issue training. ",
3 : "On the inspect screen you can see the slave's physical description and current mental status. You can also assign a custom portrait (if you have one) on the top left corner of the physical description.",
4 : "On regulations you can manage daily tasks and custom rules for your slave. As resting is not very productive, your first slave is assigned to forage, producing some food every day. Sleeping conditions help with stress and health restoration. You can also put slave into jail to keep $him trapped and isolated. ",
5 : "Non-sexual actions tend to influence slave to be more obedient or loyal. Actions cost action points which can be observed at the top of screen. Action points are restored by finishing day. ",
6 : "Sexual actions are mainly influenced by lust and lewdness. Lewdness unlocks more complex actions while lust makes slave more willing. Sexual actions produce mana and sometimes ingredients and cost action points. ",
7 : "Jail is used to hold rebellious slaves and new captures. Many detainees won't be willing to cooperate initially, but punishments can break their spirit faster. While in jail they cannot escape nor disrupt the other slaves.",
8 : "For more details on various parts of the game you can view the help section located at the top.",
9 : "Leaving  the mansion you can explore various parts of the world. There you may find new slaves, quests and other resources to use for your own benefit. ",
10 : "The Slaver's guild is a resourceful place where you can purchase new slaves, sell those you possess and no longer want, take daily missions. They also provide a few  additional services. The services and quests of each Slavers Guild varies, and may provide access to races not available by another guild. Make sure to visit them. ",
11 : "You can assign a group of up to 4 characters of your choice which will be used in combat while exploring. Many areas have hostile encounters requiring you to engage in combat. Improving your slaves will help you to defeat stronger enemies. ",
12 : "After finishing the day you'll receive a  full report on the state of your mansion. Beware, if you have no food and gold, the game will be over. \n\nThis is the end of current tutorial. For deeper information refer to the help section.",
13 : "You have finished the tutorial"
}

var stage
var center = {
box = {size = Vector2(567,247), pos = Vector2(279,142)}, 
text = {size = Vector2(517,146), pos = Vector2(24,28)},
buttonback = {size = Vector2(153,35), pos = Vector2(123,188)},
buttonnext = {size = Vector2(153,35), pos = Vector2(289,188)}
}
var side = {
box = {size = Vector2(372,411), pos = Vector2(694,93)}, 
text = {size = Vector2(340,198), pos = Vector2(23,28)},
buttonback = {size = Vector2(153,35), pos = Vector2(20,337)},
buttonnext = {size = Vector2(153,35), pos = Vector2(199,337)}
}
var outside = {
box = {size = Vector2(1039,146), pos = Vector2(26,352)}, 
text = {size = Vector2(536,103), pos = Vector2(244,20)},
buttonback = {size = Vector2(153,35), pos = Vector2(31,48)},
buttonnext = {size = Vector2(153,35), pos = Vector2(843,48)}
}
var sequence = [1,1.1,2,3,4,5,6,7,8,9,10,11,12,13]
var highlightpanel = {
1: {pos = Vector2(3,1), size = Vector2(1084,516)},
1.1: {pos = Vector2(676,32), size = Vector2(411,50)},
2: {pos = Vector2(125,57), size = Vector2(363,44)},
3: {pos = Vector2(125,57), size = Vector2(363,44)},
4: {pos = Vector2(125,57), size = Vector2(363,44)},
5: {pos = Vector2(125,57), size = Vector2(363,44)},
6: {pos = Vector2(125,57), size = Vector2(363,44)},
7: {pos = Vector2(9,455), size = Vector2(143,59)},
8: {pos = Vector2(604,8), size = Vector2(75,60)},
9: {pos = Vector2(182,532), size = Vector2(333,69)},
10: {pos = Vector2(10,105), size = Vector2(290,53)},
11: {pos = Vector2(4,519), size = Vector2(1086,92)},
12: {pos = Vector2(839,531), size = Vector2(146,69)},
13: {pos = Vector2(839,531), size = Vector2(146,69)},
}


func starttutorial():
	get_node("tutorialpanel").set_hidden(true)
	get_node("tutorialinfo").set_hidden(false)
	get_node("highlightpanel").set_hidden(false)
	stage = 1
	tutorialwindow()

func tutorialwindow():
	var textnode = get_node("tutorialinfo/turorialtext")
	var info = get_node("tutorialinfo")
	var location = center
	var text = ''
	if stage == 1:
		get_node("tutorialinfo/tutorialprevious").set_hidden(true)
	else:
		get_node("tutorialinfo/tutorialprevious").set_hidden(false)
	text = scripttext[stage]
	if stage == 1:
		get_parent()._on_mansion_pressed()
		location = center
	elif stage == 1.1:
		get_parent()._on_mansion_pressed()
		location = center
	elif stage == 2:
		get_parent().currentslave = 0
		get_parent().get_node("MainScreen/slave_tab").set_hidden(false)
		get_parent().get_node("MainScreen/slave_tab").set_current_tab(0)
		location = side
	elif stage == 3:
		get_parent().get_node("MainScreen/slave_tab").set_hidden(false)
		get_parent().get_node("MainScreen/slave_tab").set_current_tab(1)
		location = side
	elif stage == 4:
		get_parent().get_node("MainScreen/slave_tab").set_hidden(false)
		get_parent().get_node("MainScreen/slave_tab").set_current_tab(2)
		location = side
	elif stage == 5:
		get_parent().get_node("MainScreen/slave_tab").set_hidden(false)
		get_parent().get_node("MainScreen/slave_tab").set_current_tab(3)
		location = side
	elif stage == 6:
		get_parent().get_node("MainScreen/slave_tab").set_hidden(false)
		get_parent().get_node("MainScreen/slave_tab").set_current_tab(4)
		location = side
	elif stage == 7:
		get_parent()._on_jailbutton_pressed()
		location = side
	elif stage == 8:
		get_parent()._on_mansion_pressed()
		location = center
	elif stage == 9:
		get_parent()._on_mansion_pressed()
		location = center
	elif stage == 10:
		get_parent().get_node("outside")._on_leave_pressed()
		location = outside
	elif stage == 11:
		get_parent().get_node("outside")._on_leave_pressed()
		location = outside
	if stage == 12:
		get_parent()._on_mansion_pressed()
		get_node("tutorialinfo/tutorialnext").set_text('Close')
		location = center
	else:
		get_node("tutorialinfo/tutorialnext").set_text('Next')
	if stage == 13:
		globals.state.tutorialcomplete = true
		set_hidden(true)
	
	info.set_pos(location.box.pos)
	info.set_size(location.box.size)
	info.get_node("turorialtext").set_pos(location.text.pos)
	info.get_node("turorialtext").set_size(location.text.size)
	info.get_node("tutorialprevious").set_pos(location.buttonback.pos)
	info.get_node("tutorialprevious").set_size(location.buttonback.size)
	info.get_node("tutorialnext").set_pos(location.buttonnext.pos)
	info.get_node("tutorialnext").set_size(location.buttonnext.size)
	get_node("highlightpanel").set_pos(highlightpanel[stage].pos)
	get_node("highlightpanel").set_size(highlightpanel[stage].size)
	textnode.set_bbcode(globals.slaves[get_parent().currentslave].dictionary(text))

func _on_tutorialnext_pressed():
	stage = sequence[sequence.find(stage)+1]
	tutorialwindow()


func _on_tutorialprevious_pressed():
	stage = sequence[sequence.find(stage)-1]
	tutorialwindow()


