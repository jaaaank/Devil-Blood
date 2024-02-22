extends Player

@onready var bloodParticles: GPUParticles2D= $BloodParticles
var equippedWeapon: int = 0: set = set_Equipped_Weapon
@export var Bullet: PackedScene
@export var Crucifix: PackedScene
@onready var timey:= $Guns/Timer
var reloadTime: float = 1.0
var revolve: int = 6
var cooldown = false
var cruce
var crucing = false

func _physics_process(_delta):
	super(_delta)
	$Guns/Muzzle.look_at(get_global_mouse_position())
	PlayerAutoload.playerPos = global_position

func _input(_event):
	super(_event)
	if Input.is_action_just_released("altattack"):
		unaltAttack()
	if Input.is_action_just_pressed("weap1"):
		set_Equipped_Weapon(0)
		reloadTime = 1

	if Input.is_action_just_pressed("weap2")and SaveData.priestSkillTree[0]:
		set_Equipped_Weapon(1)
		reloadTime = 0.1

func attack():
	if !cooldown:
		var b = Bullet.instantiate()
		get_parent().get_parent().add_child(b)
		b.position = $Guns/Muzzle.global_position
		b.scale = $Guns/Muzzle.scale
		b.rotation_degrees = $Guns/Muzzle.rotation_degrees + randomSpread()
		cooldown = true
		match equippedWeapon:
			0:
				b.projDamage = 10
				timey.start(reloadTime)
			1:
				b.projDamage = 5
				b.scale *= .5
				revolve -=1
				if revolve <= 0:
					timey.start(5)
					revolve = 6
				else:
					timey.start(reloadTime)
	
func altAttack():
	if !crucing:
		crucing = true
		var b = Crucifix.instantiate()
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
		var spread = randf_range(-5.0, 5.0)
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
