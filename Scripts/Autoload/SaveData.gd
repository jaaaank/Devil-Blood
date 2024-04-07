extends Node
var saveFile: String = "user://playerData.txt"

var priestSkillTree: Array =[true,true,true,true,true,true,true,true,true]
var knightSkillTree: Array =[false,false,false]
var witchSkillTree: Array =[false,false,false]
var refinedSoul: int = 50
var pureSoul: int = 0

@export var saveDict: Dictionary = {
	"priestsave" = priestSkillTree,
	"knightsave" = knightSkillTree,
	"witchsave" = witchSkillTree,
	"pureSoul" = pureSoul,
	"refinedSoul" = refinedSoul
}

func _ready() -> void:
	saveData()
	print("Original Data: ", saveDict)
	loadData()
	print("Altered Data: ", saveDict)
	
func saveData() -> void:
	editData()
	print ("Saving Data")
	var file = FileAccess.open(saveFile, FileAccess.WRITE)
	file.open(saveFile, FileAccess.WRITE)
	file.store_line(JSON.new().stringify(saveDict))
	file.close()
	
func editData() -> void:
	saveDict = {
	"priestsave" = priestSkillTree,
	"knightsave" = knightSkillTree,
	"witchsave" = witchSkillTree,
	"refinedSoul" = refinedSoul,
	"pureSoul" = pureSoul
}

func loadData() -> void:
	var dataFile = FileAccess.open(saveFile, FileAccess.WRITE)
	if !dataFile.file_exists(saveFile):
		print ("No Save Data Found")
		return
	else:
		print ("Loading Save Data")
	dataFile.open(saveFile, FileAccess.READ)
	
	while dataFile.get_position() < dataFile.get_length():
		var test_json_conv = JSON.new()
		test_json_conv.parse(dataFile.get_line())
		var nodeData = test_json_conv.get_data()
		saveDict.priestsave = nodeData["priestsave"]
		saveDict.knightsave = nodeData["knightsave"]
		saveDict.witchsave = nodeData["witchsave"]
		saveDict.refinedSoul = nodeData["refinedSoul"]
		saveDict.pureSoul = nodeData["pureSoul"]
	dataFile.close()
