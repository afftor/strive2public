extends Node

var texts = {
massage = {
text1 = {consensual = 'consensual', notslavesex = 'male', nottitsize = 'flat', loyaltybelow = 70, text = 'You instruct $name to sit on the bed beside you. She looks a bit anxious, or possibly... hopeful? More anxious it seems, although you can never be sure. You start slow, your hands tracing her neck, gently rubbing her shoulders. As she begins to relax, your hands begin to slip around towards the sides, then the front, never quite reaching her breasts, and eventually leaving the poor $race yearning to be actually touched.'},
text2 = {consensual = 'consensual', notslavesex = 'male', nottitsize = 'flat', loyaltyabove = 70, text = 'At your command, $name happily sits on the bed beside you. She looks a bit anxious, or possibly... hopeful? Yes, definitely hopeful. You start slow, your hands tracing her neck, gently rubbing her shoulders. As your hands deftly work thier way around her, she sighs and leans back into you, pressing against your chest. Your hands quest upwards, finding her breasts, and eliciting a series of small moans from your plaything as you gently kneed them. A tweak and a light pinch of one of her nipples brings her nearly to the edge, but with a small smirk you tell the little $race to return to her duties.' },
text3 = {consensual = 'consensual', titsize = 'flat', loyaltybelow = 70, text = 'You instruct $name to sit on the bed beside you. $He looks a bit anxious, or possibly... hopeful? More anxious it seems, although you can never be sure. You start slow, your hands tracing thier neck, gently rubbing their shoulders. As $he begins to relax, your hands begin to slip around towards the sides, then the front, never quite reaching thier nipples, and eventually leaving the poor $race yearning to be actually touched.'},
text4 = {consensual = 'consensual', titsize = 'flat', loyaltyabove = 70, text = 'You instruct $name to sit on the bed beside you. SHe looks a bit anxious or possibly hopeful? Difficult to tell. You start slow, your hands tracing thier neck, gently rubbing thier shoulders. As $he begins to relax, your hands begin to slip around towards the sides, then the front, progressivly moving closer and closer to thier nipples. When you finally do reach them, it takes a disapointingly low number to pinches and tweaks to bring them close to the edge, and you secretly enjoy the disbelieving look $he gives you as you casually dismiss them.'},
},
pussy = {
text1 = {function = 'pussysex'}
},
ass = {
text1 = {function = 'analsex'},
text2 = {consensual = 'nonconsensualdislike', pchaspenis = true, text = '$name averts $his eyes, as you position $him to have access to $his rear. Not waiting for long, you push cock inside of $his ass making $him yelp at the sudden invasion. $He tries to get away and break free but you firmly hold his body in place. As you move inside of $his ass, tears start falling down here cheeks and $he begs you to stop. $His desperation brings you closer to climax.'},
},
blowjob = {
text1 = {function = 'blowjobsex'},
text2 = {consensual = 'nonconsensualdislike', text = "You tightly tie $name in place. Brushing over $his cheek, you take a ring gag. After a moment you have fix a gag in the $child's mouth. You take off your pants and direct your cock into the poor thing's face. $His clumsy attempts to evade it only provoke you further. With force you insert you cock into $his open mouth, making $him moan in protest. $His warm and damp tongue instinctively tries to push out the invader, but it only increases your pleasure. With glee you grabs the victim's head and hold it in place. With every thrust you force yourself into $his throat deeper and deeper. By this time moans are replaced with whimper and cries while $his tear-stained eyes begin to express humility. The sight of $him choking on you cock brings you closer to climax."},
},
hairjob = {
text1 = {function = 'hairjob'}
},
}

