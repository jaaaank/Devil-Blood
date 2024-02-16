extends mass

@onready var animP = $AnimationPlayer

func _ready():
	super()
	randomize()
	$attackTimer.start(3)
	

#0: Jumpa Jumpa
#1: Tendril
#2: Summon babies
func attack():
	var attackChosen = randi_range(0,3)
	match attackChosen:
		0:
			animP.play("jumpajumpa")
		1:
			pass
		2:
			pass
		3:
			print("didnt attack")
			pass
	$attackTimer.start(randi_range(2,5))
