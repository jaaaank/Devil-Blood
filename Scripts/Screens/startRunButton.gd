extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_continue_pressed():
	PlayerAutoload.startRun()
	match PlayerAutoload.playerCharacter:
		1:get_tree().change_scene("res://Scenes/Maps/Exterior/Garrison.tscn")
		2:get_tree().change_scene("res://Scenes/Maps/Exterior/Garrison.tscn")
		3:get_tree().change_scene("res://Scenes/Maps/Exterior/Garrison.tscn")
		4:get_tree().change_scene("res://Scenes/Maps/Exterior/Garrison.tscn")
