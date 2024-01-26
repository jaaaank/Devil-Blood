@tool
extends Area2D

@export var newSpawnPoint: Vector2
@export var nextScene: String




func _on_SceneLoader_body_entered(_body):
	MapAutoload.set_spawnPoint(newSpawnPoint)
# warning-ignore:return_value_discarded
	get_tree().change_scene_to_file(nextScene)
	
func _get_configuration_warnings() -> PackedStringArray:
	return ["Next scene or new spawn point is empty fucknuts"] if not nextScene or newSpawnPoint == Vector2.ZERO  else [""]
