extends Player

onready var animP:= $AnimationPlayer
onready var hurtbox:= $Hurtbox/HurtBoxShape
onready var guns:= $Guns
onready var bloodParticles: Particles2D= $BloodParticles
var equippedWeapon: int = 0 setget set_Equipped_Weapon

func _ready():
	health = PlayerAutoload.health
	
func _physics_process(_delta):
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
	guns.shoot()
	
func set_Equipped_Weapon(value: int):
	equippedWeapon = value
	switchWeapon()
	
func switchWeapon():
	print("wah")
	bloodParticles.emitting = true
