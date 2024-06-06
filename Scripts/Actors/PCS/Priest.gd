extends Player

@onready var bloodParticles:GPUParticles2D = $BloodParticles
@onready var gunSounds: AudioStreamPlayer = $Guns/attack
@onready var gunanimp: AnimationPlayer = $UI/PriestCanvas/ammoUi/reloadAnims
var equippedWeapon:int = 0: set = set_Equipped_Weapon
@export var reloadUis: Array
@export var Bullet:PackedScene
@export var Crucifix:PackedScene
@onready var timey:Timer = $Guns/Timer
var reloadTime:float = 1.0
var revolve:int = 6
var cooldown:bool = false
var cruceCooldown:bool = false
var cruce:Area2D
var crucing:bool = false
var canAbility:bool = true
var abilitying:bool = false

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
		reloadTime = 1.75
		
func attack():
	if !cooldown:
		shoot()
		cooldown = true
		
func shoot():
	match equippedWeapon:
		0:
			var a = Bullet.instantiate()
			get_parent().add_sibling(a)
			a.position = $Guns/Muzzle.global_position
			a.scale = $Guns/Muzzle.scale
			a.rotation_degrees = $Guns/Muzzle.rotation_degrees + randomSpread()
			a.projDamage = 10
			gunSounds.play()
			gunanimp.play("rifleReload")
		1:
			if revolve>0:
				var a = Bullet.instantiate()
				get_parent().add_sibling(a)
				a.position = $Guns/Muzzle.global_position
				a.scale = $Guns/Muzzle.scale
				a.rotation_degrees = $Guns/Muzzle.rotation_degrees + randomSpread()
				a.projDamage = 5
				a.scale *= .5
				revolve -=1
				$UI/PriestCanvas/ammoUi/revolver.set_frame(6-revolve)
				gunSounds.play()
				$Guns/revolverTimer.start()
				#if revolve <= 0:
					#timey.start(4)
					#revolve = 6
					#return
		2:
			var bullets: int = 3
			if SaveData.priestSkillTree[7]:
				bullets +=1
			for i in bullets:
				var b = Bullet.instantiate()
				gunSounds.play()
				get_parent().add_sibling(b)
				b.position = $Guns/Muzzle.global_position
				b.scale = $Guns/Muzzle.scale
				b.rotation_degrees = $Guns/Muzzle.rotation_degrees + randomSpread()*3
				b.projDamage = 5
			gunanimp.play("shotgunReload")
		3:
			var a = Bullet.instantiate()
			get_parent().add_sibling(a)
			a.position = $Guns/Muzzle.global_position
			a.scale = $Guns/Muzzle.scale
			a.rotation_degrees = $Guns/Muzzle.rotation_degrees
			a.projDamage = 6
			a.pierce = 3
	timey.start(reloadTime)
	
func altAttack():
	if !crucing and !cruceCooldown and SaveData.priestSkillTree[4]:
		crucing = true
		cruce = Crucifix.instantiate()
		add_child(cruce)
		speed /= 3
	
func unaltAttack():
	if crucing && !abilitying:
		cruceCooldown=true
		$CrucifixCooldown.start()
		crucing=false
		speed*=3
		cruce.queue_free()
	
func ability():
	if SaveData.priestSkillTree[6]&&canAbility&&!crucing:
		canAbility=false
		armor+=10
		abilitying = true
		crucing = true
		cruce = Crucifix.instantiate()
		add_child(cruce)
		for i in 10:
			heal(2)
			await get_tree().create_timer(1.0).timeout
		$abilityCooldown.start()
		armor-=10
		abilitying=false
		crucing=false
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
	var indx: int = 0
	for i in reloadUis:
		if indx == value:
			get_node(i).set_visible(true)
		else:
			get_node(i).set_visible(false)
		indx+=1
	switchWeapon()
	
func switchWeapon():
	bloodParticles.emitting=true

func _on_crucifix_cooldown_timeout():
	cruceCooldown=false

func _on_ability_cooldown_timeout():
	canAbility=true

func _on_revolver_timer_timeout():
	revolve +=1
	$UI/PriestCanvas/ammoUi/revolver.set_frame(6-revolve)
	if revolve<6:
		$Guns/revolverTimer.start()
