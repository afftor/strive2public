
extends Node

static func getHeights(slave):
	var text
	if slave['bodyshape'] != 'shortstack':
		text = [ 'petite', 'short', 'average', 'tall', 'towering' ]
	else:
		text = [ 'tiny' ]
	return text

static func getSkinColors(slave):
	var text = [ 'pale', 'fair', 'olive', 'tan' ]
	var text2 = {
	"Dark Elf" : [ 'tan', 'brown', 'dark' ],
	"Drow" : ['blue', 'purple', 'pale blue'],
	"Orc" : ['green'],
	"Goblin" : ['green'],
	"Dryad" : ['green'],
	"Slime" : ['jelly'],
	"Nereid" : ['teal', 'blue', 'pale blue']
	}
	if (text2.has(slave['race'])):
		text = text2[slave['race']]
	return text

static func getHornTypes(slave):
	var text = [ 'None' ]
	var text2 = {
	"Demon" : ['short', 'long_straight', 'curved'],
	"Dragonkin" : ['short', 'long_straight', 'curved'],
	"Taurus" : ['long_straight'],
	}
	if (text2.has(slave['race'])):
		text = text2[slave['race']]
	return text


static func getWings(slave):
	var text = [ 'None' ]
	var text2 = {
	"Fairy" : ['insect'],
	"Demon" : ['leather_black', 'leather_red'],
	"Dragonkin" : ['leather_black', 'leather_red'],
	"Seraph" : ['feathered_black', 'feathered_white', 'feathered_brown'],
	}
	if (text2.has(slave['race'])):
		text = text2[slave['race']]
	return text


static func getFurColors(slave):
	var text = [ 'None' ]
	var text2 = {
	"Beastkin Cat" : ['white', 'gray', 'orange_white','black_white','black_gray','black'],
	"Beastkin Fox" : ['black_white', 'orange'],
	"Beastkin Wolf" : ['gray', 'black_gray', 'brown'],
	"Beastkin Bunny" : ['white', 'gray'],
	"Beastkin Tanuki" : ['black_gray'],
	}
	if (text2.has(slave['race'])):
		text = text2[slave['race']]
	return text

static func getRandomFurColor():
	var temp = ['white', 'gray', 'orange_white','black_white','black_gray','black', 'orange', 'brown']
	return temp[rand_range(0,temp.size())] 


static func getRandomName(slave):
	var text = {}
	if (slave.race == 'Human' && slave.sex != 'male'):
		text['name'] = getRandomHumanFName()
		text['surname'] = getRandomHumanSurname()
	elif (slave.race == 'Human' && slave.sex == 'male'):
		text['name'] = getRandomHumanMName()
		text['surname'] = getRandomHumanSurname()
	elif ((slave.race == 'Elf'|| slave.race == 'Dark Elf' || slave.race == 'Drow') && slave.sex != 'male'):
		text['name'] = getRandomFElfName()
		text['surname'] = getRandomElfSurname()
	elif ((slave.race == 'Elf'|| slave.race == 'Dark Elf' || slave.race == 'Drow') && slave.sex == 'male'):
		text['name'] = getRandomMElfName()
		text['surname'] = getRandomElfSurname()
	elif slave.race.find('Beastkin') >= 0 || (slave.race.find('Halfkin') >= 0 && rand_range(0,1)>0.6) :
		if slave.sex != 'male':
			text['name'] = getRandomHumanFName()
		else:
			text['name'] = getRandomHumanMName()
		text.surname = getRandomFurrySurname()
	elif ((slave.race == 'Orc'|| slave.race == 'Goblin') && slave.sex != 'male'):
		text['name'] = getRandomFOrcName()
		text['surname'] = getRandomOrcSurname()
	elif ((slave.race == 'Orc'|| slave.race == 'Goblin') && slave.sex == 'male'):
		text['name'] = getRandomMOrcName()
		text['surname'] = getRandomOrcSurname()
	elif ((slave.race == 'Demon') && slave.sex != 'male'):
		text['name'] = getRandomFDemonName()
		text['surname'] = getRandomHumanSurname()
	elif ((slave.race == 'Demon') && slave.sex == 'male'):
		text['name'] = getRandomMDemonName()
		text['surname'] = getRandomHumanSurname()
	elif slave.sex != 'male':
		text['name'] = getRandomHumanFName()
		text['surname'] = getRandomHumanSurname()
	else:
		text['name'] = getRandomHumanMName()
		text['surname'] = getRandomHumanSurname()
	return text

static func getRandomSex():
	var text
	if (globals.rules['male_chance'] > 0 && rand_range(0, 100) < globals.rules['male_chance']):
		text = 'male'
	elif (rand_range(0, 100) < globals.rules['futa_chance']) && globals.rules.futa == true:
		text = 'futanari'
	else:
		text = 'female'
	return text

static func getRandomAge():
	var text = []
	if (globals.rules['children'] == true):
		text.append('child')
	
	if (globals.rules ['teens'] == true):
		text.append('teen')
	
	if (globals.rules ['adults'] == true):
		text.append('adult')
	
	return text[rand_range(0, text.size())]


