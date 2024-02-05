extends Control

@onready var itemsText:= $rightside/SelectedItemsText
@onready var moneyText:= $rightside/MoneyText
var moneySpent:int = 0
var selectedItems: Array[itemType]

signal runStarted
signal updated

func _ready():
	updateShopInterface()

func updateShopInterface():
	itemsText.text = "Items:\n"
	moneySpent = 0
	for i in selectedItems:
		itemsText.text += i["name"] + "\n"
		moneySpent += i["cost"]
		
	moneyText.text = "Devil Blood: " + str(SaveData.soulboundDevilBlood) + "\n" \
	+"Devil Blood Spent: " + str(moneySpent) + "\n"\
	+"Devil Blood Remaining: " + str(SaveData.soulboundDevilBlood - moneySpent)
	emit_signal("updated")
	for i in selectedItems:
		print(i.name)
	
func buythis():
	SaveData.soulboundDevilBlood -= moneySpent
	PlayerAutoload.inventory.clear()
	for i in selectedItems:
		print(i.name)
		PlayerAutoload.inventory.append(i)
