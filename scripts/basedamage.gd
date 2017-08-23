extends RigidBody2D

var teamid = 0

var time = 0
var maxtime = 1

func _ready():
	set_fixed_process(true)
	set_process(true)
	#pass
	
func _process(delta):
	time += 1
	if time > maxtime:
		queue_free() 
		#pass
	
	
func _fixed_process(delta):
	var bodies = get_colliding_bodies()
	
	for body in bodies:
		for group in body.get_groups():
			#print("creature")
			print(group)
			print("teamid:" + str(teamid) + "  | " + str(body.teamid))
			if group == "creature":
				if body.teamid != teamid && teamid != 0:
					body.Damage()
					queue_free()
					break
				elif teamid == 0:
					body.Damage()
					queue_free()
		
		#creature
		#if body.get_nodes_in_group("creature"):
		#if body.get_groups("creature"):
			#body.get_groups("creature")
			#queue_free()
			
		#if body.get_name() == "creature":
			#print("FOUND!")
			#do something here
			
			#delete this object
			#queue_free()