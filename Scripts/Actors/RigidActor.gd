extends RigidBody2D
class_name RigidActor

export var speed: = 500
export var health: = 100
export var armor: = 0
var sprite
export var attackrange = 125
export (PackedScene) var damagenumbers

func _physics_process(_delta):
	if linear_velocity.x<0:
		sprite.scale.x = -1
	if linear_velocity.x>0:
		sprite.scale.x = 1

func damage(dmgdealt):
# warning-ignore:narrowing_conversion
	health -= round(dmgdealt * armorCalculation())
	print("Enemy has this much health: " + String(health))
	var b = damagenumbers.instance()
	get_parent().add_child(b)
	b.global_position = global_position
	b.get_node("RichTextLabel").text = String(round(dmgdealt * armorCalculation()))
	if health<=0:
		queue_free()

func armorCalculation():
	if armor !=0:
		return (abs(armor-100)*0.01)
	else: return 1
	
