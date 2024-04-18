extends enemy
var target: Vector2

func _ready():
	sprite = $Impurity
	target = PlayerAutoload.playerPos

func _physics_process(_delta):
	velocity = lerp(velocity,position.direction_to(target) * speed,.05)
	move_and_slide()
	
func stun():
	stunned = true
	set_physics_process(false)
	$StunTimer.start()
	if PlayerAutoload.playerCharacter == 1 and SaveData.priestSkillTree[8]:
		$StunTimer.start(5)
		
func unstun():
	stunned = false
	set_physics_process(true)
	
func _on_search_timer_timeout():
	var rice: int = randi_range(-150, 150)
	var beans: int = randi_range(-150, 150)
	target = PlayerAutoload.playerPos + Vector2(rice, beans)

func _on_hurt_box_area_entered(area):
	if area.collision_layer == 1 and !stunned:
		area.get_parent().damage(basedamage)
