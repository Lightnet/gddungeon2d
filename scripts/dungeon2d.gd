extends Node2D

var bControl = true

var IsBuild = false
var IsPlace = false
var IsFixed = false
var IsSnap = false

var placeholder = null #item11

func _ready():
	set_fixed_process(true)
	set_process_input(true)
	
func _fixed_process(delta):
	var mouse_x = get_viewport().get_mouse_pos().x
	var mouse_y = get_viewport().get_mouse_pos().y
	#print("Mouse Pos:" +str(mouse_x)+ " | " +str(mouse_y))
	get_node("textmousepos").set_text("Mouse x:" +str(mouse_x)+ " y:" +str(mouse_y))
	
func _input(event):
	#print("mouse press:" + str(event.type))
	if event.type == InputEvent.MOUSE_BUTTON && event.is_pressed():
		#print("mouse press")
		print("mouse press:" + str(event.type) + " | "  +str(event.button_index))
		
		if event.button_index == 1:
			print("LEFT MOUSE PRESS")
			

