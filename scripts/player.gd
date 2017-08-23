extends StaticBody2D

const basedamage = preload("res://shapedamages/BaseDamage.tscn")

var teamid = 1

var MOVE_LEFT = false
var MOVE_RIGHT = false
var MOVE_UP = false
var MOVE_DOWN = false

func _ready():
	set_fixed_process(true)
	set_process_input(true)
	#pass
func _fixed_process(delta):
	#var y = get_pos().y
	#var mouse_x = get_viewport().get_mouse_pos().x
	#set_pos(Vector2(mouse_x,y))
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

func _input(event):
	# Get the controls
	#var move_left = Input.is_action_pressed("move_left")
	#var move_right = Input.is_action_pressed("move_right")
	#var jump = Input.is_action_pressed("jump")
	
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
		
		print("fire")
		
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
	pass
	
func Damage():
	print("player damage")