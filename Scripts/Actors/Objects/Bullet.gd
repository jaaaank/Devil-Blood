extends Area2D
class_name projectile
var speed := Vector2(5000,5000)

func _physics_process(delta):
	position += transform.x * speed * delta
	#make the sprites symmetrical so i dont have to flip them
	
func _on_Timer_timeout():
	queue_free()


func _on_Bullet_body_entered(body):
	queue_free()


func _on_Bullet_area_entered(area):
	area.owner.call("damage", 10)
