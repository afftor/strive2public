
extends Node

class glossaryelement:
	var name = ''
	var code = ''
	var text = ''

func _init():
	buildglossary()

var glossarylist = []

func buildglossary():
	var mansion = glossaryelement.new()
	mansion.text = "This is your home screen. From here you can access most management, travel and help options, while the top panel screen menu displays you resources. Your primary resources are: gold, food, and mana. Gold is required to buy items, train servants and upgrade your mansion. It is earned by assigning your servants to appropriate jobs, selling them to slaver's guild, by winning some encounters, and completing certain quests. Food is required for every person living in the mansion, including yourself. Not having enough food for your current population leads to servants (and prisoners) losing health and gaining stress. Food can be bought at the market, or acquired by servants assigned to the foraging or hunting jobs.\n\n Mana is the source of power for your spells and modifications to servants in the laboratory. It is generated by sexual activities you witness or participate in, and the amount gained varies depending on the attributes and skills of the involved characters. Energy determines how many actions you can take per day, such as interacting with servants, traveling, and fighting. When your energy is depleted, use 'Finish day' to advance time.\n\nOn the right side of the screen there is a list of your servants if you have any. From there you can check their status and access their personal screen, manage and interact with them. To acquire more servants you'll have to purchase or capture them."
	mansion.name = 'Main Mansion Screen'
	mansion.code = 'mansion'
	glossarylist.append(mansion)
	
	var servant = glossaryelement.new()
	servant.text =  "On this tab you can observe, manage and interact with your chosen servant. From here you can see their appearance and personality and check on their mood and potential. Hover the mouse cursor over different stats to see more info. " 
	servant.name = 'Servant Screen'
	servant.code = 'servant'
	glossarylist.append(servant)
	
	var branding = glossaryelement.new()
	branding.text = "Magical branding is your main tool in keeping servants in check. Branded people will not be able to oppose their owner and Refined Brand will allow the issuing additional behavior rules to them. Branding makes escape much less appealing as a branded person will typically be treated as a criminal slave - notably worse than a normal slave usually treated." 
	branding.name = 'Branding'
	branding.code = 'branding'
	glossarylist.append(branding)
	
	var obedience = glossaryelement.new()
	obedience.text = "Obedience is highly important as it will be main driving force for your servant to... obey your orders. Obedience can be built by punishments and interactions as well as some rules. Low obedience my cause servants to riot or even attempt to escape. To prevent it you may move them to prison. To reduce likelihood of escape, consider branding them. " 
	obedience.name = 'Obedience Stat'
	obedience.code = 'obedience'
	glossarylist.append(obedience)
	
	var loyalty = glossaryelement.new()
	loyalty.text = "Loyalty is your long-term relationship with given servant. Loyalty builds slowly, but high loyalty will outweigh low obedience in many cases and help improve it daily. You may also view it as a 'love' stat." 
	loyalty.name = 'Loyalty Stat'
	loyalty.code = 'loyalty'
	glossarylist.append(loyalty)
	
	var stress = glossaryelement.new()
	stress.text = "Stress builds when servant is faced with actions they find difficult or revolting. Mainly rape, prostitution assignments and combat build stress quickly. Resting and private rooms help them relax faster. High stress will cause obedience drop, complaints and may result in mental break which will severely affect servant's stats. " 
	stress.name = 'Stress Stat'
	stress.code = 'stress'
	glossarylist.append(stress)
	
	var sexaffection = glossaryelement.new()
	sexaffection.text = "Affection points represent the amount of trust a servant has in you and is used mainly to open more sex related actions with them. Affection points can be generated from positive interactions, including sex actions. Certain actions might influence servant more than others. More extreme actions take more affection points to unlock. Unlocked sexual actions will generally benefit sex related tasks and jobs. " 
	sexaffection.name = 'Affection and Sex Actions'
	sexaffection.code = 'sexaffection'
	glossarylist.append(sexaffection)
	
	var lust = glossaryelement.new()
	lust.text = "Lust represents how aroused a person is. Lust has considerable impact on the servant when dealing with sex-related actions and can be built up by some rules, actions and clothes, but also dissipate with orgasms. " 
	lust.name = 'Lust Stat'
	lust.code = 'lust'
	glossarylist.append(lust)
	
	var exploration = glossaryelement.new()
	exploration.text = "Exploring the world is a good way to acquire new items and servants. However, as it is dangerous and you are not trained in  fighting, you’ll have to use one of your servants as your battle companion in order to venture into the wilds. Combat, Survival and Body Control skills play major role during combat encounters so make sure your chosen companion is well-prepared. "
	exploration.name = 'Exploration'
	exploration.code = 'exploration'
	glossarylist.append(exploration)
	
	var captures = glossaryelement.new()
	captures.text = "Aside from buying or convincing others into working for you, you are also able to capture new slaves in fights or during some events. To capture someone during the fight, you'll have to send one of your partners after them, and hope they are quick enough to catch them. The last defeated person will always be captured though. After combat you'll be able to decide if you want to keep or release successfully captured opponents.\n\nThe captured slave will be placed into your jail, but don't expect them to cooperate willingly. As they clasp to the memory of their life out of confinement, they won't be as obedient as you would expect from long-time servants leading to more problems and possible escape attempts. \n\n'Captured' status breaks after time. The time is takes is based on the origins of the victim, and strength of their character. Jail, branding and punishments can help to break it faster and certain memory affecting methods can lift it instantly. "
	captures.name = 'Captures'
	captures.code = 'captures'
	glossarylist.append(captures)
	
	var uncivilized = glossaryelement.new()
	uncivilized.text = "Certain characters and races commonly coming from the wild won't be able to behave on the same level as normal people. You won't be able to assign them to social jobs and their sell price will be considerably lower. Their offspring, however, won't receive this penalty. There's also is a way to fix this state via use of specific potions and training. "
	uncivilized.name = 'Uncivilized'
	uncivilized.code = 'uncivilized'
	glossarylist.append(uncivilized)
	
	var repeatables = glossaryelement.new()
	repeatables.text = "Repeatable quests is a great source of gold earning. Quests are refreshed every 5 days. Harder quests have bigger reward. "
	repeatables.name = 'Repeatable Quests'
	repeatables.code = 'repeatables'
	glossarylist.append(repeatables)
	
	var jail = glossaryelement.new()
	jail.text = "The jail is used for the  temporary confinement of badly behaving characters or those who have recently been defeated in combat and returned to the manor. While in jail they won't be able to run away, steal or agitate others. However, you won't be able to utilize them and only non consensual sex is allowed there.\n\nYou can assign a Jailer to take care of prisoners for you. The Jailer's skills will affect their influence. Service will help prisoners' health recovery, Allure will increase Obedience growth and Management may reduce their [url=captures]'captured'[/url] state. "
	jail.name = 'Jail'
	jail.code = 'jail'
	glossarylist.append(jail)
	
	var cleaning = glossaryelement.new()
	cleaning.text = "Over time your mansion becomes dirty and requires cleaning. Every new resident will increase amount of dirt you will have to deal with. Some races are tidier and less prone to creating a huge mess while other (mainly monsters) require more attention. Poor mansion condition impacts residents stress and health in a bad way. Early on hiring cleaners might be an attractive and simple solution, in time their cost will increase so consider assigning personal cleaners from your slaves. Service skill helps greatly to influence their work. "
	cleaning.name = 'Cleaning'
	cleaning.code = 'cleaning'
	glossarylist.append(cleaning)
	
	var stats = glossaryelement.new()
	stats.text = "Physical stats directly influence a character's combat capabilities and may play a role in daily duties. You can raise stats only a certain number of times and the cap is primarily determined by character's race. There are 4 main stats to develop: \nStrength - affects combat power, which in turn affects physical damage and related skills. \nAgility - affects combat speed; which increases hit and dodge chance. \nMagic Affinity (Magic) - affects magic related skills. \nEndurance - affects a character's health pool. The Survival skill also increases health pool. " 
	stats.name = 'Physical Stats'
	stats.code = 'stats'
	glossarylist.append(stats)
	
	var combat = glossaryelement.new()
	combat.text = "Upon encountering hostile entities, you will be drawn into combat. Before that, you can assign up to 3 partners to travel with you. The companion with highest hidden 'awareness' stat (largely affected by survival) will be used to determine ambush chance rolls. \n\nOnce the fight starts, you'll have to defeat all enemies or use the escape ability while having enough energy to finish the battle. \nThe effectiveness of your actions will be largely affected by number of vital [url=stats]stats[/url]:\nPower: increases physical damage\nSpeed - increases hit and dodge chance, it also affects chance to capture a person running away\nMagic - affects magic related skills\nArmor - reduces physical damage\nEnergy - required by some skills and to chase escapees\n\nNote, that abilities, requiring mana, will use mana from your total reserves." 
	combat.name = 'Combat'
	combat.code = 'combat'
	glossarylist.append(combat)
	
	var role = glossaryelement.new()
	role.text = "Many of the sex actions  fall into either the 'dominant' or 'submissive' category, which will sway a neutral servant’s behaviour towards one of those. Servants, which adopted their new position, will prefer to ask you actions of a similar nature and will react negatively to the actions of opposing nature." 
	role.name = 'Dom&Sub'
	role.code = 'role'
	glossarylist.append(role)
	
	var toxicity = glossaryelement.new()
	toxicity.text = "Toxicity builds from constant exposure to magic. Wild magic running free in someone’s body in very low concentrations is not a problem. However, in high concentrations it can distress or damage that person's mind, and even cause severe mutations. Toxicity builds especially quickly from usage of magical mixtures and laboratory procedures. Albeit dangerous if it builds up too much, toxicity slowly dissipates over time. Keep it low unless you want the individual to experience side-effects." 
	toxicity.name = 'Toxicity'
	toxicity.code = 'toxicity'
	glossarylist.append(toxicity)
	
	var slaveguild = glossaryelement.new()
	slaveguild.text = "Slavers guild allows you to buy and sell slaves in a quick manner as well as  provideing some repeatable quests. Slaves initially presented to you there will not offer great quality and rarity, but will generally will be more obedient and content with their life. Slaves from the offer will eventually be sold and replaced with new ones, so if you are not happy with your options, it may be better to come few days later. " 
	slaveguild.name = "Slavers Guild"
	slaveguild.code = "slaversguild"
	glossarylist.append(slaveguild)
	
	var pregnancy = glossaryelement.new()
	pregnancy.text = "Sexual interactions can lead to pregnancy. To prevent it, you may want to use various contraceptives or operations. Someone who is pregnant will have to deal with additional stress and possibly health issues. Once the baby is born (~30 days), you will be presented with options regarding its future use. By default you'll be forced to give it away, as the mansion is poorly suited to keep babies. As you advance through guild ranks, however, there will open up alternatives. You'll be able to accelerate it's growth and maturation for a price, allowing you to obtain new slaves this way. " 
	pregnancy.name = "Pregnancy&Childbirth"
	pregnancy.code = "pregnancy"
	glossarylist.append(pregnancy)
	
	var grades = glossaryelement.new()
	grades.text = "A servant's grade represents their self-esteem and potential. Those with lower grades are easier to control, but have severe penalties to mental stat potential. Alternatively those with higher grades are harder to keep in check and require a better lifestyle, like luxury related rules, better rooms and clothes. You can change a specific servant's grade at the Slaver Guild. "
	grades.name = 'Grades'
	grades.code = 'grades'
	glossarylist.append(grades)
	
	var spells = glossaryelement.new()
	spells.text = "Spells are a hastily used form of magic requiring very little in terms of preparation and can be executed as long as you know how and have enough mana to power them. Some spells can be used in battle, others are for non-combat uses - relaxation, influencing minds, or analyzing a person’s aura. Particularly strong spells may overflow a target with magic energy and thereby build up toxic levels of uncontrolled mana."
	spells.name = 'Spells'
	spells.code = 'spells'
	glossarylist.append(spells)
	
	var alchemy = glossaryelement.new()
	alchemy.text = "Alchemy is an art. Alchemy shops are important establishments which help you with interesting potions and elixirs which can alter or influence your servants. You will have to purchase necessary laboratory equipment before being able to create such yourself. Many ingredients can be acquired in the field, from battles and having affairs with various races. Keep in mind that overdosing on potions can lead to toxicity and other complications."
	alchemy.name = 'Alchemy and Potions'
	alchemy.code = 'alchemy'
	glossarylist.append(alchemy)
	
	var farm = glossaryelement.new()
	farm.text = "On your farm you can chain down your servants to passively produce food which can either be used to feed your residents, or sold for gold. There are two important considerations for maintaining your farm. First, you should assign a manager to watch over your cattle. This will let you choose to sell or keep the produced milk and other materials, as well as other benefits. Management is the primary skill which affects production, with Service being secondary. Secondly, using servants as cattle will quickly build up stress, and eventually break their will to the lowest possible degree. While many assignments will take servant's skills and willpower stats into account, this is not true for the farm. It will mainly rely on body characteristics and augmentations, which makes it a way to utilize those slaves that have no other useful skills or potential."
	farm.name = 'Farm'
	farm.code = 'farm'
	glossarylist.append(farm)
	
	var headgirl = glossaryelement.new()
	headgirl.text = "Headgirl is an influential figure you assign to inspire or intimidate your less reliable servants. The obvious upside is that it won't take your energy to deal with rebellious servants in order to build obedience and her attendance won't have huge impact on personality of others as if you delivered punishments on your own. Confidence and Management will make her efficient when building obedience, and Charm with Allure are key to make others more accepting of your regime."
	headgirl.name = 'Headgirl'
	headgirl.code = 'headgirl'
	glossarylist.append(headgirl)
	
	var laboratory = glossaryelement.new()
	laboratory.text = "The Laboratory is a high tech place, allowing you to alter your servants. Firstly, you will need an assistant. The Assistant's Service, Management and Magic will influence the time and resources required per operation, so train them accordingly. After selecting an operation, you will leave your slave to the assistant's care, paying with resources and items. Be careful, as changing your servants will greatly affect their stress, and might have bad side effects; however, some modifications may provide great benefits. "
	laboratory.name = 'Laboratory'
	laboratory.code = 'laboratory'
	glossarylist.append(laboratory)