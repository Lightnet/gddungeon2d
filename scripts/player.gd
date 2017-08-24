#extends KinematicBody2D
extends RigidBody2D

#export var speed = 200
export var speed = 1
#tmp melee attack block
# at which distance to stop moving
# NOTE: setting this value too low might result in jerky movement near destination
const eps = 1.5

const basedamage = preload("res://shapedamages/BaseDamage.tscn")
#team id for creature check for friendly fire
var teamid = 1
#set user control
var bcontrol = false
var bnavpath = false

var MOVE_LEFT = false
var MOVE_RIGHT = false
var MOVE_UP = false
var MOVE_DOWN = false

#chracter status and stats
#var status = preload("res://scripts/status.gd").new()
var status = null #= preload("res://scripts/status.gd").new()

var targetpoint = null
# points in the path
var points = []

func _ready():
	set_fixed_process(true)
	set_process_input(true)
	status = load("res://scripts/status.gd").new()
	
	#pass
func _fixed_process(delta):
	#var y = get_pos().y
	#var mouse_x = get_viewport().get_mouse_pos().x
	#set_pos(Vector2(mouse_x,y))
	if bcontrol:
		if Input.is_action_pressed("move_left"):
			var pos = get_pos()
			set_pos(Vector2(pos.x-1,pos.y))
			
		if Input.is_action_pressed("move_right"):
			var pos = get_pos()
			set_pos(Vector2(pos.x+1,pos.y))
			
		if Input.is_action_pressed("move_up"):
			var pos = get_pos()
			set_pos(Vector2(pos.x,pos.y-1))
			
		if Input.is_action_pressed("move_down"):
			var pos = get_pos()
			set_pos(Vector2(pos.x,pos.y+1))
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
	# if there are points to draw
	if points.size() > 1:
		for p in points:
			draw_circle(p - get_global_pos(), 8, Color(1, 0, 0)) # we draw a circle (convert to global position first)
	
func _input(event):
	# Get the controls
	#var move_left = Input.is_action_pressed("move_left")
	#var move_right = Input.is_action_pressed("move_right")
	#var jump = Input.is_action_pressed("jump")
	
	if event.type == InputEvent.MOUSE_BUTTON && event.is_pressed():
		#print("pos:",get_global_pos())
		#print("mouse pos:",get_global_mouse_pos())
		#points = get_node("/root/app/dungeonnode2d/navigation2d").get_simple_path(get_global_pos(), get_global_mouse_pos(), false)
		#print("POINTS",points)
		if bnavpath:
			targetpoint = get_global_mouse_pos()
	
	if bcontrol:
		if event.is_action_pressed("fire"):
			var pos = get_pos()
			var objdamage = basedamage.instance()
			#pos.x += 40
			pos.x += 16
			#pos.y += 16
			objdamage.teamid = teamid
			objdamage.set_pos(pos)
			
			#get_node("/root/app/dungeonnode2d/effects").add_child(objdamage)
			#get_node("effects").add_child(objdamage)
			get_node("/root/dungeonnode2d/effects").add_child(objdamage)
			#print("fire")
		if event.is_action_pressed("jump"):
			print("status:"+ str(status.healthpoint))
		#pass
	#if event.is_action_pressed("move_right"):
		#var pos = get_pos()
		#set_pos(Vector2(pos.x+1,pos.y))
		
	#print("key")
	#var shoot = Input.is_action_pressed("shoot")
	#var spawn = Input.is_action_pressed("spawn")
	#if event.type == InputEvent.MOUSE_BUTTON && event.is_pressed():
		#var ball = ball_scene.instance()
		#ball.set_pos(get_pos()-Vector2(0,16))
		#get_tree().get_root().add_child(ball)
		#pass
	#pass
	
func Damage():
	print("player damage")