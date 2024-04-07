extends Control

var paused: = false: set = set_paused
@onready var healthBar= $CanvasLayer/TopLeftUI/HealthBar
@onready var soulCount= $CanvasLayer/TopLeftUI/SoulCount

# Called when the node enters the scene tree for the first time.
func _ready():
	healthBar.max_value = get_parent().health
	updateUI()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		set_paused(!paused)
		get_viewport().set_input_as_handled()
	
#button not working when actually in the scene for some reason
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
	healthBar.value = PlayerAutoload.health
	soulCount.text = "	Soul: " + str(PlayerAutoload.impureSoul)
