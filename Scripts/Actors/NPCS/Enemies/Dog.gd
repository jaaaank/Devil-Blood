extends RigidActor

var attacking: bool = false
var stunned: bool = false
var target: Vector2
@export var sprites: Array[Texture2D]
@export var biteattack: PackedScene

func _ready():
	sprite = $CollisionShape2D

func _integrate_forces(_state):
	target = PlayerAutoload.playerPos
	$CollisionShape2D.global_rotation_degrees=0
	$hurtbox.global_rotation_degrees=0
	if $CollisionShape2D/DogSprite/Marker2D.global_position.distance_to(target) > attackrange and !stunned and !attacking:
		linear_velocity = global_position.direction_to(target) * speed
	elif !attacking and !stunned: 
		attack()
		
func attack():
	if !attacking and !stunned:
		var b = biteattack.instantiate()
		$CollisionShape2D/DogSprite/Marker2D.add_child(b)
		attacking = true
		$attkcooldown.start(1)
		
func spriteDirection():
	var angl:float = roundf(rad_to_deg(linear_velocity.angle()))
	if linear_velocity!=Vector2.ZERO:
		if angl <= 45 && angl>=0 or angl >= -45 && angl<0 or angl <= 180 && angl>=135 or angl >=-180 && angl <= -135: 
			sprite.get_node("DogSprite").texture = sprites[2]
		elif angl<0:
			sprite.get_node("DogSprite").texture = sprites[1]
		else:
			sprite.get_node("DogSprite").texture = sprites[0]
			
func stun():
	stunned = true
	$attkcooldown.start(0.5)

func _on_attkcooldown_timeout():
	attacking = false
	stunned = false


