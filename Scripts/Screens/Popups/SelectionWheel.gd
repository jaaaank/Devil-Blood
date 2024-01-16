tool
extends Control

const SPRITE_SIZE = Vector2(16,16)

export var bkg_clr: Color
export var radius: int = 256
export var width: int = 128
export var linewidth: int = 32
export var line_clr: Color

export var slots: Array

func _draw():
	var offset = SPRITE_SIZE/-2
	draw_arc(Vector2.ZERO, radius, 0, TAU, 128, bkg_clr, width, true)
	for i in range(len(slots)):
		var rads = TAU * i/len(slots)
		var point = Vector2.RIGHT.rotated(rads)
# warning-ignore:integer_division
		draw_line(point * (radius+width/2), point * (radius-width/2), line_clr, linewidth, true)
		draw_texture_rect_region(slots[0].icon, Rect2(offset,SPRITE_SIZE), Rect2(offset,SPRITE_SIZE))
