extends Actor
class_name enemy



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func damage(dmgdealt):
	health -= dmgdealt
	print("took this myhc damage: " + String(dmgdealt))
	if health<0:
		queue_free()
