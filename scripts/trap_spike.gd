extends RigidBody2D

var creator = null
export var damage = 1;
var damagetype = null

export var teamid = 0
export var btrigger = true
var animation = null

export var reset_time = 0
export var reset_time_max = 30

func _ready():
	set_fixed_process(true)
	animation = get_node("AnimationPlayer")
	
func _fixed_process(delta):
	var bodies = get_colliding_bodies()
	"""
	for body in bodies:
		#print("hit")
		for group in body.get_groups():
			#print("creature")
			#print(group)
			#print("teamid:" + str(teamid) + "  | " + str(body.teamid))
			#print("hit")
			if group == "creature":
				if body.teamid != teamid && teamid != 0:
					body.Damage(creator,damage,damagetype)
					#queue_free()
					print("hit")
					animation.play("Active")
					pass
				elif teamid == 0:
					animation.play("Active")
					body.Damage(creator,damage,damagetype)
					#queue_free()
					print("hit")
					pass
"""

func _on_trap_spike_body_enter( body ):
	
	if body.is_in_group("creature"):
		if body.teamid != teamid && teamid != 0:
			body.Damage(creator,damage,damagetype)
			#queue_free()
			print("hit[no team]")
			animation.play("Active")
			#pass
		elif teamid == 0:
			animation.play("Active")
			body.Damage(creator,damage,damagetype)
			#queue_free()
			print("hit[free for all?]")
			#pass
	#pass
