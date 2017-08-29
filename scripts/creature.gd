extends RigidBody2D

#dungeon creature

const CLASS_STATUS = preload("res://scripts/status.gd")
var status = CLASS_STATUS.new()

export var is_adventurer = false
export var bcontrol = false

export var teamid = 0
#export var speed = 200
export var speed = 100
var bOverCreature = false
# at which distance to stop moving
# NOTE: setting this value too low might result in jerky movement near destination
#const eps = 1.5
const eps = 5
#tmp melee attack block
export(PackedScene) var basedamage = preload("res://shapedamages/BaseDamage.tscn")
var dir = Vector2()
var currentdirection = Vector2()

export var bselected = false
#check if creature is select with compare point on press and released
var firstpoint = Vector2()
var secondpoint = Vector2()

var bnavpath = false
var targetpoint = null
# points in the path
var points = []

var should_reset = false
var setposition = Vector2()

var path_global = "/root/global"
var global = null

func _ready():
	set_fixed_process(true)
	set_process_input(true)
	#status = load("res://scripts/status.gd").new()
	#add_to_group("persistent")
	if global == null:
		global = get_node(path_global)

func set_phy_pos(value):
	should_reset = true
	setposition = value

func reset():
	should_reset = false
	set_global_pos(setposition)

func _fixed_process(delta):
	
	if should_reset:
		# CORRECT
		# Will always work
		reset()
	
	if bcontrol == true && global.detect_mouse_panel() == false:
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
			#print("move!")
			dir.y = 1
		if (dir.x != 0) or (dir.y != 0):
			currentdirection = dir
		dir.normalized()
		set_linear_velocity(dir*speed)
		#update()
		
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
					bnavpath = false
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
		var old = null
		for p in points:
			#draw_circle(p - get_global_pos(), 8, Color(1, 0, 0)) # we draw a circle (convert to global position first)
			var pos = get_global_pos()
			if old == null:
				old = p
			else:
				draw_line(p - pos,old - pos,Color(0,1,0,1),1)
				draw_circle(p - pos, 2, Color(1, 1, 1))
				old = p

func _input(event):
	var bcontrolselect = get_node("/root/global").get_ControlSelect()
	
	if event.type == InputEvent.MOUSE_BUTTON && event.is_pressed():
		
		if event.button_index == 1 && bOverCreature == true && bcontrolselect == true:
			#print("click")
			var hud = get_node("/root/global");
			hud.CreatureControlOff()
			hud.updatecontroldisplay()
			hud.set_creature(self)
			bcontrol = true
			var camera2d = get_node("Camera2D")
			if !camera2d.is_current():
				camera2d.make_current()
				
		if event.button_index == 1 && bOverCreature == true && bselected == false:
			firstpoint = get_global_mouse_pos()
		
		if event.button_index == 1 && bOverCreature == false && bselected == true:
			bselected = false
			#print("dis selected!")
		#print("pos:",get_global_pos())
		#print("mouse pos:",get_global_mouse_pos())
		#points = get_node("/root/app/dungeonnode2d/navigation2d").get_simple_path(get_global_pos(), get_global_mouse_pos(), false)
		#print("POINTS",points)
		#if bnavpath:
			#targetpoint = get_global_mouse_pos()
		#print(event.button_index)
		if event.button_index == 2 && bselected == true:
			targetpoint = get_global_mouse_pos()
			bnavpath = true
			#print("MOVE?")
			#pass
			
	if event.type == InputEvent.MOUSE_BUTTON && event.is_pressed() == false && bOverCreature == true && bselected == false && bcontrolselect == false:
			secondpoint = get_global_mouse_pos()
			if firstpoint == secondpoint:
				bselected = true
				#print("selected!")
		
		
	if bcontrol == true && global.detect_mouse_panel() == false:
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
		#print("percent",percent)
		healthbar.set_value(percent)
		
func _on_creature_mouse_enter():
	#print("over creature")
	bOverCreature = true
	#pass
	
func _on_creature_mouse_exit():
	#print("out creature")
	bOverCreature = false
	#pass

func save():
	var save_dict = {
		pos={
			x=get_pos().x,
			y=get_pos().y
		}
	}
	return save_dict