extends Actor
class_name InteractableNPC

var interactable: bool = false
@export var wantedItem: itemType


func _ready():
	sprite = $Sprite
	
func checkForItem():
	for i in PlayerAutoload.inventory:
		if i && i.id == wantedItem.id:
			return true
	return false
