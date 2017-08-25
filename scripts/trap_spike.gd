extends RigidBody2D

var teamid = 0
var btrigger = true

func _ready():
	set_fixed_process(true)
		
func _fixed_process(delta):
	var bodies = get_colliding_bodies()
	
	for body in bodies:
		print("hit")
		for group in body.get_groups():
			#print("creature")
			#print(group)
			#print("teamid:" + str(teamid) + "  | " + str(body.teamid))
			#print("hit")
			if group == "creature":
				if body.teamid != teamid && teamid != 0:
					#body.Damage()
					#queue_free()
					print("hit")
				elif teamid == 0:
					#body.Damage()
					#queue_free()
					print("hit")