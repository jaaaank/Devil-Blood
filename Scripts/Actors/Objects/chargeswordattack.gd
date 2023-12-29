extends Position2D

var player = Node
var ogdegrees

func _ready():
	ogdegrees=global_rotation_degrees
	player = get_parent().get_parent().get_parent()
	
func _physics_process(_delta):
	global_rotation_degrees = ogdegrees
	#player.global_position = $Sword.global_position


func _on_Sword_area_entered(area):
	if area.collision_layer == 2:
		area.owner.call("damage", 15)
		area.owner.call("stun")
	#player.set_process_input(true)
	queue_free()


func _on_Sword_body_entered(_body):
	#player.set_process_input(true)
	queue_free()


func _on_Timer_timeout():
	queue_free()
