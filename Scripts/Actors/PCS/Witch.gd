extends Player

@export var Sigi: PackedScene
@onready var sigil:= $Sigil
@onready var timey:= $Sigil/Timer
var reloadTime: float = 1.0
var cooldown = false

func _physics_process(_delta):
	super(_delta)
	PlayerAutoload.playerPos = global_position
	$Sigil/Muzzle.look_at(get_global_mouse_position())
	
func attack():
	if !cooldown:
		var b = Sigi.instantiate()
		get_parent().get_parent().add_child(b)
		b.transform = $Sigil/Muzzle.global_transform
		cooldown = true
		timey.start()

func _on_Timer_timeout():
	cooldown = false
