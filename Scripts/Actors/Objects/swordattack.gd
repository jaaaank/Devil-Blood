extends Position2D

func _on_AnimationPlayer_animation_finished(anim_name):
	print("player attacked")
	queue_free()

func _on_Sword_area_entered(area):
	if area.collision_layer == 2:
		area.owner.call("damage", 10)
	queue_free()


func _on_Sword_body_entered(body):
	queue_free()
