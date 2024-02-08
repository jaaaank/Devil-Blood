extends Node

var spawnPoint: int = 0: set = set_spawnPoint

#1=priest, 2=knight, 3=witch, 4=angel
var playerCharacter: int = 1: set = set_playerCharacter
var player
#decides whether or not ALL knights on the map are agressive
var knightsAgressive: bool = false: set = set_knightsAgressive
var playerPos: Vector2 = Vector2(0,0): set = set_playerPos
var difficulty: float = 1.0: set = set_difficulty
var devilBlood: int = 0: set = set_devilBlood
var inventory: Array[itemType]
var inventorySize: = 3

# warning-ignore:unused_signal
signal interacted
signal player_dead

func startRun():
	if playerCharacter==2:
		knightsAgressive = false
	else:
		knightsAgressive = true
	#player = get_tree().root.get_child(3).get_node("PlayerSpawner").get_child(0)
	

func winRun():
	SaveData.savedDevilBlood += devilBlood
	set_devilBlood(0)
	SaveData.saveData()
	
func charDie():
	if playerCharacter==2:
		knightsAgressive = false
	else:
		knightsAgressive = true
	emit_signal("player_dead")
	set_devilBlood(0)
		
func set_devilBlood(value: int):
	set_difficulty(1.0 + (value * 0.11))
	devilBlood = value

func set_spawnPoint(value: int):
	spawnPoint = value

func set_difficulty(value: float):
	difficulty = value
	
func set_knightsAgressive(value: bool):
	knightsAgressive = value
	
func set_playerCharacter(value: int):
	playerCharacter = value
	inventory.resize(inventorySize)
	
func set_playerPos(value: Vector2):
	playerPos=value
