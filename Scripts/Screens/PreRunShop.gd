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
		
	moneyText.text = "Refined Soul: " + str(SaveData.refinedSoul) + "\n" \
	+"Refined Soul Spent: " + str(moneySpent) + "\n"\
	+"Refined Soul Remaining: " + str(SaveData.refinedSoul - moneySpent)
	emit_signal("updated")
	for i in selectedItems:
		print(i.name)
	
func buythis():
	SaveData.refinedSoul -= moneySpent
	PlayerAutoload.inventory.clear()
	for i in selectedItems:
		print(i.name)
		PlayerAutoload.inventory.append(i)
	SaveData.saveData()


func _on_skill_tree_button_pressed():
	match PlayerAutoload.playerCharacter:
		1:
			$PriestSkillTree.set_visible(true)
		3:
			$WitchSkillTree.set_visible(true)
