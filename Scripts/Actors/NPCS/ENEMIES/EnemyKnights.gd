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
	velocity = position.direction_to(target) * speed
	
	weapon.rotation = position.angle_to_point(target)
	
	if PlayerAutoload.knightsAgressive:
		target = PlayerAutoload.playerPos
	if position.distance_to(target) > 100:
		move_and_slide(velocity)
		if target == PlayerAutoload.playerPos:
			attack()
	
	
	
	
func randomWalk():
	if !PlayerAutoload.knightsAgressive:
		var x = rand_range(-walkrange, walkrange)
		var y = rand_range(-walkrange, walkrange)
		target = Vector2(x,y)
		walktimer.start(rand_range(3,6))
	else:
		target = PlayerAutoload.playerPos
	
func _on_walktimer_timeout():
	randomWalk()

func attack():
	pass
