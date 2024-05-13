extends Control


func _on_play_button_pressed():
	SaveData.loadData()
	get_tree().change_scene_to_file("res://Scenes/Screens/PlayerSelect.tscn")

func _on_settings_button_pressed():
	pass # Replace with function body.

func _on_credits_button_pressed():
	pass # Replace with function body.
