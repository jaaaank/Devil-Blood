extends Player

onready var animP:= $AnimationPlayer
onready var hurtbox:= $Hurtbox/HurtBoxShape
onready var bloodParticles: Particles2D= $BloodParticles
var equippedWeapon: int = 0 setget set_Equipped_Weapon
export (PackedScene) var Bullet
onready var timey:= $Guns/Timer
var reloadTime: float = 1.0
var revolve: int = 0
var cooldown = false
var wasrev

func _ready():
	health = PlayerAutoload.health
	
func _physics_process(_delta):
	$Muzzle.look_at(get_global_mouse_position())
	PlayerAutoload.playerPos = position
	velocity = move_and_slide(velocity)

func _input(event):
	if Input.is_action_just_pressed("weap1"):
		set_Equipped_Weapon(0)

	if Input.is_action_just_pressed("weap2")and SaveData.priestSkillTree[0]:
		set_Equipped_Weapon(1)
		
	if Input.is_action_just_pressed("weap3")and SaveData.priestSkillTree[1]:
		set_Equipped_Weapon(2)
		
	if Input.is_action_just_pressed("weap4")and SaveData.priestSkillTree[2]:
		set_Equipped_Weapon(3)

func attack():
	if !cooldown:
		var b = Bullet.instance()
		get_parent().get_parent().add_child(b)
		b.position = $Guns/Muzzle.position
		b.rotation_degrees = $Guns/Muzzle.rotation_degrees + randomSpread()
		cooldown = true
		timey.start()
	
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
