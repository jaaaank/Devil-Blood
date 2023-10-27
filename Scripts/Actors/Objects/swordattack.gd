extends Position2D

func _on_AnimationPlayer_animation_finished(anim_name):
	print("attacked")
	queue_free()
	
func _on_Sword_area_entered(area):
	if area.is_in_group("playerHurtbox"):
		PlayerAutoload.damage(10)
		$Sword.monitoring = false
