extends Sprite

export (PackedScene) var Bullet
onready var timey:= $Timer
var reloadTime: float = 1.0
var revolve: int = 0
var cooldown = false
var wasrev


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	$Muzzle.look_at(get_global_mouse_position())

func shoot():
	if !cooldown:
		print("snoob")
		var b = Bullet.instance()
		owner.add_child(b)
		b.position = $Muzzle.position
		b.rotation_degrees = $Muzzle.rotation_degrees + randomSpread()
		cooldown = true
		timey.start()
	
func randomSpread():
	if !SaveData.priestSkillTree[2]:
		var spread = rand_range(-5.0, 5.0)
		return spread
	else: return 1


func _on_Timer_timeout():
	cooldown=false
