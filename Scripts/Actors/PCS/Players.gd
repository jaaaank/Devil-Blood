extends Actor
class_name Player

@export var damagenumbers: PackedScene = load("res://Scenes/Actors/Objects/DamageNumbers.tscn")
@onready var hurtbox:= $Hurtbox/HurtBoxShape
@onready var iframesTimer:= $IframesTimer
@onready var camera: Camera2D = $PlayerCamera
var iframes = false

func _ready():
	if !PlayerAutoload.midRun:
		PlayerAutoload.startRun()
		PlayerAutoload.midRun = true
	sprite = $PlayerSprite
	

func _physics_process(_delta):
	move_and_slide()
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal()*push_force)
	camera.offset = camera.offset.move_toward(get_local_mouse_position()/10, 10) 


func _input(_event):
	velocity = Vector2.ZERO
	if Input.is_action_pressed("moveup"):
		velocity.y = -1 
	if Input.is_action_pressed("movedown"):
		velocity.y = 1
	if Input.is_action_pressed("moveleft"):
		velocity.x = -1
	if Input.is_action_pressed("moveright"):
		velocity.x = 1
	velocity = velocity.normalized()*speed
	spriteDirection()
	
	if Input.is_action_just_pressed("interact"):
		interact()
	if Input.is_action_just_pressed("attack"):
		call("attack")
	if Input.is_action_just_pressed("altattack"):
		call("altAttack")
	if Input.is_action_just_pressed("ability"):
		call("ability")
	if Input.is_action_just_pressed("wheelSelect"):
		$UI/SelectionWheel.set_visible(true)
	if Input.is_action_just_released("wheelSelect"):
		$UI/SelectionWheel.set_visible(false)
		

func interact():
	PlayerAutoload.emit_signal("interacted")

func damage(damageTaken: float):
	if !iframes:
		sprite.set_modulate(Color.WEB_MAROON)
# warning-ignore:narrowing_conversion
		PlayerAutoload.health -= round(damageTaken*armorCalculation())
		iframes = true
		spawnDamageNums(round(damageTaken*armorCalculation()), Color.FIREBRICK)
		find_child("UI").call("updateUI")
		$Hurtbox.monitoring = false
		iframesTimer.start()
	if PlayerAutoload.health <=0:
		die()
		
func heal(healingFactor: float):
# warning-ignore:narrowing_conversion
	PlayerAutoload.health += round(healingFactor)
	spawnDamageNums(round(healingFactor), Color.FOREST_GREEN)
	find_child("UI").call("updateUI")

func armorCalculation():
	if armor !=0:
		return (abs(armor-100)*0.01)
	else: return 1
	
func spawnDamageNums(damagetaken, clr):
	var b = damagenumbers.instantiate()
	get_parent().add_child(b)
	b.global_position = global_position
	b.get_node("RichTextLabel").text = str(damagetaken)
	b.get_node("RichTextLabel").add_theme_color_override("default_color", clr)


func _on_IframesTimer_timeout():
	iframes = false
	$Hurtbox.monitoring = true
	sprite.set_modulate(Color.WHITE)

func useItem(id):
	match id:
		1:
			heal(10)
			
func spriteDirection():
	var angl:float = roundf(rad_to_deg(velocity.angle()))
	if velocity!=Vector2.ZERO:
		if angl == 0 or angl == 180: 
			sprite.texture = sprites[2]
		elif angl<0:
			sprite.texture = sprites[1]
		else:
			sprite.texture = sprites[0]

func die():
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/Screens/DeathScreen.tscn")
	SaveData.saveData()
