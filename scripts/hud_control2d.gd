extends Control

var game_class = preload("res://scripts/savegame.gd")
var game = null

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process_input(true)
	game = game_class.new()
	#pass
	
func _input(event):
	var lmouse = get_node("LMouse")
	#print("mouse")
	if lmouse != null:
		lmouse.set_text("Mouse x:" + str(get_global_mouse_pos().x)  + " y:"  + str(get_global_mouse_pos().y))


func _on_btnload_pressed():
	var save = get_node("/root/save")
	save.load_game()
	#var nodes_to_save = get_tree().get_nodes_in_group("persistent")
	#for node in nodes_to_save:
		##node.set_global_pos(Vector2(0,0))
		#node.set_phy_pos(Vector2(0,0))
		#print(node.get_name())
	#pass
	
func _on_btnsave_pressed():
	var save = get_node("/root/save")
	print("save!")
	save.save_game()
	#pass
