extends enemy

var movementTarget: Vector2 
@export var senseRange: int = 750
@onready var navigationAgent: NavigationAgent2D = $NavigationAgent2D
@onready var walktimer: Timer = $walktimer
var spinspeed: int = 2

func _ready():
	randomize()
	spinspeed = randi_range(6,14)
	sprite = $Sprite
	await get_tree().physics_frame
	randomWalk()
	set_movement_target(PlayerAutoload.playerPos)
	
func set_movement_target(target: Vector2):
	navigationAgent.target_position = target

func _physics_process(delta):
	super(delta)
	spriteDirection()
	$Weapon.global_rotation -= spinspeed * delta 
	if navigationAgent.distance_to_target()<senseRange:
		set_movement_target(PlayerAutoload.playerPos)
		var next_path_position: Vector2 = navigationAgent.get_next_path_position()
		velocity = global_position.direction_to(next_path_position) * speed
	set_movement_target(PlayerAutoload.playerPos)
	move_and_slide()

func randomWalk():
	if navigationAgent.distance_to_target()>senseRange:
		var rice = randf_range(-walkrange, walkrange)
		var beans = randf_range(-walkrange, walkrange)
		set_movement_target(Vector2(rice,beans))
	walktimer.start(randf_range(3,6))
		

func _on_walktimer_timeout():
	randomWalk()
	
func attack():
	pass