var categories = {
petting = {code = 'petting', name = 'Petting', actions = ['handjob', 'fingering','handjobgive', 'fingeringtake'], cost = 10, description = 'Good for getting more intimate. Likely to lead to other, even more intimate activities. .', prereq = [], number = 0, unlockdescript = "With some confidence you talk $name into moving to the next point in your relationship and allow you to play with $his body. "}, 
oral = {code = 'oral', name = 'Oral sex', actions = ['oral', 'blowjob','blowjobgive', 'oraltake', 'rimjob', 'rimjobgive'], cost = 25, description = "Oral sex is very stimulating and good for bringing at least one of the partners to orgasm.", prereq = ['petting'], number = 1, unlockdescript = "You talk $name into using their mouth for more than just kissing. "},
vaginal = {code = 'vaginal', name = 'Classic sex', actions = ['pussy','pussytake'], cost = 20, description = "Old plain vanilla sex. Chances are you were conceived like this. ", prereq = ['petting'], number = 2, unlockdescript = "With some difficulties you talk $name into having proper sex with you. "},
anal = {code = 'anal', name = 'Anal', actions = ['ass','asstake'], cost = 30, description = "Some like it there better.\nRequired for rear selections. ", prereq = ['petting'], number = 3, unlockdescript = "You managed to talk $name into trying anal sex with you. "},
toys = {code = 'toys', name = 'Sexual toys', actions = ['dildo','dildotake'], cost = 20, description = "Nothing too fancy, but still can be pleasantly new.", prereq = ['petting'], number = 1.1, unlockdescript = "With some effort you convince $name that using additional toys in bed can spice things up. "},
fetish = {code = 'fetish', name = 'Fetish actions', actions = ['hairjob','titfuck','titfuckgive','earfuck','footjob','footjobgive','breastfeed','lbondage'], cost = 30, description = "Less common sexual practices which might turn some people off.", prereq = ['petting'], number = 4, unlockdescript = "With some effort you managed to make $name agree to comply with your weird fantasies. "},
fetish2 = {code = 'fetish2', name = 'Advanced Fetish actions', actions = ['tailjob','tailpeg','tailpegtake','hbondage'], cost = 40, description = "More pervertedness.", prereq = ['fetish'], number = 5, unlockdescript = "$name agreed to go all the way with you, since there's no point stopping anymore. "},
swing = {code = 'swing', name = 'Swing', actions = [], cost = 50, description = "It's a bit of one way, but might still be demanded.\nUnlocks option to choose different person for partner. ", prereq = ['petting'], number = 6, unlockdescript = "With great effort you managed to convince $name to have sex with others on your request. "},
group = {code = 'group', name = 'Group', actions = [], cost = 70, description = "The more, the merrier. \nUnlocks group sex. ", prereq = ['swing'], number = 7, unlockdescript = "After long discussion, $name gave up and agrees to participate in orgies from now on. "},
}


