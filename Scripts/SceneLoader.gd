@tool
extends Area2D

@export var newSpawnPoint: Vector2
@export var nextScene: String


func _on_SceneLoader_body_entered(_body):
	MapAutoload.set_spawnPoint(newSpawnPoint)
	get_tree().call_deferred("change_scene_to_file",nextScene)
