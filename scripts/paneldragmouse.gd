extends Panel
#Used root global node to assign panel if mouse in region
var path_global = "/root/global"

var global
var name 
var bpanel = false

var status = "none"
var offset=Vector2()
var mpos=Vector2()

var brect = false

func _ready():
	set_process_input(true)
	
func _input(event):
	#print("event.type", event)
	if global == null:
		name = get_name()
		global = get_node(path_global)
	
	if !is_visible():
		#make sure the status is release since it still run when toggle
		status="released"
		global.panels[name] = false
		return
		
	if event.type == InputEvent.MOUSE_BUTTON and event.button_index == BUTTON_LEFT and event.is_pressed() and status != "dragging":
		#var evpos=event.global_pos
		#get global pos from panel and mouse
		var evpos=get_global_mouse_pos()
		var gpos=get_global_pos()
		#check for panel rect with mouse in global
		if get_global_rect().has_point(get_global_mouse_pos()):
			status="clicked"
			#offset from panel pos to mouse pos subtract
			offset=gpos-evpos
		
	if status=="clicked" and event.type == InputEvent.MOUSE_MOTION:
		status="dragging"
		
	if status=="dragging" and event.type == InputEvent.MOUSE_BUTTON and event.button_index == BUTTON_LEFT:
		if not event.is_pressed():
			status="released"
		
	if status == "dragging":
		set_global_pos(mpos + offset)
		#set_global_pos(get_global_mouse_pos())
		print("drag!")
		
	#mpos=event.global_pos
	mpos=get_global_mouse_pos()
	
	if (event.type == InputEvent.MOUSE_MOTION):
		var name = get_name()
		if is_visible():
			if get_global_rect().has_point(get_global_mouse_pos()):
				#print("FOUND!",get_global_rect(),get_global_mouse_pos())
				bpanel = true
			else:
				bpanel = false
		else:
			bpanel = false
		global.panels[name] = bpanel