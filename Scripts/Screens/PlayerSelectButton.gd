extends Button


export var characternum: int


func _on_PlayerSelectButton_pressed():
	PlayerAutoload.playerCharacter = characternum
	get_tree().change_scene("res://Scenes/Maps/Exterior/HellGarrison.tscn")
