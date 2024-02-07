extends Node2D

@export var oneTime: bool
@export var charRequired: int
@export var random: bool
@export var sequential: bool
@export var possilbleText: Array[String]

func _ready():
	randomize()

func _on_detection_area_body_entered(body):
	showText()


func showText():
	if charRequired == 0 or PlayerAutoload.playerCharacter == charRequired:
		$TextBG/Text.set_visible(true)
		if sequential:
			for i in range(len(possilbleText)):
				$TextBG/Text.text = i
				#blah blah ill finish this later, wait a few seconds then display the next message
		if random:
			var beans = randi_range(0,len(possilbleText)-1)
			$TextBG/Text.text = possilbleText[beans]
			
			
		if oneTime:
			queue_free()
