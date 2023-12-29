extends Player

onready var bloodParticles: Particles2D= $BloodParticles
var equippedWeapon: int = 0 setget set_Equipped_Weapon
export (PackedScene) var Bullet
export (PackedScene) var Crucifix
onready var timey:= $Guns/Timer
var reloadTime: float = 1.0
var revolve: int = 0
var cooldown = false
var wasrev
var cruce
var crucing = false

func _physics_process(_delta):
	$Guns/Muzzle.look_at(get_global_mouse_position())
	PlayerAutoload.playerPos = global_position

func _input(_event):
	if Input.is_action_just_released("altattack"):
		unaltAttack()
		
	if Input.is_action_just_pressed("weap1"):
		set_Equipped_Weapon(0)

	if Input.is_action_just_pressed("weap2")and SaveData.priestSkillTree[0]:
		set_Equipped_Weapon(1)

func attack():
	if !cooldown:
		var b = Bullet.instance()
		get_parent().get_parent().add_child(b)
		b.position = $Guns/Muzzle.global_position
		b.scale = $Guns/Muzzle.scale
		b.rotation_degrees = $Guns/Muzzle.rotation_degrees + randomSpread()
		cooldown = true
		timey.start()
	
func altAttack():
	if !crucing:
		crucing = true
		var b = Crucifix.instance()
		add_child(b)
		cruce = b
		speed /= 3
		print("alt attacked")
	
func unaltAttack():
	if crucing:
		crucing = false
		speed *=3
		cruce.queue_free()
	
func randomSpread():
	if !SaveData.priestSkillTree[2]:
		var spread = rand_range(-5.0, 5.0)
		return spread
	else: return 1

func _on_Timer_timeout():
	cooldown=false
	
func set_Equipped_Weapon(value: int):
	equippedWeapon = value
	switchWeapon()
	
func switchWeapon():
	print("wah")
	bloodParticles.emitting = true
