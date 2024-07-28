extends Node
var saveFile: String = "user://playerData.txt"

var priestSkillTree: Array =[true,true,true,true,true,true,true,true,true]
var knightSkillTree: Array =[false,false,false]
var witchSkillTree: Array =[false,false,false]
var unlockedPurchasables: Array = [null,true,false,false,false,false,false,false,false]
var refinedSoul: int
var pureSoul: int
var settings: Array = [false]
var saveDict: Dictionary = {
	"priestsave" = priestSkillTree,
	"knightsave" = knightSkillTree,
	"witchsave" = witchSkillTree,
	"unlockedPurchasables" = unlockedPurchasables,
	"refinedSoul" = refinedSoul,
	"pureSoul" = pureSoul,
	"settings" = settings
}
	
func saveData():
	editDict()
	print ("Saving Data: " + str(saveDict))
	var file = FileAccess.open(saveFile, FileAccess.WRITE)
	file.store_var(saveDict)

func editDict():
	saveDict = {
	"priestsave" = priestSkillTree,
	"knightsave" = knightSkillTree,
	"witchsave" = witchSkillTree,
	"unlockedPurchasables"= unlockedPurchasables,
	"refinedSoul" = refinedSoul,
	"pureSoul" = pureSoul,
	"settings" = settings
}

func loadData():
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
		unlockedPurchasables = saveDict["unlockedPurchasables"]
		refinedSoul = saveDict["refinedSoul"]
		pureSoul = saveDict["pureSoul"]
		settings = saveDict["settings"]
