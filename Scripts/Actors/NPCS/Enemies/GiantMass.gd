extends mass

@onready var animP = $AnimationPlayer
@export var tendril: PackedScene

func _ready():
	super()
	randomize()
	$attackTimer.start(3)
	

#0: Jumpa Jumpa
#1: Tendril
#2: Summon babies
func attack():
	var attackChosen = randi_range(0,1)
	match attackChosen:
		0:
			animP.play("jumpajumpa")
			await animP.animation_finished
		1:
			$Aim.look_at(PlayerAutoload.playerPos)
			$Aim.add_child(tendril.instantiate())
		2:
			pass
		3:
			print("didnt attack")
			pass
	$attackTimer.start(randi_range(2,5))
