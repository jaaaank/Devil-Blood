extends Area2D
var speed := Vector2(350,350)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	position += transform.x * speed * delta


func _on_Timer_timeout():
	queue_free()


func _on_Bullet_body_entered(body):
	queue_free()


func _on_Bullet_area_entered(area):
	queue_free()
