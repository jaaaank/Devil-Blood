extends RigidActor

var attacking = false
var stunned = false
export (PackedScene) var biteattack


func _ready():
	sprite = $DogSprite
	speed = 300
	attackrange = 25
	
func _integrate_forces(_state):
	global_rotation_degrees=0
	if global_position.distance_to(PlayerAutoload.playerPos) > attackrange:
		linear_velocity = global_position.direction_to(PlayerAutoload.playerPos) * speed
	else: 
		attack()
		
func attack():
	if !attacking and !stunned:
		var b = biteattack.instance()
		$Weapon.add_child(b)
		attacking = true
		$attkcooldown.start(1)
		

func stun():
	stunned = true
	$attkcooldown.start(0.3)

func _on_attkcooldown_timeout():
	attacking = false
	stunned = false
