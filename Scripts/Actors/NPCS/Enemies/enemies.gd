extends Actor
class_name enemy

export (PackedScene) var damagenumbers = load("res://Scenes/Actors/Objects/DamageNumbers.tscn")
var knight = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func damage(dmgdealt):
	if knight:
		PlayerAutoload.knightsAgressive = true
	health -= round(dmgdealt * armorCalculation())
	print("Enemy has this much health: " + String(health))
	var b = damagenumbers.instance()
	add_child(b)
	b.get_node("RichTextLabel").text = String(round(dmgdealt * armorCalculation()))
	if health<=0:
		queue_free()
		
func armorCalculation():
	if armor !=0:
		return (abs(armor-100)*0.01)
	else: return 1
