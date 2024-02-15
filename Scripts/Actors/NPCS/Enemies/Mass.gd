extends enemy
@export var walkrange = 10000
var target: Vector2
@onready var walktimer:= $walktimer
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
		move_and_slide()

func randomWalk():
	var rice = randf_range(-walkrange, walkrange)
	var beans = randf_range(-walkrange, walkrange)
	target = Vector2(rice,beans)
	print(target)
	walktimer.start(randf_range(3,6))
	
func _on_walktimer_timeout():
	randomWalk()

func stun():
	stunned = true
	print("stunned")
	set_physics_process(false)
	$stuntimer.start()
	
func unstun():
	stunned = false
	set_physics_process(true)
	
func _on_Hurtbox_area_entered(area):
	if area.collision_layer == 1 and !stunned:
		area.owner.damage(basedamage)
