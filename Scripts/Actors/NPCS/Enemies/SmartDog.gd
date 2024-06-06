extends enemy

var movementTarget: Vector2 
var agressive: bool = false
var attacking: bool = false
@export var senseRange: int = 750
@export var biteattack: PackedScene
@onready var navigationAgent: NavigationAgent2D = $NavigationAgent2D

func _ready():
	sprite = $hurtbox
	await get_tree().physics_frame
	set_movement_target(PlayerAutoload.playerPos)

func set_movement_target(target: Vector2):
	navigationAgent.target_position = target

func _physics_process(delta):
	super(delta)
	spriteDirection()
	set_movement_target(PlayerAutoload.playerPos)
	if navigationAgent.distance_to_target()<50:
		attack()
	elif navigationAgent.distance_to_target()<senseRange:
		var next_path_position: Vector2 = navigationAgent.get_next_path_position()
		velocity = global_position.direction_to(next_path_position) * speed
		move_and_slide()

func attack():
	if !attacking and !stunned:
		var b = biteattack.instantiate()
		$hurtbox/DogSprite/Marker2D.add_child(b)
		attacking = true
		$attkcooldown.start(1)

func stun():
	stunned = true
	$attkcooldown.start(0.3)
	
func spriteDirection():
	var angl:float = roundf(rad_to_deg(velocity.angle()))
	if velocity!=Vector2.ZERO:
		if angl <= 45 && angl>=0 or angl >= -45 && angl<0 or angl <= 180 && angl>=135 or angl >=-180 && angl <= -135: 
			sprite.get_node("DogSprite").texture = sprites[2]
		elif angl<0:
			sprite.get_node("DogSprite").texture = sprites[1]
		else:
			sprite.get_node("DogSprite").texture = sprites[0]
			
func _on_attkcooldown_timeout():
	attacking = false
	stunned = false
