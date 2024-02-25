extends Area2D
class_name projectile
@export var speed := Vector2(2500,2500)
@export var projDamage: int = 10

func _physics_process(delta):
	position += transform.x * speed * delta
	if $SeekingArea:
		print(rotation_degrees)
		var closestOne: Vector2
		if $SeekingArea.get_overlapping_areas().size()!=0:
			for i in $SeekingArea.get_overlapping_areas():
				closestOne = i.global_position
		if closestOne:
			rotation_degrees = rotate_toward(rotation_degrees,rad_to_deg(global_position.angle_to_point(closestOne)),100)
			
func _on_Timer_timeout():
	queue_free()
	
func _on_Bullet_area_entered(area):
	if area.get_collision_layer_value(2):
		area.owner.call("damage", projDamage)
		queue_free()

func _on_body_entered(_body):
	queue_free()
