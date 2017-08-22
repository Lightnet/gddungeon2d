extends Node2D

var bControl = true

var IsBuild = false
var IsPlace = false
var IsFixed = false
var IsSnap = false

var placeholder = null #item11

var block_Wall = preload("res://miniscenes/wall.tscn")
var block_floor = preload("res://miniscenes/floor.tscn")

func _ready():
	set_fixed_process(true)
	set_process_input(true)
	set_process(true)
	#set_process_unhandled_input(true)
	
func _process(delta):
	update() #update draw
	
func _fixed_process(delta):
	#var mouse_x = get_viewport().get_mouse_pos().x
	#var mouse_y = get_viewport().get_mouse_pos().y
	var mouse = get_global_mouse_pos()
	
	#print("Mouse Pos:" +str(mouse_x)+ " | " +str(mouse_y))
	get_node("textmousepos").set_text("Mouse x:" +str(mouse.x)+ " y:" +str(mouse.y))
	#print("update fixed")
	
func _input(event):
	#print("mouse press:" + str(event.type))
	if event.type == InputEvent.MOUSE_BUTTON && event.is_pressed():
		#print("mouse press")
		#print("mouse press:" + str(event.type) + " | "  +str(event.button_index))
		#var bmouseclick = get_node("/root/app/hud").bmouseclick
		var bmouseclick =  true
		
		if event.button_index == 1 && bmouseclick:
			#print("LEFT MOUSE PRESS")
			print("CLICKABLE")
			#var mousepos = get_viewport().get_mouse_pos()
			var mousepos = get_global_mouse_pos()
			
			var gx = floor(mousepos.x / 32) * 32
			var gy = floor(mousepos.y / 32) * 32
			placeholder = block_Wall
			
			if placeholder != null:
				var wallscene = placeholder.instance()
				wallscene.set_pos(Vector2(gx,gy))
				print("x:"+ str(gx) + " y:"+str(gy))
				get_node("/root/app/dungeonnode2d/dungeonlayout").add_child(wallscene)
			
		else:
			print("Not CLICKABLE")
			
func _unhandled_input(event):
	#print(str(event.ACTION))
	pass

func _draw():
	#your draw commands here
	#var mouse_x = get_viewport().get_mouse_pos().x
	#var mouse_y = get_viewport().get_mouse_pos().y
	var from = get_global_mouse_pos()
	#var from = get_viewport().get_mouse_pos()
	#var to =  get_viewport().get_mouse_pos()
	from.x = floor(from.x / 32) * 32
	from.y = floor(from.y / 32) * 32
	var to = from
	to.x += 32
	to.y += 32
	
	var tl = Vector2(min(to.x,from.x),min(to.y,from.y))
	var br = Vector2(max(to.x,from.x),max(to.y,from.y))
	var tr = Vector2(br.x,tl.y)
	var bl = Vector2(tl.x,br.y)
	var my = Rect2(tl, br-tl )
	#var my = Rect2(tl, br )
	draw_rect(my,Color(0,1,1,0.2))
	#draw_circle(from, 10, Color(0,1,1,0.2))
	#print("draw")
	#pass
