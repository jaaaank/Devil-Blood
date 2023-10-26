extends Node


var spawnPoint: int = 0 setget set_spawnPoint
var health: int = 100 setget set_playerHealth
#1=priest, 2=knight, 3=witch, 4=angel
var playerCharacter: int = 3 setget set_playerCharacter
#decides whether or not ALL knights on the map are agressive
var knightsAgressive: bool = true setget set_knightsAgressive
var playerPos: Vector2 = Vector2(0,0) setget set_playerPos
var soul: int = 0 setget set_soul

signal knightsAgressive
signal interact

func _ready():
	pass 

func startRun():
	if playerCharacter==2:
		knightsAgressive = false
	soul = 0

func heal(healingFactor: float):
	set_playerHealth(health + healingFactor)

func set_soul(value: int):
	soul = value

func set_spawnPoint(value: int):
	spawnPoint = value
	
func set_playerHealth(value: int):
	health = value
	
func set_knightsAgressive(value: bool):
	knightsAgressive = value
	emit_signal("knightsAgressive")
	
func set_playerCharacter(value: int):
	playerCharacter = value
	
func set_playerPos(value: Vector2):
	playerPos=value
