extends Node

#http://docs.godotengine.org/en/stable/learning/step_by_step/singletons_autoload.html
# scene
var current_scene = null
# gui mouse check if over layer and visiable
var panels = {}
# characters 
var creatures = []
var creature_count = 0
var adventurers = []
var adventurer_count = 0

#current monster that you control last selected
var lastcreaturecontrol = null

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child( root.get_child_count() -1 )
	
func set_creature(value):
	lastcreaturecontrol = value
	
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
	
#mouse check click
func detect_mouse_panel():
	var bfound = false
	#print("ispanel======",panels)
	for panel in panels:
		#print("ispanel: ",panels[panel]," Name:",panel)
		#print("ispanel: > ",panels[panel])
		if panels[panel]:
			bfound = true
			break
	return bfound
	
func total_creatures():
	var creaturecount = 0 
	var adveturercount = 0
	
	var creatures = get_tree().get_nodes_in_group("creature")
	for creature in creatures:
		if creature.is_adventurer:
			adveturercount += 1
		else:
			creaturecount += 1
		#print(creature)
	var hud = get_node("/root/app/hud")
	hud.set_creaturecount(creaturecount)
	hud.set_adventurercount(adveturercount)
	creature_count = creaturecount
	creature_count = adveturercount
	adveturercount = null
	adveturercount = null
	
func updatecontroldisplay():
	var hud = get_node("/root/app/hud")
	hud.updatecontroldisplay()
	
func CreatureControlOff():
	var creatures = get_tree().get_nodes_in_group("creature")
	for creature in creatures:
		creature.bcontrol = false
	
	var hud = get_node("/root/app/hud")
	hud.bControlCreature = false
	
func get_ControlSelect():
	var hud = get_node("/root/app/hud")
	return hud.bControlCreature