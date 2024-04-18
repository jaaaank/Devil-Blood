extends Player

@onready var bloodParticles: GPUParticles2D = $BloodParticles
var equippedWeapon: int = 0: set = set_Equipped_Weapon
@export var Bullet: PackedScene
@export var Crucifix: PackedScene
@onready var timey:= $Guns/Timer
var reloadTime: float = 1.0
var revolve: int = 6
var cooldown = false
var cruce
var crucing = false

func _ready():
	super()
	if SaveData.priestSkillTree[1]:
		armor = 5

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
	if Input.is_action_just_pressed("weap3")and SaveData.priestSkillTree[5]:
		set_Equipped_Weapon(2)
		reloadTime = 2
	if Input.is_action_just_pressed("weap4")and SaveData.priestSkillTree[3]:
		set_Equipped_Weapon(3)
		reloadTime = 2
		
func attack():
	if !cooldown:
		shoot()
		cooldown = true
		
func shoot():
	var a = Bullet.instantiate()
	match equippedWeapon:
		0:
			get_parent().get_parent().add_child(a)
			a.position = $Guns/Muzzle.global_position
			a.scale = $Guns/Muzzle.scale
			a.rotation_degrees = $Guns/Muzzle.rotation_degrees + randomSpread()
			a.projDamage = 10
		1:
			get_parent().get_parent().add_child(a)
			a.position = $Guns/Muzzle.global_position
			a.scale = $Guns/Muzzle.scale
			a.rotation_degrees = $Guns/Muzzle.rotation_degrees + randomSpread()
			a.projDamage = 5
			a.scale *= .5
			revolve -=1
			if revolve <= 0:
				timey.start(5)
				revolve = 6
				return
		2:
			var b = Bullet.instantiate()
			var c = Bullet.instantiate()
			var d = Bullet.instantiate()
			var bullets:Array =[a,b,c,d]
			if SaveData.priestSkillTree[7]:
				var e = Bullet.instantiate()
				bullets.append(e)
			for i in bullets:
				get_parent().get_parent().add_child(i)
				i.position = $Guns/Muzzle.global_position
				i.scale = $Guns/Muzzle.scale
				i.rotation_degrees = $Guns/Muzzle.rotation_degrees + randomSpread()*3
				i.projDamage = 5
		3:
			get_parent().get_parent().add_child(a)
			a.position = $Guns/Muzzle.global_position
			a.scale = $Guns/Muzzle.scale
			a.rotation_degrees = $Guns/Muzzle.rotation_degrees
			a.projDamage = 6
			a.pierce = 3
	timey.start(reloadTime)
	
func altAttack():
	if !crucing and SaveData.priestSkillTree[4]:
		crucing = true
		var b = Crucifix.instantiate()
		add_child(b)
		cruce = b
		speed /= 3
	
func unaltAttack():
	if crucing:
		crucing = false
		speed *=3
		cruce.queue_free()
	
func randomSpread():
	var spread = randf_range(-5.0, 5.0)
	if SaveData.priestSkillTree[2]:
		spread = randf_range(-2.0, 2.0)
	return spread

func _on_Timer_timeout():
	cooldown=false
	
func set_Equipped_Weapon(value: int):
	equippedWeapon = value
	switchWeapon()
	
func switchWeapon():
	bloodParticles.emitting = true
