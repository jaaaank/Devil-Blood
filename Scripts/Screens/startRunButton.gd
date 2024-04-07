extends Button

func _on_continue_pressed():
	match PlayerAutoload.playerCharacter:
		1:get_tree().change_scene_to_file("res://Scenes/Maps/Exterior/PriestCave.tscn")
		2:get_tree().change_scene_to_file("res://Scenes/Maps/Exterior/Garrison.tscn")
		3:get_tree().change_scene_to_file("res://Scenes/Maps/Exterior/Garrison.tscn")
		4:get_tree().change_scene_to_file("res://Scenes/Maps/Exterior/Garrison.tscn")
