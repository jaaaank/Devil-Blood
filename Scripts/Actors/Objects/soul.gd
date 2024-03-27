extends Area2D

var player
@export var worth: int = 1

func _ready():
	player = PlayerAutoload.get_player()

func _physics_process(delta):
	if global_position.distance_to(player.global_position)<200:
		translate(global_position.direction_to(player.global_position).normalized() * delta *400)
	
func _on_body_entered(body):
	if body.is_in_group("player"):
		PlayerAutoload.set_soul(PlayerAutoload.soul + 1)
		queue_free()
