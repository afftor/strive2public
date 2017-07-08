extends Node

var texts = {
massage = {
text1 = {consensual = 'consensual', notslavesex = 'male', nottitsize = 'flat', loyaltybelow = 70, text = 'You instruct $name to sit on the bed beside you. $he looks a bit anxious, or possibly... hopeful? More anxious it seems, although you can never be sure. You start slow, your hands tracing $his neck, gently rubbing $his shoulders. As $he begins to relax, your hands begin to slip around towards the sides, then the front, never quite reaching $his breasts, and eventually leaving the poor $race yearning to be actually touched.'},
text2 = {consensual = 'consensual', notslavesex = 'male', nottitsize = 'flat', loyaltyabove = 70, text = 'At your command, $name happily sits on the bed beside you. $He looks a bit anxious, or possibly... hopeful? Yes, definitely hopeful. You start slow, your hands tracing $his neck, gently rubbing $his shoulders. As your hands deftly work their way around $his, $he sighs and leans back into you, pressing against your chest. Your hands quest upwards, finding $his breasts, and eliciting a series of small moans from your plaything as you gently kneed them. A tweak and a light pinch of one of $his nipples brings $his nearly to the edge, but with a small smirk you tell the little $race to return to $his duties.' },
text3 = {consensual = 'consensual', titsize = 'flat', loyaltybelow = 70, text = 'You instruct $name to sit on the bed beside you. $He looks a bit anxious, or possibly... hopeful? More anxious it seems, although you can never be sure. You start slow, your hands tracing their neck, gently rubbing their shoulders. As $he begins to relax, your hands begin to slip around towards the sides, then the front, never quite reaching their nipples, and eventually leaving the poor $race yearning to be actually touched.'},
text4 = {consensual = 'consensual', titsize = 'flat', loyaltyabove = 70, text = 'You instruct $name to sit on the bed beside you. $He looks a bit anxious or possibly hopeful? Difficult to tell. You start slow, your hands tracing their neck, gently rubbing their shoulders. As $he begins to relax, your hands begin to slip around towards the sides, then the front, progressively moving closer and closer to their nipples. When you finally do reach them, it takes a disappointingly low number to pinches and tweaks to bring them close to the edge, and you secretly enjoy the disbelieving look $he gives you as you casually dismiss them.'},
},
pussy = {
text1 = {consensual = 'consensual', function = 'pussysex', hole = 'pussy'},
text2 = {consensual = 'nonconsensualdislike', pchaspenis = true, function = 'pussyrape',hole = 'pussy'},
text3 = {consensual = 'nonconsensuallike', function = 'pussysex', hole = 'pussy'},
},
ass = {
text1 = {consensual = 'consensual', function = 'analsex'},
text2 = {consensual = 'nonconsensualdislike', pchaspenis = true, text = "$name averts $his eyes as you position $him to have access to $his rear. Not waiting for long, you push cock inside of $his ass making $him yelp at the sudden invasion. $He tries to get away and break free but you firmly hold $his body in place. $he begs you to stop with tears in $his eyes, but the desperation only brings you closer to climax. Soon, you bottom out in $him hard one last time and deposit a heavy load of cum deep in $name's asshole."},
text3 = {consensual = 'nonconsensuallike', function = 'analsexrapelike'},
},
blowjob = {
text1 = {consensual = 'consensual', function = 'blowjobsex'},
text2 = {consensual = 'nonconsensualdislike', function = 'blowjobrape'},
},
hairjob = {
text1 = {consensual = 'consensual', function = 'hairjob'},
},
fingering = {
text1 = {consensual = 'consensual', function = 'fingering', hole = 'pussy'},
text2 = {consensual = 'consensual', function = 'fingeringass', hole = 'ass'},
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
consensual = 'You deeply kiss $name and tightly hug $his body. $He responds to your embrace, taking noticeable pleasure from the contact. Proceeding to make out with $him for a little while, you eventually pull back, slightly breathless and definitively aroused. ',
rape = "Sliding a hand behind $name's head, you grab $him by the hair and hold him tight. With $him at your mercy now, you are free to give $name a forceful kiss. Exploring $his mouth with your tongue is fun, although $he struggles a little in your grasp. ",
swing = "$2name and $name touch each other's bodies a little and share a passionate kiss. They clearly enjoy making out with each other as you watch them go at it. ",
swingforced = "Accepting your order, $name steps up to $2name and pulls $2him into a forceful kiss. $2name struggles a little bit in $his grasp, but has no choice but to obey your wishes. ",
}, 'massage': {
consensual = 'You direct $name to lie down on a bed, then proceed to give $him a gentle massage. Kneading and stroking $his muscles with your hands, you help $name relax quite a bit. By the time you finish and give $his body a last stroke, $name lets out a pleased groan.',
swing = "You tell $2name to take care of $name and $2he proceeds to guide $him to a bed, then gives $him a gentle massage. $name groans in pleasure as $his muscles are kneaded, helping $him relax and improving $his mood.",
}, 'handjob': {
consensual = '$name obediently steps up beside you, wrapping $his hand around your manhood and starts to jerk. With $him slowly stroking up and down on your shaft at first, then going faster and faster, $he brings you to a breathtaking climax in a few minutes. Spurts of cum shoot out of your cock in a high arch, showing your servant how much you liked $his attention. ',
swing = "Instructing $name to take care of $2name, you watch as $he obediently steps up to the other servant and takes hold of $2his cock. Stroking up and down on the erect pole with a smile on $his face, it doesn't take long before $2name is pushed to a gasp out loud as $he comes. ",
}, 'fingering': {
consensual = "Guiding $name over to a sofa, you gently push $him to sit back on it, then strip $his lower body bare with a few quick movements. Spreading $his legs, you crouch down between them and start working $his $hole with your hand, first stroking a little then penetrating $his body with first one finger, then two. Over the next little while, you thoroughly work on $name's $hole with your hand until $he cums.",
swing = "After you point $name out to $2name, $2he approaches $him and soon is working on $name's $hole with $2his hand. The stimulation soon brings $him to a loudly moaned climax, cumming hard.",
}, 'oral': {
consensual = "You guide $name over to your desk, instructing $him to sit on its edge. Crouching in front of $him, you bare $his crotch and push $his legs apart a little, then get to licking $his pussy. Swipe after swipe of your tongue pushes $name to higher and higher arousal in no time, soon giving $him an orgasm and covering your tongue with $his female juices. Catching $his breath afterwards, $name squeezes your shoulders in thanks and contently sighs your name.",
swing = "You direct $2name to take care of $name's need and watch them get into bed together. Soon, $name is lying back with $his legs spread wide, $his friend lying between $his legs and lapping at $name's pussy. It doesn't take all that long before the stimulation pushes $him to a gasping climax, splashing $2name's smiling face with pussy juice.",
}, 'blowjob': {
consensual = '$name takes your cock into $his mouth and gives you a blowjob, eventually making you cum.',
rape = "You force your cock into $name's mouth. Grabing $his head you rape it and pouring everything down $his throat. ",
swing = "With a smile on $his face, $name kneels in front of $2name and takes $2his cock into $his mouth. Bobbing up and down on the hard rod, $he gives $2him an eager blowjob, eventually making $2him cum. $name turns $his head to you and shows off a tongue covered in creamy white before $he closes $his mouth and swallows demonstratively.",
swingforced = "After you point $name out to $2name, $2he walks over to $him and pushes down on $his shoulders, forcing the slave to kneel. Then $2he forces $2his cock into $name's mouth, face-fucking $him hard. It doesn't take long before $2he shoots $2his load down $his throat, holding $name tightly as spurt after spurt is pumped into $him.",
}, 'titfuck': {
consensual = "Being presented with your hard cock and the request to take care of it, $name sinks to $his knees and slides it between $his breasts. $He stimulates your erection by rubbing up against it, an eager smile on $his face. It doesn't take long before you cum, splashing your seed over $name's chest, neck and lower face.",
swing = "$name takes $2name's cock between $his breasts and stimulates it with passion, soon making $2him cum.",
}, 'handjobgive': {
consensual = "You give step up to $name and slide a hand down to $his crotch, taking hold of the servant's manhood. Wrapping your fingers around it, you proceed to stroke it, drawing eager moans from $him. Eventually, your stimulation pushes $him to come, pumping out long spurts of cum to splatter on the ground.",
swing = "$2name wraps $2his hand around $name's cock and begins to stroke it. Eventually $2his stimulation pushes $him over the edge, long spurts of cum splattering onto the ground.",
}, 'fingeringtake': {
consensual = "$name puts a hand on your hip and strokes your thigh, before moving on from there to stimulates your $hole with $his talented fingers, driving your arousal up and up. Thanks to $his eager attention, it doesn't take all that long until you come with a gasped-out moan.",
swing = "",
}, 'oraltake': {
consensual = "$name kneels before you and obediently opens $his mouth to start licking, $his tongue playing over your nether lips in pleasurable swipes that make you all tingly inside. Thanks to $his eager oral service, it doesn't take all that long until you soon come, squirting pussy juice over $his face.",
swing = "",
}, 'blowjobgive': {
consensual = 'You give $name a fine blowjob as $he moans in pleasure being brushed by your tongue.',
swing = "$2name takes $name's cock into $2his mouth and makes @him moan in pleasure from the stimulation. ",
}, 'titfuckgive': {
consensual = "Guiding $name over to a bed, you tell $him to sit down on its edge, then sink into a crouch and pull out $his cock. With a grin on your face, you hold up the quickly hardening shaft and give it a slow, teasing lick. It is fun to see $name react to the stimulation, moaning out loud and digging $his hands into the blanket on the mattress. Baring your own chest, you then proceed to rub $his erection between them, giving $him a very nice time with your boobs and mouth. As wound up as you have $him by this time, it doesn't take all that long before $he comes, giving you a creamy white pearl necklace.",
swing = "Following your instructions, $2name and $name quickly strip, then $2name crouches down and starts to give your other servant a really nice tit-fuck with $2his ample breasts. Between rubbing up against shapely breasts and being serviced orally, it doesn't take all that long before $name comes with a grunt, giving $2name a creamy pearl necklace of cum.",
}, 'pussy': {
consensual = "$name lets you pound $his pussy while moaning in ecstasy. ",
rape = "You overpower and rape $name's pussy. ",
swing = "Guiding your two servants to a bed, you order the two of them to strip down and get on it. They eagerly comply and soon are entwined on the bed, caressing each other and making out. You do not have to say anything more as their mutual stimulation soon expands to $2name moving on top of $2his partner, then sinking $2his $2penis into $his pussy. Both of them moan loudly as $2he starts to pound in and out, fucking $name and giving great pleasure to them both.",
swingforced = "Together with $2name, you drag $name over to a bed and make $him lie back on it, naked. Then you command $2name to take $name's pussy. $2He eagerly climbs on top of $him. $name struggles a little and tries to get away - until you grab hold of $him and hold $him down tight on the bed. Now having a helpless target, $2name ruthlessly penetrates $him with $2penis, thrusting away at a rapid pace.",
}, 'ass': {
consensual = "$name invites you to fuck $his asshole taking clear joy from it. ",
rape = "You overpower and rape $name's asshole. ",
swing = "Gleefully setting to strip down your two servants, you tell $name to step up against a wall, bracing $himself with both hands and bending forward a little. With you giving $his buttocks an appreciative squeeze or two, $2name readily picks up on your plan for how this should go, and before long, $2he stands beside you, $2his $2penis at the ready. Yielding your place, you watch as $2name steps up and sinks $2himself into $name's asshole, taking $him hard from behind.",
swingforced = "$2name forcefully pushes down $name onto the bed and ruthlessly penetrates $his asshole with $2penis. ",
}, 'pussytake': {
consensual = "Guiding $name to your own big and soft bed, you spend a little fun-time stripping $him and yourself, then get in the bed and lay back. With an inviting wave at your naked partner, you spread your legs wide, baring your pussy for $him to see. There is a broad smile on $his face as the $race steps forward, $his $penis leading the way for $him to climb on top of you. Nudging apart your nether lips, $he slides into you with a grunt right after that, then proceeds to give you a pleasurable time of hard fucking.",
swing = "Guiding your two servants to a bed, you order the two of them to strip down and get on it. They eagerly comply and soon are entwined on the bed, caressing each other and making out. You do not have to say anything more as their mutual stimulation soon expands to $2name moving to straddle $2his partner, then sinking $2his pussy down on $his $penis. Both of them moan loudly as $2he starts to grind against $name, joyfully taking $his length into $2his body.",
}, 'asstake': {
consensual =  "Moving over to your office with $name in tow, you quickly strip down and bend over, bracing yourself against the writing desk with your ass raised high. It takes nothing more than a lewd smile over your shoulder to get $him lined up behind you, naked and ready to fuck. $He of course first puts $his face between your buttocks, eating you out to prepare $his $master for penetration, but it is more than clear how eager $name is to take you. Soon, $he slaps $his $penis between your buttocks, then proceeds to push in and goes on to pound your ass from there.",
swing = "Gleefully setting to strip down your two servants, you tell $2name to step up against a wall, bracing $2himself with both hands and bending forward a little. With you giving $2his buttocks an appreciative squeeze or two, $name readily picks up on your plan for how this should go, and before long, $he stands beside you, $his $penis at the ready. Yielding your place, you watch as $name steps up and sinks $himself into $2name's asshole, taking $2him hard from behind.",
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
consensual = "You dominantly stroke $name's cock with your feet. ",
swing = "$2name dominantly strokes $name's cock with $2his feet. ",
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
description = "You will restrict $name's limbs and play with $his body. ",
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
description = "You will restrict $name's whole body and provide $him with some heavy-handed discipline. ",
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
	text += "You don’t keep $him waiting for very long. Leaning down, you press your mouth against $his " + globals.fastif(slave.bodyshape == 'bestial', "muzzle", "own") + " eagerly tasting inside, even as $he starts to respond.  Your hands stroke over $his body, things growing more heated as you line up the tip of " +  globals.player.dictionaryplayer("$penis") + " sliding up and down $his lower lips. $He’s already more than soaked, and you have no trouble at all parting $his folds and pushing into $his body. $He " + globals.fastif(slave.pussy.virgin == true, "winces rather hard, the resistance within $him breaking away a moment later as $he gasps, then", "") + globals.fastif(slave.sexuals.actions.pussy >= 4, " gives a lusty moan and", "") + " squirms under you as you start a steady pace of thrusts into $his body, holding $him to you as $his legs wrap around your back almost instinctively" + globals.fastif(slave.tail != "none", " and $his tail wraps around your leg", "" )+ ". $His insides are hot and wet against your " +  globals.player.dictionaryplayer("$penis") + ", feeling amazing as you slide in and out of $his body. " + globals.fastif(slave.pussy.virgin == true, "A small amount of pink tinting to the fluids around your connection prove it.  You’ve taken $his virginity. ", "")
	text += "\n\nIt doesn’t take long before you feel yourself nearing the end, and pick up the pace pounding into $his body, possessively kissing $him as you hold $him down. Taken by $his own instincts, $name moans into the kiss as $his whole body rocks under you. " +  globals.fastif(globals.player.penis.number >= 1, "$He clenches down a moment later, shivering as you feel $his walls start to squeeze and contract around you, almost begging you for your seed. " , "" ) + globals.fastif(slave.penis.number >= 1, "$His own dick twitches as well, messily splattering up $his stomach.", "") + globals.fastif(globals.player.penis.number >= 1, " Soon you slam in as deep as you can go and flooding $his core with your cum. ", "")
	return text

func pussyrape(slave):
	var text = ''
	if slave.traits.has('Likes it rough'):
		text += "$name makes a show of struggling "
	else:
		text += "$name struggles "
	text += "as you roughly toss $him onto the bed. "
	if slave.bodyshape in ['humanoid', 'bestial']:
		if slave.tail != "none":
			text += "Forcing $his legs apart you roughly push $his " + slave.tail + " tail out of the way exposing $his pussy to you. "
		else:
			text += "Forcing $his legs apart you open $his pussy to you. "
	else:
		text += "Grabbing $him by $his " + slave.legs + "legs you reveal $his pussy. "
	text += "Pressing your " + globals.player.dictionaryplayer("$penis") + " against $his pussy $he begs you not to do it. With a single thrust you slam your " +  globals.player.dictionaryplayer("$penis") + " all the way into $his pussy. $He " + globals.fastif(slave.pussy.virgin == true, "screams in pain as your " + globals.player.dictionaryplayer("$penis") + " tears through $his virginity.", "yells out in protest at your sudden assault.") + "\n\n Wraping your arms about $him you hold $him in position as you thrust your " +  globals.player.dictionaryplayer("$penis") + " in and out of $his pussy with hard violent strokes. $He squirms trying to break free and get away but you hold on tightly. Tears start falling down $his cheeks and $he begs you to stop. $His desperation brings you closer to climax."
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
	text += "\n\nPicking up the pace, it doesn’t take long before you feel like coming. " + globals.fastif(globals.player.penis.number >= 1, "Bottoming out in one hard push, you empty your seed into $his rectum, flooding $his bowels with hot liquid as shot after shot is released into $him.", "") + "Feeling the hot cum rushing into $his pushes $him over the edge too, and $he shivers, as $his own juices slide down $his inner thighs" 
	if slave.skincov == 'full_body_fur':
		text += "saturating the fur with $his fluids"
	elif slave.skincov == 'scales':
		text += "slicking $his scales with $his fluids"
	elif slave.skincov == 'feathers':
		text += "saturating the feathers with $his fluids"
	text += ". You unceremoniously pull out of $him, stepping back to admire your handiwork.  Your seed slides slowly down between $his ass cheeks and $his thighs, and $he gives a " + globals.fastif(slave.sexuals.actions.size() >= 3, "pleased purr, looking back over $his shoulder at you as $he licks $his fingers off of $his own juices. "," contented sigh, sagging a little after you let $him go. ") + "You leave $him to clean up as you continue about your day."
	return text
	
func analsexrapelike(slave):
	var text = "With a simple gesture, you order $name to strip, moving around behind $him as $he does. " 
	if slave.sexuals.actions.ass >= 5:
		text += "$He seems to know what’s coming and makes a show of attempting to resist you."
	else:
		text += "$He hesitates at your intent, trying to squirm out of your grasp." 
	if slave.tail != 'none': 
		text +="$name attempts to cover $his ass with $his tail in an attempt to block access for you."
	elif slave.tail != 'none':
		text += "Tries to cover $his ass with his hand in an attempt to block access for you."
	text += "You grab ahold of $name "
	text += globals.player.dictionaryplayer("pressing your $penis") + " up and nestling it between the cheeks of $his ass.  Your hands squeeze both sides of $his hips as you pull $him back against you and grind for a moment, drawing out a plead from $him.\n\n"
	text += "Please $master don't do this!\n\n"
	text += "$name makes a feeble attemp to slip your grasp, as you work back and forth for a few thrusts, getting a healthy smear over $his rear hole before pressing the tip of your " + globals.player.dictionaryplayer("$penis") + " up against it and roughtly pushing into $his tight hole.  The suddenness causes $him to wince regardless as you waste no time bottoming out your length in $his ass.  You start a healthy rhythm, pounding hard into $his body.  "
	
	if slave.sexuals.actions.size() >= 8 && slave.pussy.has == true: 
		text += "It doesn’t take $him long to start $his lustful moaning, $his hand sliding down to finger $himself as you plow $his rear. "
	else:
		text += "$He squirms against you, biting $his lower lip as you plow $him over and over again. "
	text += "\n\nPicking up the pace, it doesn’t take long before you feel like coming. " + globals.fastif(globals.player.penis.number >= 1, "Bottoming out in one hard push, you empty your seed into $his rectum, flooding $his bowels with hot liquid as shot after shot is released into $him.", "") + "Feeling the hot cum rushing into $his pushes $him over the edge too, and $he shivers, as $his own juices slide down $his inner thighs" 
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
		text += "As you get closer to climax, you order $him to swallow everything. Your semen gushes into $his mouth." +globals.fastif(slave.sexuals.actions.blowjob < 3, ", nearly making $him choke", "") + ".  $name shows you the creamy covering of $his tongue proudly before swallowing it down with a grin. After thanking $him, you leave $him to $his duties."
	else:
		text += "As you climax, you pull out of $his mouth and covering $his "+ globals.fastif(slave.face.beauty >= 70, "pretty", "") + " face and "+slave.haircolor + " hair with your seed."
	return text
	
func blowjobrape(slave):
	var text = ''
	text += "You grab $name by the hair and tie $him tightly in place. Brushing your cock over $his cheek, you pick up a ring gag. After a moment you have fixed the gag in the $child's "+ globals.fastif(slave.bodyshape == 'bestial', "muzzle", "mouth") + ". You remove your pants and direct your cock into the poor thing's face. $His clumsy attempts to evade it only provoke you further. With force you insert you cock into $his open "+ globals.fastif(slave.bodyshape == 'bestial', "muzzle", "mouth") + ", making $him moan in protest. $His warm and damp tongue instinctively tries to push out the invader, but it only increases your pleasure. \n\nWith glee you grab the victim's head and hold it in place. With every thrust you force yourself into $his throat deeper and deeper. By this time moans are replaced with whimpers and cries while $his tear-stained eyes begin to express humility. The sight of $him choking on your cock brings you closer to climax. With one last thrust you pump your load down $his throat. Letting go of $name, $he collapses to the ground, retching a little while trying to gasp for air."
	return text

func hairjob(slave):
	var text = ''
	text += slave.dictionary("$name gives your cock tender care with $his $haircolor hair. ")
	return text
	
func fingering(slave):
	var text = ''
	text += "You move your hand over $name's pussy, gently teasing the outside of $his lips. As $he gets wetter you slide your finger between $his lips and rub $his clit. $name gasps as you shove your middle finger into $his wet pussy. You begin to move your finger in and out while carressing $his clit."
	return text
	
func fingeringass(slave):
	var text = ''
	text += "You lube up your fingers before spreading $name's ass cheeks. You gently tease the outside of $his ass transfering some of the lube. You slowly press your finger into $his hole, the tight muscles squeezing down on you as you work your way in deeper. When $he is ready you add an additional finger to $his hole and begin to fuck it in ernest."
	return text	

func getscene(sexaction, slave, consensual, hole):
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
		if i.has('hole'):
			if i.hole != hole:
 				check = false
		if i.has('function') && check == true:
			array.append(call(i.function, slave))
		elif check == true:
			array.append(i.text)
	if array.size() > 0:
		return array[rand_range(0,array.size())]
	else:
		return ''
