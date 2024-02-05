extends Control

var paused: = false: set = set_paused
@onready var healthbar= $CanvasLayer/HealthBar


# Called when the node enters the scene tree for the first time.
func _ready():
	healthbar.max_value = get_parent().health
	updateUI()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		self.paused = !paused
		get_viewport().set_input_as_handled()
		
func set_paused(value: bool) -> void:
	paused = value
	if paused:
		$CanvasLayer/PauseMenu.set_deferred("visible", true)
	else:
		$CanvasLayer/PauseMenu.set_deferred("visible", false)
	get_tree().paused = value

func _input(_event):
	if Input.is_action_just_pressed("wheelSelect"):
		$SelectionWheel.set_deferred("visible", true)
	if Input.is_action_just_released("wheelSelect"):
		$SelectionWheel.set_deferred("visible", false)

func updateUI():
	healthbar.value = get_parent().health
