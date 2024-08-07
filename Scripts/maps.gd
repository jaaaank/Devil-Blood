extends Node
class_name Maps

@export var music: AudioStreamMP3
@export var limits: Array[float]
#left, top, right, bottom

func _ready():
	MapAutoload.changeMusic(music)

func setLimits():
	for i in limits:
		$PlayerSpawner.get_child(0).get_node("PlayerCamera").call("set_limit", limits.find(i), i)
