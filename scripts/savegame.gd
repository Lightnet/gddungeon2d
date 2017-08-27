extends Node

const SAVE_PATH = "res://save.json"
var _settings = {}

func _ready():
	pass

func save_game():
	#get all the save data from persistent nodes
	var save_dict = {}
	var nodes_to_save = get_tree().get_nodes_in_group("persistent")
	for node in nodes_to_save:
		save_dict[node.get_path()] = node.save()
	#create a file
	var save_file = File.new()
	save_file.open(SAVE_PATH, File.WRITE)
	#serialize the data dictionary to json
	save_file.store_line(save_dict.to_json())
	print(save_dict.to_json())
	#write the json to the file and save to disk
	save_file.close()
	print("save game?")
	#pass
	
func load_game():
	#try to load a save file
	var save_file = File.new()
	if not save_file.file_exists(SAVE_PATH):
		print("no file")
		return
	#parse the file data
	save_file.open(SAVE_PATH, File.READ)
	var data = {}
	data.parse_json(save_file.get_as_text())
	print(data)
	
	#load the data into persistent nodes
	for node_path in data.keys():
		var node = get_node(node_path)
		
		for attribute in data[node_path]:
			if attribute == "pos":
				#print(data[node_path]["pos"]["x"],":",data[node_path]["pos"]["y"])
				#custom pos set that it need to be in _fixed_process to update postion
				node.set_phy_pos(Vector2(data[node_path]["pos"]["x"],data[node_path]["pos"]["y"]))
				#phy doesn't set set_pos error ?
				#node.set_pos(Vector2(data[node_path]["pos"]["x"],data[node_path]["pos"]["y"]))
				#node.set_global_pos(Vector2(data[node_path]["pos"]["x"],data[node_path]["pos"]["y"]))
			else:
				node.set(attribute,data[node_path][attribute])
	#pass