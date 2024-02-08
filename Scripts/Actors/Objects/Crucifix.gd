extends Area2D



func _ready():
	pass # Replace with function body.

func _on_Crucifix_area_entered(area):
	area.get_parent().call("stun")

func _on_Crucifix_area_exited(area):
	area.get_parent().call("unstun")
