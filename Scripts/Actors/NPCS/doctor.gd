extends InteractableNPC

@onready var animP: AnimationPlayer=$AnimationPlayer
var interactable = false

func _ready():
	PlayerAutoload.connect("interacted", Callable(self, "interacted"))

func _on_interaction_shape_2d_body_entered(_body):
	interactable = true
	if checkForBag():
		$hasBag.set_visible(true)
		
func _on_interaction_shape_2d_body_exited(_body):
	interactable = false
	$hasBag.set_visible(false)


func interacted():
	pass

func yorn(yes: bool):
	$hasBag.set_visible(false)
	PlayerAutoload.inventory.pop_at(PlayerAutoload.inventory.find(load("res://Scenes/Items/drsbag.tres")))
	PlayerAutoload.inventory.append(load("res://Scenes/Items/crystdevbl.tres"))
	SaveData.unlockedPurchasables[2] = true
	if yes:
		$PopupTextBox.say("Thanks.")
		
func checkForBag():
	for i in PlayerAutoload.inventory:
		if i && i.id == 3:
			return true
	return false
