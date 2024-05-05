extends mass

@onready var animP = $AnimationPlayer
@export var tendril: PackedScene
@export var baby: PackedScene
@export var shockwave: PackedScene

func _ready():
	sprite = $Masssheet
	set_physics_process(false)

func activate(_body):
	@warning_ignore("integer_division")
	$Healthbar/ProgressBar.value = health/2
	$Healthbar.set_visible(true)
	set_physics_process(true)
	randomize()
	$attackTimer.start(3)
	randomWalk()
	$ActivationSensor.queue_free()
	
func attack():
	var attackChosen = randi_range(0,2)
	if is_physics_processing():
		match attackChosen:
			0:
				animP.play("jumpajumpa")
				await animP.animation_finished
				animP.play("RESET")
			1:
				$Aim.look_at(PlayerAutoload.playerPos)
				$Aim.add_child(tendril.instantiate())
			2:
				var randomPos = [Vector2(-12000,-500), Vector2(-12000, 1500), Vector2(-10500, 1500), Vector2(-10500, -500), Vector2(-11500, 1000), Vector2(-11500, 0)]
				for i in randomPos:
					var b = baby.instantiate()
					add_sibling(b)
					b.global_position = i
		$attackTimer.start(randi_range(1,3))

func stun():
	pass

func damage(dmgdealt):
	super(dmgdealt)
	@warning_ignore("integer_division")
	$Healthbar/ProgressBar.value = health/2

func spawnShockwave():
	var pee = shockwave.instantiate()
	add_sibling(pee)
	pee.global_position = global_position

func die():
	dropDrops()
	animP.play("death")
