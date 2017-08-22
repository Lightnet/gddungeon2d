extends Node

const dungeon_scene = preload("res://scenes/dungeon.tscn")
const ground_scene = preload("res://scenes/world.tscn")
const hud_scene = preload("res://ui/hud.tscn")

var dungeonscene = null;
var groundscene = null;
var hudscene = null;

var playername = "Guest"

var creatures = []
var adventurers = []

func _ready():
	#get_tree().get_root().add_child(ground)
	groundscene = ground_scene.instance()
	dungeonscene = dungeon_scene.instance()
	hudscene = hud_scene.instance()
	groundscene.hide();
	#dungeonscene.hide();
	get_node("/root/app").add_child(groundscene)
	get_node("/root/app").add_child(dungeonscene)
	get_node("/root/app").add_child(hudscene)
	#print("START?")

func hidesense():
	if dungeonscene != null:
		dungeonscene.hide()
	if groundscene != null:
		groundscene.hide()
		
func show_dungeon():
	if dungeonscene != null:
		dungeonscene.show();
		
func hide_dungeon():
	if dungeonscene != null:
		dungeonscene.hide()
		
func show_ground():
	if groundscene != null:
		groundscene.show()

func hide_ground():
	if groundscene != null:
		groundscene.hide()