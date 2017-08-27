#extends KinematicBody2D
extends RigidBody2D

export var is_adventurer = true
#set user control
export var bcontrol = false
#export var speed = 200
export var speed = 1

var bOverCreature = false

# at which distance to stop moving
# NOTE: setting this value too low might result in jerky movement near destination
const eps = 1.5
#tmp melee attack block
const basedamage = preload("res://shapedamages/BaseDamage.tscn")
#team id for creature check for friendly fire
export var teamid = 1
var bnavpath = false
#chracter status and stats
#var status = preload("res://scripts/status.gd").new()
var status = load("res://scripts/status.gd").new()

var dir = Vector2()
var currentdirection = Vector2()
var targetpoint = null
# points in the path
var points = []

func _ready():
	set_fixed_process(true)
	set_process_input(true)
	
func _fixed_process(delta):
	if bcontrol:
		dir.x = 0
		dir.y = 0
		if Input.is_action_pressed("move_left"):
			#var pos = get_pos()
			#set_pos(Vector2(pos.x-1,pos.y))
			dir.x = -1
		elif Input.is_action_pressed("move_right"):
			#var pos = get_pos()
			#set_pos(Vector2(pos.x+1,pos.y))
			dir.x = 1
		if Input.is_action_pressed("move_up"):
			#var pos = get_pos()
			#set_pos(Vector2(pos.x,pos.y-1))
			dir.y = -1
		elif Input.is_action_pressed("move_down"):
			#var pos = get_pos()
			#set_pos(Vector2(pos.x,pos.y+1))
			dir.y = 1
		if (dir.x != 0) or (dir.y != 0):
			currentdirection = dir
		dir.normalized()
		set_linear_velocity(dir*speed)
		#update()
		#pass
	
	if bnavpath:
		# refresh the points in the path
		if targetpoint != null:
			points = get_node("/root/app/dungeonnode2d/navigation2d").get_simple_path(get_global_pos(), targetpoint, false)
			
			# if the path has more than one point
			if points.size() > 1:
				var distance = points[1] - get_global_pos()
				var direction = distance.normalized() # direction of movement
				if distance.length() > eps or points.size() > 2:
					set_linear_velocity(direction*speed)
					#print("move")
				else:
					#print("stop")
					set_linear_velocity(Vector2(0, 0)) # close enough - stop moving
				update() # we update the node so it has to draw it self again
		
func _draw():
	#draw_rect(get_item_rect(),Color(0,1,0,1))
	#draw_circle(get_global_pos(), 8, Color(1, 0, 0,1))
	#draw_circle(get_global_mouse_pos(), 8, Color(1, 0, 0,1))
	#var rect = Rect2(get_global_pos(),Vector2(32,32))
	#var sprite = get_node("Sprite")
	#var rect = get_item_rect()
	#var rect = sprite.get_item_rect()
	#draw_rect(rect,Color(0,1,0,1))
	# if there are points to draw
	if points.size() > 1:
		for p in points:
			draw_circle(p - get_global_pos(), 8, Color(1, 0, 0)) # we draw a circle (convert to global position first)
	
func _input(event):
	# Get the controls
	
	if event.type == InputEvent.MOUSE_BUTTON && event.is_pressed():
		if event.button_index == 1 && bOverCreature == true:
			print("click")
			var hud = get_node("/root/global");
			hud.CreatureControlOff()
			hud.updatecontroldisplay()
			hud.set_creature(self)
			bcontrol = true
			var camera2d = get_node("Camera2D")
			if !camera2d.is_current():
				camera2d.make_current()
			
		
		#print("pos:",get_global_pos())
		#print("mouse pos:",get_global_mouse_pos())
		#points = get_node("/root/app/dungeonnode2d/navigation2d").get_simple_path(get_global_pos(), get_global_mouse_pos(), false)
		#print("POINTS",points)
		if bnavpath:
			targetpoint = get_global_mouse_pos()
	
	if bcontrol:
		if event.is_action_pressed("fire"):
			var pos = currentdirection * 32
			var objdamage = basedamage.instance()
			objdamage.creator = self
			objdamage.teamid = teamid
			objdamage.set_pos(pos)
			add_child(objdamage)
			#print("fire")
		if event.is_action_pressed("jump"):
			print("status:"+ str(status.healthpoint))
		#pass
		
	#print("key")
	#var shoot = Input.is_action_pressed("shoot")
	#pass
	
func Damage(_creator,_damage,_damagetype):
	#print("player damage")
	status.healthpoint -= _damage
	#print(status.healthpoint)
	UpdateHealthBar()
	
func UpdateHealthBar():
	var healthbar = get_node("ProgressBar")
	if healthbar != null:
		var percent = float(status.healthpoint) / float(status.healthpointmax) * 100
		percent = clamp(percent,0.00,100)
		healthbar.set_value(percent)
	
func _on_creature_mouse_enter():
	print("over creature")
	bOverCreature = true
	#pass
	
func _on_creature_mouse_exit():
	bOverCreature = false
	#pass
