extends enemy
export var walkrange = 10000
var target: Vector2
onready var walktimer:= $walktimer
# Called when the node enters the scene tree for the first time.
func _ready():
	speed = 100
	sprite = $Masssheet
	randomize()
	randomWalk()
	armor = 0
	health = 5
	
func _physics_process(_delta):
	if global_position.distance_to(target) > 100:
		velocity = global_position.direction_to(target) * speed
# warning-ignore:return_value_discarded
		move_and_slide(velocity)

func randomWalk():
	var rice = rand_range(-walkrange, walkrange)
	var beans = rand_range(-walkrange, walkrange)
	target = Vector2(rice,beans)
	print(target)
	walktimer.start(rand_range(3,6))
	
func _on_walktimer_timeout():
	randomWalk()

func stun():
	stunned = true
	set_physics_process(false)
	$stuntimer.start()
	
func unstun():
	stunned = false
	set_physics_process(true)
	
func _on_Hurtbox_area_entered(area):
	if area.get_collision_layer_bit(0) and !stunned:
		PlayerAutoload.damage(5)
