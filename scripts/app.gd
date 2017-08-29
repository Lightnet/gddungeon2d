extends Node

const dungeon_scene = preload("res://scenes/dungeon.tscn")
#const ground_scene = preload("res://scenes/world.tscn")
#const hud_scene = preload("res://ui/hud.tscn")

var Classes = load("res://scripts/classes.gd")

var dungeonscene = null;
var groundscene = null;
var hudscene = null;

#var gameinstance = null
func _ready():
	#print("START MAIN?")
	#gameinstance = get_node("/root/gameinstance")
	#center_window()
	Init_Scenes()
	#var test = Classes.Test.new()
	#print("test")
	#test.foo()
	
	
	
func Init_Scenes():
	#hudscene = hud_scene.instance()
	#get_node("/root/app").add_child(hudscene)
	#groundscene = ground_scene.instance()
	dungeonscene = dungeon_scene.instance()
	#groundscene.hide();
	#dungeonscene.hide();
	get_node("/root/app").add_child(groundscene)
	get_node("/root/app").add_child(dungeonscene)
	
func center_window():
	var screen_size = OS.get_screen_size()
	var window_size = OS.get_window_size()
	OS.set_window_position(screen_size*0.5 - window_size*0.5)
	
func hide_scenes():
	#if dungeonscene != null:
		#dungeonscene.hide()
	#if groundscene != null:
		#groundscene.hide()
	pass
		
func show_dungeon():
	if dungeonscene != null:
		dungeonscene.show();
		
func show_ground():
	#if groundscene != null:
		#groundscene.show()
	pass