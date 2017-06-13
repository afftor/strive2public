
extends Node

static func RaceHuman():
	var rval = {
	bodyshape ='humanoid',
	skin = globals.assets.getRandomSkinColorStandard(),
	eyecolor = globals.assets.getRandomEyeStandardColor(),
	eyeshape = 'normal',
	eyesclera = 'normal',
	haircolor = globals.assets.getRandomHairStandardColor(),
	furcolor = 'none',
	skincov = 'none',
	ears = 'human',
	tail = 'none',
	horns = 'none',
	wings = 'none',
	arms = 'normal',
	legs = 'normal',
	stats = { str_max = 5, agi_max = 3, maf_max = 2, end_max = 4},
	}
	return rval
	

static func RaceElf():
	var rval = RaceHuman()
	rval['ears'] = 'pointy'
	rval['stats']['str_max'] = 3
	rval['stats']['agi_max'] = 5
	rval['stats']['maf_max'] = 4
	rval['stats']['end_max'] = 3
	rval['haircolor'] = globals.assets.getRandomHairFancyColor()
	
	return rval

static func RaceDarkElf():
	var rval = RaceElf()
	rval['stats']['str_max'] = 4
	rval['stats']['agi_max'] = 5
	rval['stats']['maf_max'] = 3
	rval['stats']['end_max'] = 4
	rval['skin'] = globals.assets.getRandomSkinColorDark()
	rval['eyecolor'] = globals.assets.getRandomEyeFancyColor()
	
	return rval

static func RaceDrow():
	var rval = RaceElf()
	var temp = ['blue', 'purple', 'pale blue']
	rval['stats']['str_max'] = 4
	rval['stats']['agi_max'] = 5
	rval['stats']['maf_max'] = 6
	rval['stats']['end_max'] = 3
	rval['skin'] = temp[rand_range(0, temp.size())]
	
	return rval

static func RaceOrc():
	var rval = RaceHuman()
	rval['stats']['str_max'] = 6
	rval['stats']['agi_max'] = 3
	rval['stats']['maf_max'] = 1
	rval['stats']['end_max'] = 5
	rval['skin'] = 'green'
	rval['ears'] = 'pointy'
	
	return rval

static func RaceGnome():
	var rval = RaceHuman()
	rval['stats']['str_max'] = 3
	rval['stats']['agi_max'] = 3
	rval['stats']['maf_max'] = 5
	rval['stats']['end_max'] = 3
	rval['bodyshape'] = 'shortstack'
	rval['height'] = 'tiny'
	
	return rval

static func RaceGoblin():
	var rval = RaceHuman()
	rval['stats']['str_max'] = 3
	rval['stats']['agi_max'] = 5
	rval['stats']['maf_max'] = 3
	rval['stats']['end_max'] = 3
	rval['bodyshape'] = 'shortstack'
	rval['skin'] = 'green'
	rval['ears'] = 'pointy'
	rval['height'] = 'tiny'
	
	return rval

static func RaceFairy():
	var rval = RaceHuman()
	rval['stats']['str_max'] = 2
	rval['stats']['agi_max'] = 5
	rval['stats']['maf_max'] = 6
	rval['stats']['end_max'] = 2
	rval['bodyshape'] = 'shortstack'
	rval['eyecolor'] = globals.assets.getRandomEyeFancyColor()
	rval['haircolor'] = globals.assets.getRandomHairFancyColor()
	rval['ears'] = 'pointy'
	rval['wings'] = 'insect'
	rval['surname'] = ''
	rval['height'] = 'tiny'
	
	return rval

static func RaceSeraph():
	var rval = RaceHuman()
	rval['stats']['str_max'] = 4
	rval['stats']['agi_max'] = 5
	rval['stats']['maf_max'] = 3
	rval['stats']['end_max'] = 3
	var temp = ['feathered_black', 'feathered_white', 'feathered_brown'];
	rval['ears'] = 'pointy'
	rval['wings'] = temp[rand_range(0, temp.size())]
	
	return rval

static func RaceDemon():
	var rval = RaceHuman()
	rval['stats']['str_max'] = 5
	rval['stats']['agi_max'] = 4
	rval['stats']['maf_max'] = 4
	rval['stats']['end_max'] = 3
	rval['ears'] = 'pointy'
	rval['tail'] = 'demon'
	var temp = ['leather_black', 'leather_red']
	rval['wings'] = temp[rand_range(0, temp.size())]
	rval['horns'] = globals.assets.getRandomHorns()
	
	return rval

static func RaceDryad():
	var rval = RaceHuman()
	rval['stats']['str_max'] = 3
	rval['stats']['agi_max'] = 4
	rval['stats']['maf_max'] = 5
	rval['stats']['end_max'] = 4
	rval['skin'] = 'green'
	rval['eyesclera'] = 'green'
	var temp = ['green', 'purple']
	rval['haircolor'] = temp[rand_range(0, temp.size())]
	rval['ears'] = 'pointy'
	rval['skincov'] = 'plants'
	rval['surname'] = ''
	
	return rval