static func getRandomHumanFName():
	var FHumanNames =["Adelia","Adelina","Afton","Agueda","Aisha","Aja","Akiko","Alberta","Alda","Aleen","Alina","Alison","Alita","Alyce","Alyse","Amedea","Amiee","Angela","Angeles","Angelika","Angelina","Angeline","Anika","Anissa","Anita","Anjanette","Annalisa","Annetta","Ardelia","Ardell","Ariana","Arlean","Arletta","Armida","Artie","Audry","Augusta","Avis","Avril","Aya","Barabara","Beatris","Berta","Bethann","Bettyann","Billye","Bree","Brooke","Callie","Cami","Cammie","Candra","Carina","Carman","Carrie","Cassey","Cassondra","Cathrine","Cathy","Cecile","Cecille","Ceola","Chanelle","Chantell","Chantelle","Charise","Charissa","Charlene","Charline","Chelsea","Chere","Cherryl","Chiquita","Chira","Christal","Chu","Ciara","Cinda","Cinthia","Clemencia","Codi","Consuelo","Coralie","Cordelia","Cordia","Corie","Corinna","Corliss","Criselda","Cyndi","Dacia","Dalene","Daniell","Daniella","Danyel","Dayna","Daysi","Deana","Deane","Debbra","Delana","Delcie","Delia","Delilah","Deloise","Delorse","Demetria","Demetrice","Denise","Denisse","Dessie","Dian","Diana","Diedra","Dierdre","Dolores","Donetta","Donya","Dori","Doris","Dorothea","Dot","Echo","Edra","Edwina","Edyth","Elease","Eleni","Eliana","Elina","Elinor","Elinore","Elise","Eliza","Ella","Ellie","Elodia","Eloise","Elvira","Emmy","Enna","Erlene","Erline","Eustolia","Evelien","Felecia","Filicia","Fiona","Fleurette","Florence","Floretta","Florine","Floy","Francesca","Francina","Freda","Freya","Gaye","Gaylene","Genevie","Genia","Georgeann","Georgetta","Geralyn","Geri","Germaine","Gertrude","Ginger","Ginny","Glennis","Glynis","Gracia","Gracie","Griselda","Gussie","Ha","Hanna","Hattie","Heide","Helga","Herminia","Hester","Hettie","Honey","Hope","Hyun","Idella","Ilana","Inga","Irena","Isabella","Ivette","Jacinda","Jacquie","Jaimie","Jama","Jamika","Janay","Janette","Jann","Janna","Jaunita","Jayna","Jazmin","Jeanene","Jeannetta","Jennefer","Jenni","Jenniffer","Jestine","Jodee","Jodie","Joelle","Jolyn","Joselyn","Joslyn","Joyce","Joye","Juanita","Julene","Julia","Julieann","Juliet","Kam","Kanesha","Karie","Karleen","Karolyn","Katharine","Katherine","Kathey","Kathleen","Kathrin","Kathryne","Kaye","Kazuko","Kecia","Kellye","Kesha","Kiara","Kristle","Krysten","Krystle","Lahoma","Lakeesha","Lakendra","Lana","Lanette","Lanie","Laree","Larhonda","Larisa","Lashonda","Latisha","Latoria","Latoya","Lauralee","Laurine","Lauryn","Lavenia","Laveta","Lawana","Lawanna","Layla","Leana","Leanora","Leesa","Leila","Leisha","Leonida","Lera","Lessie","Liane","Lilly","Linda","Linette","Linh","Linsey","Lore","Lorean","Lorene","Loris","Louann","Luana","Luanna","Lucilla","Lucinda","Ludivina","Lyda","Lynsey","Maeva","Mai","Maira","Malika","Malissa","Manda","Marceline","Margarette","Marguerite","Maria","Mariela","Marielle","Marilyn","Marla","Marlana","Marti","Marya","Maryetta","Maryjo","Marylee","Matha","Maudie","Maureen","Maurita","Mavis","Maye","Mazie","Meghann","Melanie","Mellisa","Melodee","Melody","Melonie","Mercedes","Michaela","Michele","Mignon","Mimi","Mina","Mindy","Minta","Mira","Mirtha","Miyoko","Monica","Monique","Monserrate","Muriel","My","Myra","Myrl","Na","Nanci","Nancie","Naoma","Natacha","Neida","Nelda","Nenita","Nerissa","Nga","Ngan","Nichol","Nikia","Nikita","Nila","Nina","Noreen","Olevia","Olive","Olympia","Oma","Ona","Onita","Oretha","Palmira","Pamala","Pamelia","Pamella","Patrina","Paulette","Pearle","Peggy","Pelagia","Penney","Pinkie","Priscilla","Providencia","Rachelle","Raguel","Raina","Ranae","Randa","Randi","Ranee","Rea","Regan","Reina","Rema","Rhiannon","Rita","Riya","Robin","Robyn","Romona","Rosalia","Rosalina","Rose","Roseanne","Rosia","Rosie","Roterica","Roxana","Roxann","Roxy","Ruth","Sallie","Samanta","Samira","Sarai","Scarlet","Season","Sebrina","See","Selina","Shana","Shaniqua","Shannan","Shantell","Shantelle","Shanti","Sharice","Sharita","Sharlene","Sharonda","Shauna","Shawna","Shaylee","Shelba","Shelli","Sherrie","Sima","Simone","Soledad","Sona","Sonya","Sophie","Sparkle","Starr","Stefania","Stepanie","Su","Suellen","Susan","Susana","Susanne","Takisha","Tali","Tamala","Tami","Tanika","Tatiana","Tawanna","Tayna","Teena","Telma","Tenesha","Teodora","Teofila","Teresa","Teressa","Thalia","Thea","Thresa","Tiffani","Tira","Tish","Tobie","Tonisha","Tracy","Treena","Tricia","Trinity","Trisha","Vanessa","Vella","Venetta","Vikki","Vilma","Viola","Virginia","Vivienne","Vonnie","Wanita","Willette","Windy","Wonda","Wynona","Xenia","Xochitl","Xuan","Yen","Yessenia","Yoana","Zella","Zofia"]
	var text = FHumanNames[rand_range(0, FHumanNames.size())]
	return text
	
static func getRandomHumanMName():
	var MHumanNames = ["Abel","Abraham","Adalberto","Adam","Adolfo","Ahmad","Alan","Alejandro","Alfonso","Alfonzo","Alfredo","Alonso","Alton","Alvaro","Alvin","Anderson","Andre","Andrea","Andres","Andrew","Andy","Anibal","Antone","Archie","Arlie","Arnulfo","Arron","Art","Augustus","Avery","Ben","Benito","Bernard","Bernardo","Blake","Booker","Brad","Brett","Brian","Brice","Brock","Brooks","Bruno","Buck","Bud","Burton","Buster","Cameron","Carl","Carlo","Carol","Carrol","Cedric","Cedrick","Chance","Charles","Charlie","Chong","Christian","Christoper","Chung","Clarence","Claud","Claudio","Clayton","Cleo","Clinton","Cody","Connie","Cordell","Corey","Courtney","Craig","Cruz","Cyril","Dan","Dana","Daniel","Danilo","Dannie","Darius","Darnell","Daron","Darrell","Darren","Darrick","Darron","Darwin","Daryl","David","Dee","Delbert","Demarcus","Demetrius","Denis","Derrick","Diego","Dominique","Don","Donnell","Doug","Douglas","Drew","Dudley","Duncan","Dustin","Dwayne","Dwight","Ed","Edgar","Edgardo","Edison","Edmond","Edmund","Edward","Edwardo","Efrain","Efren","Elden","Eliseo","Elliott","Eloy","Elvis","Elwood","Emanuel","Emery","Emmitt","Ernest","Ernesto","Ervin","Erwin","Ethan","Eusebio","Evan","Ezequiel","Faustino","Felix","Ferdinand","Florentino","Forest","Forrest","Frances","Francis","Francisco","Frank","Frankie","Franklyn","Frederick","Gabriel","Gail","Gale","Galen","Garfield","Garret","Garrett","Gaston","Gavin","Genaro","Gene","Geoffrey","Gerard","Gerry","Gino","Glenn","Grady","Grant","Guadalupe","Guillermo","Gustavo","Guy","Hal","Harry","Haywood","Heath","Henry","Herman","Hiram","Horace","Houston","Howard","Huey","Hunter","Irvin","Isaias","Ismael","Isreal","Issac","Ivory","Jacinto","Jake","James","Jamison","Jared","Jarod","Jarrod","Jarvis","Jc","Jean","Jeff","Jefferson","Jeffery","Jerald","Jeremy","Jerrell","Jess","Jimmy","Joel","Joesph","John","Johnathan","Johnson","Jonathon","Jordan","Jorge","Jose","Joseph","Jude","Julian","Junior","Karl","Keenan","Kelvin","Kendall","Kendrick","Kevin","Kirby","Kirk","Kristofer","Kyle","Lacy","Landon","Lee","Leif","Leland","Leo","Leon","Leonardo","Leroy","Lesley","Linwood","Logan","Lorenzo","Louis","Lucius","Luigi","Luther","Mack","Major","Malcolm","Malcom","Malik","Manuel","Marc","Marcelo","Marco","Marcus","Mariano","Marion","Mark","Marquis","Marty","Marvin","Matt","Maynard","Mckinley","Melvin","Merle","Merlin","Merrill","Micah","Michael","Micheal","Michel","Mickey","Mike","Mikel","Miles","Millard","Mohamed","Moises","Monty","Morgan","Myles","Nathanial","Nathaniel","Ned","Nelson","Nicky","Octavio","Odis","Olen","Oren","Orville","Oscar","Oswaldo","Owen","Palmer","Pedro","Porter","Preston","Quentin","Quincy","Quintin","Rafael","Ramiro","Randall","Randell","Randolph","Raphael","Raul","Rayford","Raymon","Reid","Renato","Reuben","Rey","Rich","Rick","Ricky","Riley","Robert","Rocco","Rocky","Rod","Roderick","Rodger","Rodney","Roland","Rolland","Ronald","Rory","Rosendo","Ross","Rudolf","Rufus","Rusty","Ryan","Salvatore","Sam","Samuel","Santiago","Santo","Santos","Scottie","Sebastian","Seth","Shad","Shawn","Sherwood","Sid","Sidney","Silas","Sol","Son","Stanley","Stanton","Stefan","Stewart","Sydney","Thanh","Theo","Theron","Todd","Tom","Tomas","Tommie","Tracey","Trenton","Trey","Tristan","Truman","Tyrell","Tyrone","Tyson","Val","Van","Vance","Vicente","Victor","Vincent","Vincenzo","Virgilio","Waldo","Walker","Wallace","Warner","Warren","Waylon","Werner","Weston","Wilber","Wilbur","Wilfredo","Willard","William","Williams","Wilmer","Wilton","Woodrow","Zachary"]
	var text = MHumanNames[rand_range(0, MHumanNames.size())]
	return text
	
