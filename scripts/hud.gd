extends Control

var boption = false;

func _ready():
	get_node("/root/app/hud/btnmenu").hide()
	get_node("/root/app/hud/paneloptions").hide()
	pass

func _on_btnworld_pressed():
	hidesense()
	show_ground()
	
func _on_btndungoen_pressed():
	hidesense()
	show_dungeon()
	
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
