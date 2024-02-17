extends Node2D

@export var oneTime: bool
@export var charRequired: int
@export var random: bool
@export var sequential: bool
var talking: bool
#can't be both sequential and random
@export var possilbleText: Array[String]

func _ready():
	randomize()

func _on_detection_area_body_entered(body):
	showText()


func showText():
	if !talking and (charRequired == 0 or PlayerAutoload.playerCharacter == charRequired):
		talking = true
		$TextBG.set_visible(true)
		if sequential:
			for i in range(len(possilbleText)):
				$TextBG/Text.text = possilbleText[i]
				$talkingTimer.start()
				await $talkingTimer.timeout
			talking = false
			if oneTime:
				queue_free()
		elif random:
			var beans = randi_range(0,len(possilbleText)-1)
			$TextBG/Text.text = possilbleText[beans]
			if oneTime:
				queue_free()