static func getRandomHumanSurname():
	var HumanSurnames = ["Adams","Alexander","Alvarado","Anderson","Arellano","Arnold","Austin","Baker","Baker","Banks","Barrera","Baxter","Bean","Bennett","Benson","Best","Bird","Black","Booth","Boyd","Bradford","Bradshaw","Brady","Brock","Brooks","Brown","Brown","Bullock","Burch","Burke","Calderon","Callahan","Campbell","Cantrell","Cantu","Charles","Clarke","Cline","Cobb","Cochran","Collier","Cooper","Cooper","Costa","Cowan","Crawford","Cruz","Cummings","Daniels","Davenport","Davidson","Davies","Davis","Decker","Dickerson","Dillon","Dixon","Doherty","Dougherty","Downs","Drake","Duarte","Dudley","Duncan","Edwards","Ellis","Esparza","Evans","Everett","Farmer","Fitzgerald","Flores","Foster","Fox","Frank","Frazier","Frederick","Fuller","Galloway","Gamble","Garcia","Gay","Graham","Gray","Gray","Green","Gutierrez","Hale","Hamilton","Hancock","Haney","Hanna","Hansen","Hanson","Harrison","Hayden","Hayes","Haynes","Hays","Herman","Hernandez","Herrera","Hines","Hodge","Hooper","Hopkins","Horne","Howe","Huang","Hughes","Hughes","Huynh","Ibarra","Jackson","Jacobs","James","Jarvis","Johnson","Johnston","Johnston","Jones","Juarez","Kelly","Kennedy","Kent","Kim","Kirk","Knapp","Knox","Kramer","Krause","Leawis","Lee","Leon","Lewis","Lewis","Little","Livingston","Love","Lynn","Mack","Mahoney","Manning","Marks","Marshall","Martin","Mason","Massey","Mata","Mathews","Mayer","Mcbride","Mccall","Mccarthy","Mcclain","Mcclure","Mcconnell","Mccoy","Mcdonald","Mcgee","Melendez","Melton","Mercer","Merritt","Meyer","Middleton","Miller","Mitchell","Mitchell","Monroe","Montgomery","Moore","Morales","Moreno","Morrow","Moss","Murphy","Murray","Nelson","Norris","Novak","O’Neill","Owens","Parrish","Parsons","Patel","Patel","Patrick","Patterson","Pena","Peterson","Phelps","Phillips","Pruitt","Quinn","Ramirez","Ramsey","Ray","Rich","Riggs","Roberson","Roberts","Robinson","Rogers","Roman","Rose","Santos","Saunders","Sawyer","Schaefer","Schneider","Schultz","Scott","Shah","Shelton","Shepard","Sheppard","Sloan","Small","Smith","Smyth","Snow","Solomon","Stafford","Stewart","Stuart","Summers","Taylor","Thomas","Thompson","Todd","Tyler","Valdez","Vega","Velazquez","Villanueva","Wagner","Walker","Waller","Walsh","Weiss","Whitehead","Wiggins","Wilcox","Wiley","Williams","Willis","Wilson","Winthrop","Wood","Wright","Wu","Yoder","Young","Zhang"]
	var text  = HumanSurnames[rand_range(0, HumanSurnames.size())]
	return text

static func getRandomFElfName():
	var FElfNames = ["Adgella","Adina","Admoira","Adna","Aeris","Albis","Anhanna","Arabanise","Aracaryn","Aracyne","Aramoira","Arawenys","Ariel","Bidove","Bihana","Bileth","Bilynn","Birel","Bivyre","Bryralei","Caenairra","Caisatra","Caithana","Chaelana","Chaephyra","Chaerieth","Chaetris","Chaevaris","Daefina","Daephine","Daesys","Daeyra","Damoira","Datris","Dawenys","Daynore","Driszora","Durrastra","Eilbella","Eilcahne","Eilfiel","Eilkyrath","Eilrie","Eilthyra","Eilxana","Enacelle","Endi","Enna","Enra","Enthyra","Fabella","Faedi","Faemoira","Faemys","Faeralei","Faeriele","Faesanna","Faexisys","Fafina","Fagella","Fakalyn","Farieth","Favyre","Faynore","Gilleth","Gilrora","Gilthyra","Grebanise","Grecaryn","Gremys","Grephine","Grera","Greynore","Grucelle","Helerel","Helezana","Holacaryn","Hyllyn","Iarlynn","Illayana","Inahana","Inakrana","Inazorwyn","Irexana","Jelenriele","Jelenshana","Jelenzane","Jorel","Jovaris","Kaicahne","Kaiqirith","Kairastra","Keybella","Keymys","Keyxina","Krisdove","Kriskalyn","Krisralei","Krissys","Liagella","Liaqirelle","Liastina","Loragella","Lorarel","Lorawynn","Maglee","Magrona","Magsatra","Magstina","Menairra","Miacyne","Miafiel","Mialynn","Miarora","Miaroris","Miavyre","Miazorwyn","Nairiele","Naitora","Nerigella","Nerirona","Nerithana","Nerixana","Olabanise","Olana","Olaphyra","Olaqirelle","Olaralei","Olasatra","Olavaris","Olazana","Oricelle","Orifina","Orihana","Oriphine","Orirora","Phibanise","Phifiel","Phigella","Phihana","Phikalyn","Phirie","Phisatra","Phivaris","Phiwenys","Phiwynn","Phiyra","Presbella","Presna","Qithana","Qiwenys","Qixisys","Qizana","Quibanise","Quibella","Quigwyn","Quilana","Quithyra","Quiwenys","Quiwynn","Quiynore","Ravabella","Ravagwyn","Ravakalyn","Ravamoira","Ravarel","Reykrana","Reyrora","Reyroris","Reytris","Reywenys","Reyzana","Rigrys","Rolhyssa","Shameiv","Sharona","Shasys","Shavyre","Shawenys","Sylcyne","Sylgella","Sylharice","Syljyre","Sylrie","Sylsys","Torbanise","Torharice","Torlana","Torlee","Torrora","Torroris","Torvyre","Trihyssa","Trisharice","Triskalyn","Trislynn","Trisnala","Trisrel","Trisstina","Tristris","Trisxina","Uladi","Ulamoira","Ularalei","Ulavyre","Ulaxina","Ulkyrath","Ulthaea","Ultrianna","Uribanise","Urilynn","Urimys","Urina","Uriphyra","Uriqirelle","Urirora","Urithyra","Uritris","Urivaris","Vacelle","Valjyre","Valrel","Valynore","Vameiv","Venbanise","Venkalyn","Venphyra","Venrel","Venthyra","Weswena","Weszora","Wyncyne","Xildove","Xilfina","Xilleth","Xilphyra","Xilqirelle","Xilthana","Xilvaris","Xilwynn","Xilxisys","Xyrrona","Xyrthana","Yesharice","Yesleth","Yesralei","Yesrora","Yeswynn","Yllacelle","Yllagwyn","Yllalee","Yllaparys","Yllasys","Yllaxina","Zelda","Zenhanna","Zinlana","Zinralei","Zinsatra","Zinyra","Zylharice","Zyltris"]
	var text  = FElfNames[rand_range(0, FElfNames.size())]
	return text

