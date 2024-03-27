extends Control

const SPRITE_SIZE = Vector2(16,16)

@export var bkg_clr: Color
@export var highclr: Color
@export var radius: int = 256
@export var width: int = 128
@export var linewidth: int = 32
@export var line_clr: Color
@export var empty: itemType

@export var slots: Array[itemType]
var select = 0

func _ready():
	slots = PlayerAutoload.inventory

func _draw():
	var offset = SPRITE_SIZE/-2
	draw_arc(Vector2.ZERO, radius, 0, TAU, 128, bkg_clr, width, true)
	for i in range(len(slots)):
		var rads = TAU * i/len(slots)
		var point = Vector2.from_angle(rads)
		@warning_ignore("integer_division")
		draw_line(point * (radius+width/2), point * (radius-width/2), line_clr, linewidth)
	for i in range(0,len(slots)):
		var start_rads = (TAU*(i-1)/len(slots))
		var end_rads = (TAU * (i)/len(slots))
		var mid_rads = (start_rads + end_rads)/2.0
		if select == i and slots[i]!=null:
			#var poi_per_arc = 32
			#var poiinner = PackedVector2Array()
			#var poiouter = PackedVector2Array()
			#for j in range(poi_per_arc):
				#var angle = start_rads + j *(end_rads-start_rads)/poi_per_arc
				#poiinner.append((radius-width/2)* Vector2.from_angle(TAU-angle))
				#poiouter.append((radius+width/2)* Vector2.from_angle(TAU-angle))
			#poiouter.reverse()
			#draw_polygon(poiinner+poiouter, PackedColorArray([highclr]))
			draw_arc(Vector2.ZERO,radius,start_rads,end_rads,128,highclr,width)
		if slots[i] != null:
			var draw_pos = radius * Vector2.from_angle(mid_rads) + offset*3
			draw_texture_rect_region(slots[i].atlas, Rect2(draw_pos, SPRITE_SIZE*3), slots[i].region)
		
func _process(_delta):
	var mouse_pos = get_local_mouse_position()
	var _mouse_radius = mouse_pos.length()
	var mouse_rads = fposmod(mouse_pos.angle(), TAU)
	select = floorf((mouse_rads/TAU) * (len(slots))) +1
	if select == len(slots): select= 0
	#print(select)
	queue_redraw()
	
func _input(_event):
	if Input.is_action_just_pressed("attack") and !slots.is_empty() and visible and slots[select]!=null:
		print("itemused: " + slots[select].name)
		get_parent().get_parent().call("useItem", slots[select].id)
		slots[select] = null
		
