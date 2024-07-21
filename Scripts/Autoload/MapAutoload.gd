extends Node

var spawnPoint: Vector2 = Vector2.ZERO: set = set_spawnPoint

func set_spawnPoint(value: Vector2):
	spawnPoint = value

func reset():
	pass

func changeMusic(music):
	if music == null:
		$AudioStreamPlayer.stop()
		return
	elif music!=$AudioStreamPlayer.stream:
		$AudioStreamPlayer.stream = music
		$AudioStreamPlayer.play()
