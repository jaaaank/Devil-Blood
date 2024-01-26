@tool
extends Control

@onready var animP:= $AnimationPlayer
@onready var lText:= $LocationName
@export var locationName: String

func _ready():
	lText.append_text(locationName)
	animP.play("fadeinandout")