static func RaceDragonkin():
	var rval = RaceHuman()
	var temp
	rval['stats']['str_max'] = 6
	rval['stats']['agi_max'] = 4
	rval['stats']['maf_max'] = 5
	rval['stats']['end_max'] = 5
	temp = ['amber', 'red', 'brown']
	rval['eyecolor'] = temp[rand_range(0, temp.size())]
	temp = ['slit', 'normal']
	rval['eyeshape'] = temp[rand_range(0, temp.size())]
	rval['haircolor'] = globals.assets.getRandomHairFancyColor();
	rval['ears'] = 'pointy'
	rval['tail'] = 'dragon'
	rval['horns'] = globals.assets.getRandomHorns()
	temp = ['leather_black', 'leather_red']
	rval['wings'] = temp[rand_range(0, temp.size())]
	rval['skincov'] = 'scales'
	rval['arms'] = 'scales'
	rval['legs'] = 'scales'
	
	return rval


static func RaceTaurus():
	var rval = RaceHuman()
	rval['stats']['str_max'] = 5
	rval['stats']['agi_max'] = 3
	rval['stats']['maf_max'] = 2
	rval['stats']['end_max'] = 6
	rval['horns'] = 'long_straight'
	rval['ears'] = 'short_furry'
	rval['tail'] = 'scruffy'
	
	return rval

static func RaceSlime():
	var rval = RaceHuman()
	rval['stats']['str_max'] = 4
	rval['stats']['agi_max'] = 6
	rval['stats']['maf_max'] = 3
	rval['stats']['end_max'] = 3
	rval['bodyshape'] = 'jelly'
	rval['haircolor'] = 'jelly'
	rval['skin'] = 'jelly'
	rval['surname'] = ''
	return rval



static func RaceHarpy():
	var rval = RaceHuman()
	rval['stats']['str_max'] = 4
	rval['stats']['agi_max'] = 5
	rval['stats']['maf_max'] = 3
	rval['stats']['end_max'] = 3
	rval['bodyshape'] = 'halfbird'
	rval['haircolor'] = globals.assets.getRandomHairFancyColor()
	rval['tail'] = 'bird'
	rval['ears'] = 'feathery'
	rval['skincov'] = 'feathers'
	rval['arms'] = 'winged'
	rval['legs'] = 'avian'
	rval['surname'] = ''
	
	return rval


static func RaceLamia():
	var rval = RaceHuman()
	rval['stats']['str_max'] = 4
	rval['stats']['agi_max'] = 5
	rval['stats']['maf_max'] = 4
	rval['stats']['end_max'] = 4
	rval['bodyshape'] = 'halfsnake'
	rval['haircolor'] = globals.assets.getRandomHairFancyColor()
	rval['tail'] = 'snake tail'
	rval['ears'] = 'pointy'
	rval['skincov'] = 'scales'
	rval['legs'] = 'snake'
	rval['eyecolor'] = globals.assets.getRandomBeastEyeColor()
	rval['eyeshape'] = 'slit'
	rval['surname'] = ''
	
	return rval

static func RaceArachna():
	var rval = RaceHuman()
	rval['stats']['str_max'] = 4
	rval['stats']['agi_max'] = 4
	rval['stats']['maf_max'] = 5
	rval['stats']['end_max'] = 4
	rval['bodyshape'] = 'halfspider'
	rval['haircolor'] = globals.assets.getRandomHairFancyColor()
	rval['tail'] = 'spider abdomen'
	rval['ears'] = 'pointy'
	rval['skincov'] = 'scales'
	rval['legs'] = 'spider'
	rval['eyecolor'] = globals.assets.getRandomBeastEyeColor()
	rval['eyeshape'] = 'slit'
	rval['surname'] = ''
	
	return rval

static func RaceCentaur():
	var rval = RaceHuman()
	rval['stats']['str_max'] = 5
	rval['stats']['agi_max'] = 5
	rval['stats']['maf_max'] = 3
	rval['stats']['end_max'] = 5
	rval['stats']['energy_max'] = 40
	rval['bodyshape'] = 'halfhorse'
	rval['tail'] = 'horse'
	rval['ears'] = 'short_furry'
	rval['legs'] = 'horse'
	
	return rval