var normalscenes = {
'kiss': {
consensual = 'You deeply kiss $name and tightly hug $his body. $He responds to your embrace and takes noticable pleasure from the contact. ',
rape = "You forcefully push your way into $name's mouth and spend some time exploring it with your tongue. ",
swing = "$2name and $name share a passionate kiss. They clearly enjoy each other as you watch. ",
swingforced = "$name forcefully embraces and kisses $name at your order. ",
}, 'massage': {
consensual = 'You give $name a gentle massage helping $him to relax and improve $his mood.',
swing = "$2name gives $name a gentle massage helping $him to relax and improve $his mood.",
}, 'handjob': {
consensual = '$name obediently jerks you off bringing you to climax in few minutes. ',
swing = "$name obediently jerks off $2name's cock. ",
}, 'fingering': {
consensual = "You thoroughly work on $name's $hole with your hand until $he cums.",
swing = "$2name thoroughly work on $name's $hole with $2his hand until $he cums.",
}, 'oral': {
consensual = 'You make $name spread $his legs for you and thoroughly lick $his pussy.',
swing = "$name lets $2name thoroughly lick $his pussy. ",
}, 'blowjob': {
consensual = '$name takes your cock into $his mouth and gives you a blowjob, eventually making you cum.',
rape = "You force your cock into $name's mouth, raping it and pouring everything down $his throat. ",
swing = "$name takes $2name's cock into $his mouth and gives $2him a blowjob, eventually making @2him cum.",
swingforced = "$2name forces $2his cock into $name's mouth, raping it and pouring everything down $his throat. ",
}, 'titfuck': {
consensual = '$name takes your cock between $his breasts and stimulates it with passion, soon making you cum.',
swing = "$name takes $2name's cock between $his breasts and stimulates it with passion, soon making $2him cum.",
}, 'handjobgive': {
consensual = 'You give $name a handjob as $he moans pleasantly eventually spraying $his cum.',
swing = "",
}, 'fingeringtake': {
consensual = '$name stimulates your $hole with $his hand until you quickly come.',
swing = "",
}, 'oraltake': {
consensual = '$name thoroughly tongues your pussy until you finally cum into $his mouth. ',
swing = "",
}, 'blowjobgive': {
consensual = 'You give $name a fine blowjob as $he moans in pleasure being brushed by your tongue.',
swing = "$2name takes $name's cock into $2his mouth and makes @him moan in pleasure from the stimulation. ",
}, 'titfuckgive': {
consensual = "You give $name's cock a pleasant treatment with your boobs and mouth.",
swing = "$2name gives $name a tifuck with $2his ample breasts. ",
}, 'pussy': {
consensual = "$name lets you pound $his pussy while moaning in ecstasy. ",
rape = "You overpower and rape $name's pussy. ",
swing = "$2name pushes $name down and rams his $2penis into $his pussy. ",
swingforced = "$2name forcefully pushes down $name onto the bed and ruthlessly penetrates $him with $2penis. ",
}, 'ass': {
consensual = "$name invites you to fuck $his asshole taking clear joy from it. ",
rape = "You overpower and rape $name's asshole. ",
swing = "$name takes $2name's $2penis into $his asshole with joy. ",
swingforced = "$2name forcefully pushes down $name onto the bed and ruthlessly penetrates $his asshole with $2penis. ",
}, 'pussytake': {
consensual = "You let $name fuck your pussy with $his $penis. ",
swing = "$2name rides $name's $penis with clear joy. ",
}, 'asstake': {
consensual = "You let $name fuck your asshole with $his $penis. ",
swing = "$2name lets $name fuck $2his asshole with $his $penis. ",
}, 'nipplefuck': {
consensual = "$name lets your fuck $his soft, stretching nipples. ",
swing = "$name lets $2name fuck $his soft, stretching nipples. ",
}, 'bestiality': {
consensual = "$name lets a big dog fuck $him as you watch. ",
rape = "You tie $name up and let a big dog fuck $him as you watch. ",
}, 'hairjob': {
consensual = "$name gives your cock tender care with $his hair. ",
swing = "$name carefully masturbates $2name's $penis with $his hair. ",
}, 'footjob': {
consensual = "$name jerks you off with $his feet. ",
swing = "$name jerks off $2name with $his feet. ",
}, 'rimjob': {
consensual = "$name obediently licks your asshole clean. ",
swing = "$name obediently licks $2name's asshole clean. ",
}, 'earfuck': {
consensual = "$name jerks you off with $his lengthy ears. ",
swing = "$2name jerks off $2name with $his lengthy ears. ",
}, 'tailjob': {
consensual = "With naughty smile, $name wraps $his tail over your cock providing enough stimulation for you to reach orgasm in few minutes. ",
swing = "$name skillfully uses $his tail over $2name's cock, providing enough stimulation for $2him to reach orgasm in few minutes. ",
}, 'footjobgive': {
consensual = "You dominatively stroke $name's cock with your feet. ",
swing = "$2name dominatively strokes $name's cock with $2his feet. ",
}, 'rimjobgive': {
consensual = "You use your tongue to stimulate $name's ass. ",
swing = "$2name uses $2his tongue to stimulate $name's ass. ",
}, 'tailpeg': {
consensual = "You strip $name and penetrate $his $hole with your tail. ",
rape = "You forcefully push $name down and despite $his protests, penetrate $his hole with your long tail. ",
swing = "$2name uses $2his tail to penetrate $name's $hole. ",
swingforced = "$2name pushes $name down and uses $2his tail to penetrate $name's $hole.",
},
'tailpegtake': {
consensual = "As you both undress, $name hugs you from behind and presses $his tail against your $hole, before spreading and penetrating it. ",
swing = "$name uses $his tail to penetrate $2name's $hole. ",
}, 'dildo': {
consensual = "After you both strip off your clothes, you take medium-sized dildo and use it to penetrate $name's $hole. ",
rape = "You forcefully push $name down and despite $his protests, penetrate $his $hole with a medium-sized dildo. ",
swing = "$2name strips $name's clothes and uses dildo to play with $name's ass. ",
swingforced = "$2name forcefully push $name down and despite $his protests, penetrates $his $hole with a medium-sized dildo.",
}, 'dildotake': {
consensual = "You undress and lay down giving $name easy access to your body. By your order, $he picks up a medium-sized dildo and pushes it into your $hole. ",
swing = "$2name lets $name  use a dildo on $2his $hole. ",
},'breastfeed': {
consensual = "You latch onto $name's nipples with your mouth, greedily sucking milk out of them as $he moans under your attack. ",
swing = "$2name sucks milk out of $name's tits, while massaging $his body and making $him moan sweetly. ",
},'lbondage': {
consensual = "You tie $name's hands together and tether $him to the bed. As you go over $his helpless body, $name submissively moans at your touch. As you both get sufficiently aroused, you penetrate $name's body, roughly fucking $him, $he accompanies you with $his passionate cries. ",
swing = "As a tied up $name lies on the bed, $2name passionately plays with $his body, dominantly fucking $him in a rough manner. ",
rape = "You tie up resisting $name's hands and push $him onto the bed. Despite $his pleas, you forcefully fuck $his defenseless body to your heart's content. ",
swingforced = "After tying up resisting $name's hands, you order $2name teach $him a lesson. Despite $name's pleas, $2he joyfully plays with $his body, roughly fucking $him afterwards. ",
},'hbondage': {
consensual = "After completely restricting $name's body, blindfolding and gagging $him, you slowly discipline $him with unharming tools, focusing on privates and erogenous zones. As room fills with $his lustful moans, you proceed to overpower $his helpless body and fuck $his reddened privates. ",
swing = "After completely restricting $name's body, blindfolding and gagging $him, $2name slowly discipline $him with unharming tools, focusing on privates and erogenous zones. As the room fills with $his lustful moans, $2name proceed to  overpower $his helpless body and fuck $his reddened privates. ",
rape = "With force, you secure, tie, blindfold and gag $name as $he tries to resist. With that you give $him a full course of discipline with specially designed tools, focusing on private places, until $his moans show his arousal, after which you finally rape $his restrained body. ",
swingforced = "With force, you secure, tie, blindfold and gag $name as $he tries to resist. With that you order $2name to give $him a full course of discipline with specially designed tools, focusing on their private places. After $name's moans starts to show a reasonable amount of arousal, $2name finally rape $his restrained body. ",
},
}

