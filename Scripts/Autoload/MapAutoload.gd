extends Node

var spawnPoint: Vector2 = Vector2.ZERO: set = set_spawnPoint
@onready var music: AudioStreamPlayer = $Music

func set_spawnPoint(value: Vector2):
	spawnPoint = value

func reset():
	pass

func changeMusic(toPlay):
	if toPlay == null:
		music.stop()
		return
	elif toPlay != music.stream:
		music.stream = toPlay
		music.play()
