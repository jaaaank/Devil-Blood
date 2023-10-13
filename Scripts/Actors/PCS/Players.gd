extends Actor
class_name Player

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(_event):
	if Input.is_action_pressed("moveup"):
		velocity.y = -speed.y
	if Input.is_action_pressed("movedown"):
		velocity.y = speed.y
	if Input.is_action_pressed("moveleft"):
		velocity.x = -speed.x
	if Input.is_action_pressed("moveright"):
		velocity.x = speed.x
	velocity = velocity.normalized() * speed
