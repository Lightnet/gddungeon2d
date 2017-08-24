extends Panel

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_VButtonArray_button_selected( button_idx ):
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
	
	pass # replace with function body
