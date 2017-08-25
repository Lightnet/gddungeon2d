extends CanvasLayer

var boption = false
var bmouseclick = true

var PANEL_STATUS = null
var PANEL_TRAP = null
var PANEL_BUILD = null
var PANEL_CREATURE = null
var PANEL_ADVENTURER = null
var PANEL_SUMMON = null
var PANEL_SKILLS = null
var PANEL_HELP = null

var DUNGEON = null

func _ready():
	#get_node("/root/app/hud/btnmenu").hide()
	get_node("/root/app/hud/Control/btnmenu").hide()
	get_node("/root/app/hud/Control/paneloptions").hide()
	
	PANEL_STATUS = get_node("Control/panelstatus")
	PANEL_BUILD = get_node("Control/panelblocks")
	PANEL_TRAP = get_node("Control/paneltraps")
	PANEL_CREATURE = get_node("Control/panelcreatures")
	PANEL_ADVENTURER = get_node("Control/paneladventurers")
	PANEL_SUMMON = get_node("Control/panelsummons")
	PANEL_SKILLS = get_node("Control/panelskills")
	PANEL_HELP = get_node("Control/panelhelp")
	
	DUNGEON = get_node("/root/app/dungeonnode2d")
	
	get_tree().get_root().connect("size_changed", self, "_sizechange")
	
	var control = get_node("Control")
	#getallnodes_mouse(control)
	connect_node_and_children(control, "mouse_enter", self, "_on_mouse_enter")
	connect_node_and_children(control, "mouse_exit", self, "_on_mouse_exit")
	trapupdatelist()
	
func connect_node_and_children(node, string_signal, target, string_method):
	if node.is_type("Control"):
		node.connect(string_signal, target, string_method)
	else:
		node.connect(string_signal, target, string_method)
	for child in node.get_children():
		connect_node_and_children(child, string_signal, target, string_method)
		
func _on_mouse_enter():
	#print("mouse enter")
	bmouseclick = false;
	
func _on_mouse_exit():
	#print("mouse exit")
	bmouseclick = true
	
func trapupdatelist():
	var btnstraps = get_node("Control/paneltraps/VBoxContainer/btnstraps")
	if btnstraps != null:
		#print("FOUND ARRAY")
		btnstraps.clear()
		btnstraps.add_button("Door","")
		btnstraps.add_button("Spike","")
		#btnstraps.add_button("Pit Fall","")
		#btnstraps.add_button("Arrows","")
		#btnstraps.add_button("Darts","")
		#btnstraps.add_button("Rolling Boulder","")
		
func _sizechange():
	#print("Resizing: ...")
	#print("Resizing: ", get_viewport().get_rect().size)
	#scale base percent in (0 - 1.0)
	var width = Globals.get("display/width")
	var height = Globals.get("display/height")
	var wx = get_viewport().get_rect().size.x / width;
	var wy = get_viewport().get_rect().size.y / height;
	#print("width:" + str(wx) + " height:" + str(wy))
	set_scale(Vector2(wx,wy))
	
func _on_btnworld_pressed():
	get_node("/root/app").hide_scenes()
	get_node("/root/app").show_ground()
	
func _on_btndungoen_pressed():
	get_node("/root/app").hide_scenes()
	get_node("/root/app").show_dungeon()
	
func _on_btnclose_pressed():
	get_node("/root/app/hud/Control/PanelDungeonAccess").hide()
	get_node("/root/app/hud/Control/btnmenu").show()
	
func _on_btnmenu_pressed():
	get_node("/root/app/hud/Control/PanelDungeonAccess").show()
	get_node("/root/app/hud/Control/btnmenu").hide()
	
func toggleoption():
	if boption:
		get_node("/root/app/hud/Control/paneloptions").hide()
		boption = false
	else:
		boption = true
		get_node("/root/app/hud/Control/paneloptions").show()
		
func _on_btnoptions_pressed():
	toggleoption()
	
func _on_VButtonArray_button_selected( button_idx ):
	print("LIST:"+str(button_idx))
	
func _on_btntrapsclose_pressed():
	PANEL_TRAP.hide()
	
func _on_btnblockclose_pressed():
	PANEL_BUILD.hide()
	DUNGEON.bControl = false
	
func _on_btncreatureclose_pressed():
	PANEL_CREATURE.hide()
	
func _on_btnsummonclose_pressed():
	PANEL_SUMMON.hide()
	
func _on_btnadventurerclose_pressed():
	PANEL_ADVENTURER.hide()
	
func _on_btntraps_pressed():
	if PANEL_TRAP.is_visible():
		PANEL_TRAP.hide()
	else:
		PANEL_TRAP.show()
		
func _on_btnbuild_pressed():
	DUNGEON = get_node("/root/app/dungeonnode2d")
	if PANEL_BUILD.is_visible():
		PANEL_BUILD.hide()
		DUNGEON.bControl = false
	else:
		PANEL_BUILD.show()
		DUNGEON.bControl = true
		
func _on_btncreatures_pressed():
	if PANEL_CREATURE.is_visible():
		PANEL_CREATURE.hide()
	else:
		PANEL_CREATURE.show()
		
func _on_btnsummon_pressed():
	if PANEL_SUMMON.is_visible():
		PANEL_SUMMON.hide()
	else:
		PANEL_SUMMON.show()
		
func _on_btnadventurers_pressed():
	if PANEL_ADVENTURER.is_visible():
		PANEL_ADVENTURER.hide()
	else:
		PANEL_ADVENTURER.show()
	
func _on_btnstatus_pressed():
	if PANEL_STATUS.is_visible():
		PANEL_STATUS.hide()
	else:
		PANEL_STATUS.show()
		
func _on_btnstatusclose_pressed():
	PANEL_STATUS.hide()
	
func _on_btnskillsclose_pressed():
	PANEL_SKILLS.hide()
	
func _on_btnabilities_pressed():
	if PANEL_SKILLS.is_visible():
		PANEL_SKILLS.hide()
	else:
		PANEL_SKILLS.show()


	"""
func getallnodes_mouse(node):
	for N in node.get_children():
		if N.get_child_count() > 0:
			print("["+N.get_name()+"]")
			getallnodes_mouse(N)
		else:
			# Do something
			print("- "+N.get_name())
"""

func _on_VButtonArray_input_event( ev ):
	#print("...")
	bmouseclick = false;
	#pass # replace with function body
	
func _on_input_event( ev ):
	#print("...")
	bmouseclick = false;
	pass # replace with function body
	
func _on_VBtnBuildArray_button_selected( button_idx ):
	var dungeon = get_node("/root/app/dungeonnode2d");
	if dungeon == null:
		return
	#dungeon.placeholder = 
	if button_idx == 0:
		print("None")
		dungeon.blockid = -1 #remove tileset
	if button_idx == 1:
		print("Wall")
		dungeon.blockid = 0 #add wall tileset
	if button_idx == 2:
		print("Floor")
		dungeon.blockid = 1 #add floor tileset
		
func _on_btnshelp_pressed():
	if PANEL_HELP.is_visible():
		PANEL_HELP.hide()
	else:
		PANEL_HELP.show()
		
func _on_btnhelpclose_pressed():
	PANEL_HELP.hide()
