extends Position2D

func _on_AnimationPlayer_animation_finished(anim_name):
	print("attacked")
	queue_free()
