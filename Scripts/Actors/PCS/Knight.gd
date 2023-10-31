extends Player

export (PackedScene) var SwordAttack
export (PackedScene) var LanceAttack
onready var weapons:= $Weapons
onready var timey:= $Weapons/Timer
var reloadTime: float = 1.0
var cooldown = false
var dashing = false

func _physics_process(_delta):
	PlayerAutoload.playerPos = global_position
	velocity = move_and_slide(velocity)
	if !cooldown:
		$Weapons/hand.look_at(get_global_mouse_position())

func attack():
	if !cooldown:
		var b = SwordAttack.instance()
		$Weapons/hand.add_child(b)
		cooldown = true
		timey.start(reloadTime)
		
func altAttack():
	var b = LanceAttack.instance()
	$Weapons/hand.add_child(b)
#	if !dashing:
#		velocity = Vector2(10000, 10000)
#		dashing = true
#		$dashtimer.start()
#		print("alt attack")
	pass

func _on_Timer_timeout():
	cooldown = false
	
func _on_dashtimer_timeout():
	dashing = false
