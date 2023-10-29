extends Node


var spawnPoint: int = 0 setget set_spawnPoint
var health: int = 100 setget set_playerHealth
var armor: int = 0 setget set_playerArmor
#1=priest, 2=knight, 3=witch, 4=angel
var playerCharacter: int = 1 setget set_playerCharacter
#decides whether or not ALL knights on the map are agressive
var knightsAgressive: bool = true setget set_knightsAgressive
var playerPos: Vector2 = Vector2(0,0) setget set_playerPos
var difficulty: float = 1.0 setget set_difficulty
var soul: int = 0 setget set_soul
var devilBlood: int = 0 setget set_devilBlood

signal interact
signal player_damaged
signal player_dead

func _ready():
	startRun(0) 

func startRun(addedArmor):
	match playerCharacter:
		1:
			set_playerHealth(80)
			set_playerArmor(0+addedArmor)
		2:
			set_playerHealth(100)
			set_playerArmor(20+addedArmor)
		3:
			set_playerHealth(70)
			set_playerArmor(0+addedArmor)
		4:
			set_playerHealth(100)
			set_playerArmor(10+addedArmor)
	if playerCharacter==2:
		knightsAgressive = false
	else:
		knightsAgressive = true
	soul = 0
	devilBlood = 0


func finishRun():
	SaveData.savedDevilBlood += devilBlood
	SaveData.savedSoul += soul

func charDie():
	if playerCharacter==2:
		knightsAgressive = false
	else:
		knightsAgressive = true
	soul = 0
	devilBlood = 0
	emit_signal("player_dead")

func damage(damageTaken: float):
	set_playerHealth(round(health - damageTaken*armorCalculation()*difficulty))
	emit_signal("player_damaged", damageTaken)
	print("Player damaged; Health = " + String(health))
	
func heal(healingFactor: float):
	set_playerHealth(round(health + healingFactor/difficulty))
	print("Healed; Health = " + String(health))

func armorCalculation():
	if armor !=0:
		return (abs(armor-100)*0.01)
	else: return 1

func set_soul(value: int):
	soul = value
	
func set_devilBlood(value: int):
	match value:
		3:
			difficulty = 1.2
		6:
			difficulty = 1.3
		10:
			difficulty = 1.5
		15:
			difficulty = 1.8
		20: 
			difficulty = 2.2
		25:
			difficulty = 2.7
		30: 
			difficulty = 3.0
	devilBlood = value

func set_spawnPoint(value: int):
	spawnPoint = value
	
func set_playerHealth(value: int):
	health = value
	if health <=0:
		charDie()

func set_playerArmor(value: int):
	armor = value
	
func set_difficulty(value: float):
	difficulty = value
	
func set_knightsAgressive(value: bool):
	knightsAgressive = value
	
func set_playerCharacter(value: int):
	playerCharacter = value
	
func set_playerPos(value: Vector2):
	playerPos=value
