extends Node

var spawnPoint: Vector2 = Vector2.ZERO: set = set_spawnPoint
var metRats: bool = false

func set_spawnPoint(value: Vector2):
	spawnPoint = value

func reset():
	metRats=false