static func getRandomMElfName():
	var MElfNames = ["Adjeon","Adkian","Admaris","Adric","Adven","Adxidor","Aefir","Aekas","Aepeiros","Aeven","Aeydark","Ailduin","Alaion","Alluin","Ardryll","Balberos","Balcan","Baldan","Balmaris","Balmyar","Balpeiros","Balris","Baltumal","Balwraek","Beican","Beijor","Beikian","Beimyar","Carmenor","Carric","Carro","Carwraek","Crajor","Crakian","Craran","Cratumal","Daebalar","Daelen","Daeqen","Daeyarus","Darthoridan","Dorceran","Dorpeiros","Dorvalur","Edwyrd","Elabalar","Elahorn","Elakas","Elakian","Elalar","Elanan","Elatumal","Elaven","Elaydark","Eldithas","Elfaren","Ellar","Elmyar","Elre","Elric","Elwarin","Elwin","Elydark","Elzumin","Ercan","Erlamin","Erlar","Erran","Falaerin","Fardithas","Farfaren","Fargeiros","Farsalor","Fenceran","Fenneiros","Feno","Fensalor","Fenydark","Fenzumin","Folwin","Genlar","Genmyar","Genqen","Genvalur","Genwraek","Genydark","Glyncan","Glynlar","Glynneiros","Glynpetor","Glynris","Glynsalor","Glynyarus","Haldir","Heigeiros","Heijeon","Heilamin","Heimyar","Heinorin","Heiqen","Heiwarin","Heiydark","Hermaris","Hernan","Iankian","Ianneiros","Ianxidor","Ilibalar","Iliqen","Ilivalur","Jannalor","Keafaren","Kealamin","Keaneiros","Kearan","Keasalor","Kelkian","Kelvalur","Leoro","Lunan","Luren","Luro","Lutoris","Luwarin","Luydark","Lysanthir","Malgath","Miragolor","Miramenor","Miramyar","Miraric","Miraris","Mirasalor","Morhorn","Mornelis","Morpeiros","Morpetor","Morzeiros","Naeberos","Naehorn","Naelar","Naelen","Nieven","Norberos","Norqen","Norran","Norric","Nuvian","Oenel","Olojor","Oloran","Omadan","Omalamin","Omamenor","Omanelis","Omaxidor","Padan","Paeral","Pageiros","Pamaer","Pamaris","Paran","Perneiros","Perquinal","Petfir","Petyarus","Pharom","Qidithas","Qijeon","Qimaris","Qineiros","Qinelis","Qingolor","Qinkas","Qinric","Qipetor","Qiquinal","Qiwarin","Qiwraek","Ralojor","Ralokian","Ralonelis","Raloquinal","Respen","Riluaneth","Rodan","Rodithas","Rofir","Romaris","Romyar","Roro","Rowraek","Roxalim","Ruith","Sarceran","Sarneiros","Sarydark","Sataleeti","Sylberos","Sylven","Sythaeryn","Taanyth","Taranath","Tarron","Thenan","Theodmon","Theric","Thesandoral","Thexalim","Tralamin","Tramaris","Tramyar","Tranan","Traqen","Tratoris","Traxalim","Umebalar","Umenan","Umetoris","Umeven","Umexidor","Uribalar","Uriceran","Urifaren","Uriris","Urixidor","Uriyarus","Vajeon","Varo","Vaxalim","Virbalar","Virneiros","Virnorin","Volodar","Waesbalar","Waesdan","Waeshorn","Waeslar","Waesnelis","Waespetor","Waeszeiros","Wranbalar","Wrangeiros","Wranlamin","Wranwarin","Wranzumin","Xanotter","Yelmaer","Yelyarus","Yelzumin","Yinjeon","Yinqen","Yinro","Yinven","Yinzeiros","Zandro","Zelphar","Zhoron","Zincan","Zinfaren","Zinhice","Zinmenor","Zinxalim","Zumlar","Zumzeiros"]
	var text  = MElfNames[rand_range(0, MElfNames.size())]
	return text

static func getRandomElfSurname():
	var ElfSurnames = ["Autumncrest","Autumnspirit","Blacksinger","Bladeheart","Blademane","Darksky","Dawnwind","Dewbreath","Dewspirit","Farspyre","Feathermane","Feathermoon","Feathersword","Fogbow","Forestwhisper","Greenwater","Lunarage","Moongrove","Rainsinger","Rapidsnow","Sagespear","Sagespirit","Sealight","Shademane","Shadewind","Shadowblade","Silverwhisper","Skyclouds","Skyswift","Stagbranch","Stillrunner","Summerbloom","Sunspear","Swiftseeker","Thunderspear","Treeleaf","Treespear","Truetree","Winterrage","Wintersinger","Woodforest"]
	var text  = ElfSurnames[rand_range(0, ElfSurnames.size())]
	return text

static func getRandomFurrySurname():
	var furrysurnames1 = ['Black','White','Red','Dark','Frost','Fire','Wind','Ice','Forest','Shade','Moon','Iron','Shadow','Gold','Strong','Grim','River','Silver','Great']
	var furrysurnames2 = ['paw','mane','tail','fang','howl','bone','pelt','eyes','hunter','claw','growl']
	return furrysurnames1[rand_range(0,furrysurnames1.size())] + furrysurnames2[rand_range(0,furrysurnames2.size())]

