extends enemy

var movementTarget: Vector2 
@onready var navigationAgent: NavigationAgent2D = $NavigationAgent2D
@export var swordattack: PackedScene 
@onready var walktimer: Timer = $walktimer
var attacking: bool = false

func _ready():
	randomize()
	knight = true
	sprite = $KnightSprite
	randomWalk()

func set_movement_target(target: Vector2):
	navigationAgent.target_position = target

func _physics_process(delta):
	super(delta)
	$Weapon.global_rotation = global_position.angle_to_point(movementTarget)
	if PlayerAutoload.knightsAgressive:
		movementTarget = PlayerAutoload.playerPos
	set_movement_target(movementTarget)
	if navigationAgent.distance_to_target()<attackrange:
		if movementTarget == PlayerAutoload.playerPos:
			attack()
			return
		else:
			return
	var next_path_position: Vector2 = navigationAgent.get_next_path_position()
	velocity = global_position.direction_to(next_path_position) * speed
	move_and_slide()
	
func attack():
	if !attacking and !stunned:
		var b = swordattack.instantiate()
		$Weapon.add_child(b)
		attacking = true
		$attkcooldown.start(1)
		
func randomWalk():
	if !PlayerAutoload.knightsAgressive:
		speed = 100
		var rice = randf_range(-walkrange, walkrange)
		var beans = randf_range(-walkrange, walkrange)
		movementTarget = Vector2(rice,beans)
		walktimer.start(randf_range(3,6))
	else:
		speed = 300
		movementTarget = PlayerAutoload.playerPos
		
func stun():
	stunned = true
	$attkcooldown.start(0.3)
	
func _on_attkcooldown_timeout():
	attacking = false
	stunned = false
	
func _on_walktimer_timeout():
	randomWalk()

