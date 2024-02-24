extends enemy

@export var swordattack: PackedScene 
@export var walkrange:int = 10000
var target: Vector2
@onready var walktimer:Timer= $walktimer
var attacking:bool= false

func _ready():
	randomize()
	speed = 300
	knight = true
	sprite = $KnightSprite
	randomWalk()
	armor = 40
	health = 60

#func _physics_process(_delta):
	#$Weapon.global_rotation = global_position.angle_to_point(target)
	#if PlayerAutoload.knightsAgressive:
		#target = PlayerAutoload.playerPos
	#if global_position.distance_to(target) > attackrange:
		#velocity = global_position.direction_to(target) * speed
		#set_velocity(velocity)
		#move_and_slide()
	#else:
		#if target == PlayerAutoload.playerPos:
			#attack()
	#
func randomWalk():
	if !PlayerAutoload.knightsAgressive:
		var rice = randf_range(-walkrange, walkrange)
		var beans = randf_range(-walkrange, walkrange)
		target = Vector2(rice,beans)
		walktimer.start(randf_range(3,6))
	else:
		target = PlayerAutoload.playerPos
	
func _on_walktimer_timeout():
	randomWalk()

func attack():
	if !attacking and !stunned:
		var b = swordattack.instantiate()
		$Weapon.add_child(b)
		attacking = true
		$attkcooldown.start(1)
		

func stun():
	stunned = true
	$attkcooldown.start(0.3)

func _on_attkcooldown_timeout():
	attacking = false
	stunned = false
