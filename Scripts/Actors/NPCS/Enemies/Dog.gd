extends RigidActor


var target

func _ready():
	sprite = $Bloodsigilplaceholder
	speed = 300

func _integrate_forces(state):
	linear_velocity = global_position.direction_to(PlayerAutoload.playerPos) * speed
	print(linear_velocity)
