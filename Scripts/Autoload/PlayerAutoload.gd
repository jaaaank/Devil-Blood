extends Node

#1=priest, 2=knight, 3=witch, 4=angel
var playerCharacter: int = 0 setget set_playerCharacter
var knightsAgressive: bool = true setget set_knightsAgressive
signal knightsAgressive

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func set_knightsAgressive(value: bool) -> void:
	knightsAgressive = value
	emit_signal("knightsAgressive")
	
func set_playerCharacter(value: int) -> void:
	playerCharacter = value
	
