extends enemy

var movementTarget: Vector2 
var agressive: bool = false
var attacking: bool = false
@export var biteattack: PackedScene
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

func _ready():
	sprite = $DogSprite
	await get_tree().physics_frame
	set_movement_target(PlayerAutoload.playerPos)

func set_movement_target(target: Vector2):
	navigation_agent.target_position = target

func _physics_process(delta):
	set_movement_target(PlayerAutoload.playerPos)
	if navigation_agent.is_navigation_finished():
		if movementTarget == PlayerAutoload.playerPos:
			attack()
	elif navigation_agent.distance_to_target()<1000:
		var next_path_position: Vector2 = navigation_agent.get_next_path_position()
		velocity = global_position.direction_to(next_path_position) * speed/2
		move_and_slide()

func attack():
	if !attacking and !stunned:
		var b = biteattack.instantiate()
		$CollisionPolygon2D/DogSprite/Marker2D.add_child(b)
		attacking = true
		$attkcooldown.start(1)

func stun():
	stunned = true
	$attkcooldown.start(0.3)

func _on_attkcooldown_timeout():
	attacking = false
	stunned = false
