extends Button

@onready var mainshop = get_parent().get_parent()
@export var itemID: itemType

func _ready():
	tooltip_text = itemID.description
	mainshop.updated.connect(self.checkAvailability)
	icon = itemID["atlas"]
	if SaveData.refinedSoul - mainshop.moneySpent < itemID["cost"]:
		disabled = true

func _on_buyThingButton_pressed():
	itemID.purchased = true
	mainshop.selectedItems.append(itemID)
	mainshop.updateShopInterface()
	if SaveData.refinedSoul - mainshop.moneySpent < itemID["cost"] or (itemID.singlePurchase and itemID.purchased):
		disabled = true

func checkAvailability():
	if SaveData.refinedSoul - mainshop.moneySpent < itemID["cost"] or mainshop.selectedItems.size()>=PlayerAutoload.inventory.size():
		disabled = true
