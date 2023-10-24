extends Node2D

export (PackedScene) var Priest
export (PackedScene) var Knight
export (PackedScene) var Witch
export (PackedScene) var Angel



func _ready():
	set_position(MapAutoload.spawnPoint)
	print("spawnin")
	match PlayerAutoload.playerCharacter:
		1:
			add_child(Priest.instance())
		2:
			add_child(Knight.instance())
		3:
			add_child(Witch.instance())
		4:
			add_child(Angel.instance())
