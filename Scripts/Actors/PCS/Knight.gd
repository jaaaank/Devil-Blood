extends Player

@export var SwordAttack: PackedScene
@export var LanceAttack: PackedScene
@onready var weapons:= $Weapons
@onready var timey:= $Weapons/Timer
var reloadTime: float = 1.0
var cooldown = false
var dashing = false

func _physics_process(_delta):
	super(_delta)
	PlayerAutoload.playerPos = global_position
	if !cooldown:
		$Weapons/hand.look_at(get_global_mouse_position())

func attack():
	if !dashing and !cooldown:
		var b = SwordAttack.instantiate()
		$Weapons/hand.add_child(b)
		cooldown = true
		timey.start(reloadTime)
		
func altAttack():
	if !dashing and !cooldown:
		iframes = true 
		set_process_input(false)
		var b = LanceAttack.instantiate()
		$Weapons/hand.add_child(b)
		velocity = global_position.direction_to(get_global_mouse_position())*2500
		dashing = true
		$dashtimer.start()
		
func _on_Timer_timeout():
	cooldown = false
	
func _on_dashtimer_timeout():
	iframes = false 
	cooldown = true
	timey.start(reloadTime)
	dashing = false
	velocity = Vector2.ZERO
	set_process_input(true)
