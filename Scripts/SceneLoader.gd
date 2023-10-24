tool
extends Area2D

export var newSpawnPoint: Vector2
export var nextScene: String




func _on_SceneLoader_body_entered(body):
	MapAutoload.set_spawnPoint(newSpawnPoint)
	get_tree().change_scene(nextScene)
	
func _get_configuration_warning() -> String:
	return "Next scene or new spawn point is empty fucknuts" if not nextScene or newSpawnPoint == Vector2.ZERO  else ""