var sexbuttons = {

kiss = {
name = 'Kiss',
type = 'foreplay',
description = 'Spend private time mouth to mouth with $name.',
energycost = 12,
cost = 0,
basereward = 1,
canbeforced = true,
tags = ['oral'],
basemana = 1,
alwaysallowed = true,
slavereqs = 'true',
playerreqs = 'true',
receive = false,
lusteffect = 15,
},
massage = {
name = 'Massage',
type = 'foreplay',
description = 'You will give $name an erotic massage.',
energycost = 15,
cost = 10,
basereward = 3,
canbeforced = false,
tags = ['touch'],
basemana = 2,
alwaysallowed = true,
slavereqs = 'true',
playerreqs = 'true',
receive = false,
lusteffect = 20,
},
handjob = {
name = 'Handjob',
type = 'foreplay',
description = '$name will give you a handjob.',
energycost = 15,
cost = 15,
basereward = 2,
canbeforced = false,
tags = ['touch'],
basemana = 3,
alwaysallowed = false,
slavereqs = "globals.currentslave.arms == 'normal'",
playerreqs = 'globals.partner.penis.number >= 1',
receive = false,
lusteffect = 15,
},
fingering = {
name = 'Fingering',
type = 'foreplay',
description = "You will use fingers to stimulate $name's orifices.",
energycost = 20,
cost = 15,
basereward = 4,
canbeforced = false,
tags = ['touch','cancum','choosehole'],
basemana = 2,
alwaysallowed = false,
slavereqs = 'true',
playerreqs = 'globals.partner.arms == "normal"',
receive = false,
lusteffect = 25,
},
oral = {
name = 'Oral',
type = 'foreplay',
description = "You will lick $name's pussy.",
energycost = 20,
cost = 25,
basereward = 4,
canbeforced = false,
tags = ['touch','dom','cancum'],
basemana = 2,
alwaysallowed = false,
slavereqs = 'globals.currentslave.pussy.has == true',
playerreqs = 'true',
receive = false,
lusteffect = 35,
},
blowjob = {
name = 'Blowjob',
type = 'foreplay',
description = '$name will give you a blowjob.',
energycost = 15,
cost = 25,
basereward = 3,
canbeforced = true,
tags = ['oral','sub'],
basemana = 3,
alwaysallowed = false,
slavereqs = 'true',
playerreqs = 'globals.partner.penis.number >= 1',
receive = false,
lusteffect = 20,
},
titfuck = {
name = 'Titfuck',
type = 'foreplay',
description = '$name will give you a titjob.',
energycost = 20,
cost = 35,
basereward = 5,
canbeforced = false,
tags = ['oral','touch','sub'],
basemana = 4,
alwaysallowed = false,
slavereqs = 'globals.sizearray.find(globals.currentslave.tits.size) >= 2',
playerreqs = 'globals.partner.penis.number >= 1',
receive = false,
lusteffect = 30,
},
handjobgive = {
name = 'Give Handjob',
type = 'foreplay',
description = 'You will give handjob to $name.',
energycost = 20,
cost = 20,
basereward = 3,
canbeforced = false,
tags = ['touch','penis','cancum','dom'],
basemana = 2,
alwaysallowed = false,
slavereqs = 'globals.currentslave.penis.number >= 1',
playerreqs = 'globals.partner.arms == "normal"',
receive = true,
lusteffect = 30,
},
fingeringtake = {
name = 'Take Fingering',
type = 'foreplay',
description = '$name will finger your orifices.',
energycost = 15,
cost = 15,
basereward = 2,
canbeforced = false,
tags = ['touch','chooseholeself','sub'],
basemana = 2,
alwaysallowed = false,
slavereqs = 'globals.currentslave.arms == "normal"',
playerreqs = 'true',
receive = true,
lusteffect = 15,
},
oraltake = {
name = 'Take Oral',
type = 'foreplay',
description = '$name will give a lick to your pussy.',
energycost = 15,
cost = 25,
basereward = 3,
canbeforced = false,
tags = ['oral','sub'],
basemana = 3,
alwaysallowed = false,
slavereqs = 'true',
playerreqs = 'globals.partner.pussy.has == true',
receive = false,
lusteffect = 15,
},
blowjobgive = {
name = 'Give Blowjob',
type = 'foreplay',
description = 'You will give blowjob to $name.',
energycost = 20,
cost = 20,
basereward = 4,
canbeforced = false,
tags = ['touch','dom','penis','cancum'],
basemana = 3,
alwaysallowed = false,
slavereqs = 'globals.currentslave.penis.number >= 1',
playerreqs = 'true',
receive = true,
lusteffect = 35,
},
titfuckgive = {
name = 'Give Titfuck',
type = 'foreplay',
description = 'You will give titfuck to $name.',
energycost = 20,
cost = 30,
basereward = 5,
canbeforced = false,
tags = ['touch','dom','penis','cancum'],
basemana = 4,
alwaysallowed = false,
slavereqs = 'globals.currentslave.penis.number >= 1',
playerreqs = 'globals.sizearray.find(globals.partner.tits.size) >= 1',
receive = true,
lusteffect = 40,
},
hairjob = {
name = 'Hairjob',
type = 'fetish',
description = '$name will give you a hairjob.',
energycost = 20,
cost = 50,
basereward = 5,
canbeforced = false,
tags = ['touch','sub','fetish','degrading'],
basemana = 4,
alwaysallowed = false,
slavereqs = 'globals.hairlengtharray.find(globals.currentslave.hairlength) >= 1',
playerreqs = 'globals.partner.penis.number >= 1',
receive = false,
lusteffect = 15,
},
footjob = {
name = 'Footjob',
type = 'fetish',
description = '$name will give you a footjob.',
energycost = 20,
cost = 40,
basereward = 3,
canbeforced = false,
tags = ['touch','dom','fetish'],
basemana = 4,
alwaysallowed = false,
slavereqs = 'true',
playerreqs = 'globals.partner.penis.number >= 1',
receive = false,
lusteffect = 15,
},
rimjob = {
name = 'Rimjob',
type = 'fetish',
description = '$name will give you a rimjob.',
energycost = 20,
cost = 55,
basereward = 2,
canbeforced = false,
tags = ['oral','sub','fetish','degrading'],
basemana = 3,
alwaysallowed = false,
slavereqs = 'true',
playerreqs = 'globals.partner.sexuals.unlocks.has("anal") || globals.partner == globals.player',
receive = false,
lusteffect = 15,
},
earfuck = {
name = 'Earfuck',
type = 'fetish',
description = '$name will let you fuck $him into $his ears.',
energycost = 20,
cost = 65,
basereward = 5,
canbeforced = false,
tags = ['touch','sub','fetish','degrading'],
basemana = 4,
alwaysallowed = false,
slavereqs = "globals.currentslave.ears != 'human'",
playerreqs = 'globals.partner.penis.number >= 1',
receive = false,
lusteffect = 20,
},
tailjob = {
name = 'Tailjob',
type = 'fetish',
description = '$name will give you a tailjob.',
energycost = 20,
cost = 60,
basereward = 5,
canbeforced = false,
tags = ['touch','fetish','degrading'],
basemana = 5,
alwaysallowed = false,
slavereqs = 'globals.longtails.find(globals.currentslave.tail) >= 0',
playerreqs = 'globals.partner.penis.number >= 1',
receive = false,
lusteffect = 20,
},
footjobgive = {
name = 'Give Footjob',
type = 'fetish',
description = 'You will give footjob to $name.',
energycost = 20,
cost = 40,
basereward = 4,
canbeforced = true,
tags = ['touch','fetish','sub','penis','degrading','cancum'],
basemana = 4,
alwaysallowed = false,
slavereqs = 'globals.currentslave.penis.number >= 1',
playerreqs = 'true',
receive = false,
lusteffect = 30,
},
rimjobgive = {
name = 'Give Rimjob',
type = 'fetish',
description = 'You will give rimjob to $name.',
energycost = 20,
cost = 45,
basereward = 5,
canbeforced = false,
tags = ['touch','anal','fetish','dom','degrading','cancum'],
basemana = 4,
alwaysallowed = false,
slavereqs = 'globals.currentslave.sexuals.unlocks.has("anal")',
playerreqs = 'true',
receive = false,
lusteffect = 30,
},
pussy = {
name = 'Vaginal Sex',
type = 'penetration',
description = "You will fuck $name's pussy.",
energycost = 25,
cost = 20,
basereward = 5,
canbeforced = true,
tags = ['penetration','cancum','pussy'],
basemana = 4,
alwaysallowed = false,
slavereqs = 'globals.currentslave.pussy.has == true',
playerreqs = 'true',
receive = false,
lusteffect = 40,
},
ass = {
name = 'Anal Sex',
type = 'penetration',
description = "You will fuck $name's ass.",
energycost = 25,
cost = 35,
basereward = 4,
canbeforced = true,
tags = ['penetration','anal','cancum','sub'],
basemana = 4,
alwaysallowed = false,
slavereqs = 'true',
playerreqs = 'true',
receive = false,
lusteffect = 35,
},
pussytake = {
name = 'Receive Vaginal Sex',
type = 'penetration',
description = "$name will fuck you in the pussy with $penis",
energycost = 25,
cost = 20,
basereward = 4,
canbeforced = false,
tags = ['penis','cancum','selfpenetration'],
basemana = 5,
alwaysallowed = false,
slavereqs = 'globals.currentslave.penis.number >= 1 || globals.currentslave.sexuals.unlocks.has("toys") == true',
playerreqs = 'globals.partner.pussy.has == true',
receive = true,
lusteffect = 35,
},
asstake = {
name = 'Receive Anal Sex',
type = 'penetration',
description = "$name will fuck you in the ass with $penis",
energycost = 25,
cost = 30,
basereward = 5,
canbeforced = false,
tags = ['penis','cancum','dom'],
basemana = 4,
alwaysallowed = false,
slavereqs = 'globals.currentslave.penis.number >= 1 || globals.currentslave.sexuals.unlocks.has("toys") == true',
playerreqs = 'true',
receive = true,
lusteffect = 35,
},
nipplefuck = {
name = 'Nipplefuck',
type = 'fetish',
description = "$name will let you fuck $his nipples",
energycost = 25,
cost = 50,
basereward = 5,
canbeforced = false,
tags = ['fetish','degrading','cancum','sub'],
basemana = 5,
alwaysallowed = false,
slavereqs = "globals.currentslave.mods.has('hollownipples') == true",
playerreqs = 'globals.partner.penis.number >= 1',
receive = false,
lusteffect = 35,
},
bestiality = {
name = 'Bestiality',
type = 'fetish',
description = "$name will be fucked by a dog",
energycost = 25,
cost = 80,
basereward = 3,
canbeforced = false,
tags = ['penetration','fetish','degrading','choosehole','cancum','cantswing','sub'],
basemana = 5,
alwaysallowed = false,
slavereqs = 'true',
playerreqs = 'true',
receive = false,
lusteffect = 35,
},
tailpeg = {
name = 'Tailpegging',
type = 'fetish',
description = "You will use your tail to penetrate $name. ",
energycost = 20,
cost = 65,
basereward = 4,
canbeforced = true,
tags = ['penetration','fetish','degrading','choosehole','cancum','sub'],
basemana = 3,
alwaysallowed = false,
slavereqs = 'true',
playerreqs = 'globals.longtails.find(globals.partner.tail) >= 0',
receive = false,
lusteffect = 40,
},
tailpegtake = {
name = 'Receive Tailpegging',
type = 'fetish',
description = "$name will use $his tail to penetrate you. ",
energycost = 20,
cost = 75,
basereward = 4,
canbeforced = false,
tags = ['fetish','degrading','chooseholeself','selfpenetration','dom'],
basemana = 3,
alwaysallowed = false,
slavereqs = 'globals.longtails.find(globals.currentslave.tail) >= 0',
playerreqs = 'true',
receive = true,
lusteffect = 30,
},
dildo = {
name = 'Fuck with Dildo',
type = 'penetration',
description = "You will use dildo on $name. ",
energycost = 20,
cost = 25,
basereward = 3,
canbeforced = true,
tags = ['penetration','choosehole','cancum','sub'],
basemana = 3,
alwaysallowed = false,
slavereqs = 'true',
playerreqs = 'true',
receive = false,
lusteffect = 30,
},
dildotake = {
name = "Be fucked with Dildo",
type = 'penetration',
description = "$name will use dildo on you. ",
energycost = 20,
cost = 20,
basereward = 3,
canbeforced = false,
tags = ['dom','chooseholeself','selfpenetration'],
basemana = 3,
alwaysallowed = false,
slavereqs = 'true',
playerreqs = 'true',
receive = true,
lusteffect = 20,
},
lbondage = {
name = "Light bondage",
type = 'fetish',
description = "You will restirct $name's limbs and play with $his body. ",
energycost = 20,
cost = 20,
basereward = 3,
canbeforced = true,
tags = ['fetish','cancum','choosehole','sub','penetration'],
basemana = 3,
alwaysallowed = false,
slavereqs = 'true',
playerreqs = 'true',
receive = false,
lusteffect = 30,
},
hbondage = {
name = "Hard bondage",
type = 'fetish',
description = "You will restirct $name's whole body and provide $him with some heavy-handed discipline. ",
energycost = 25,
cost = 20,
basereward = 4,
canbeforced = true,
tags = ['fetish','cancum','choosehole','sub','degrading','penetration'],
basemana = 4,
alwaysallowed = false,
slavereqs = 'true',
playerreqs = 'true',
receive = false,
lusteffect = 40,
},
breastfeed = {
name = "Breastfeeding",
type = 'fetish',
description = "$name let you suck milk from $his nipples. ",
energycost = 20,
cost = 20,
basereward = 3,
canbeforced = false,
tags = ['fetish'],
basemana = 3,
alwaysallowed = false,
slavereqs = 'globals.currentslave.tits.lactation == true',
playerreqs = 'true',
receive = false,
lusteffect = 20,
},
}
func pussysex(slave):
	var text = ''
	text += "You gesture to $name to take $his clothes off. "
	if slave.sexuals.actions.size() >= 8: 
		text += "$He agrees eagerly almost immediately, and quickly strips to give you full access to $his body. "
	elif slave.sexuals.actions.size() >= 5:
		text += "$He agrees readily and without fuss, stripping and giving you full access to $his body. "
	else:
		text += " $He hesitates for a moment, but eventually agrees, stripping to give you full access to $his body. "
	text += "You don’t keep $him waiting for very long. Leaning down, you press your mouth against $his " + globals.fastif(slave.bodyshape == 'bestial', "muzzle", "own") + " eagerly tasting inside, even as $he starts to respond.  Your hands stroke over $his body, things growing more heated as you line up the tip of " +  globals.player.dictionaryplayer("$penis") + " sliding up and down $his lower lips. $He’s already more than soaked, and you have no trouble at all parting $his folds and pushing into $his body. $He " + globals.fastif(slave.pussy.virgin == true, "winces rather hard, the resistance within her breaking away a moment later as she gasps, then", "") + globals.fastif(slave.sexuals.actions.pussy >= 4, " gives a lusty moan and", "") + " squirms under you as you start a steady pace of thrusts into $his body, holding $him to you as $his legs wrap around your back almost instinctively" + globals.fastif(slave.tail != "none", " and $his tail wraps around your leg", "" )+ ". $His insides are hot and wet against your " +  globals.player.dictionaryplayer("$penis") + ", feeling amazing and you slide in and out of $his body. " + globals.fastif(slave.pussy.virgin == true, "A small amount of pink tinting to the fluids around your connection prove it.  You’ve taken $his virginity. ", "")
	text += "\n\nIt doesn’t take long before you feel yourself nearing the end, and pick up the pace pounding into $his body, possessively kissing $him as you hold her down. Taken by $his own instincts, $name moans into the kiss as $his whole body rocks under you. " +  globals.fastif(globals.player.penis.number >= 1, "$He clenches down a moment later, shivering as you feel $his walls start to squeeze and contract around you, almost begging you for your seed. " , "" ) + globals.fastif(slave.penis.number >= 1, "Her own dick twitches as well, messily splattering up $his stomach.", "") + globals.fastif(globals.player.penis.number >= 1, " Soon you slam in as deep as you can go and flooding her core with your cum. ", "")
	return text