static func getRandomFOrcName():
	var FOrcNames = ["Abimfash","Adkul","Adlugbuk","Agazu","Agdesh","Aglash","Agli","Agrash","Agrulla","Agzurz","Akash","Akgruhl","Akkra","Aklash","Alga","Arakh","Argulla","Argurgol","Arzakh","Arzorag","Ashaka","Ashgara","Ashgel","Ashrashag","Atoga","Atorag","Atugol","Atzurbesh","Aza","Azabesh","Azadhai","Azhnakha","Azhnolga","Azhnura","Azilkh","Azlakha","Azulga","Baag","Baagug","Badush","Bafthaka","Bagrugbesh","Bagul","Bagula","Barza","Barazal","Batara","Batasha","Batorabesh","Bazbava","Bazgara","Bhagruan","Bluga","Bolash","Bolgar","Bolugbeka","Borbgur","Borbuga","Borgburakh","Borgdorga","Borgrara","Boroth","Borzog","Bugbekh","Bugbesh","Bugha","Bularkh","Bulfor","Bumava","Bumbuk","Bumzuna","Dagarha","Drienne","Droka","Druga","Dufbash","Dulasha","Dulfra","Dulfraga","Dulkhi","Dulroi","Dumoga","Dumuguk","Dumurzog","Duragma","Durga","Durgura","Durhaz","Durida","Durogbesh","Dushug","Erisa","Fnagdesh","Gahgra","Gargum","Garl","Garlor","Garlub","Garotusha","Ghamzeh","Gharakul","Gharn","Ghat","Gheshol","Ghobub","Ghogogg","Ghorbog","Ghorzolga","Ghratutha","Glagag","Glagosh","Glarikha","Glash","Glath","Glathut","Glesh","Glolbikla","Glothum","Glurbasha","Glurduk","Glurmghal","Glurzul","Gluth","Gluthesh","Gnush","Gogul","Golga","Gonbubal","Gondubaga","Goorga","Grabash","Graghesh","Grahla","Grahuar","Grakguhl","Graklha","Grash","Grashla","Grashug","Grazda","Grazubesha","Grenbet","Groddi","Grubalash","Grubathag","Grubazh","Grubesha","Grugleg","Grumgha","Grundag","Gruzbura","Guazh","Gula","Gulara","Gulgula","Gulorz","Gulugash","Gulza","Gulzurgol","Gurhul","Gurikha","Gursthuk","Gurum","Guth","Guurzash","Guuth","Guz","Guzash","Guzmara","Haghai","Harza","Hurabesh","Ilg","Irsugha","Jorthan","Junlock","Kashurthag","Khagral","Khagruk","Khaguga","Khaguur","Kharza","Kharzolga","Khazrakh","Kora","Korgha","Kroma","Kruaga","Kuhlon","Kurz","Lagabul","Laganakh","Lagbaal","Lagbuga","Lagra","Lagruda","Lahzga","Lakhazga","Lamazh","Lambur","Lamburak","Lamugbek","Lamur","Lamzakha","Larzgug","Lashakh","Lashbesh","Lashbura","Lashdura","Lashgikh","Lashgurgol","Lashza","Lazdutha","Lazghal","Lazgara","Legdul","Mugaga","Lig","Logdotha","Loglorag","Logru","Lokra","Lorak","Lorogdu","Luga","Lugharz","Luglorash","Lugrugha","Lurgush","Luruzesh","Lurz","Mabgikha","Mabgrolabesh","Mabgrorga","Mabgrubaga","Mabgruhl","Magula","Maraka","Marutha","Maugruhl","Mazgroth","Mazrah","Mazuka","Megruk","Moglurkgul","Mograg","Mogul","Mordra","Morga","Mornamph","Morndolag","Mozgosh","Mugumurn","Muguur","Mulgabesh","Multa","Mulzah","Mulzara","Murotha","Murzgut","Muzgraga","Narzdush","Nazdura","Nazhag","Nazhataga","Nazubesh","Noguza","Nunchak","Nuza","Ogzaz","Oorga","Oorza","Oorzuka","Orbuhl","Orcolag","Ordatha","Orgotha","Orlozag","Orlugash","Orluguk","Orthuna","Orutha","Orzbara","Orzdara","Orzorga","Oshgana","Othbekha","Othgozag","Othikha","Othrika","Ozrog","Pruzag","Pruzga","Ragbarlag","Ragushna","Rakhaz","Rakuga","Ranarsh","Razbela","Rogag","Rogba","Rogbual","Rogoga","Rogzesh","Roku","Rolbutha","Rolfikha","Rolfzal","Rolga","Rulbagab","Rulbza","Ruldor","Rulfala","Rulfub","Rulfuna","Rulfzub","Sgala","Sgrugbesh","Sgrugha","Sgrula","Shabaga","Shabeg","Shabeshga","Shabgrut","Shabon","Shagareg","Shagduka","Shagora","Shagrum","Shagrush","Shagura","Shakul","Shalug","Shamuk","Shamush","Shara","Sharbzur","Sharduka","Shardush","Shardzozag","Sharga","Shargduguk","Shargra","Sharuk","Sharushnam","Shaza","Shebakh","Shelboth","Sheluka","Shgrag","Sholg","Shubesha","Shufdal","Shufgrut","Shufthakul","Shuga","Shugzar","Shurkul","Shuzrag","Sloogolga","Sluz","Snagara","Snaghusha","Snarataga","Snarga","Snargara","Snaruga","Sneehash","Snilga","Snoogh","Snushbesh","Solgra","Stilga","Stroda","Stuga","Stughrush","Tamozag","Theg","Thegbesh","Thegshakul","Thegshalash","Theshaga","Theshgoth","Thishnaku","Thoga","Thogra","Thrugrak","Thugnekh","Thulga","Thushleg","Tugha","Ubzigub","Udai","Ufalga","Ufgabesh","Ufgaz","Ufgel","Ufgra","Uftheg","Ugarnesh","Ugduk","Ugrash","Ugrush","Uldushna","Ulfgalash","Ulg","Ulgush","Ulsha","Ulu","Ulubesh","Uluga","Ulukhaz","Umbugbek","Umgubesh","Umutha","Umzolabesh","Undorga","Undush","Undusha","Uratag","Urbzag","Urdboga","Urgarlag","Urshra","Uruka","Urzula","Usha","Ushaga","Ushenat","Ushruka","Ushuta","Uthik","Uzka","Vosh","Vumnish","Vush","Yakhu","Yarlak","Yarulorz","Yatanakh","Yatular","Yatzog","Yazara","Yazgruga","Yazoga","Zaag","Zagla","Zagula","Zubesha","Zugh","Zuugarz","Zuuthag","Zuuthusha"]
	var text  = FOrcNames[rand_range(0, FOrcNames.size())]
	return text
	
