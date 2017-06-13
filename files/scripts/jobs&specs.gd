extends Node



var specs = {
geisha = {
name = "Geisha",
code = 'geisha',
descript = "A Geisha is an adept of love. They are trained to please both men and women, not only with sex but also in companionship. They are genuinely pleasant to have around as they try their best to feel what potential partner might want. ",
descriptbonus = "+25% to escort and prostitution, no penalties for same-sex, opposite dominance or perverted actions",
descriptreqs = "Charm 75+, Beauty 60+, grade Commoner or above, unlocked sex.",
reqs = "slave.charm >= 75 && slave.face.beauty >= 60 && !slave.origins in ['slave','poor'] && slave.sexuals.unlocked == true"
},
ranger = {
name = "Ranger",
code = 'ranger',
descript = "Rangers are quick and resourceful individuals who are at home in any natural environment.. Not only do they have an eye for better opportunities, but also can spot richer prey. ",
descriptbonus = "+50% drop rate from combat encounters, forage and hunt efficiency + 25%, scouting bonus",
descriptreqs = "Wit 75+, Endurance 3+.",
reqs = "slave.wit >= 75 && slave.send >= 3"
},
executor = {
name = "Executor",
code = 'executor',
descript = "Executors are trained to work with people in a most efficient way. Their commands are always straight and on-point and their attitude is met with respect. ",
descriptbonus = "Management-related tasks ignore confidence (will always count as 100). Obedience can't drop above 50.",
descriptreqs = "Conf 75+, Wit 50+, grade Rich or above",
reqs = "slave.conf >= 75 && slave.wit >= 50 && slave.origins in ['rich', 'noble']"
},
bodyguard = {
name = "Bodyguard",
code = 'bodyguard',
descript = "A Bodyguard is trained to put their life before their master's. Not only they are capable of taking down threats on their own, but are substantially more resilient. ",
descriptbonus = "Bonus armor and health, 'Protect' action doubles the amount of reduced damage.",
descriptreqs = "Courage 60+, agility 3+, strength 4+, loyalty 50+",
reqs = "slave.cour >= 60 && slave.sagi >= 3 && slave.sstr >= 4 && slave.loyal >= 50"
},
assassin = {
name = "Assassin",
code = 'assassin',
descript = "Assassins are trained to act swiftly and surely, when required. They prefer efficiency over show and offence to defence.  ",
descriptbonus = "Speed +5, Damage +5",
descriptreqs = "Agility 5+, Wit 65+",
reqs = "slave.wit >= 65 && slave.sagi >= 5"
},
housekeeper = {
name = "Housekeeper",
code = 'housekeeper',
descript = "Housekeepers are experts at supplying and taking care of the living quarters. ",
descriptbonus = "Will clean the house on stationary jobs (half effect of normal cleaning). Personal daily expenses are cut in half.",
descriptreqs = "None",
reqs = "true"
},
trapper = {
name = "Trapper",
code = 'trapper',
descript = "Trappers are generally common professionals you can find in any slavers party. They are also reasonably well trained in hunting. ",
descriptbonus = "Bonus hunting +20%, 1/3 chance to automatically capture escaping person, bonus capture rate. ",
descriptreqs = "Wit 50+, Grade: Commoner and above ",
reqs = "slave.wit >= 50 && !slave.origins in ['slave','poor']"
},
nympho = {
name = "Nympho",
code = 'nympho',
descript = "Nymphos devote their life entirely to the lewdness. They are ready for anything and everything and want more. It's common practice to make such slaves into tools and toys by owners. ",
descriptbonus = "Sex actions take only half energy, + 2 mana from sex actions, + 25% to fucktoy, no penalties from any sex activities. ",
descriptreqs = "Grade: Commoner and below, Unlocked sex, Charm and Courage 50+ ",
reqs = "slave.origins in ['slave','poor','commoner'] && slave.sexuals.unlocked == true && slave.cour >= 50 && slave.charm >= 50"
},
merchant = {
name = "Merchant",
code = 'merchant',
descript = "People with a kink for bargains, not only profitable to keep around, but also good at connecting with others. ",
descriptbonus = "Bonus shopping activities, bonus item selling while in party 25% (does not stack). ",
descriptreqs = "Wit and Charm 50+ ",
reqs = "slave.wit >= 50 && slave.charm >= 50"
},
tamer = {
name = "Tamer",
code = 'tamer',
descript = "Tamers are trained to work with wild animals and savagely behaving individuals. By utilizing many simple lessons they even may eventually bring true potential out of those. ",
descriptbonus = "Uncivilized races more obedient and can lose trait while Tamer is resting, managing or working on same occupation. ",
descriptreqs = "Confidence and charm 50+, Grade: Commoner and above",
reqs = "slave.conf >= 50 && slave.charm >= 50 && slave.origins in ['commoner','rich','noble']"
},
}