func analsex(slave):
	var text = "With a simple gesture, you order $name to strip, moving around behind $him as $he does. " 
	if slave.sexuals.actions.ass >= 5:
		text += "$He seems to know what’s coming and does so eagerly, a smile playing at $his lips. "
	elif slave.loyal >= 60:
		text += "$He seems to know what’s coming and does as instructed. "
	else:
		text += "$He hesitates at your intent, but nervously strips while looking over $his shoulders at you. " 
	text +=  "You don’t waste any time "
	if slave.tail != 'none' && slave.sexuals.actions.size() >= 6: 
		text +="smirking as $he eagerly lifts $his tail out of the way for you, then "
	elif slave.tail != 'none':
		text += "lifting $his tail out of the way and "
	text += globals.player.dictionaryplayer("pressing your $penis") + " up and nestling it between the cheeks of $his ass.  Your hands squeeze both sides of $his hips as you pull $him back against you and grind for a moment, drawing out " + globals.fastif(slave.sexuals.actions.ass >= 4, "an excited groan ", "a nervous whine ") + "from $him.\n\n"
	text += "Working back and forth for a few thrusts, you get a healthy smear over $his rear hole before pushing the tip of your " + globals.player.dictionaryplayer("$penis") + " up against it and pushing firmly inside.  The suddenness causes $him to wince regardless as you waste no time in bottoming out your length in $his ass.  You start a healthy rhythm, "
	if slave.tail != 'none' && slave.sexuals.actions.size() >= 6: 
		text += "$him keeping $his own tail shoved up onto $his back for you.  Grinning at $his eagerness, you start "
	elif slave.tail != 'none':
		text += "using your hand to keep $his tail shoved up onto $his back and "
	text += "pounding hard into $his body. " 
	if slave.sexuals.actions.size() >= 8 && slave.pussy.has == true: 
		text += "It doesn’t take $him long to start $his lustful moaning, $his hand sliding down to finger $himself as you plow $his rear. "
	else:
		text += "$He holds obediently steady, biting $his lower lip as you plow $him over and over again. "
	text += "\n\nPicking up the pace, it doesn’t take long before you feel like coming. " + globals.fastif(globals.player.penis.number >= 1, "Bottoming out in one hard push, you empty your seed into $him rectum, flooding $his bowels with hot liquid as shot after shot is released into $him.", "") + "Feeling the hot cum rushing into $his pushes $him over the edge too, and $he shivers, as $his own juices slide down $his inner thighs" 
	if slave.skincov == 'full_body_fur':
		text += "saturating the fur with $his fluids"
	elif slave.skincov == 'scales':
		text += "slicking $his scales with $his fluids"
	elif slave.skincov == 'feathers':
		text += "saturating the feathers with $his fluids"
	text += ". You unceremoniously pull out of $him, stepping back to admire your handiwork.  Your seed slides slowly down between $his ass cheeks and $his thighs, and $he gives a " + globals.fastif(slave.sexuals.actions.size() >= 3, "pleased purr, looking back over $his shoulder at you as $he licks $his fingers off of $his own juices. "," contented sigh, sagging a little after you let $him go. ") + "You leave $him to clean up as you continue about your day."
	return text

