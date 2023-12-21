extends Node2D

var offset

func _ready():
	offset = rand_range(-40, 40)
	position.x += offset
	position.y += offset
	
func _physics_process(delta):
	position.y -= 150 * delta

func _on_Timer_timeout():
	queue_free()
