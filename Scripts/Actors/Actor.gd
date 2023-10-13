extends KinematicBody2D
class_name Actor


export var speed: = Vector2(140.0, 140.0)
export var sprint_mult: = Vector2(1.2, 1.2)
export var health: = 100
export var playercharacter: =false
var velocity: = Vector2.ZERO

func _input(_event):
	if playercharacter:
		if Input.is_action_pressed("moveup"):
			velocity.y = -speed.y
		if Input.is_action_pressed("movedown"):
			velocity.y = speed.y
		if Input.is_action_pressed("moveleft"):
			velocity.x = -speed.x
		if Input.is_action_pressed("moveright"):
			velocity.x = speed.x
		velocity = velocity.normalized() * speed
