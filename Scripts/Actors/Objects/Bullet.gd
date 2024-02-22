extends Area2D
class_name projectile
@export var speed := Vector2(2500,2500)
@export var projDamage: int = 10

func _physics_process(delta):
	position += transform.x * speed * delta

	
func _on_Timer_timeout():
	queue_free()

func _on_Bullet_area_entered(area):
	if area.get_collision_layer_value(2):
		area.owner.call("damage", projDamage)
		queue_free()

func _on_body_entered(_body):
	queue_free()