static func getRandomMOrcName():
	var MOrcNames = [ "Abzag","Abzrolg","Abzug","Agganor","Aghurz","Agnar","Agrakh","Agrobal","Agstarg","Aguz","Ahzug","Arghragdush","Arghur","Ashzu","Aturgh","Avreg","Azarg","Azgarub","Azimbul","Balarkh","Balknakh","Balmeg","Baloth","Balrook","Balzag","Bargo","Bargrug","Bash","Bashagorn","Batgrul","Bazrag","Begnar","Bekhwug","Bhagrun","Biknuk","Bisquelas","Blodrat","Boagog","Boggeryk","Bogham","Bognash","Bogodug","Bogzul","Bolg","Bolgrul","Borab","Borbuz","Borgath","Borgh","Bormolg","Borolg","Borth","Borz","Borzighu","Borzugh","Braadoth","Braghul","Brog","Brogdul","Brugagikh","Brugdush","Brughamug","Brulak","Bugnerg","Bugunh","Bulg","Bullig","Bulugbek","Bulzog","Bulozog","Bumnog","Buragrub","Burzgrag","Burzunguk","Burzura","Buzog","Carzog","Charlvain","Cognor","Dagnub","Dorzogg","Dromash","Dugakh","Dugan","Dugroth","Dugtosh","Dugug","Dugugikh","Dular","Dulph","Dulphago","Dulrat","Dumolg","Durak","Dushgor","Dushkul","Dushugg","Fangoz","Farbalg","Fheg","Gahgdar","Gahznar","Gard","Gargak","Garmeg","Garnikh","Gashdug","Gasheg","Gezdak","Gezorz","Ghagrub","Ghak","Ghaknag","Ghamron","Ghamulg","Ghashur","Ghatrugh","Ghaturn","Ghaz","Ghobargh","Ghogurz","Ghorn","Ghornag","Ghornugag","Ghrategg","Ghromrash","Gladba","Glag","Glagbor","Glamalg","Glaz","Glazgor","Glazulg","Glegokh","Gloorag","Gloorot","Glorgzorgo","Gloth","Glothozug","Glud","Glundeg","Glunrum","Glunurgakh","Glurdag","Glurnt","Glushonkh","Gluthob","Gluthush","Gobur","Goburbak","Godrun","Gogaz","Gogbag","Gogrikh","Goh","Gohazgu","Golbag","Golg","Goorgul","Goragol","Gorak","Goramalg","Gorbakh","Gorblad","Gorbu","Gordag","Gorgath","Gorgrolg","Gorlar","Gorotho","Gorrath","Goruz","Gorzesh","Gothurg","Gozarth","Graalug","Gralturg","Grashbag","Grashub","Gravik","Grezgor","Grishduf","Grodagur","Grodoguz","Gronov","Grookh","Grubdosh","Grudogub","Grugnur","Grulbash","Gruldum","Gruloq","Gruluk","Grulzul","Grumth","Grunyun","Grushbub","Grushnag","Gruudus","Gruzdash","Gruznak","Gulargh","Gulburz","Gulug","Gulzog","Gunagud","Gunran","Gurg","Gurgozod","Gurlak","Guruzug","Guzg","Gwilherm","Hagard","Horak","Ilthag","Inazzur","Kargnuth","Kazok","Kelrog","Kentosh","Khal","Khamagash","Kharsh","Kharsthun","Khartag","Khoruzoth","Khralek","Kurog","Kirgut","Klang","Klovag","Kogaz","Kradauk","Krodak","Krog","Krogrash","Kulth","Kurd","Kurlash","Lagarg","Lagrog","Lahkgarg","Lakhalg","Lakhdosh","Larhoth","Larob","Lashbag","Latumph","Laurig","Lazgel","Lob","Logbur","Logogru","Logrun","Lorbash","Lothdush","Lothgud","Lozotusk","Lozruth","Lug","Lugbagg","Lugbur","Lugdakh","Lugdugul","Lugnikh","Lugolg","Lugrots","Lugrun","Lugzod","Lum","Lumgol","Lungruk","Lunk","Lurash","Lurbozog","Lurg","Lurgonash","Luzmash","Maaga","Mag","Magunh","Makhoguz","Makhug","Marzul","Maugash","Mauhoth","Mazabakh","Mazgro","Mazogug","Mekag","Mog","Mogazgur","Mogrub","Mokhrul","Mokhul","Mordrog","Mordugul","Mordularg","Morgaz","Morgbrath","Morlak","Morothmash","Morotub","Mort","Mothozog","Muduk","Mudush","Muglugd","Muhaimin","Mulatub","Mulgargh","Mulgu","Mulur","Mulzalt","Murdodosh","Murgonak","Murgoz","Murgrud","Murkh","Murlog","Murukh","Murzog","Muzbar","Muzdrulz","Muzgalg","Muzgash","Muzgu","Muzogu","Nagoth","Nagrul","Nahzgra","Nahzush","Namoroth","Narazz","Nargbagorn","Narhag","Narkhagikh","Narkhozikh","Narkhukulg","Narkularz","Nash","Nenesh","Norgol","Nugok","Nugwugg","Nunkuk","Obdeg","Obgol","Obgurob","Obrash","Ofglog","Ogmash","Ogog","Ogorosh","Ogozod","Ogruk","Ogularz","Ogumalg","Ogzor","Okrat","Olfim","Olfin","Olgol","Olugush","Ontogu","Oodeg","Oodegu","Oorg","Oorgurn","Oorlug","Ordooth","Orgak","Orgdugrash","Orgotash","Orntosh","Orzbara","Orzuk","Osgrikh","Osgulug","Othbug","Othigu","Othogor","Othohoth","Otholug","Othukul","Othulg","Othzog","Ozor","Pergol","Rablarz","Ragbul","Ragbur","Ragnast","Ramash","Ramazbur","Ramorgol","Ramosh","Razgor","Razgugul","Rhosh","Rogbum","Rognar","Rogrug","Rogurog","Rokaug","Rokut","Roog","Rooglag","Rorburz","Rozag","Rugdugbash","Rugmeg","Ruzgrol","Sgagul","Sgolag","Shab","Shagol","Shagrod","Shakh","Shakhighu","Shamar","Shamlakh","Shargarkh","Shargunh","Sharkagub","Sharkuzog","Sharnag","Shogorn","Shugral","Shukul","Shulthog","Shurkol","Skagurn","Skagwar","Skalgunh","Skalguth","Skarath","Skordo","Skulzak","Slagwug","Slayag","Slegbash","Smagbogoth","Smauk","Snagbash","Snagg","Snagh","Snakh","Snakzut","Snalikh","Snarbugag","Snargorg","Snazumph","Snegbug","Snegburgak","Snegh","Snikhbat","Snoog","Snoorg","Snugar","Snugok","Snukh","Snushbat","Sogh","Spagel","Storgh","Stugbrulz","Stugbulukh","Szugburg","Szugogroth","Targoth","Tazgol","Tazgul","Thagbush","Thakh","Thakush","Tharag","Tharkul","Thaz","Thazeg","Thaznog","Thegur","Thereg","Tholog","Thorzh","Thorzhul","Thrag","Thragdosh","Thragosh","Threg","Thrug","Thrugb","Thukbug","Thungdosh","Todrak","Togbrig","Tograz","Torg","Torug","Tugam","Tugawuz","Tumuthag","Tungthu","Ufthag","Ugdush","Uggnath","Ugorz","Ugruntuk","Uguntig","Ugurz","Ulagash","Ulagug","Ulang","Ulgdagorn","Ulghesh","Ulmamug","Ulozikh","Undrigug","Undugar","Ungruk","Unrahg","Unthrikh","Uragor","Urak","Urdbug","Urgdosh","Urok","Ushang","Usn","Usnagikh","Uulgarg","Uuth","Uznom","Vargos","Waghuth","Wardush","Wort","Yagorkh","Yagramak","Yakegg","Yamukuz","Yargob","Yarnabakh","Yarnag","Yarulg","Yat","Yggnast","Yggoz","Yggruk","Yzzgol","Zagh","Zaghurbak","Zagrakh","Zagrugh","Zbulg","Zegol","Zgog","Zhagush","Zhosh","Zilbash","Zogbag","Zulbash","Zulgozu","Zulgukh","Zungarg","Zunlog"]
	var text  = MOrcNames[rand_range(0, MOrcNames.size())]
	return text
	
