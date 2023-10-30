extends Actor
class_name Player

export (PackedScene) var damagenumbers = load("res://Scenes/Actors/Objects/DamageNumbers.tscn")
onready var hurtbox:= $Hurtbox/HurtBoxShape
onready var iframesTimer:= $IframesTimer

func _ready():
	sprite = $PlayerSprite
	PlayerAutoload.connect("player_dead", self, "die")
	PlayerAutoload.connect("player_damaged", self, "spawnDamageNums")

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
		call("attack")
		
	if Input.is_action_just_pressed("altattack"):
		call("altAttack")
		
	velocity = velocity.normalized() * speed 

func interact():
	PlayerAutoload.emit_signal("interact")
	
func die():
	queue_free()
	
func spawnDamageNums(damagetaken):
	var b = damagenumbers.instance()
	add_child(b)
	b.get_node("RichTextLabel").text = String(round(damagetaken*PlayerAutoload.armorCalculation()*PlayerAutoload.difficulty))
	iframesTimer.start()

func _on_IframesTimer_timeout():
	PlayerAutoload.iframes = false
