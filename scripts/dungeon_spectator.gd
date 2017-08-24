extends StaticBody2D

#https://godotengine.org/qa/625/not-looking-towards-mouse-cursor-when-using-moving-camera

var drag = false
var dragscale = 5
var initPosCam = false
var initPosMouse = false
var initPosNode = false
var zoom = Vector2(1, 1)
#var BUTTON_MIDDLE = 3;

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	#get_viewport().get_camera().set_zoom(zoom)
	set_process_input(true)
	set_process(true)
	#pass

#Input handler, listen for ESC to exit app
func _input(event):
	if(event.type == InputEvent.KEY):
		var curPos = get_pos()
		if(event.scancode == KEY_A):
			curPos.x = curPos.x - 10
			#print(curPos.x)
			set_pos(Vector2(curPos.x,curPos.y))
			#pass
		if(event.scancode == KEY_D):
			curPos.x = curPos.x + 10
			#print(curPos.x)
			set_pos(Vector2(curPos.x,curPos.y))
			#pass
		if(event.scancode == KEY_S):
			curPos.y = curPos.y + 10
			#print(curPos.y)
			set_pos(Vector2(curPos.x,curPos.y))
			#pass
		if(event.scancode == KEY_W):
			curPos.y = curPos.y - 10
			#print(curPos.x)
			set_pos(Vector2(curPos.x,curPos.y))
			#pass
			
	if(event.is_pressed()):
		if(Input.is_key_pressed(KEY_ESCAPE)):
			get_tree().quit()
			
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
				#initPosMouse = get_global_mouse_pos()
				initPosMouse = get_viewport().get_mouse_pos()
				#initPosNode = get_node("camera2d").get_pos
				initPosNode = get_pos()
				drag = true
			else:
				print("button middle release")
				drag = false
		#get_node("camera").set_zoom(zoom)
		#get_viewport().get_camera().set_zoom(zoom)
		#set_zzoom(zoom)
		get_node("dungeon_cam2d").set_zoom(zoom)
		#print("zoom")
	