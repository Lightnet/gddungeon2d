extends Button

func _ready():
	set_process_input(true)
	
func _input(event):
	#print("event.type", event)
		if (event.type == InputEvent.MOUSE_MOTION):
			var name = get_name()
			if is_visible():
				if get_global_rect().has_point(get_global_mouse_pos()):
					#print("FOUND!",get_global_rect(),get_global_mouse_pos())
					get_node("/root/global").panels[name] = true
				else:
					get_node("/root/global").panels[name] = false
			else:
				get_node("/root/global").panels[name] = false
