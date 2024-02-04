extends Button

@onready var mainshop = get_parent().get_parent()
@export var itemID: Array
@export var singlePurchase: bool = false

func _ready():
	mainshop.updated.connect(self.checkAvailability)
	icon = itemID[3]
	if SaveData.soulboundDevilBlood - mainshop.moneySpent < itemID[1]:
		disabled = true

func _on_buyThingButton_pressed():
	mainshop.selectedItems.append(itemID)
	mainshop.updateShopInterface()
	if SaveData.soulboundDevilBlood - mainshop.moneySpent < itemID[1] or singlePurchase:
		disabled = true

func checkAvailability():
	if SaveData.soulboundDevilBlood - mainshop.moneySpent < itemID[1]:
		disabled = true
