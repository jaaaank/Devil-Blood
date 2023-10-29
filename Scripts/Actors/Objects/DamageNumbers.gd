extends Node2D

var offset

func _ready():
	offset = rand_range(-200, 200)
	position.x += offset
	position.y += offset
	
func _process(delta):
	position.y -= 1000 * delta

func _on_Timer_timeout():
	queue_free()
