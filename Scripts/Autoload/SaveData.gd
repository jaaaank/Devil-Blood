extends Node
var saveFile: String = "user://playerData.txt"

var priestSkillTree: Array =[false,false,false]
var knightSkillTree: Array =[false,false,false]
var witchSkillTree: Array =[false,false,false]
var angelSkillTree: Array =[false,false,false]
var soulboundDevilBlood: int = 10

export(Dictionary) var saveDict = {
	priestsave = priestSkillTree,
	knightsave = knightSkillTree,
	witchsave = witchSkillTree,
	angelsave = angelSkillTree,
	devilblood = soulboundDevilBlood
}

func _ready() -> void:
	saveData()
	print("Original Data: ", saveDict)
	loadData()
	print("Altered Data: ", saveDict)
	
func saveData() -> void:
	editData()
	print ("Saving Data")
	var file = File.new()
	file.open(saveFile, File.WRITE)
	file.store_line(to_json(saveDict))
	file.close()
	
func editData() -> void:
	saveDict = {
	priestsave = priestSkillTree,
	knightsave = knightSkillTree,
	witchsave = witchSkillTree,
	angelsave = angelSkillTree,
	devilblood = soulboundDevilBlood
}

func loadData() -> void:
	var dataFile = File.new()
	if !dataFile.file_exists(saveFile):
		print ("No Save Data Found")
		return
	else:
		print ("Loading Save Data")
	dataFile.open(saveFile, File.READ)
	
	while dataFile.get_position() < dataFile.get_len():
		var nodeData = parse_json(dataFile.get_line())
		saveDict.priestsave = nodeData["priestsave"]
		saveDict.knightsave = nodeData["knightsave"]
		saveDict.witchsave = nodeData["witchsave"]
		saveDict.angelsave = nodeData["angelsave"]
		saveDict.devilblood = nodeData["devilblood"]
	dataFile.close()
