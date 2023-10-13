tool
extends Control

onready var animP:= $AnimationPlayer
onready var lText:= $LocationName
export var locationName: String

# Called when the node enters the scene tree for the first time.
func _ready():
	lText.append_bbcode(locationName)
	animP.play("fadeinandout")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass

func _get_configuration_warning() -> String:
	return "LOCATION NAME EMPTY" if not locationName else ""
