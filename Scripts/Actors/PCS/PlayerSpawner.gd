extends Node2D


export (PackedScene) var Priest
export (PackedScene) var Knight
export (PackedScene) var Witch
export (PackedScene) var Angel



func _ready():
	match PlayerAutoload.playerCharacter:
		1:
			get_tree().get_root().add_child(Priest.instance())
		2:
			get_tree().get_root().add_child(Knight.instance())
		3:
			get_tree().get_root().add_child(Witch.instance())
		4:
			get_tree().get_root().add_child(Angel.instance())
