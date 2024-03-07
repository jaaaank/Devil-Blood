extends Node
class_name Maps

@export var limits: Array[float]
#left, top, right, bottom

func _ready():
	for i in limits:
		$PlayerSpawner.get_child(0).get_node("PlayerCamera").call("set_limit", limits.find(i), i)
