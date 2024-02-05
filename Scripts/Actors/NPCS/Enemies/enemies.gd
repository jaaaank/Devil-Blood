extends Actor
class_name enemy

@export var basedamage: int
@export var damagenumbers:PackedScene = load("res://Scenes/Actors/Objects/DamageNumbers.tscn")
var knight = false
var stunned = false
var attackrange = 125

func damage(dmgdealt):
	if knight:
		PlayerAutoload.knightsAgressive = true
# warning-ignore:narrowing_conversion
	health -= round(dmgdealt * armorCalculation())
	print("Enemy has this much health: " + str(health))
	spawnDamageNums(round(dmgdealt*armorCalculation()), Color.FIREBRICK)
	if health<=0:
		queue_free()
		
func spawnDamageNums(damagetaken, clr):
	var b = damagenumbers.instantiate()
	get_parent().add_child(b)
	b.global_position = global_position
	b.get_node("RichTextLabel").text = str(damagetaken)
	b.get_node("RichTextLabel").add_theme_color_override("default_color", clr)
		
func armorCalculation():
	if armor !=0:
		return (abs(armor-100)*0.01)
	else: return 1
	
