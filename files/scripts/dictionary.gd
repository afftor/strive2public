
extends Node

static func getRaceDescription(race, full = true, reverse = false): #show description for X race
	var text
	var text2
	if (race == 'Human'):
		text = 'Humans are a highly successful militaristic people whose members can be found throughout much of the world, their presence often receiving a mixed reception. Slavery is a common part of human society, viewed as a civilized form of alternative punishment, with many laws and businesses based around the concept. Because of this slave driven culture, you have found that humans tend to be the most widely accessible residents, servants, and slaves.'
		if full == true:
			text2 = '[color=aqua]Racial trait: Punishment expectations and praise lasts twice as long.[/color]\n\n[color=yellow]Stat potential: Strength - 5, Agility - 3, Magic - 2, Endurance - 4 [/color]'
			if reverse == false:
				text = text + "\n\n" + text2
			else:
				text = text2 + "\n\n" + text
	elif (race == 'Elf'):
		text = 'Elves are famous among the various races for the legends and stories of ancient times, when elves held a similar status to modern humans. These tales speak of elves as arrogant, and in command of powerful nature magic, but ultimately spelling their own downfall in some great act of folly.\n\nModern elves bear few connections to their ancestors beyond physical appearance and a close connection to nature. In stark contrast, their lives are often fairly humble and reclusive, generally staying deep within forests. There is no evidence to suggest any inherent magic found in modern elves, but this hardly impedes their popularity.'
		if full == true:
			text2 = '[color=aqua]Racial trait: Preferred role based on confidence level.[/color]\n\n[color=yellow]Stat potential: Strength - 3, Agility - 5, Magic - 4, Endurance - 3 [/color]'
			if reverse == false:
				text = text + "\n\n" + text2
			else:
				text = text2 + "\n\n" + text
	elif (race == 'Dark Elf'):
		text = 'Elves are famous among the various races for the legends and stories of ancient times, when elves held a similar status to modern humans. These tales speak of elves as arrogant, and in command of powerful nature magic, but ultimately spelling their own downfall in some great act of folly.\n\nDark elves belong to less known tribes, rumored to be separated from main groups and living in warmer regions.'
		if full == true:
			text2 = '[color=aqua]Racial trait: Temporal effects from potions and spells last longer.[/color]\n\n[color=yellow]Stat potential: Strength - 4, Agility - 5, Magic - 3, Endurance - 4 [/color]'
			if reverse == false:
				text = text + "\n\n" + text2
			else:
				text = text2 + "\n\n" + text
	elif (race == 'Drow'):
		text = 'Drow are a race, considered a branching species of elf. Little is known about their history and motherland, if they ever had one at all, as their underground cities are spread thin across multiple continents, and are even more difficult to enter than to locate.\n\nBeyond a preference for isolation and their general appearance, drow are quite different from their cousins in both attitude and culture. However, what sets them apart most is the unusual pigmentation of their skin; a dark colors with occasional blue tint. The unusual pigmentation is the subject of much debate and speculation, with theories ranging from natural mutation, to the byproduct of ancient beings.'
		if full == true:
			text2 = '[color=aqua]Racial trait: sexual actions give 20% more mana.[/color]\n\n[color=yellow]Stat potential: Strength - 4, Agility - 5, Magic - 6, Endurance - 3 [/color]'
			if reverse == false:
				text = text + "\n\n" + text2
			else:
				text = text2 + "\n\n" + text
	elif (race == 'Orc'):
		text = 'Orcs are among the most recognizable races for their unique green skin color, and naturally untamed appearances. Orcs are widely considered barbarians for their tribal nature, but those who study them have found a diverse and highly communal society, far more civilized than it may first appear.\n\nOrcs reside primarily in the south, within the borders of Gorn; a powerful nation. It is well documented in local history and folklore that as the scale and ferocity of the tribal wars grew, foreign invaders were pushed further out, allowing Gorn’s relatively undisturbed development. These days, though the constant wars have ended, the remaining tribes receive regular offerings to stay within the nation’s borders as a deterrent and to maintain friendly relations.'
		if full == true:
			text2 = '[color=aqua]Racial trait: wounds heal quicker.[/color]\n\n[color=yellow]Stat potential: Strength - 6, Agility - 3, Magic - 1, Endurance - 5 [/color]'
			if reverse == false:
				text = text + "\n\n" + text2
			else:
				text = text2 + "\n\n" + text
	elif (race == 'Gnome'):
		text = 'Though nowadays the gnome capital is open as a tourist spot, there are stories and documents stating that generations ago, they were once humans sealed within the city by demons, experimented on and mutated into the forms they have today.\n\nThough they are a stocky, physically weak race, they compensate for their shortcomings with outstanding intellect, holding a commanding lead as the world’s frontrunners in technology.'
		if full == true:
			text2 = '[color=aqua]Racial trait: studying at Library twice as effective. [/color]\n\n[color=yellow]Stat potential: Strength - 3, Agility - 3, Magic - 5, Endurance - 3 [/color]'
			if reverse == false:
				text = text + "\n\n" + text2
			else:
				text = text2 + "\n\n" + text
	elif (race == 'Goblin'):
		text = 'Goblins are a race of cave dwellers, loosely resembling short, green-skinned elves. They have existed for a very long time, but despite their prevalence rarely played any influential role. While often been considered nothing more than common monsters, they have surprising skill and understanding, putting them on par with many humanoid races in term of sentience.'
		if full == true:
			text2 = '[color=aqua]Racial trait: pregnancy progresses lot quicker. [/color]\n\n[color=yellow]Stat potential: Strength - 3, Agility - 5, Magic - 3, Endurance - 3 [/color]'
			if reverse == false:
				text = text + "\n\n" + text2
			else:
				text = text2 + "\n\n" + text
	elif (race == 'Fairy'):
		text = 'Modern fairies, often referred to as city fairies by some parts of the magic community, are an unexpected evolution of nature spirits sharing the same name, resulting from interaction with outsiders and migration into cities. These fairies have retained much of the cute, friendly, and playful attitudes of the spirits they came from, making them popular for positions with high volumes of public interaction.'
		if full == true:
			text2 = '[color=aqua]Racial trait: build-up stress dissipates twice as fast.[/color]\n\n[color=yellow]Stat potential: Strength - 2, Agility - 5, Magic - 6, Endurance - 2 [/color]'
			if reverse == false:
				text = text + "\n\n" + text2
			else:
				text = text2 + "\n\n" + text
	elif (race == 'Seraph'):
		text = 'Seraphs were named because of their similarity in appearance to angels, the winged servants of divinity spoken of in myth. The reclusiveness of seraphs has led to a lack of research, but common theories are that they are a subspecies of harpy, or an artificial race created accidentally many generations ago.\n\nUnlike demons, seraphs seem to exhibit many behavioral traits in line with their mythic counterparts, such as a prudish nature and a slight inclination towards public service, though it’s unknown if these traits are universal, or if they come down to an individual basis.'
		if full == true:
			text2 = '[color=aqua]Racial trait: +4 speed in combat[/color]\n\n[color=yellow]Stat potential: Strength - 4, Agility - 5, Magic - 3, Endurance - 3 [/color]'
			if reverse == false:
				text = text + "\n\n" + text2
			else:
				text = text2 + "\n\n" + text
	elif (race == 'Demon'):
		text = 'Though they share a name and certain physical traits, modern demons bear no true resemblance to their ancient counterparts, who were driven into the great depths of the underground, and even into other dimensions. It is speculated that modern demons are either the offspring of humans and actual monsters, or as some research suggests, the byproduct of extensive magical corruption, similar to gnomes.\n\nThough demons are often feared and reviled, those with outstanding talent or skill often receive recognition for their abilities, so it is not entirely uncommon to see demons among the elite, or in high profile positions.'
		if full == true:
			text2 = '[color=aqua]Racial trait: laboratory modifications are cheaper.[/color]\n\n[color=yellow]Stat potential: Strength - 5, Agility - 4, Magic - 4, Endurance - 3 [/color]'
			if reverse == false:
				text = text + "\n\n" + text2
			else:
				text = text2 + "\n\n" + text
	elif (race == 'Dryad'):
		text = 'Dryads are a virtual unknown, with little information on their natural habitat and reproduction. It is speculated that they are nature spirits born from old trees that have absorbed a large amount of mana.'
		if full == true:
			text2 = '[color=aqua]Racial trait: forage is 50% more effective.[/color]\n\n[color=yellow]Stat potential: Strength - 3, Agility - 4, Magic - 5, Endurance - 4 [/color]'
			if reverse == false:
				text = text + "\n\n" + text2
			else:
				text = text2 + "\n\n" + text
	elif (race == 'Dragonkin'):
		text = 'Dragonkin are an extremely rare breed of human with draconic lineage, partially possessing the blood and certain physical traits of dragons, such as wings, scales, and a tail. While originally confined to the whims of dragons, a coalition of influential mages banded together and developed a powerful ritual to imbue grown humans with dragon blood, in spite of observed difficulties in adoption of the blood so late into development. There is a great deal of secrecy surrounding the ritual, and outside of a few involved elite, its success rate is unknown. The few dragonkin alleged to have been produced by the ritual are virtually indistinguishable from those who were naturally birthed.'
		if full == true:
			text2 = '[color=aqua]Racial trait: strength is increased.[/color]\n\n[color=yellow]Stat potential: Strength - 6, Agility - 4, Magic - 5, Endurance - 5 [/color]'
			if reverse == false:
				text = text + "\n\n" + text2
			else:
				text = text2 + "\n\n" + text
	elif (race == 'Taurus'):
		text = 'Tauruses are a purely artificial race, created on the orders of a group of noblemen looking for bodyguards. The experiment seems to have been an attempt at recreating the size and strength of orcs and beastkin in a more easily controlled package, but was ultimately considered only partially successful, as specimens of the new species had a tendency of taking too many bovine behavioral traits, becoming too passive, or in some cases, too aggressive.\n\nStill, they, especially the females, remain popular among certain individuals for their appearance and outstanding natural lactation.'
		if full == true:
			text2 = '[color=aqua]Racial trait: milking is more effective. [/color]\n\n[color=yellow]Stat potential: Strength - 5, Agility - 3, Magic - 2, Endurance - 6 [/color]'
			if reverse == false:
				text = text + "\n\n" + text2
			else:
				text = text2 + "\n\n" + text
	elif (race == 'Slime'):
		text = "Slimes are the result of a relatively common magical mutation, which dramatically changes a person's bodily integrity. Slimes are heavily reliant on water, even though their body is not actually 'slimy'. They can freely ooze over anything they touch, yet are in fact, pretty cohesive and firm to the touch.\n\nUnlike most other ooze-type slime monsters, slimes of humanoid origins are capable of nearly the same mental processes, although they are generally ill-regarded for having a clearly monstrous appearance."
		if full == true:
			text2 = "[color=aqua]Racial trait: can't be modified in the lab, toxicity is nullified every day.[/color]'\n\n[color=yellow]Stat potential: Strength - 4, Agility - 6, Magic - 3, Endurance - 3 [/color]"
			if reverse == false:
				text = text + "\n\n" + text2
			else:
				text = text2 + "\n\n" + text
	elif (race == 'Harpy'):
		text = "Harpies are human-bird hybrids with easily recognisable features, such as their feathered arms and avian lower quarters. Commonly seen as monsters, they have existed since time immemorial. Wild harpies generally inhabit mountain regions and are relatively aggressive. Their intelligence has a wide range, and people have had some success making them into slave-pets."
		if full == true:
			text2 = '[color=aqua]Racial trait: egg-laying is more effective.[/color]\n\n[color=yellow]Stat potential: Strength - 4, Agility - 5, Magic - 3, Endurance - 3 [/color]'
			if reverse == false:
				text = text + "\n\n" + text2
			else:
				text = text2 + "\n\n" + text
	elif (race == 'Lamia'):
		text = 'Lamias are easily recognized and tend to be timid in their interactions, rarely showing themselves to majority of the population. Their population has been severely reduced by hunting and extermination expeditions launched by different races. Lamias are surprisingly intelligent, as the few captured and studied samples have shown.'
		if full == true:
			text2 = '[color=aqua]Racial trait: None.[/color]\n\n[color=yellow]Stat potential: Strength - 4, Agility - 5, Magic - 4, Endurance - 4 [/color]'
			if reverse == false:
				text = text + "\n\n" + text2
			else:
				text = text2 + "\n\n" + text
	elif (race == 'Arachna'):
		text = 'Arachna live in isolation and tend to choose caves and other underground locations as their homes. While not being especially aggressive, they are fearsome hunters and have been reported for rare night attacks on both cattle and humans.'
		if full == true:
			text2 = '[color=aqua]Racial trait: hunting is more effective.[/color]\n\n[color=yellow]Stat potential: Strength - 4, Agility - 4, Magic - 5, Endurance - 4 [/color]'
			if reverse == false:
				text = text + "\n\n" + text2
			else:
				text = text2 + "\n\n" + text
	elif (race == 'Centaur'):
		text = 'The Centaur race is somewhat distant, yet not unheard of in southern regions. Some individuals have made it very far by adopting a nomadic lifestyle, making the race common enough to be recognized by most. The centauri population is relatively small, due to dealing with territorial oppression from humanoid races.'
		if full == true:
			text2 = '[color=aqua]Racial trait: Increased Energy.[/color]\n\n[color=yellow]Stat potential: Strength - 5, Agility - 5, Magic - 3, Endurance - 5. [/color]'
			if reverse == false:
				text = text + "\n\n" + text2
			else:
				text = text2 + "\n\n" + text
	elif (race == 'Nereid'):
		text = 'Nereid are considered to be another subspecies of the humanoid races, yet they likely split from another race in the distant past. They adapted to an aquatic lifestyle. Nereids are often seen by sailors and fishermen, but they tend to be hesitant in making contact with humans, likely viewing them as a threat.'
		if full == true:
			text2 = '[color=aqua]Racial trait: entertainment is more effective.[/color]\n\n[color=yellow]Stat potential: Strength - 3, Agility - 5, Magic - 5, Endurance - 3 [/color]'
			if reverse == false:
				text = text + "\n\n" + text2
			else:
				text = text2 + "\n\n" + text
	elif (race == 'Scylla'):
		text = 'Scylla are rather unusual in appearance, possessing a number of tentacle-like appendages they use in the place of legs. They generally prefer damp and aquatic regions. In general, their behavior and capabilities are not much different from lamia. Their appearance is extremely rare, to the point of being treated as mere myth or drunken fancy by some.'
		if full == true:
			text2 = '[color=aqua]Racial trait: cooking is more effective.[/color]\n\n[color=yellow]Stat potential: Strength - 5, Agility - 4, Magic - 5, Endurance - 4 [/color]'
			if reverse == false:
				text = text + "\n\n" + text2
			else:
				text = text2 + "\n\n" + text
	elif (race.find('Beastkin') >= 0 || race.find('Halfkin') >= 0):
		if (race.find('Beastkin') >= 0):
			text = 'The term Beastkin refers to a wide range of sentient species with prominent humanoid and animalistic traits. True beastkin are fully covered in fur, feathers, or scales, with similar stature and proportions to a human. Even among individual species, there are wide differences to be observed with inherited animal traits, such as eyes, claws, and teeth. It is unknown whether Beastkin are man-made or the product of nature, as their spread and diversity often leads to inconsistent findings.\n\n'
		elif (race.find('Halfkin') >= 0):
			text = 'Halfkin are the offspring produced by the union of a beastkin and a human. Halfkin most prominently display their human lineage, lacking fur and other major animalistic characteristics, but do possess secondary traits from their beastkin forebears, such as claws, ears, and tails, and tend to exhibit behavior from both parents equally.\n\nThe fate of halfkin varies from place to place, some living normally as any other race, others living under persecution and prejudice, and even rumors of far off lands where they are respected and worshipped. Regardless of what kind of environment they live in, halfkin are a popular item among collectors for their exotic appearance and the unique quality that their offspring will often swing back to fully human or fully beast. \n\n'
		if (race.find('Cat') >= 0):
			text = text + 'Cat folk are an unusually social breed of Beastkin, having no known settlements of their own, and living quite openly in populous towns and cities. They have a great deal of popularity among certain crowds for their lush appearance and lascivious nature.'
			if full == true:
				text2 = '[color=aqua]Racial trait: increased dodge chance.[/color]\n\n[color=yellow]Stat potential: Strength - 4, Agility - 6, Magic - 3, Endurance - 3 [/color]'
				if reverse == false:
					text = text + "\n\n" + text2
				else:
					text = text2 + "\n\n" + text
		elif (race.find('Fox') >= 0):
			text = text + 'Fox folk are a rare, and relatively mysterious breed of Beastkin. They display high intelligence, a tendency towards lifelong monogamy, and congregate in small, close-knit communities.'
			if full == true:
				text2 = '[color=aqua]Racial trait: escort assignment is more effective.[/color]'
				text += '\n\n[color=yellow]Stat potential: Strength - 4, Agility - 5, Magic - 4, Endurance - 3 [/color]'
				if reverse == false:
					text = text + "\n\n" + text2
				else:
					text = text2 + "\n\n" + text
		elif (race.find('Wolf') >= 0):
			text = text + 'Unlike other Beastkin, Wolves are not viewed as simple novelties, but are treated as the powerful, agile pack hunters they are. Though they rarely show hostility towards outsiders unless threatened, great caution should be taken when dealing with them.\n\nThere are rumors that far to the north exists a nation richly populated by Beastkin, where wolves play a leading role, being well suited to the harsh environment.'
			if full == true:
				text2 = '[color=aqua]Racial trait: Detection bonus, Combat Power increased.[/color]\n\n[color=yellow]Stat potential: Strength - 5, Agility - 5, Magic - 2, Endurance - 4 [/color]'
				if reverse == false:
					text = text + "\n\n" + text2
				else:
					text = text2 + "\n\n" + text
		elif (race.find('Bunny') >= 0):
			text = text + 'Bunnies are one of the least self-sufficient, but netherless common beast races. They are not aggressive and can actually be quite timid. They are quite well liked  due to their comforting appearance and their natural lewdness makes them a popular choice for slave pets.'
			if full == true:
				text2 = '[color=aqua]Racial trait: prostitution related assignments cause only half stress.[/color]\n\n[color=yellow]Stat potential: Strength - 3, Agility - 5, Magic - 3, Endurance - 3 [/color]'
				if reverse == false:
					text = text + "\n\n" + text2
				else:
					text = text2 + "\n\n" + text
		elif (race.find('Tanuki') >= 0):
			text = text + "The Tanuki are a rare beast race possessing raccoon features. It's hard to pinpoint any specific mental differences between them and the majority of the humanoid races. Some say that their behavior and attitudes are much like that of the average human. There's still much  speculation as to how they originated."
			if full == true:
				text2 = '[color=aqua]Racial trait: store assignment more effective.[/color]\n\n[color=yellow]Stat potential: Strength - 4, Agility - 4, Magic - 4, Endurance - 4 [/color]'
				if reverse == false:
					text = text + "\n\n" + text2
				else:
					text = text2 + "\n\n" + text
	return text


