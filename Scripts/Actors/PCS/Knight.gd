extends Player

export (PackedScene) var SwordAttack
onready var weapons:= $Weapons
onready var timey:= $Weapons/Timer
var reloadTime: float = 1.0
var cooldown = false

func _physics_process(_delta):
	PlayerAutoload.playerPos = global_position
	velocity = move_and_slide(velocity)
	$Weapons/hand.look_at(get_global_mouse_position())

func attack():
	if !cooldown:
		var b = SwordAttack.instance()
		$Weapons/hand.add_child(b)
		cooldown = true
		timey.start()
		
func altAttack():
	set_physics_process(false)
	
	
	set_physics_process(true)

func _on_Timer_timeout():
	cooldown = false
