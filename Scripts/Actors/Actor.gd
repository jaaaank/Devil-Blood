extends KinematicBody2D
class_name Actor

export var speed: = Vector2(4000, 4000)
export var sprint_mult: = Vector2(1.2, 1.2)
export var health: = 100
export var armor: = 0
var velocity: = Vector2.ZERO
var sprite: Sprite

func _process(delta):
	if velocity.x>0:
		sprite.flip_h = true
	if velocity.x<0:
		sprite.flip_h = false
