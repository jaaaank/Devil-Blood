extends InteractableNPC

var interactable = false

func _ready():
	PlayerAutoload.connect("interacted", Callable(self, "interacted"))

func _on_interaction_shape_2d_body_entered(body):
	interactable = true
func _on_interaction_shape_2d_body_exited(body):
	interactable = false
#AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
func interacted():
	if interactable:
		print("abkjashvjk")
