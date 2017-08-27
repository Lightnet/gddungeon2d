extends RigidBody2D

var bupdate_creaturecount = false;
var time = 0
var timemax = 10

func _ready():
	set_process(true)
	#pass
func _process(delta):
	if !bupdate_creaturecount:
		return
		
	time += 1
	if time > timemax:
		time = 0
		bupdate_creaturecount = false
		print("update")
		update_creatures()
		
		
func _on_dungeon_exit_body_enter( body ):
	if body.is_in_group("creature"):
		if body.is_adventurer:
			print("FOUND!")
			body.queue_free()
			bupdate_creaturecount = true
			#pass
	#pass

func update_creatures():
	var global = get_node("/root/global")
	global.total_creatures();