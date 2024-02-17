extends mass

@onready var animP = $AnimationPlayer
@export var tendril: PackedScene
@export var baby: PackedScene
@export var shockwave: PackedScene

func _ready():
	super()
	randomize()
	$attackTimer.start(3)
	

#0: Jumpa Jumpa
#1: Tendril
#2: Summon babies
func attack():
	var attackChosen = randi_range(0,2)
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
		#3:
			#print("didnt attack")
			#pass
	$attackTimer.start(randi_range(2,5))

func spawnShockwave():
	var pee = shockwave.instantiate()
	add_sibling(pee)
	pee.global_position = global_position