static func getRaceShortName(race):
	var text
	if (race == 'Human'):
		text = 'human'
	elif (race == 'Elf'):
		text = 'elf'
	elif (race == 'Dark Elf'):
		text = 'dark elf'
	elif (race == 'Drow'):
		text = 'drow'
	elif (race == 'Gnome'):
		text = 'gnome'
	elif (race == 'Goblin'):
		text = 'goblin'
	elif (race == 'Seraph'):
		text = 'seraph'
	elif (race == 'Demon'):
		text = 'demon'
	elif (race == 'Fairy'):
		text = 'fairy'
	elif (race == 'Orc'):
		text = 'orc'
	elif (race == 'Dryad'):
		text = 'dryad'
	elif (race == 'Dragonkin'):
		text = 'dragon'
	elif (race == 'Taurus'):
		text = 'cow'
	elif (race == 'Slime'):
		text = 'slime'
	elif (race == 'Harpy'):
		text = 'harpy'
	elif (race == 'Lamia'):
		text = 'lamia'
	elif (race == 'Arachna'):
		text = 'spider'
	elif (race == 'Centaur'):
		text = 'centaur'
	elif (race == 'Nereid'):
		text = 'nereid'
	elif (race == 'Scylla'):
		text = 'scylla'
	elif (race.find('Cat') >= 0):
		text = 'cat'
	elif (race.find('Fox') >= 0):
		text = 'fox'
	elif (race.find('Wolf') >= 0):
		text = 'wolf'
	elif (race.find('Bunny') >= 0):
		text = 'bunny'
	elif (race.find('Tanuki') >= 0):
		text = 'racoon'

