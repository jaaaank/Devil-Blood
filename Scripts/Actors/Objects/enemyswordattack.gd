extends Marker2D

@export var basedamage: int

func _on_AnimationPlayer_animation_finished(_anim_name):
	queue_free()
	

func _on_Sword_area_entered(area):
	area.owner.damage(basedamage)


func _on_Timer_timeout():
	queue_free()
