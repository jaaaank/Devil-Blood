extends TextureButton

@export var cost: int
@export var skillIndex: int
@export var character: int

func _ready():
	match character:
		1: if SaveData.priestSkillTree[skillIndex]:
				texture_disabled = texture_hover
				disabled = true
		2: if SaveData.knightSkillTree[skillIndex]:
				texture_disabled = texture_hover
				disabled = true
		3: if SaveData.witchSkillTree[skillIndex]:
				texture_disabled = texture_hover
				disabled = true
	if SaveData.pureSoul<cost:
		disabled = true

func _on_pressed():
	SaveData.pureSoul-=cost
	match character:
		1: SaveData.priestSkillTree[skillIndex] = true
		2: SaveData.knightSkillTree[skillIndex] = true
		3: SaveData.witchSkillTree[skillIndex] = true
	SaveData.saveData()
	get_parent()._ready()
