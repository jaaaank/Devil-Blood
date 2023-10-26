extends Actor

export var walkrange = 10000
var target: Vector2
onready var walktimer:= $walktimer
onready var weapon:= $Sword

# Called when the node enters the scene tree for the first time.
func _ready():
	randomWalk()
	randomize()
	armor = 40
	health = 60



func _physics_process(delta):
	velocity = global_position.direction_to(target) * speed * delta * 40
	weapon.rotation = global_position.angle_to_point(target)
	if PlayerAutoload.knightsAgressive:
		target = PlayerAutoload.playerPos
	if global_position.distance_to(target) > 50:
		move_and_slide(velocity)
		if target == PlayerAutoload.playerPos:
			attack()
	
	
	
	
func randomWalk():
	if !PlayerAutoload.knightsAgressive:
		var rice = rand_range(-walkrange, walkrange)
		var beans = rand_range(-walkrange, walkrange)
		target = Vector2(rice,beans)
		print(target)
		walktimer.start(rand_range(3,6))
	else:
		target = PlayerAutoload.playerPos
	
func _on_walktimer_timeout():
	randomWalk()

func attack():
	weapon.monitorable = true
