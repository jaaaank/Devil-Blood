extends RigidActor


func _ready():
	sprite = $CollisionShape2D/DogSprite
	speed = 300

func _integrate_forces(state):
	$CollisionShape2D.global_rotation_degrees =0
	linear_velocity = global_position.direction_to(PlayerAutoload.playerPos) * speed
