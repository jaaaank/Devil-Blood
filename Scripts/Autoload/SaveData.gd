extends Node
var saveFile: String = "user://playerData.txt"

var priestSkillTree: Array =[true,true,true,true,true,true,true,true,true]
var knightSkillTree: Array =[false,false,false]
var witchSkillTree: Array =[false,false,false]
var refinedSoul: int
var pureSoul: int
var saveDict: Dictionary = {
	"priestsave" = priestSkillTree,
	"knightsave" = knightSkillTree,
	"witchsave" = witchSkillTree,
	"refinedSoul" = refinedSoul,
	"pureSoul" = pureSoul
}

func _ready() -> void:
	loadData()
	
func saveData() -> void:
	editDict()
	print ("Saving Data: " + str(saveDict))
	var file = FileAccess.open(saveFile, FileAccess.WRITE)
	file.store_var(saveDict)

func editDict():
	saveDict = {
	"priestsave" = priestSkillTree,
	"knightsave" = knightSkillTree,
	"witchsave" = witchSkillTree,
	"refinedSoul" = refinedSoul,
	"pureSoul" = pureSoul
}

func loadData() -> void:
	if !FileAccess.file_exists(saveFile):
		print ("No Save Data Found")
		return
	else:
		var file = FileAccess.open(saveFile, FileAccess.READ)
		saveDict = file.get_var()
		print ("Loaded Save Data: " + str(saveDict))
		priestSkillTree = saveDict["priestsave"]
		knightSkillTree = saveDict["knightsave"]
		witchSkillTree = saveDict["witchsave"]
		refinedSoul = saveDict["refinedSoul"]
		pureSoul = saveDict["pureSoul"]
