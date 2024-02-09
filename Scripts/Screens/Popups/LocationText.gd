extends Control

@onready var animP:= $AnimationPlayer
@onready var lText:= $LocationName
@export var locationName: String

func _ready():
	lText.append_text(locationName)
	animP.play("fadeinandout")
	show()


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fadeinandout":
		queue_free()
