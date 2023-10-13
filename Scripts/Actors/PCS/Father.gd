extends Actor

export (PackedScene) var bomb
onready var animP:= $AnimationPlayer
onready var hurtbox:= $Hurtbox/HurtBoxShape

func _ready():
	playercharacter = true
	
func _physics_process(_delta):
	velocity = move_and_slide(velocity)

func die():
	if !$deathsound.playing:
		velocity=Vector2.ZERO
		set_physics_process(false)
		set_process_input(false)
		$Hurtbox/HurtBoxShape.disabled=true
		$PlayerSprite.frame = 2
		$deathsound.play()