static func getRandomOrcSurname():
	var OrcSurnames = ["Agadbu","Aglakh","Agum","Atumph","Azorku","Badbu","Bagrat","Bagul","Bamog","Bar","Bargamph","Bashnag","Bat","Batul","Boga","Bogamakh","Bogharz","Bogla","Boglar","Bogrol","Boguk","Bol","Bolak","Borbog","Borbul","Bug","Bugarn","Bulag","Bularz","Bulfish","Burbug","Burish","Burol","Buzga","Dugul","Dul","Dula","Dulob","Dumul","Dumulg","Durga","Durog","Durug","Dush","Gar","Gashel","Gat","Ghash","Ghasharzol","Gholfim","Gholob","Ghorak","Glorzuf","Gluk","Glurkub","Gorzog","Grambak","Gulfim","Gurakh","Gurub","Kashug","Khagdum","Kharbush","Kharz","Khash","Khashnar","Khatub","Khazor","Lag","Lagdub","Largum","Lazgarn","Loghash","Logob","Logrob","Lorga","Lumbuk","Lumob","Lurkul","Lurn","Luzgan","Magar","Magrish","Mar","Marob","Mashnar","Mogduk","Moghakh","Mughol","Muk","Mulakh","Murgol","Murug","Murz","Muzgob","Muzgub","Muzgur","Ogar","Ogdub","Ogdum","Olor","Olurba","Orbuma","Rimph","Rugob","Rush","Rushub","Shadbuk","Shagdub","Shagdulg","Shagrak","Shagramph","Shak","Sham","Shamub","Sharbag","Sharga","Sharob","Sharolg","Shat","Shatub","Shazog","Shug","Shugarz","Shugham","Shula","Shulor","Shumba","Shuzgub","Skandar","Snagarz","Snagdu","Ufthamph","Uftharz","Ugruma","Ular","Ulfimph","Urgak","Ushar","Ushug","Ushul","Uzgurn","Uzuk","Yagarz","Yak","Yargul","Yarzol"]
	var text  = OrcSurnames[rand_range(0, OrcSurnames.size())]
	return text
	
static func getRandomFDemonName():
	var FDemonNames = ["Aflaia","Afseis","Agnenise","Agnewure","Anilith","Aranarei","Arayola","Arigoria","Arihala","Arilia","Belmaia","Belrali","Belyola","Bliss","Crefaris","Crelith","Creseis","Dalyvia","Daqine","Darali","Dawure","Delight","Difirith","Dimuphis","Dorcyra","Dorlypsis","Dorzes","Eauphis","Eayola","Frilith","Frimeia","Friza","Glory","Gricria","Gritari","Hiski","Hisqine","Hisvari","Hisyola","Inigrea","Inilies","Inipione","Inisolis","Inyis","Kalnise","Lekaria","Leloth","Lemine","Lerissa","Levborys","Levgoria","Levlia","Lilborys","Lillia","Lilphi","Lilseis","Mafaris","Magrea","Maki","Mardani","Marmeia","Marnirith","Martish","Mazes","Misdani","Misrali","Missolis","Mithborys","Mithrissa","Mithtari","Nahiri","Nameia","Natlies","Natuphis","Natvine","Nehala","Netari","Nethhala","Nethlith","Nethloth","Nethtish","Nithlaia","Nithpunith","Oriloth","Pesdoris","Peslypsis","Peswala","Pesza","Phedani","Phelaia","Phepunith","Phetari","Poetry","Qumaia","Qupione","Quxori","Ricyra","Rogoria","Rokaria","Saborys","Salaia","Sapunith","Sarhiri","Sarkaria","Sartari","Satari","Saxibis","Saza","Seiripione","Seirivari","Seirixibis","Seiriyola","Shafirith","Shalia","Shaxori","Valborys","Veltish","Velzes","Yaspira","Yaxibis","Yaza","Yorameia","Yorayola","Yoraza","Yucyra","Yudoris","Yulypsis","Yuuphis","Zaihiri","Zailaia","Zenarei","Zevari"]
	var text  = FDemonNames[rand_range(0, FDemonNames.size())]
	return text
	
static func getRandomMDemonName():
	var MDemonNames = ["Aetilius","Aetreus","Akxikas","Amemon","Amlius","Ammarir","Amrai","Andrai","Andron","Anguish","Arkxes","Armeros","Armus","Arrakir","Arthor","Arthos","Barchar","Barichar","Barmarir","Barthos","Barxikas","Caremon","Carmeros","Carrias","Carvir","Casilius","Casmenos","Casrai","Casrakas","Casrus","Casrut","Casxius","Conten","Damlyre","Damrius","Dharmeros","Dharrai","Ebthus","Ebvius","Ekrai","Ermus","Errai","Errakir","Errus","Ervius","Erxus","Eternal","Garlius","Garmarir","Garthus","Garxire","Gudos","Gueichar","Guemir","Guevir","Guevius","Guthus","Guzer","Horchar","Horvenom","Horxes","Horzire","Iacius","Iamir","Iarias","Kachar","Kail","Kaimir","Kairos","Karadius","Karil","Karlyre","Karmeros","Karzer","Kaxire","Kilmir","Kosnon","Kychar","Kymenos","Kythor","Lokelech","Lokemeros","Lokerai","Lokerakas","Lokexus","Malechar","Malemarir","Malemos","Maleris","Malrai","Malrut","Master","Mavcius","Mavilius","Mavnon","Mavxes","Mavxire","Meichar","Memarir","Merakir","Mexus","Moril","Morrakas","Nephrias","Nephris","Nephxikas","Ozrai","Ozrakir","Ozthor","Ozxes","Ralxikas","Reris","Rexius","Rolchar","Rollius","Rolrakir","Rolthor","Salemon","Salrius","Salrut","Salvius","Salxik","Shaakas","Shalyre","Sharai","Silence","Sircis","Sirira","Sirmenos","Sirreus","Sirthor","Skacius","Skamus","Skarakir","Skaron","Skathos","Thynecis","Thynemenos","Thynevius","Thynexire","Thyxes","Urdos","Uriil","Uril","Urimarir","Urira","Uriros","Urxikas","Urxus","Valakos","Valrakas","Valrut","Valxus","Woe","Xarakos","Xarilius","Xarmeros","Xarzire","Zaremon","Zarrias","Zermarir","Zherira","Zorcius"]
	var text  = MDemonNames[rand_range(0, MDemonNames.size())]
	return text
	
static func getRandomDemonSurname():
	var DemonSurnames = []
	var text  = DemonSurnames[rand_range(0, DemonSurnames.size())]
	return text

