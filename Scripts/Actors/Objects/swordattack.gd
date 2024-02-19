extends Marker2D

func _on_AnimationPlayer_animation_finished(_anim_name):
	queue_free()

func _on_Sword_area_entered(area):
	if area.collision_layer == 2:
		area.owner.call("damage", 10)
