extends Node

#http://docs.godotengine.org/en/stable/learning/step_by_step/singletons_autoload.html

var current_scene = null

var panels = {}

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child( root.get_child_count() -1 )
	
func goto_scene(path):

	# This function will usually be called from a signal callback,
	# or some other function from the running scene.
	# Deleting the current scene at this point might be
	# a bad idea, because it may be inside of a callback or function of it.
	# The worst case will be a crash or unexpected behavior.

	# The way around this is deferring the load to a later time, when
	# it is ensured that no code from the current scene is running:

	call_deferred("_deferred_goto_scene",path)

func _deferred_goto_scene(path):

	# Immediately free the current scene,
	# there is no risk here.
	current_scene.free()

	# Load new scene
	var s = ResourceLoader.load(path)

	# Instance the new scene
	current_scene = s.instance()

	# Add it to the active scene, as child of root
	get_tree().get_root().add_child(current_scene)

	# optional, to make it compatible with the SceneTree.change_scene() API
	get_tree().set_current_scene( current_scene )
	
func detect_mouse_panel():
	var bfound = false
	print("ispanel======",panels)
	for panel in panels:
		print("ispanel: > ",panels[panel])
		if panels[panel]:
			bfound = true
			break
	return bfound
	
	
	
	
	
	
	
	