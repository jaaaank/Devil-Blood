extends Sprite

export (PackedScene) var Sigi
onready var timey:= $Timer
var reloadTime: float = 1.0
var cooldown = false

# Called when the node enters the scene tree for the first time.



func _physics_process(_delta):
	pass

func _on_Timer_timeout():
	cooldown=false
