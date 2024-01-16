extends Control

var paused: = false setget set_paused


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		self.paused = !paused
		get_tree().set_input_as_handled()
		
func set_paused(value: bool) -> void:
	paused = value
	get_tree().paused = value

func _input(event):
	if Input.is_action_just_pressed("wheelSelect"):
		$SelectionWheel.set_deferred("visible", true)
	if Input.is_action_just_released("wheelSelect"):
		$SelectionWheel.set_deferred("visible", false)
