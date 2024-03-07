extends Actor
class_name enemy

@export var walkrange: int = 1000
@export var basedamage: int
@export var damagenumbers:PackedScene = load("res://Scenes/Actors/Objects/DamageNumbers.tscn")
@export var attackrange = 125
var knight = false


func _physics_process(_delta):
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal()*push_force)
			
func damage(dmgdealt):
	if knight:
		PlayerAutoload.knightsAgressive = true
# warning-ignore:narrowing_conversion
	health -= round(dmgdealt * armorCalculation())
	spawnDamageNums(round(dmgdealt*armorCalculation()), Color.FIREBRICK)
	if health<=0:
		queue_free()
		
func spawnDamageNums(damagetaken, clr):
	randomize()
	var b = damagenumbers.instantiate()
	get_parent().add_child(b)
	b.global_position = global_position + Vector2(randi_range(-50, 50), randi_range(-50, 50))
	b.get_node("RichTextLabel").text = str(damagetaken)
	b.get_node("RichTextLabel").add_theme_color_override("default_color", clr)
		
func armorCalculation():
	if armor !=0:
		return (abs(armor-100)*0.01)
	else: return 1
	
