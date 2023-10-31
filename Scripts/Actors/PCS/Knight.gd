extends Player

export (PackedScene) var SwordAttack
onready var weapons:= $Weapons
onready var timey:= $Weapons/Timer
var reloadTime: float = 1.0
var cooldown = false

func _physics_process(_delta):
	var dir: = get_direction()
	PlayerAutoload.playerPos = global_position
	#velocity = move_and_slide(velocity)
	velocity = lerp(move_and_slide(velocity), speed*dir, acceleration)
	if !cooldown:
		$Weapons/hand.look_at(get_global_mouse_position())

func attack():
	if !cooldown:
		var b = SwordAttack.instance()
		$Weapons/hand.add_child(b)
		cooldown = true
		timey.start(reloadTime)
		
func altAttack():
	velocity *= 100000
	print("rah")

func _on_Timer_timeout():
	cooldown = false
	
func get_direction() -> Vector2:
	return Vector2 (
		Input.get_action_strength("moveright") - Input.get_action_strength("moveleft"), 
		Input.get_action_strength("movedown") - Input.get_action_strength("moveup"))
