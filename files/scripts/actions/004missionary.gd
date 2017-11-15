extends Node

var category = 'fucking'
var code = 'missionary'
var givers
var takers
var canlast = true
var givereffects = {lust = 50, sens = 100}
var targeteffects = {lust = 50, sens = 100, pain = 20}
var giverpart = 'penis'
var takerpart = 'vagina'

func getname(state = null):
	return "Missionary"

func getongoingname(givers, takers):
	return "[name1] fuck[s/1] [name2] in the missionary position."

func getongoingdescription(givers, takers):
	return "[name1] continue[s/1] fucking [names2] [pussy2] in the missionary position."

func requirements():
    var valid = true
    if takers.size() != 1 || givers.size() != 1:
        valid = false
    elif (!givers[0].penis in [takers[0].vagina, takers[0].anus] && (takers[0].vagina != null || givers[0].penis != null)) || takers[0].person.vagina == 'none':
        valid = false
    return valid

func initiate():
	var text = ''
	text = "[name1] lay[s/1] [name2] down on [his2] back, parting [his2] thighs to expose [his2] [pussy2]. [names2] [labia2] envelop [names1] [penis1] as [he1]"
	if takers[0].person.vagvirgin == true:
		text += " rip[s/1] open [partners2] hymen."
		takers[0].person.vagvirgin = false
	else:
		text += " push[es/1] [his1] [penis1] deep into [partners2] [pussy2]."
	text += " [names2] bod[y/ies2] twitch[es/2] as [his2] [pussy2] get[s/2] stretched by [names1] [penis1]."
	return text


#func reaction(member):
#	var text = ''
#	var pleasure = member.sens
#	return text

