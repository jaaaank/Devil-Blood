extends Node2D

@export var Priest: PackedScene
@export var Knight: PackedScene
@export var Witch: PackedScene
@export var Angel: PackedScene

func _ready():
	if MapAutoload.spawnPoint:
		set_position(MapAutoload.spawnPoint)
	else:
		print("spawnin")
		match PlayerAutoload.playerCharacter:
			1:
				add_child(Priest.instantiate())
			2:
				add_child(Knight.instantiate())
			3:
				add_child(Witch.instantiate())
			4:
				add_child(Angel.instantiate())
