extends Position2D

var player = Node

func _ready():
	player = get_parent().get_parent().get_parent()
	player.set_physics_process(false)
	
func _on_AnimationPlayer_animation_finished(anim_name):
	print("player attacked")
	player.global_position = global_position
	player.set_physics_process(true)
	queue_free()
	

func _physics_process(delta):
	player.global_position = $Sword.global_position

func _on_Sword_area_entered(area):
	if area.collision_layer == 2:
		area.owner.call("damage", 15)
	player.set_physics_process(true)
	queue_free()
