extends Button


export var characternum: int

func _on_PlayerSelectButton_pressed() -> void:
	PlayerAutoload.playerCharacter = characternum
	get_tree().change_scene("res://Scenes/Screens/PreRunShop.tscn")
