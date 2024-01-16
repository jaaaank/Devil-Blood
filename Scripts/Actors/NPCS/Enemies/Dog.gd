extends RigidActor

var attacking = false
var stunned = false
var target
export (PackedScene) var biteattack


func _ready():
	sprite = $CollisionPolygon2D
	speed = 300
	attackrange = 25
	
func _integrate_forces(_state):
	target = PlayerAutoload.playerPos + Vector2(0,40)
	global_rotation_degrees=0
	if $CollisionPolygon2D/DogSprite/Position2D.global_position.distance_to(target) > attackrange and !stunned and !attacking:
		linear_velocity = global_position.direction_to(target) * speed
	else: 
		attack()
		
func attack():
	if !attacking and !stunned:
		var b = biteattack.instance()
		$CollisionPolygon2D/DogSprite/Position2D.add_child(b)
		attacking = true
		$attkcooldown.start(1)
		

func stun():
	stunned = true
	$attkcooldown.start(0.3)

func _on_attkcooldown_timeout():
	attacking = false
	stunned = false
