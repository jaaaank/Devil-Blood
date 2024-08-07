extends RigidBody2D
class_name RigidActor

@export var speed: = 500
@export var health: = 100
@export var armor: = 0
var sprite
@export var attackrange = 125
@export var damagenumbers: PackedScene

func _physics_process(_delta):
	if linear_velocity.x<0:
		sprite.scale.x = -1
	if linear_velocity.x>0:
		sprite.scale.x = 1

func damage(dmgdealt):
# warning-ignore:narrowing_conversion
	health -= round(dmgdealt * armorCalculation())
	print("Enemy has this much health: " + str(health))
	spawnDamageNums(round(dmgdealt * armorCalculation()), Color.FIREBRICK)
	if health<=0:
		queue_free()

func spawnDamageNums(damagetaken, clr):
	var b = damagenumbers.instantiate()
	get_parent().add_child(b)
	b.global_position = global_position
	b.get_node("Label").text = str(damagetaken)
	b.get_node("Label").label_settings.outline_color = clr
	
func armorCalculation():
	if armor !=0:
		return (abs(armor-100)*0.01)
	else: return 1
	
