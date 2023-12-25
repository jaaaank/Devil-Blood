extends RigidBody2D
class_name RigidActor

export var speed: = 500
export var health: = 100
export var armor: = 0
var sprite: Sprite


func _physics_process(delta):
	if linear_velocity.x<0:
		sprite.flip_h = true
	if linear_velocity.x>0:
		sprite.flip_h = false
