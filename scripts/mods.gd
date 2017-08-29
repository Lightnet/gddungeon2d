extends Node

var MOD_PATH = "res://mods"

func _ready():
	dir_contents(MOD_PATH)
	pass

func dir_contents(path):
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while (file_name != ""):
			if dir.current_is_dir():
				#print("Found directory: " + file_name)
				pass
			else:
				#print("Found file: " + file_name)
				pass
			file_name = dir.get_next()
	else:
		#print("An error occurred when trying to access the path.")
		pass
	pass