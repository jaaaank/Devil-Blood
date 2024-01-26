extends Control

@export var next_scene_path: = "" # (String, FILE)

func _on_VideoPlayer_finished():
# warning-ignore:return_value_discarded
	get_tree().change_scene_to_file(next_scene_path)
