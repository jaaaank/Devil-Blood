extends Position2D

func _on_AnimationPlayer_animation_finished(anim_name):
	print("player attacked")
	queue_free()
	


func _on_Sword_area_entered(area):
	area.owner.call("damage", 10)
