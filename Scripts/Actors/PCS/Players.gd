extends Actor
class_name Player

func _ready():
	pass # Replace with function body.

func _input(_event):
	velocity = Vector2.ZERO
	if Input.is_action_just_pressed("interact"):
		interact()
	if Input.is_action_pressed("moveup"):
		velocity.y = -speed.y
	if Input.is_action_pressed("movedown"):
		velocity.y = speed.y
	if Input.is_action_pressed("moveleft"):
		velocity.x = -speed.x
	if Input.is_action_pressed("moveright"):
		velocity.x = speed.x
		
	if Input.is_action_just_pressed("attack"):
		call_deferred("attack")
		
	velocity = velocity.normalized() * speed 

func interact():
	PlayerAutoload.emit_signal("interact")

func _on_Hurtbox_area_entered(area):
	if area.is_in_group("enemyWeapon"):
		print("damaged")
