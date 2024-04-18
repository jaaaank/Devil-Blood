extends enemy
var target: Vector2

func _ready():
	sprite = $Impurity
	target = PlayerAutoload.playerPos

func _physics_process(_delta):
	velocity = lerp(velocity,position.direction_to(target) * speed,.05)
	move_and_slide()


func _on_search_timer_timeout():
	var rice: int = randi_range(-150, 150)
	var beans: int = randi_range(-150, 150)
	target = PlayerAutoload.playerPos + Vector2(rice, beans)
