extends Node
class_name Maps

var spawnPoint: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	spawnPoint = MapAutoload.spawnPoint


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
