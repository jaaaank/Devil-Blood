extends Node2D

var talking: bool
@export var charRequired: int
@export var random: bool
@export var sequential: bool
#Can't be both sequential and random
@export var waitTime: float = 2
@onready var textBox: RichTextLabel = $CanvasLayer/Text
@export_multiline var possilbleText: Array[String]

func _ready():
	randomize()
	$talkingTimer.wait_time = waitTime
	
func _physics_process(delta):
	textBox.visible_characters += delta*70
	
func showText(_body):
	textBox.visible_characters = 0
	if !talking and (charRequired == 0 or PlayerAutoload.playerCharacter == charRequired):
		talking = true
		textBox.set_visible(true)
		textBox.get_node("TextBG").size = textBox.size
		if sequential:
			for i in range(len(possilbleText)):
				say(possilbleText[i])
				textBox.get_node("TextBG").size = textBox.size
				$talkingTimer.start()
				await $talkingTimer.timeout
			talking = false
		elif random:
			var beans = randi_range(0,len(possilbleText)-1)
			say(possilbleText[beans])
			textBox.get_node("TextBG").size = textBox.size
		hideText(null)

func ask(op1: String, op2: String):
	$CanvasLayer/Text/Buttons/op1.text = op1
	$CanvasLayer/Text/Buttons/op2.text = op2
	$CanvasLayer/Text/Buttons.set_visible(true)

func say(words: String):
	textBox.visible_characters = 0
	textBox.text = "[color=" +get_parent().dialogueColor+"]" + get_parent().dialogueName + ": [/color]" + words
	print("spoke")
	talking = true
	textBox.set_visible(true)
	textBox.get_node("TextBG").size = textBox.size
	
func hideText(_body):
	talking = false
	textBox.set_visible(false)
