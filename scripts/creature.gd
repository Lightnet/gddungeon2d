extends StaticBody2D

var teamid = 0
var status = null #= preload("res://scripts/status.gd").new()

func _ready():
	set_fixed_process(true)
	set_process_input(true)
	status = load("res://scripts/status.gd").new()
	
func _fixed_process(delta):
	#var y = get_pos().y
	#var mouse_x = get_viewport().get_mouse_pos().x
	#set_pos(Vector2(mouse_x,y))
	pass

func _input(event):
	if event.type == InputEvent.MOUSE_BUTTON && event.is_pressed():
		#var ball = ball_scene.instance()
		#ball.set_pos(get_pos()-Vector2(0,16))
		#get_tree().get_root().add_child(ball)
		pass
		
func Damage():
	print("creature damage")
