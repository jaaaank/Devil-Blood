extends InteractableNPC

@onready var animP: AnimationPlayer = $AnimationPlayer

func _ready():
	PlayerAutoload.connect("interacted", Callable(self, "interacted"))

func _on_interaction_shape_2d_body_entered(_body):
	interactable = true
	if checkForItem():
		pass
		
func _on_interaction_shape_2d_body_exited(_body):
	interactable = false

func interact():
	pass

func yorn(yes: bool):
	PlayerAutoload.inventory.pop_at(PlayerAutoload.inventory.find(load("res://Scenes/Items/drsbag.tres")))
	PlayerAutoload.inventory.append(load("res://Scenes/Items/crystdevbl.tres"))
	SaveData.unlockedPurchasables[2] = true
	if yes:
		$PopupTextBox.say("Thanks. Take this and head south.")
		
