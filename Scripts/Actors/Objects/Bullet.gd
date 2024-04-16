extends Area2D
class_name projectile
@export var speed: int = 2500
@export var projDamage: int = 10
@export var pierce: int = 0

func _physics_process(delta):
	position += transform.x * speed * delta
	if get_node_or_null("SeekingArea"):
		var closestOne: Vector2
		var targets: Array = $SeekingArea.get_overlapping_areas()
		if targets.size()>0:
			targets.sort_custom(sort_distance)
			closestOne = targets[0].global_position
			rotation_degrees = rotate_toward(rotation_degrees,rad_to_deg(global_position.angle_to_point(closestOne)),100)

#i don't think this sorting is really working at all tbh but I'll get back to it later if it becomes a problem
func sort_distance(a, b):
	#print(global_position.distance_to(a.global_position))
	#print(global_position.distance_to(b.global_position))
	#print(global_position.distance_to(a.global_position)>global_position.distance_to(b.global_position))
	return global_position.distance_to(a.global_position)>global_position.distance_to(b.global_position)
	
func _on_Timer_timeout():
	queue_free()
	
func _on_Bullet_area_entered(area):
	if area.get_collision_layer_value(2):
		area.owner.call("damage", projDamage)
		pierce -=1
		if pierce<=0:
			queue_free()
			
func _on_body_entered(_body):
	pierce -=1
	if pierce<=0:
		queue_free()
