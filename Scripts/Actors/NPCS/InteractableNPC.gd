extends Actor
class_name InteractableNPC

var interactable: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite = $Sprite
