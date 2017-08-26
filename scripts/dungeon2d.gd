extends Node2D

enum {UNIT_NEUTRAL, UNIT_ENEMY, UNIT_ALLY}
#print(UNIT_ENEMY) # 0
enum {LIST_NONE,LIST_BLOCK,LIST_TRAP,LIST_CREATURE,LIST_SUMMON,LIST_SKILL,LIST_ADVENTURER}

var bControl = true
var IsBuild = false
var IsPlace = false
var IsFixed = false
var IsSnap = false
var placeholder = null #item11
var blockid = -1
#var block_Wall = preload("res://miniscenes/wall.tscn")
#var block_floor = preload("res://miniscenes/floor.tscn")

var Trap_spike = preload("res://traps/trap_spike.tscn")

var Summon_slime = preload("res://creatures/monsters/slime/slime01.tscn")

var buildtype = null

func _ready():
	print(LIST_ADVENTURER)
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
	if !bControl:
		return
		#pass
	if Input.is_key_pressed(KEY_Z):
		var cube = get_node("/root/app/dungeonnode2d/furniture/cube")
		cube.set_global_pos(Vector2(488,250))
		print("reset")
		
	if event.type == InputEvent.MOUSE_BUTTON && event.is_pressed():
		#print("mouse press")
		#print("mouse press:" + str(event.type) + " | "  +str(event.button_index))
		var ispanel = get_node("/root/global").detect_mouse_panel()
		#print("ispanel:",ispanel)
		if event.button_index == 1 && ispanel == false:
			#print("LEFT MOUSE PRESS")
			#print("CLICKABLE")
			if (blockid != -1) && (buildtype == LIST_BLOCK): #if -1 not to remove tile set
				#var mousepos = get_viewport().get_mouse_pos()
				dungeon_tileset()
				
			if (buildtype == LIST_TRAP):
				dungeon_trapset()
				
			if (buildtype == LIST_SUMMON):
				dungeon_summonset()
				
				
		else:
			#print("Not CLICKABLE")
			pass
			
#used mouse pos to assign tilesets
func dungeon_tileset():
	var mousepos = get_global_mouse_pos()
	var gx = floor(mousepos.x / 32) * 32
	var gy = floor(mousepos.y / 32) * 32
	var dungeontile = get_node("/root/app/dungeonnode2d/navigation2d/dungeontile")
	#print(dungeontile.get_tileset())
	#convert by mouse postion divide 32 grid to 32:1
	dungeontile.set_cell(gx/32 , gy/32 , blockid)
	#placeholder = block_Wall # test
	#placeblock(gx,gy)
	#for tile in dungeontile.get_tiles_ids():
		#print(str(tile))
func dungeon_trapset():
	var mousepos = get_global_mouse_pos()
	var gx = floor(mousepos.x / 32) * 32
	var gy = floor(mousepos.y / 32) * 32
	var dungeontraps = get_node("dungeontraps")
	
	print("size",get_tree().get_nodes_in_group("traps").size())
	
	print("TRAPS HERE")
	var traps = get_tree().get_nodes_in_group("trap")
	var current_pos = Vector2(gx,gy)
	var bfound = false
	
	for trap in traps:
		print(trap.get_global_pos())
		if trap.get_global_pos() == current_pos:
			print(trap.get_global_pos(),current_pos)
			bfound = true
			break
		
	if bfound:
		print("Same Postion!")
		return
		
	if blockid == 0:
		pass
	if blockid == 1:
		if(dungeontraps != null):
			var trap_spike = Trap_spike.instance()
			trap_spike.set_pos(Vector2(gx,gy))
			print("PLACE!")
			#add to scene in dungeontraps node
			dungeontraps.add_child(trap_spike)
			
func dungeon_summonset():
	var mousepos = get_global_mouse_pos()
	var gx = floor(mousepos.x / 32) * 32
	var gy = floor(mousepos.y / 32) * 32
	var dungeoncreatures = get_node("creatures")
	#Summon_slime
	if blockid == 1:
		var creature = Summon_slime.instance()
		creature.set_pos(Vector2(gx,gy))
		dungeoncreatures.add_child(creature)

func placeblock(gx,gy):
	if placeholder != null:
		var wallscene = placeholder.instance()
		wallscene.set_pos(Vector2(gx,gy))
		print("x:"+ str(gx) + " y:"+str(gy))
		get_node("/root/app/dungeonnode2d/dungeonlayout").add_child(wallscene)
		
#draw rect from mouse position
func _draw():
	var from = get_global_mouse_pos()
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
	draw_rect(my,Color(0,1,1,0.2))
	#draw_circle(from, 10, Color(0,1,1,0.2))
	#pass
