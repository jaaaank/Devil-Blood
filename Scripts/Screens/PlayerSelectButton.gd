extends Button


export var characternum: int


func _on_PlayerSelectButton_pressed():
	PlayerAutoload.playerCharacter = characternum
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Maps/Exterior/Garrison.tscn")