static func getRaceArticle(race):
	if race in ['Elf', 'Arachna', 'Orc']:
		return 'an '
	else:
		return 'a '

static func getOriginDescription(slave):
	var text = "Servant's grade reflects their current attitude, expectations and demands. Low grade severely limits mental stats, while high grade requires luxurous lifestyle or they will grow untrustworthy. Grade can be changed at Slavers Guild"
	var dict = {
#	none = "This shouldn't be here =/",
#	slave = 'Those, who lived most of their life as a slaves, are in general considerably more obedient than the others. However, their skills and capabilities fall off from most other people as well. ',
#	poor = 'Being poor is not easy. Constant struggle for food and survival made them initially somewhat more capable, than common slaves, but not by far. ',
#	commoner = 'Commoners are primal population of big towns and cities. They often work as craftsmen, soldiers and provide better service compared to traditional slavery manpower. ',
#	rich = 'Rich people are characterized by their easygoing life and high attitude. Often possessing better education and stronger character, they are tend to take it badly being turned into those, who previously served them. ',
#	royal = "Royal blood is rare and worth a lot. Royals tend to get the best education and training available in their lands, and often possess outstanding beauty. However, it won't be an easy task, to make them submit and cooperate afterwards. ",
	}
	text 
	return text

func getLore():
	var loredict = {
	branding = "[center]Magical branding.[/center]\n\nMagical branding is one of the oldest and most common spells currently used. The procedure of applying one is relatively simple, and only requires the Brander to put their hands around the neck of the one to be branded, as if to strangle them when applying this spell. This allows for the Brander’s blood to be enchanted and infused onto the Branded. As a result, barely visible symbols appear on the neck of the Branded, coiling around and allowing them to be returned to their owner if necessary. The entire procedure is relatively painful for those branded though, as their body is being affected by foreign biology.\n\nBranding is the first thing anyone would want to do to their new human property; and it is expected to be done, as branded people are universally recognized as slaves. Not only that, but branding provides very important measures against rebellion, as a Branded person will not be able to inflict any sort of harm on the Brander. The spell prevents any actions influenced by such thoughts and causes paralysis by blocking signals to the spinal cord and inflicting pain and nausea in return.\n\nRecognition of a brand makes it a decent measure against escape attempts, as branded people, while not usually returned to their masters if found far away, quickly end up in very bad conditions; exploited by commoners or taken by local governments to occupy dangerous and unpleasant jobs. Being branded basically lowers a person's rights to that of an object to be used.\n\nMagical branding was most likely developed by elvenkind. Long ago, their magical powers allowed them to control some of the fiercest creatures thanks to this technique. In modern times, its use has become a part of everyday life, as apparently human beings can be easily subdued by their equals.\n\nThere's 3 ways to remove a brand. First, the owner can perform a simple spell, clearing the Branded of their influence if they find that they need to do so. Secondly, the brand will disappear if the Brander happens to die. Lastly, there's the option of having brand dispelled by skilled mages, although this is generally prohibited by law, and one would be challenged to find a person who would be willing to risk performing such ritual. Needless to say, normal branding is impossible if the living being has already been branded as current brand prevents it.",
	magesorder = "[center]Magi Order.[/center]\n\nThe current era represents humans as the dominant race, as they belong to the most populated and organized structures of land. Humans are led by groups of magi who, many centuries in the past, have established control over many towns. The Order of Magi play the role of government in each corresponding region, but they also comply with the High Order located in The Capital, which may assume control in the event of danger.\n\nThe Order is not just a governing structure, but also plays a primal role in magical and technological research and warfare. Hence every person in The Order is not necessarily a mage, but powerful and rich people often join it, as members receive special privileges over normal people and are able to participate in lawmaking and management. At the same time they contribute to The Order and the city by playing a role in various activities, providing money, people, or property as needed. In this way, The Order was able to maintain itself for a very long time, even after the role of magic became less vital for survival.\n\nMagi Orders are led by Grand Mages who are reelected by members of The Order every 10 years and who must also meet the needs of the High Order. The High Order, instead, is led by a small group of individuals.\n\nThe High Order operates and plans around every location and provides directives and goals for smaller instances, but those still have enough freedom to act on their own; basically acting in unison like a federation. At the legislative level, there aren’t any real prejudices against any other humanoid race, as they are all regarded in the same manner that any human would be. However,  occasional domestic conflicts may raise up, as it is in society's nature to look for a common enemy.",
	slavery = "[center]Slavery.[/center]\n\nSlavery is a widely common occurrence in the world, and has been implemented in nearly every region in one form or another. Slaves are generally used for small tasks and as valuable sources of mana for mages. With food production being poor,  and its distribution unreliable,  keeping a significant number of slaves around seems almost like a luxury, although in more prosperous regions it's not uncommon for middle class people to buy one or two servants for personal use.\n\nThe Order of Magi regulates the practice of slavery and tracks possible escapees; as in the past, slaves played a massive role in magical experiments. Branding is what defines a slave, but branding may only be performed by either members of The Order or the Slavers’ Guild. The Order keeps track of every local member's marks so that their slaves have no problem being recognized. However, anyone in possession of a slave not belonging to The Order (such as when buying from the guild) must register his slave and brand to prevent his newly acquired property from being taken away. Unidentified slaves are considered to be the guild's property and are generally used for various social assignments and sometimes end up being released after diligent service; eventually even making a considerable career.\n\nWhile owners possess nearly unlimited control over their slaves, they are also expected to keep them fed and sheltered, making it a considerable option for poor people to sell themselves into slavery, provided that they are attractive or useful enough to be taken. However it's not acceptable to forcibly enslave locals without agreement from their relatives, and doing so results in a penalty. Relatives are also able to buy out such slaves, but not for a lesser amount than what was paid, which holds true even for non-locals.\n\nGiven the nature of laws, exotic or high quality slaves are often taken by individuals raiding other regions and trafficking captured people for sale. Some mages went a bit further and employed personal portals for easy access to fresh candidates for their experiments.",
	magic = "[center]Theory of Magic.[/center]\n\nEnergy has always been a part of living beings, yet conjuring it into something different requires a substantial amount of skill. The use of magic usually comes from considerable concentration and incantations, sometimes also involving specific devices to lead or control the flow of energy. Magic can be roughly divided into 4 types:\n\nTransportation magic is used primarily for teleportation and transportation. It is very effective at allowing easy and quick movement across huge distances with portals. It's hard to use this kind of magic with any degree of speed, making it ill-suited for combat in general.\n\nTransformation magic enables the change of various properties of living beings, achieved through the alteration of their DNA. This kind of magic is both the primary and most commonly used type in the present day. Needless to say, it took ages for humans to hone their skills enough to be able to use this kind of magic without posing a great danger to others; but the results were outstanding. With enough knowledge and equipment you can even produce completely new, superior species or improve abilities of existing ones to an unnatural level. Transformation, however, takes a considerable amount of time to prepare. It also requires specialized equipment and skilled practitioners, making it accessible at a professional level only to a select few individuals.\n\nInfluential magic is the simplest form of magic, being that it does not involve any significant changes to the real world, instead only affecting the mind of a target. Because of this, it's usually easy to learn and cast on the go without a huge risk. Effects vary from inducing emotions, making a victim fall unconscious, to complete mind control (the latter being much more difficult, naturally). For a skilled mage it's not hard to protect oneself from this sort of magic either, but in a general sense it's forbidden to publicly use it against anyone but your slaves.\n\nDestruction magic is mostly absent from current magical practice. Due to the nature of magical energy (that it is  fueled by living beings) destruction magic was extremely dangerous, as one professionally conjured spell could potentially grow indefinitely as long as it was draining life and energy from its target. Moreover, due to its potency, destruction magic used to cause major pollution and the tainting of an area, inducing all manner of transmutations and alterations to bystanders. Adepts of destruction magic, elves and drows, lost all potential to ever use it again after their defeat in The Old War.",
	worldhistory = "[center]History of Mankind[/center]At the beginning of time, the elves were the only race present. They managed to build a strong society and had access to powerful magic, making them the most dominant species in the land. Class inequality played a large role in their society, as the strongest and most noble were the dominant class. Eventually, elven researchers made a breakthrough with transformation magic and thus it was decided to utilize said magic to produce a new caste of menial workers with even fewer rights as a means to lift social tension from the lower castes. In the process, Humans were developed. Humans looked crude compared to the elves and they were denied any potential in destructive magic, making them unable to muster any significant resistance to their rulers. They lived shorter lives but had a higher birth rate to compensate. At first, the elves’ treatment of humanity wasn't terrible, but with successive generations humans became increasingly aware of their inferior position. After a considerable amount of time passed, it became obvious that the size of humanity was getting out of hand and the elven nobility needed a solution to the overpopulation. The execution of newborn humans was proposed and implemented in many regions, but a few regions actually let certain troublesome human communities leave and settle on their own. As time passed, humanity grew tired of their mistreatment and, after a series of gruesome events, rebelled against their masters. This led to The Old War.\n\nOld communities of human escapees did not have a good relationship with the elven kingdom, so they were quick to provide support to the rioters and rebels.However, it soon became apparent that the elves would not treat any humans with respect, and they began to mercilessly eliminate the human opposition. This led to many deaths and to human refugees leaving elven regions for good. The Elves reacted with punitive force, but they weren't completely effective, as old communities developed ways to fight back against enemy casters. For many centuries afterwards,  there was an ongoing conflict between humans and elves. There wasn't much that humans could do against destruction magic, as one caster could easily wipe out an entire squad, so many dirty tactics were used. Ambushes, traps and sudden raids became the main tools that humanity used to fight back against their superior foe, but it wasn't anywhere near enough for a successful counterattack, hence there was no end to the war in sight.\n\nDuring this time, humanity formed The Mage Order as the primary organization to lead the counterattack against the elves. Individuals, who devoted their lives to the research and development of all available forms of magic, became the most valuable members of society as their discoveries provided a significant edge that humans lacked on their own. Physical enhancements played a great role in confrontations, as capable individuals were generally more potent than assembled armies. The Mage Order also took every chance they could to study the after effects of the elves’ destruction magic. As the war continued, magical taint spread across the land, giving birth to many twisted creatures and mutants.\n\nSome of those creatures gave The Order the idea to produce animal hybrids. Thankfully, by that time humans had mastered transmutation magic to a great enough extent that they were able to conduct many experiments in that direction. The most successful of these resulted in the beastkin races. Cat hybrids had outstanding reaction times and grace while wolf mutations provided increased strength, a keen sense of smell, and great co-ordination in packs. There was no prejudice on humanity’s side towards their newfound allies, as any amount of help mattered in war. Beastkins eventually made their own communities, although they still kept close ties to their ancestors.\n\nAlthough, human hybrids weren't the only thing developed by the Order. Orcs were an unfortunate result of experimentation on elves in an attempt to allow humans to use destruction magic and bring them closer to the elves. However, the excessive energy of the experiments went awry and resulted in immense physical growth and skin pigment mutation as the Order had failed to hone human genes to support the alien function, and equally failed to reverse the unintended mutations. On the other side, Elven magicians working on transmutations managed to produce better soldiers from common elves - drow. They possessed an increased affinity to magic and had some physical improvements,  making them more fit for combat. However, the extreme magical influence lead them to mutate with a dark, tainted skin.\n\nThe Old War finally ended a few centuries ago with humanity winning against all odds. Although many elves were killed during the final sieges of their cities, they weren't completely eradicated. Instead The Mages’ Order, lead by some inner directions, modified every surviving elf to remove their ability to ever use destructive magic again, and prevented the ability from being passed onto future generations. In this way, the destruction once caused by the elves and their magic, witnessed by generations throughout the War, would not repeat itself.\n\nAfter the war, the elves were mostly divided between those who returned to their forests holding a minor grudge against humans but not being able to oppose them anymore, and those who were assimilated into human society. By law, the Order did not tolerate racial discrimination of any kind, even towards elves, as a way to foster cooperation with manmade races. After that, led by the Order, many settlements were set up among the lands, eventually giving birth to somewhat distant beastkin and orcish nations. The Order also discouraged remembrance of The Old War as a great tragedy of the past, and after a few generations, the commoners had completely forgotten about that bloody history."
	}
	
	return loredict
