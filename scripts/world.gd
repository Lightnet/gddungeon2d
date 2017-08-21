extends Node

const dungeon_scene = preload("res://scenes/dungeon.tscn")
const ground_scene = preload("res://scenes/ground.tscn")

var playername = "guest"

var creatures = []
var adventurers = []

func _ready():
	var ground = ground_scene.instance()
	var dungeon = dungeon_scene.instance()
	print("START?")
	#get_tree().get_root().add_child(ground)
	get_node("/root/world").add_child(ground)
	get_node("/root/world").add_child(dungeon)