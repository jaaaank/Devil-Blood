tool
extends Area2D

export var newSpawnPoint: Vector2
export var nextScene: String
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_SceneLoader_body_entered(body):
	MapAutoload.spawnPoint = newSpawnPoint
	get_tree().change_scene(nextScene)
	
func _get_configuration_warning() -> String:
	return "Next scene or new spawn point is empty fucknuts" if not nextScene or newSpawnPoint == Vector2.ZERO  else ""
