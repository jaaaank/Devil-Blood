extends Control

export(String, FILE) var next_scene_path: = ""

func _on_VideoPlayer_finished():
# warning-ignore:return_value_discarded
	get_tree().change_scene(next_scene_path)
