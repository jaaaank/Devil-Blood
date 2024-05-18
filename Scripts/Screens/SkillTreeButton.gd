extends TextureButton

@export var cost: int
@export  var skillName: String
@export  var skillDesc: String
@export var skillIndex: int
@export var character: int

func _ready():
	match character:
		1: if SaveData.priestSkillTree[skillIndex]:
				texture_normal = texture_hover
		2: if SaveData.knightSkillTree[skillIndex]:
				texture_normal = texture_hover
		3: if SaveData.witchSkillTree[skillIndex]:
				texture_normal = texture_hover

func _on_pressed():
	get_parent().call_deferred("selectSkill", skillName, skillDesc, cost, skillIndex)

