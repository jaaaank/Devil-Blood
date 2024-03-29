extends Node

#0=morning 1=day 2=day 3=night
var cycletime: int = 0: set = set_cycletime
var spawnPoint: Vector2 = Vector2.ZERO: set = set_spawnPoint

func set_cycletime(value: int):
	cycletime = value

func set_spawnPoint(value: Vector2):
	spawnPoint = value
