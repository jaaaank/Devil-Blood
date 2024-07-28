extends Node

var spawnPoint: int = 0: set = set_spawnPoint
#1=priest, 2=knight, 3=witch
var playerCharacter: int = 1: set = set_playerCharacter
#decides whether or not ALL knights on the map are agressive
var knightsAgressive: bool = false: set = set_knightsAgressive
var playerPos: Vector2 = Vector2(0,0): set = set_playerPos
var impureSoul: int = 0: set = set_impureSoul
var midRun: bool = false
var inventory: Array[itemType]
var inventorySize: = 3

# warning-ignore:unused_signal
signal interacted
signal player_dead

func _ready():
	get_window().set_min_size(Vector2(800,450))
	
func startRun():
	match playerCharacter:
		2:
			knightsAgressive = false
	
func winRun():
	SaveData.saveData()
	
func set_impureSoul(value: int):
	impureSoul = value
	get_player().find_child("UI").updateUI()
	
func get_player():
	return get_tree().root.get_child(3).get_node("PlayerSpawner").get_child(0)
	
func set_spawnPoint(value: int):
	spawnPoint = value
	
func set_knightsAgressive(value: bool):
	knightsAgressive = value
	
func set_playerCharacter(value: int):
	playerCharacter = value
	inventory.resize(inventorySize)
	
func set_playerPos(value: Vector2):
	playerPos=value
