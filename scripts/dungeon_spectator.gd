extends StaticBody2D
#https://godotengine.org/qa/625/not-looking-towards-mouse-cursor-when-using-moving-camera
export var bcontrol = true
export var move_speed = 10
export var dragscale = 5

var drag = false
var initPosCam = false
var initPosMouse = false
var initPosNode = false
var zoom = Vector2(1, 1)

func _ready():
	set_process_input(true)

#Input handler, listen for ESC to exit app
func _input(event):
	
	if !bcontrol:
		return
		
	if(event.type == InputEvent.KEY):
		var curPos = get_pos()
		if(event.scancode == KEY_A):
			curPos.x = curPos.x - move_speed
			#print(curPos.x)
			set_pos(Vector2(curPos.x,curPos.y))
			#pass
		if(event.scancode == KEY_D):
			curPos.x = curPos.x + move_speed
			#print(curPos.x)
			set_pos(Vector2(curPos.x,curPos.y))
			#pass
		if(event.scancode == KEY_S):
			curPos.y = curPos.y + move_speed
			#print(curPos.y)
			set_pos(Vector2(curPos.x,curPos.y))
			#pass
		if(event.scancode == KEY_W):
			curPos.y = curPos.y - move_speed
			#print(curPos.x)
			set_pos(Vector2(curPos.x,curPos.y))
			#pass
			
	if(event.is_pressed()):
		if(Input.is_key_pressed(KEY_ESCAPE)):
			get_tree().quit()
			#pass
			
	if (event.type == InputEvent.MOUSE_MOTION):
		if(drag == true):
			#var mouse_pos = get_global_mouse_pos()
			var mouse_pos = get_viewport().get_mouse_pos()
			var dis = mouse_pos - initPosMouse
			#print(dis)
			var point = initPosNode + (dis * zoom * dragscale)
			set_pos(point);
		elif(drag == false):
			# print("undrag")
			pass
	if (event.type == InputEvent.MOUSE_BUTTON):
		if (event.button_index == BUTTON_WHEEL_UP):
			# print("wheel up (event)")
			zoom[0] = zoom[0] + 0.25
			zoom[1] = zoom[1] + 0.25
		if (event.button_index == BUTTON_WHEEL_DOWN):
			# print("wheel down (event)")
			if(zoom[0] - 0.25 > 0 && zoom[1] - 0.25 > 0):
				zoom[0] = zoom[0] - 0.25
				zoom[1] = zoom[1] - 0.25
		if event.button_index == BUTTON_MIDDLE:
			if(Input.is_mouse_button_pressed(3)):
				print("button middle")
				initPosMouse = get_viewport().get_mouse_pos()
				initPosNode = get_pos()
				drag = true
			else:
				print("button middle release")
				drag = false
		get_node("Camera2D").set_zoom(zoom)
		#print("zoom")
func set_currentcamera():
	var camera2d = get_node("Camera2D")
	camera2d.make_current()
	