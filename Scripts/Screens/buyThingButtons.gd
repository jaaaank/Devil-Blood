extends Button

onready var mainshop = get_parent().get_parent()
export(Array) var itemID

# Called when the node enters the scene tree for the first time.
func _ready():
	icon = itemID[3]
#	if SaveData.soulboundDevilBlood - mainshop.moneySpent < itemID[1]:
#		disabled = true

func _on_buyThingButton_pressed():
	mainshop.selectedItems.append(itemID)
	mainshop.updateShopInterface()