static func getRandomEyeStandardColor():
	var text = [ 'blue', 'green', 'brown', 'hazel', 'black', 'gray' ]
	return text[rand_range(0, text.size())]


static func getRandomBeastEyeColor():
	var text = [ 'blue', 'green', 'amber', 'red']
	return text[rand_range(0, text.size())]


static func getRandomHorns():
	var text = ['short', 'long_straight', 'curved']
	return text[rand_range(0, text.size())]


static func getRandomEyeFancyColor():
	var text = ['blue', 'green', 'amber', 'red', 'purple']
	return text[rand_range(0, text.size())]

static func getRandomAnyEyeColor():
	var text = [ 'blue', 'green', 'amber', 'red', 'purple', 'brown', 'hazel', 'black', 'gray' ]
	return text[rand_range(0, text.size())]

static func getRandomHairStandardColor():
	var text = ['blond', 'red', 'auburn', 'brown', 'black']
	return text[rand_range(0, text.size())]

static func getRandomHairFancyColor():
	var text = ['white', 'green', 'purple', 'blue', 'blond', 'red', 'auburn' ]
	return text[rand_range(0, text.size())]

static func getRandomHairAnyColor():
	var text = ['blond', 'red', 'auburn', 'brown', 'black', 'white', 'green', 'purple', 'blue', 'gradient' ]
	return text[rand_range(0, text.size())]

static func getHairLengthBase(slave):
	var text = '';
	if (slave.sex == 'male'):
		text = getRandomHairLengthShort()
	else:
		if (slave.age == 'child'):
			if (rand_range(0, 10) >= 8):
				text = getRandomHairLengthLong()
			else:
				text = getRandomHairLengthNormal()
		elif (slave.age != 'child' && rand_range(0,10) > 4):
			text = getRandomHairLengthLong() 
		else:
			text = getRandomHairLengthLong()
	return text#[rand_range(0, text.size())]

static func getRandomHairStyle(slave):
	var text = [];
	
	if (slave['hairlength'] != 'short' && rand_range(0,10) < 6):
		text = ['ponytail', 'twintails', 'braid', 'two braids', 'bun']
	else:
		text = ['straight']
	if (slave['sex'] == 'male'):
		text = ['straight', 'straight', 'straight', 'straight', 'ponytail']
	return text[rand_range(0, text.size())]


static func getRandomHairLengthShort():
	var text = ['ear', 'neck']
	return text[rand_range(0, text.size())]

static func getRandomHairLengthNormal():
	var text = ['ear', 'neck', 'shoulder']
	return text[rand_range(0, text.size())]

static func getRandomHairLengthLong():
	var text = ['shoulder', 'waist', 'hips']
	return text[rand_range(0, text.size())]

static func getRandomSkinColorStandard():
	var text = [ 'pale', 'pale', 'fair', 'fair', 'fair', 'olive', 'tan' ]
	return text[rand_range(0, text.size())]


static func getRandomSkinColorDark():
	var text = [ 'tan', 'brown', 'dark' ]
	return text[rand_range(0, text.size())]

static func getRandomSkinColorDrow():
	var text = [ 'blue', 'purple' ]
	return text[rand_range(0, text.size())]

static func getRandomSkinColorAny():
	var text = [ 'pale', 'fair', 'olive', 'tan', 'brown', 'blue', 'green', 'red', 'purple', 'dark', 'teal', 'jelly' ]
	return text[rand_range(0, text.size())]


static func getSexFeatures(slave):
	var age = slave['age']
	var bodyshape = slave['bodyshape']
	var sex = slave['sex']
	var height = []
	var titssize = []
	var tits = {
	size = '',
	extrapairs = 0,
	developed = false,
	lactation = false
	}
	var ass = []
	var rval = {}
	var balls = []
	var penissize = []
	var penistype = 'human'
	var penisnumber = 0
	var penis = {}
	var pussy = {}
	
	if (slave['race'].find("Beastkin") >= 0 && globals.rules['furrynipples'] == true):
		tits['extrapairs'] = 3
	
	if (sex != 'male'):
			if (age == 'child'):
				height = [ 'petite', 'short']
				titssize = ['flat', 'small']
				ass = titssize
			elif (age == 'teen'):
				height = [ 'petite', 'short', 'short', 'average', 'average', 'average', 'tall' ]
				titssize = ['flat', 'small','average','big']
				ass = titssize
			elif (age == 'adult'):
				height = [ 'short', 'short', 'average', 'average', 'average', 'tall', 'tall', 'towering']
				titssize = ['small','average','big', 'huge']
				ass = titssize
			
	elif (sex == 'male'):
		penisnumber = 1
		pussy['has'] = false
		pussy['virgin'] = false
		if (age == 'child'):
			height = [ 'petite', 'short']
			titssize = ['flat']
			ass = ['flat']
			penissize = ['small', 'average']
			balls = ['small', 'average']
		else:
			height = [ 'short', 'average', 'tall', 'towering' ]
			titssize = ['flat','masculine']
			ass = ['flat', 'masculine']
			penissize = ['small','average','big']
			balls = ['small', 'average', 'big']
		
	if (sex == 'futanari' && globals.rules['futa'] == true): #check for futas to be allowed
		penisnumber = 1
		if (age == 'child'):
			penissize = ['small', 'average']
		else:
			penissize = ['small','average','big']
			
	if (globals.rules['futaballs'] == true && sex == 'futanari'): #// check for balls to be allowed
		if (age == 'child'):
			balls = ['small', 'average']
		else:
			balls = ['small', 'average', 'big'];
	elif (sex != 'male'):
		balls = ['none']
		
		
	if (sex == 'female'):
		penissize = ['none']
		balls = ['none']
	elif (sex == 'male'):
		pussy['has'] = false
		
	if (sex != 'male') :
		pussy['has'] = true
		pussy['virgin'] = false
		if (age == 'child' && rand_range(0,12) < 10):
			pussy['virgin'] = true
		elif (age == 'teen'):
			if (rand_range(0,10) >= 4):
				pussy['virgin'] = false
			else:
				pussy['virgin'] = true
		elif (age == 'adult'):
			if (rand_range(0,10) >= 3):
				pussy['virgin'] = false
			else: 
				pussy['virgin'] = true
		else:
			pussy['virgin'] = false
		
		if (bodyshape == 'shortstack'):
			height = ['tiny']
	if (penissize != 'none' && slave['race'].find('Beastkin') >= 0):
		if (slave['race'].find('Cat') >= 0):
			penistype = 'feline'
		elif (slave['race'].find('Fox') >= 0 || slave['race'].find('Wolf') >= 0):
			penistype = 'canine'
	if (penissize != 'none' && slave['race'].find('Centaur') >= 0):
		penistype = 'equine'
	
	penis['type'] = penistype
	penis['size'] = penissize[rand_range(0, penissize.size())]
	penis['number'] = penisnumber
	tits['size'] = titssize[rand_range(0, titssize.size())]
	rval['tits'] = tits
	rval['ass'] = ass[rand_range(0, ass.size())]
	rval['height'] = height[rand_range(0, height.size())]
	rval['penis'] = penis
	rval['balls'] = balls[rand_range(0, balls.size())]
	rval['pussy'] = pussy
	return rval;