func blowjobsex(slave):
	var text = ''
	text += "You ask $name to give you a blowjob. After a moment of consideration, $he accepts.\n\nYou free your penis from your pants, as $he shimmies down your body $his face drawing level with your groin. Eagerly, $he takes your member into $his "+ globals.fastif(slave.bodyshape == 'bestial', "muzzle", "mouth") + " and begins to carefully suck on you while maintaining eye contact to measure your reaction.\n\n"
	if rand_range(0,1) >= 0.5:
		text += "As you get closer to climax, you order $him to swallow everything, with which $he obediently complies. Your semen gushes into $his throat" +globals.fastif(slave.sexuals.actions.blowjob < 3, ", nearly making $him choke", "") + ". After thanking $him, you leave $him to $his duties."
	else:
		text += "As you climax, you pull out of $his mouth and covering $his "+ globals.fastif(slave.face.beauty >= 70, "pretty", "") + " face and "+slave.haircolor + " hair with your seed."
	return text

func hairjob(slave):
	var text = ''
	text += slave.dictionary("$name gives your cock tender care with $his $haircolor hair. ")
	return text

func getscene(sexaction, slave, consensual):
	if texts.has(sexaction) == false:
		return ''
	var dict = texts[sexaction]
	var array = []
	for i in dict.values():
		var check = true
		if i.has('consensual'):
			if i.consensual != consensual:
				check = false
		if i.has('slavesex'):
			if slave.sex != i.slavesex:
				check = false
		if i.has('notslavesex'):
			if slave.sex == i.notslavesex:
				check = false
		if i.has('titsize'):
			if globals.sizearray.find(slave.tits.size) > globals.sizearray.find(i.titsize):
				check = false
		if i.has('nottitsize'):
			if globals.sizearray.find(slave.tits.size) <= globals.sizearray.find(i.nottitsize):
				check = false
		if i.has('loyaltyabove'):
			if slave.loyal < i.loyaltyabove:
				check = false
		if i.has('loyaltybelow'):
			if slave.loyal >= i.loyaltybelow:
				check = false
		if i.has('pchaspenis'):
			if globals.player.penis.number == 0:
				check = false
		if i.has('function') && check == true:
			array.append(call(i.function, slave))
		elif check == true:
			array.append(i.text)
	if array.size() > 0:
		return array[rand_range(0,array.size())]
	else:
		return ''
