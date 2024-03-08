extends enemy

var movementTarget: Vector2 
@onready var navigationAgent: NavigationAgent2D = $NavigationAgent2D
@onready var walktimer: Timer = $walktimer
var agressive: bool = false
var spinspeed: int = 2

func _ready():
	randomize()
	spinspeed = randf_range(6,14)
	sprite = $KnightSprite
	await get_tree().physics_frame
	set_movement_target(PlayerAutoload.playerPos)
	randomWalk()

func set_movement_target(target: Vector2):
	navigationAgent.target_position = target

func _physics_process(delta):
	super(delta)
	$Weapon.global_rotation -= spinspeed * delta 
	set_movement_target(PlayerAutoload.playerPos)
	if navigationAgent.distance_to_target()<50:
		attack()
	elif navigationAgent.distance_to_target()<1000:
		var next_path_position: Vector2 = navigationAgent.get_next_path_position()
		velocity = global_position.direction_to(next_path_position) * speed
		move_and_slide()

func randomWalk():
	if !agressive:
		var rice = randf_range(-walkrange, walkrange)
		var beans = randf_range(-walkrange, walkrange)
		movementTarget = Vector2(rice,beans)
		walktimer.start(randf_range(3,6))
		print(movementTarget)
	else:
		#speed *= sprint_mult
		movementTarget = PlayerAutoload.playerPos
		
func attack():
	pass
