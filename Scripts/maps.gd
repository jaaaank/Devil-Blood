extends Node
class_name Maps

@export var limits: Array[float]
#left, top, right, bottom

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in limits:
		$PlayerSpawner.get_child(0).get_node("PlayerCamera").call("set_limit", limits.find(i), i)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
