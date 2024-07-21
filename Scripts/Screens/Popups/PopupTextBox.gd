extends Node2D

var talking: bool
@export var canHide: bool
@export var oneTime: bool
@export var charRequired: int
@export var random: bool
@export var sequential: bool
@export var waitTime: float = 2
#can't be both sequential and random
@export_multiline var possilbleText: Array[String]

func _ready():
	randomize()
	$talkingTimer.wait_time = waitTime
	
func showText(_body):
	if !talking and (charRequired == 0 or PlayerAutoload.playerCharacter == charRequired):
		talking = true
		$Text.set_visible(true)
		$Text/TextBG.size = $Text.size
		if sequential:
			for i in range(len(possilbleText)):
				$Text.text = "[center]"+possilbleText[i]
				$Text/TextBG.size = $Text.size
				$talkingTimer.start()
				await $talkingTimer.timeout
			talking = false
			if oneTime:
				queue_free()
		elif random:
			var beans = randi_range(0,len(possilbleText)-1)
			$Text.text = "[center]"+possilbleText[beans]
			$Text/TextBG.size = $Text.size
			if oneTime:
				queue_free()
		hideText(null)
		
func say(words: String):
	$Text.text = "[center]" + words
	talking = true
	$Text.set_visible(true)
	$Text/TextBG.size = $Text.size
	
func hideText(_body):
	if canHide:
		talking = false
		$Text.set_visible(false)
