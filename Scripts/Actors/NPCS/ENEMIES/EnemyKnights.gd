extends enemy

export (PackedScene) var swordattack
export var walkrange = 10000
var target: Vector2
onready var walktimer:= $walktimer
var attacking:= false

func _ready():
	randomize()
	speed = 300
	knight = true
	sprite = $KnightSprite
	randomWalk()
	armor = 40
	health = 60


func _physics_process(_delta):
	$Weapon.rotation = global_position.angle_to_point(target)
	if PlayerAutoload.knightsAgressive:
		target = PlayerAutoload.playerPos
	if global_position.distance_to(target) > attackrange:
		velocity = global_position.direction_to(target) * speed
		move_and_slide(velocity)
	else:
		if target == PlayerAutoload.playerPos:
			attack()
	
func randomWalk():
	if !PlayerAutoload.knightsAgressive:
		var rice = rand_range(-walkrange, walkrange)
		var beans = rand_range(-walkrange, walkrange)
		target = Vector2(rice,beans)
		walktimer.start(rand_range(3,6))
	else:
		target = PlayerAutoload.playerPos
	
func _on_walktimer_timeout():
	randomWalk()

func attack():
	if !attacking and !stunned:
		var b = swordattack.instance()
		$Weapon.add_child(b)
		attacking = true
		$attkcooldown.start(1)
		

func stun():
	stunned = true
	$attkcooldown.start(0.3)

func _on_attkcooldown_timeout():
	attacking = false
	stunned = false
