extends Node

#0=morning 1=day 2=day 3=night
var cycletime: int = 0 setget set_cycletime

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_cycletime(value: int)-> void:
	cycletime = value