extends InteractableNPC

var interactable = false

func _ready():
	PlayerAutoload.connect("interacted", Callable(self, "interacted"))

func _on_interaction_shape_2d_body_entered(_body):
	interactable = true
	
func _on_interaction_shape_2d_body_exited(_body):
	interactable = false

func interacted():
	if interactable && MapAutoload.metRats:
		$metRats.set_visible(true)

func yorn(yes: bool):
	$metRats.set_visible(false)
	if yes:
		$PopupTextBox.say("Thanks.")
