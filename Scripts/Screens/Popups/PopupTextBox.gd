extends Node2D

var talking: bool
@export var canHide: bool
@export var oneTime: bool
@export var charRequired: int
@export var random: bool
@export var sequential: bool
@export var waitTime: float = 2
@onready var textBox: RichTextLabel = $CanvasLayer/Text
#can't be both sequential and random
@export_multiline var possilbleText: Array[String]

func _ready():
	randomize()
	$talkingTimer.wait_time = waitTime
	
func showText(_body):
	if !talking and (charRequired == 0 or PlayerAutoload.playerCharacter == charRequired):
		talking = true
		textBox.set_visible(true)
		textBox.get_node("TextBG").size = textBox.size
		if sequential:
			for i in range(len(possilbleText)):
				textBox.text = "[center]"+possilbleText[i]
				textBox.get_node("TextBG").size = textBox.size
				$talkingTimer.start()
				await $talkingTimer.timeout
			talking = false
			if oneTime:
				queue_free()
		elif random:
			var beans = randi_range(0,len(possilbleText)-1)
			textBox.text = "[center]"+possilbleText[beans]
			textBox.get_node("TextBG").size = textBox.size
			if oneTime:
				queue_free()
		hideText(null)
		
func say(words: String):
	textBox.text = "[center]" + words
	talking = true
	textBox.set_visible(true)
	textBox.get_node("TextBG").size = textBox.size
	
func hideText(_body):
	if canHide:
		talking = false
		textBox.set_visible(false)