static func RaceNereid():
	var rval = RaceHuman()
	rval['stats']['str_max'] = 3
	rval['stats']['agi_max'] = 5
	rval['stats']['maf_max'] = 5
	rval['stats']['end_max'] = 3
	rval['bodyshape'] = 'halffish'
	rval['tail'] = 'fish'
	rval['ears'] = 'fins'
	rval['legs'] = 'webbed'
	rval['arms'] = 'webbed'
	var temp = ['amber', 'red', 'turquoise']
	rval['eyecolor'] = temp[rand_range(0, temp.size())]
	rval['eyeshape'] = 'slit'
	rval['eyesclera'] = 'yellow'
	temp =  ['teal', 'blue', 'pale blue']
	rval['skin'] =temp[rand_range(0, temp.size())]
	rval['surname'] = ''
	
	return rval

static func RaceScylla():
	var rval = RaceHuman()
	rval['stats']['str_max'] = 5
	rval['stats']['agi_max'] = 4
	rval['stats']['maf_max'] = 5
	rval['stats']['end_max'] = 4
	rval['bodyshape'] = 'halfsquid'
	rval['tail'] = 'tentacles'
	rval['ears'] = 'pointy'
	rval['legs'] = 'tentacles'
	rval['eyecolor'] = globals.assets.getRandomBeastEyeColor()
	rval['surname'] = ''
	
	return rval

static func RaceCat():
	var rval = RaceHuman()
	rval['stats']['str_max'] = 4
	rval['stats']['agi_max'] = 6
	rval['stats']['maf_max'] = 3
	rval['stats']['end_max'] = 3
	rval['bodyshape'] = 'bestial'
	rval['skincov'] = 'full_body_fur'
	var temp = ['white', 'gray', 'orange_white','black_white','black_gray','black']
	rval['furcolor'] = temp[rand_range(0, temp.size())]
	rval['tail'] = 'cat'
	rval['ears'] = 'short_furry'
	rval['legs'] = 'fur_covered'
	rval['arms'] = 'fur_covered'
	rval['eyecolor'] = globals.assets.getRandomBeastEyeColor()
	rval['eyeshape'] = 'slit'
	return rval

static func RaceFox():
	var rval = RaceHuman()
	rval['stats']['str_max'] = 4
	rval['stats']['agi_max'] = 5
	rval['stats']['maf_max'] = 4
	rval['stats']['end_max'] = 3
	rval['bodyshape'] = 'bestial'
	rval['skincov'] = 'full_body_fur'
	var temp = ['black_white', 'orange', 'orange', 'orange']
	rval['furcolor'] = temp[rand_range(0, temp.size())]
	rval['tail'] = 'fox'
	rval['ears'] = 'long_pointy_furry'
	rval['legs'] = 'fur_covered'
	rval['arms'] = 'fur_covered'
	rval['eyecolor'] = globals.assets.getRandomBeastEyeColor()
	rval['eyeshape'] = 'slit'
	return rval

static func RaceWolf():
	var rval = RaceHuman()
	rval['stats']['str_max'] = 5
	rval['stats']['agi_max'] = 5
	rval['stats']['maf_max'] = 2
	rval['stats']['end_max'] = 4
	rval['bodyshape'] = 'bestial'
	rval['skincov'] = 'full_body_fur'
	var temp = ['gray', 'black_gray', 'brown']
	rval['furcolor'] = temp[rand_range(0, temp.size())]
	rval['tail'] = 'wolf'
	rval['ears'] = 'short_furry'
	rval['legs'] = 'fur_covered'
	rval['arms'] = 'fur_covered'
	rval['eyecolor'] = globals.assets.getRandomBeastEyeColor()
	rval['eyeshape'] = 'slit'
	return rval

static func RaceBunny():
	var rval = RaceHuman()
	rval['stats']['str_max'] = 3
	rval['stats']['agi_max'] = 5
	rval['stats']['maf_max'] = 3
	rval['stats']['end_max'] = 3
	rval['bodyshape'] = 'bestial'
	rval['skincov'] = 'full_body_fur'
	var temp = ['white', 'gray']
	rval['furcolor'] = temp[rand_range(0, temp.size())]
	rval['tail'] = 'bunny'
	temp = ['long_round_furry', 'long_droopy_furry']
	rval['ears'] = temp[rand_range(0, temp.size())]
	rval['legs'] = 'fur_covered'
	rval['arms'] = 'fur_covered'
	rval['eyecolor'] = globals.assets.getRandomBeastEyeColor()
	return rval

static func RaceTanuki():
	var rval = RaceHuman()
	rval['stats']['str_max'] = 4
	rval['stats']['agi_max'] = 4
	rval['stats']['maf_max'] = 4
	rval['stats']['end_max'] = 4
	rval['bodyshape'] = 'bestial'
	rval['skincov'] = 'full_body_fur'
	rval['furcolor'] = 'black_gray'
	rval['tail'] = 'racoon'
	rval['ears'] = 'short_furry'
	rval['legs'] = 'fur_covered'
	rval['arms'] = 'fur_covered'
	rval['eyecolor'] = globals.assets.getRandomBeastEyeColor()
	rval['eyeshape'] = 'slit'
	return rval