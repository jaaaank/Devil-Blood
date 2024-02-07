extends CharacterBody2D
class_name Actor

@export var speed: = 500
@export var sprint_mult: = 1.2
@export var health: = 100
@export var armor: = 0
var sprite: Sprite2D
var push_force = 80

func _process(_delta):
	if velocity.x<0:
		sprite.flip_h = true
	if velocity.x>0:
		sprite.flip_h = false
