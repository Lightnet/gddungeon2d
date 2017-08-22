extends Panel

func _ready():
	connect("mouse_enter", self, "_mouse_enter")
	connect("mouse_exit", self, "_mouse_exit")
	pass
	
func _mouse_enter():
	get_node("/root/app/hud").bmouseclick = false
	print("enter")
	
func _mouse_exit():
	get_node("/root/app/hud").bmouseclick = true
	print("Exit")
	