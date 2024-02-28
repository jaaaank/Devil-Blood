extends Actor
class_name Player

@export var damagenumbers: PackedScene = load("res://Scenes/Actors/Objects/DamageNumbers.tscn")
@onready var hurtbox:= $Hurtbox/HurtBoxShape
@onready var iframesTimer:= $IframesTimer
var iframes = false

func _ready():
	sprite = $PlayerSprite
# warning-ignore:return_value_discarded
	PlayerAutoload.connect("player_dead", Callable(self, "die"))

func _physics_process(_delta):
	#var direction = Input.get_vector("moveleft", "moveright", "moveup", "movedown",0)
	#velocity = direction * speed
	move_and_slide()
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal()*push_force)

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
	
	if Input.is_action_just_pressed("interact"):
		interact()
	if Input.is_action_just_pressed("attack"):
		call("attack")
	if Input.is_action_just_pressed("altattack"):
		call("altAttack")
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
		health -= round(damageTaken*armorCalculation()*PlayerAutoload.difficulty)
		iframes = true
		spawnDamageNums(round(damageTaken*armorCalculation()*PlayerAutoload.difficulty), Color.FIREBRICK)
		find_child("UI").call("updateUI")
		$Hurtbox.monitoring = false
	if health <=0:
		PlayerAutoload.charDie()
		queue_free()
		
func heal(healingFactor: float):
# warning-ignore:narrowing_conversion
	health += round(healingFactor/PlayerAutoload.difficulty)
	print("Healed; Health = " + str(health))
	spawnDamageNums(round(healingFactor/PlayerAutoload.difficulty), Color.FOREST_GREEN)
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
	iframesTimer.start()

func _on_IframesTimer_timeout():
	iframes = false
	$Hurtbox.monitoring = true
	sprite.set_modulate(Color.WHITE)

func useItem(id):
	match id:
		1:
			heal(10)
