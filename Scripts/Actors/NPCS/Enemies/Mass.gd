extends enemy
class_name  mass
@export var walkrange = 500
@export var textures: Array
var target: Vector2
@onready var walktimer:= $walktimer

func _ready():
	sprite = $Masssheet
	randomize()
	sprite.texture = textures.pick_random()
	randomWalk()
	
func _physics_process(_delta):
	if global_position.distance_to(target) > 50:
		velocity = global_position.direction_to(target) * speed
# warning-ignore:return_value_discarded
		move_and_slide()

func randomWalk():
	var rice = randf_range(-walkrange, walkrange)
	var beans = randf_range(-walkrange, walkrange)
	target = global_position + Vector2(rice,beans)
	walktimer.start(randf_range(3,6))
	
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
	if area.collision_layer == 1 and !stunned:
		area.owner.damage(basedamage)
