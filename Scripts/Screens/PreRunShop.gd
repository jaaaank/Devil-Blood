extends Control

onready var itemsText:= $rightside/SelectedItemsText
onready var moneyText:= $rightside/MoneyText
var moneySpent:int = 0
var selectedItems: Array

signal runStarted

func _ready():
	updateShopInterface()

func updateShopInterface():
	itemsText.text = "Items:\n"
	moneySpent = 0
	for i in selectedItems:
		itemsText.text += i[0] + "\n"
		moneySpent += i[1]
		
	moneyText.text = "Devil Blood: " + String(SaveData.soulboundDevilBlood) + "\n" \
	+"Devil Blood Spent: " + String(moneySpent) + "\n"\
	+"Devil Blood Remaining: " + String(SaveData.soulboundDevilBlood - moneySpent)
	
	
func buythis(cost):
	SaveData.soulboundDevilBlood -= cost
	for i in selectedItems:
		pass
