extends Node


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
	
