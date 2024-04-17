extends StaticBody2D


@export var efficiency: float = .5

func _input(event):
	if Input.is_action_just_pressed("interact"):
		for i in $Area2D.get_overlapping_bodies():
			if i.is_in_group("player"):
				print("peepe")
