extends StaticBody2D


@export var efficiency: float = .5
var impurity: PackedScene = load("res://Scenes/Actors/Enemies/LowTier/Impurity.tscn")

func _input(_event):
	if Input.is_action_just_pressed("interact") and PlayerAutoload.impureSoul>1/efficiency:
		for i in $Area2D.get_overlapping_bodies():
			if i.is_in_group("player"):
				@warning_ignore("narrowing_conversion")
				PlayerAutoload.set_refinedSoul(PlayerAutoload.refinedSoul+PlayerAutoload.impureSoul*efficiency)
				spawnImpurities()
				for a in PlayerAutoload.impureSoul*(abs(efficiency-1)):
					spawnImpurities()
				PlayerAutoload.set_impureSoul(0)

func spawnImpurities():
	var a: CharacterBody2D = impurity.instantiate()
	get_parent().add_child(a)
	a.global_position = global_position
