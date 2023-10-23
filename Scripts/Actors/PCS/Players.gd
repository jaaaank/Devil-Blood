extends Actor
class_name Player

func _ready():
	pass # Replace with function body.

func _input(_event):
	velocity = Vector2.ZERO
	if Input.is_action_pressed("interact"):
		interact()
	if Input.is_action_pressed("moveup"):
		velocity.y = -speed.y
	if Input.is_action_pressed("movedown"):
		velocity.y = speed.y
	if Input.is_action_pressed("moveleft"):
		velocity.x = -speed.x
	if Input.is_action_pressed("moveright"):
		velocity.x = speed.x
	velocity = velocity.normalized() * speed

func interact():
	PlayerAutoload.emit_signal("interact")


