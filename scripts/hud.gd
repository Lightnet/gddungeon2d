extends Control

var boption = false;

func _ready():
	get_node("/root/app/hud/btnmenu").hide()
	get_node("/root/app/hud/paneloptions").hide()
	pass

func _on_btnworld_pressed():
	get_node("/root/app").hidesense()
	get_node("/root/app").show_ground()
	
func _on_btndungoen_pressed():
	get_node("/root/app").hidesense()
	get_node("/root/app").show_dungeon()
	
func _on_btnclose_pressed():
	get_node("/root/app/hud/PanelDungeonAccess").hide()
	get_node("/root/app/hud/btnmenu").show()
	
func _on_btnmenu_pressed():
	get_node("/root/app/hud/PanelDungeonAccess").show()
	get_node("/root/app/hud/btnmenu").hide()
	
func toggleoption():
	if boption:
		get_node("paneloptions").hide()
		boption = false
	else:
		boption = true
		get_node("paneloptions").show()
		
func _on_btnoptions_pressed():
	toggleoption()


func _on_VButtonArray_button_selected( button_idx ):
	print("LIST:"+str(button_idx))
	pass # replace with function body


func _on_btnstatus_pressed():
	print("status")
	pass # replace with function body
