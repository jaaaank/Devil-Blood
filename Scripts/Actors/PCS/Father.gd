extends Player

onready var animP:= $AnimationPlayer
onready var hurtbox:= $Hurtbox/HurtBoxShape

func _ready():
	print("yead")
	
func _physics_process(_delta):
	PlayerAutoload.playerPos = position
	velocity = move_and_slide(velocity)
