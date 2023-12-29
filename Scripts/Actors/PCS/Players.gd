extends Actor
class_name Player

export (PackedScene) var damagenumbers = load("res://Scenes/Actors/Objects/DamageNumbers.tscn")
onready var hurtbox:= $Hurtbox/HurtBoxShape
onready var iframesTimer:= $IframesTimer

func _ready():
	sprite = $PlayerSprite
# warning-ignore:return_value_discarded
	PlayerAutoload.connect("player_dead", self, "die")
# warning-ignore:return_value_discarded
	PlayerAutoload.connect("player_damaged", self, "spawnDamageNums")

func _physics_process(_delta):
# warning-ignore:return_value_discarded
	move_and_slide(velocity)
	
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
		
	velocity = velocity.normalized() * speed
	if Input.is_action_just_pressed("interact"):
		interact()
	if Input.is_action_just_pressed("attack"):
		call("attack")
	if Input.is_action_just_pressed("altattack"):
		call("altAttack")
		


func interact():
	PlayerAutoload.emit_signal("interact")
	
func die():
	queue_free()
	
func spawnDamageNums(damagetaken):
	var b = damagenumbers.instance()
	get_parent().add_child(b)
	b.global_position = global_position
	b.get_node("RichTextLabel").text = String(round(damagetaken*PlayerAutoload.armorCalculation()*PlayerAutoload.difficulty))
	iframesTimer.start()

func _on_IframesTimer_timeout():
	PlayerAutoload.iframes = false
