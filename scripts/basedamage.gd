extends RigidBody2D

var creator = null
export var damage = 10
var damgetype = null
export var teamid = 0
var time = 0
var maxtime = 2

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
			#print(group)
			#print("teamid:" + str(teamid) + "  | " + str(body.teamid))
			if group == "creature":
				if body.teamid != teamid && teamid != 0:
					#print("teamid",teamid,body.teamid)
					body.Damage(creator,damage,damgetype)
					queue_free()
					
				elif (teamid == 0) && (body != creator):
					#print("teamid",teamid,body.teamid)
					body.Damage(creator,damage,damgetype)
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