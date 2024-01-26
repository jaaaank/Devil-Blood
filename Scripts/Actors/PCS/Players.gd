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
# warning-ignore:return_value_discarded
	PlayerAutoload.connect("player_damaged", Callable(self, "spawnDamageNums"))

func _physics_process(delta):
	var direction = Input.get_vector("moveleft", "moveright", "moveup", "movedown",0)
	velocity = direction * speed
	move_and_slide()

func _input(_event):
	if Input.is_action_just_pressed("interact"):
		interact()
	if Input.is_action_just_pressed("attack"):
		call("attack")
	if Input.is_action_just_pressed("altattack"):
		call("altAttack")

func interact():
	PlayerAutoload.emit_signal("interact")

func damage(damageTaken: float):
	if !iframes:
# warning-ignore:narrowing_conversion
		health = round(health - damageTaken*armorCalculation()*PlayerAutoload.difficulty)
		iframes = true
		spawnDamageNums(damageTaken)
	if health <=0:
		PlayerAutoload.charDie()
		queue_free()
		
func heal(healingFactor: float):
# warning-ignore:narrowing_conversion
	health=round(health + healingFactor/PlayerAutoload.difficulty)
	print("Healed; Health = " + str(health))

func armorCalculation():
	if armor !=0:
		return (abs(armor-100)*0.01)
	else: return 1
	
func spawnDamageNums(damagetaken):
	var b = damagenumbers.instantiate()
	get_parent().add_child(b)
	b.global_position = global_position
	b.get_node("RichTextLabel").text = str(round(damagetaken*armorCalculation()*PlayerAutoload.difficulty))
	iframesTimer.start()

func _on_IframesTimer_timeout():
	iframes = false
