extends CanvasLayer

var boption = false
var bmouseclick = true

func _ready():
	#get_node("/root/app/hud/btnmenu").hide()
	get_node("/root/app/hud/Control/btnmenu").hide()
	get_node("/root/app/hud/Control/paneloptions").hide()
	#var paneloptions = get_node("/root/app/hud/paneloptions");
	#connect("mouse_enter",paneloptions, "_mouse_enter")
	#var panelblocks = get_node("panelblocks");
	#connect("mouse_enter", panelblocks, "_mouse_enter")
	#connect("mouse_exit", panelblocks, "_mouse_exit")
	get_tree().get_root().connect("mouse_enter", self, "_mouse_enter")
	#pass
	
func _mouse_enter():
	print("enter gui?")
func _mouse_exit():
	print("Exit gui")

func _on_btnworld_pressed():
	get_node("/root/app").hidesense()
	get_node("/root/app").show_ground()
	
func _on_btndungoen_pressed():
	get_node("/root/app").hidesense()
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
	pass # replace with function body
	
func _on_btnstatus_pressed():
	print("status")
	pass # replace with function body
	
func _on_mouse_enter():
	#print("enter")
	bmouseclick = false;
	#pass # replace with function body
	
func _on_mouse_exit():
	#print("exit")
	bmouseclick = true
	#pass # replace with function body
	