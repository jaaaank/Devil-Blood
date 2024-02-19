extends Player

@export var Sigi: PackedScene
@export var scythe: PackedScene
@onready var aim:= $Sigil/hand
@onready var timey:= $Sigil/Timer
var reloadTime: float = 1.0
var cooldown = false

func _physics_process(_delta):
	super(_delta)
	PlayerAutoload.playerPos = global_position
	if !cooldown:
		aim.look_at(get_global_mouse_position())
	
func attack():
	if !cooldown:
		var b = Sigi.instantiate()
		get_parent().get_parent().add_child(b)
		b.transform = aim.global_transform
		cooldown = true
		timey.start()

func altAttack():
	if !cooldown:
		var b = scythe.instantiate()
		aim.add_child(b)
		cooldown = true
		timey.start()

func _on_Timer_timeout():
	cooldown = false
