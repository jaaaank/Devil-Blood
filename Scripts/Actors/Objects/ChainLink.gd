extends Node2D

export var intended_distance: int = 100

func _physics_process(delta):
	if global_position.distance_to(get_child(0).global_position) != intended_distance:
		get_child(0).position =  global_position.direction_to(get_child(0).global_position) * intended_distance
	$Line2D.set_point_position(0,global_position)
	$Line2D.set_point_position(1,get_child(0).global_position)
