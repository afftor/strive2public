extends Node

var traits = {
  "Foul Mouth": {
    "name": "Foul Mouth",
    "description": "All too often, $name uses words more suited for construction workers and sailors. \n\n[color=aqua]Vocal occupations less effective, -Max Charm. [/color]",
    "effect": {
      "code": "foul_mouth",
      "charm_max": -25
    },
    "tags": [
      "mental",
      "detrimental"
    ],
    "conflict": [
      "Mute"
    ]
  },
  "Mute": {
    "name": "Mute",
    "description": "$name can't speak in a normal way and only uses signs and moans to communicate. \n\n[color=aqua]Obedience growth increased. Can't work at occupations requiring speech. [/color]",
    "effect": {
      "code": "mute",
      "obed_mod": 25
    },
    "tags": [
      "mental",
      "detrimental"
    ],
    "conflict": [
      "Foul Mouth"
    ]
  },
  "Devoted": {
    "name": "Devoted",
    "description": "$name trusts you to a great degree. $His willingness to follow you caused $him to find new strengths in $his character. \n\n[color=aqua]Courage and Wit increased, Loyalty can't drop below high. [/color]",
    "effect": {
      "code": "devoted",
      "cour_base": 25,
      "wit_base": 25,
      "loyalty_min": 80
    },
    "tags": [
      "mental",
      "secondary"
    ],
    "conflict": [
      ""
    ]
  },
  "Passive": {
    "name": "Passive",
    "description": "$name prefers to go with the flow and barely tries to proactively affect $his surroundings. \n\n[color=aqua]Can't take management related jobs, daily obedience growth increased. [/color]",
    "effect": {
      "code": "passive",
      "obed_mod": 25
    },
    "tags": [
      "mental"
    ],
    "conflict": [
      ""
    ]
  },
  "Masochist": {
    "name": "Masochist",
    "description": "$name enjoys pain far more than $he should. \n\n[color=aqua]Physical punishments penalty lowered, physical punishments cause lust to grow. [/color]",
    "effect": {
      
    },
    "tags": [
      "sexual",
      "mental",
      "perversy"
    ],
    "conflict": [
      ""
    ]
  },
  "Deviant": {
    "name": "Deviant",
    "description": "$name has a fondness for very unusual sexual practices. A cat or dog is fine for $him too. \n\n[color=aqua]Degrading sexual actions have no penalty. [/color]",
    "effect": {
      
    },
    "tags": [
      "sexual",
      "mental",
      "perversy"
    ],
    "conflict": [
      "Prude"
    ]
  },
  "Clumsy": {
    "name": "Clumsy",
    "description": "$name is not very flexible and rarely aware of $his surroundings, often leading to unfortunate incidents. \n\n[color=aqua]Physical tasks suffer penalty. [/color]",
    "effect": {
      
    },
    "tags": [
      "mental",
      "detrimental"
    ],
    "conflict": [
      ""
    ]
  },
  "Slutty": {
    "name": "Slutty",
    "description": "Your influence over $name caused $him to accept sex in many forms and enjoy $his body to the fullest. \n\n[color=aqua]Confidence and charm increased, removes penalty from many sexual actions. [/color]",
    "effect": {
      "code": "slutty",
      "charm_base": 25,
      "conf_base": 25,
      "loyalty_min": 80
    },
    "tags": [
      "mental",
      "perversy",
      "secondary"
    ],
    "conflict": [
      ""
    ]
  },
  "Bisexual": {
    "name": "Bisexual",
    "description": "$name is open to having affairs with people of the same sex. \n\n[color=aqua]Same-sex encounters are easier to accept. [/color]",
    "effect": {
      
    },
    "tags": [
      "sexual",
      "mental"
    ],
    "conflict": [
      "Lesbian"
    ]
  },
  "Lesbian": {
    "name": "Lesbian",
    "description": "$name is only expecting to have same-sex affairs. \n\n[color=aqua]Same-sex encounters have no penalty, opposite sex actions are unpreferred. [/color]",
    "effect": {
      
    },
    "tags": [
      "sexual",
      "mental",
      "secondary"
    ],
    "conflict": [
      "Bisexual",
      "Gay"
    ]
  },
  "Gay": {
    "name": "Gay",
    "description": "$name is only expecting to have same-sex affairs. \n\n[color=aqua]Same-sex encounters have no penalty, opposite sex actions are unpreferred. [/color]",
    "effect": {
      
    },
    "tags": [
      "sexual",
      "mental",
      "secondary"
    ],
    "conflict": [
      "Bisexual",
      "Lesbian"
    ]
  },
  "Monogamous": {
    "name": "Monogamous",
    "description": "$name does not favor random encounters and believes there is one true partner in life for $him. \n\n[color=aqua]Refuses to work as prostitute, loyalty builds faster from sex with master. Sleeping with other partners is more stressful. [/color]",
    "effect": {
      
    },
    "tags": [
      "sexual",
      "mental"
    ],
    "conflict": [
      "Fickle"
    ]
  },
  "Pretty voice": {
    "name": "Pretty voice",
    "description": "$name's voice is downright charming, making surrounding people just want to hear more of it.\n\n[color=aqua]Vocal occupations more effective, +Charm [/color]",
    "effect": {
      "code": "pretty_voice",
      "charm_cur": 20
    },
    "tags": [
      "mental"
    ],
    "conflict": [
      "Mute"
    ]
  },
  "Clingy": {
    "name": "Clingy",
    "description": "$name gets easily attached to people. However this behavior is rarely met with acceptance, which in turn annoys $him. \n\n[color=aqua]Loyalty grows faster from actions, Obedience drops quickly if constantly ignored. [/color]",
    "effect": {
      "code": "clingy",
      "loyalty_mod": 35
    },
    "tags": [
      "mental"
    ],
    "conflict": [
      ""
    ]
  },
  "Fickle": {
    "name": "Fickle",
    "description": "$name prefers having as many sexual partners as possible, unable to stay confined to only one person for long. \n\n[color=aqua]Prostituion job bonus, multiple partners are unlocked by default. [/color]",
    "effect": {
      
    },
    "tags": [
      "sexual",
      "mental"
    ],
    "conflict": [
      "Monogamous"
    ]
  },
  "Frail": {
    "name": "Frail",
    "description": "$name's body is much less durable than most. $His physical potential is severely impaired. \n\n[color=aqua]Max Strength -2, Max Agi -1. [/color]",
    "effect": {
      "code": "frail",
      "conf_max": -25,
      "agi_max": -1,
      "str_max": -2
    },
    "tags": [
      "physical",
      "detrimental"
    ],
    "conflict": [
      ""
    ]
  },
  "Scarred": {
    "name": "Scarred",
    "description": "$name's body is covered in massive burn scars. Besides being terrifying to look at, this also makes $him suffer from low confidence.\n\n[color=aqua]--Beauty, -Confidence [/color]",
    "effect": {
      "code": "scarred",
      "conf_cur": -30,
      "beautybase": -30
    },
    "tags": [
      "physical",
      "detrimental"
    ],
    "conflict": [
      ""
    ]
  },
  "Coward": {
    "name": "Coward",
    "description": "$name is of a meek character and has a difficult time handling $himself in physical confrontations. \n\n[color=aqua]Physical punishments build obedience quicker, -max courage, stress in combat grows twice as fast. [/color]",
    "effect": {
      "code": "coward",
      "cour_max": -50,
      "obed_mod": 30,
    },
    "tags": [
      "detrimental",
      "mental"
    ],
    "conflict": [
      ""
    ]
  },
  "Prude": {
    "name": "Prude",
    "description": "$name is very intolerant of many sexual practices, believing there are many inappropriate behaviors which shouldn't be practiced.\n\n[color=aqua]Sexual actions are harder to initiate and are less impactful. Refuses to work on sex-related jobs. [/color]",
    "effect": {
      
    },
    "tags": [
      "sexual",
      "mental"
    ],
    "conflict": [
      "Pervert",
      "Deviant",
      "Fickle"
    ]
  },
  "Pervert": {
    "name": "Pervert",
    "description": "$name has a pretty broad definition of stuff $he finds enjoyable.\n\n[color=aqua]Sexual actions are easier to unlock. Fetishist actions have no penalty. [/color]",
    "effect": {
      
    },
    "tags": [
      "sexual",
      "mental",
      "perversy"
    ],
    "conflict": [
      "Prude"
    ]
  },
  "Clever": {
    "name": "Clever",
    "description": "$name is more prone to creative thinking than an average person, which makes $him both resourceful and disobedient. \n\n[color=aqua]+Wit, +Confidence, -Obedience. [/color]",
    "effect": {
      "code": "clever",
      "wit_cur": 20,
      "conf_cur": 15,
      "obed_mod": -20
    },
    "tags": [
      "mental"
    ],
    "conflict": [
      ""
    ]
  },
  "Pliable": {
    "name": "Pliable",
    "description": "$name is still naive and can be swayed one way or another... \n\n[color=aqua]Has room for changes and growth. [/color]",
    "effect": {
      
    },
    "tags": [
      "mental"
    ],
    "conflict": [
      ""
    ]
  },
  "Dominant": {
    "name": "Dominant",
    "description": "$name really prefers to be in control, instead of being controlled. \n\n[color=aqua]Obedience growth decreased. +Confidence.  [/color]",
    "effect": {
      "code": "dominant",
      "conf_max": 15,
      "conf_cur": 25,
      "obed_mod": -30
    },
    "tags": [
      "mental"
    ],
    "conflict": [
      "Submissive"
    ]
  },
  "Submissive": {
    "name": "Submissive",
    "description": "$name is very comfortable when having someone $he can rely on. \n\n[color=aqua]Obedience growth increased. No penalty for rape actions as long as loyalty is above average. -Max Confidence. [/color]",
    "effect": {
      "code": "submissive",
      "conf_max": -30,
      "conf_cur": -10,
      "obed_mod": 40
    },
    "tags": [
      "mental"
    ],
    "conflict": [
      "Dominant"
    ]
  },
  "Uncivilized": {
    "name": "Uncivilized",
    "description": "$name has spent most of $his lifetime in the wilds barely interacting with modern society and acting more like an animal. As a result, $he can't realistically fit into common groups and be accepted there. \n\n[color=aqua]Social jobs disabled; Max Loyalty ---; Max Obedience -; Max Wit --. [/color]",
    "effect": {
      "code": "uncivilized",
      "wit_max": -50,
      "obed_max": -30,
      "loyal_max": -65
    },
    "tags": [
      "secondary",
      "mental"
    ],
    "conflict": [
      ""
    ]
  },
  "Regressed": {
    "name": "Regressed",
    "description": "Due to some circumstances, $name's mind reversed to infantile state. $He's barely capable of normal tasks, but $he's a lot more responsive to social training.\n\n[color=aqua]Social jobs disabled. [/color]",
    "effect": {
      "code": "regressed"
    },
    "tags": [
      "secondary",
      "mental"
    ],
    "conflict": [
      ""
    ]
  },
  "Sex-crazed": {
    "name": "Sex-crazed",
    "description": "$name barely can keep $his mind off dirty stuff. $His perpetual excitement makes $him look and enjoy nearly everything at the cost of $his sanity. \n\n[color=aqua]Min lust++; Max Wit --; Max Confidence --; no penalty from any sexual activity and brothel assignement. [/color]",
    "effect": {
      "code": "sexcrazed",
      "wit_max": -80,
      "conf_max": -60,
      "lust_min": 50
    },
    "tags": [
      "secondary",
      "mental",
      "perversy",
      "detrimental"
    ],
    "conflict": [
      ""
    ]
  },
  "Likes it rough": {
    "name": "Likes it rough",
    "description": "$name secretly enjoys being treated badly and taken by force. \n\n[color=aqua]Rape actions cause no loyalty and obedience reduction. [/color]",
    "effect": {
      
    },
    "tags": [
      "sexual",
      "mental",
      "perversy"
    ],
    "conflict": [
      ""
    ]
  },
  "Ascetic": {
    "name": "Ascetic",
    "description": "$name cares little about luxury around $him. \n\n[color=aqua]Luxury demands are lowered. [/color]",
    "effect": {
      
    },
    "tags": [
      "mental",
    ],
    "conflict": [
      ""
    ]    
  },
  "Small Eater": {
    "name": "Small Eater",
    "description": "[color=aqua]Food consumption reduced to 1/3. [/color]",
    "effect": {
      
    },
    "tags": [
      "secondary",
    ],
    "conflict": [
      ""
    ]    
  },
  "Hard Worker": {
    "name": "Hard Worker",
    "description": "[color=aqua]+15% gold from non-sexual occupations. [/color]",
    "effect": {
      
    },
    "tags": [
      "secondary",
      "mental",
    ],
    "conflict": [
      ""
    ]    
  },
  "Sturdy": {
    "name": "Sturdy",
    "description": "[color=aqua]Takes 15% less damage in combat [/color]",
    "effect": {
      
    },
    "tags": [
      "secondary",
    ],
    "conflict": [
      ""
    ]    
  },
  "Influential": {
    "name": "Influential",
    "description": "[color=aqua]Selling slaves worth 20% more gold. [/color]",
    "effect": {
      
    },
    "tags": [
      "secondary",
    ],
    "conflict": [
      ""
    ]    
  },
  "Gifted": {
    "name": "Gifted",
    "description": "[color=aqua]+20% upgrade points received. [/color]",
    "effect": {
      
    },
    "tags": [
      "secondary",
    ],
    "conflict": [
      ""
    ]    
  },
  "Scoundrel": {
    "name": "Scoundrel",
    "description": "[color=aqua]+15 gold per day. [/color]",
    "effect": {
      
    },
    "tags": [
      "secondary",
    ],
    "conflict": [
      ""
    ]    
  },
  "Nimble": {
    "name": "Nimble",
    "description": "[color=aqua]+25% to hit chances. [/color]",
    "effect": {
      
    },
    "tags": [
      "secondary",
    ],
    "conflict": [
      ""
    ]    
  },
  "Authority": {
    "name": "Authority",
    "description": "[color=aqua]If above 95 obedience, all other slaves gain +5 obedience per day. [/color]",
    "effect": {
      
    },
    "tags": [
      "secondary",
    ],
    "conflict": [
      ""
    ]    
  },
  "Mentor": {
    "name": "Mentor",
    "description": "[color=aqua]Slaves below level 3 gain +5 exp points per day[/color]",
    "effect": {
      
    },
    "tags": [
      "secondary",
    ],
    "conflict": [
      ""
    ]    
  },
  "Grateful": {
    "name": "Grateful",
    "description": "Due to your actions, $name will overlook certain hardships willing to stick close to you.\n\n [color=aqua]No luxury requirements. [/color]",
    "effect": {
      
    },
    "tags": [
      "secondary",
    ],
    "conflict": [
      ""
    ]    
  },
}