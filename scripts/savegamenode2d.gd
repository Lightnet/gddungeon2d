extends Node2D

# http://docs.godotengine.org/en/stable/learning/features/misc/saving_games.html

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

# Note: This can be called from anywhere inside the tree.  This function is path independent.
# Go through everything in the persist category and ask them to return a dict of relevant variables

func save_game():
	var savegame = File.new()
	savegame.open("user://savegame.save", File.WRITE)
	savegame.store_line("test file me")
	savegame.close()
	
# Note: This can be called from anywhere inside the tree.  This function is path independent.
func load_game():
	var savegame = File.new()
	if !savegame.file_exists("user://savegame.save"):
		print("No File Exist!")
		return #Error!  We don't have a save to load
		
	# Load the file line by line and process that dictionary to restore the object it represents
	var currentline = {} # dict.parse_json() requires a declared dict.
	savegame.open("user://savegame.save", File.READ)
	print("line:",savegame.get_line())
	currentline.parse_json(savegame.get_line())
	
	
	savegame.close()
	

	

func _on_btnsave_pressed():
	save_game()
	#pass # replace with function body

func _on_btnload_pressed():
	load_game()
	#pass # replace with function body
