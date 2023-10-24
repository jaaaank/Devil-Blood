extends Area2D
var speed := Vector2(5000,5000)

func _physics_process(delta):
	position += transform.x * speed * delta


func _on_Timer_timeout():
	queue_free()


func _on_Bullet_body_entered(body):
	queue_free()


func _on_Bullet_area_entered(area):
	queue_free()
