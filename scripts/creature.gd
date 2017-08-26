extends RigidBody2D

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
		
func Damage(_creator,_damage,_damagetype):
	print("player damage")
	status.healthpoint -= _damage
	print(status.healthpoint)
	UpdateHealthBar()
	
func UpdateHealthBar():
	var healthbar = get_node("ProgressBar")
	if healthbar != null:
		var percent = float(status.healthpoint) / float(status.healthpointmax) * 100
		percent = clamp(percent,0.00,100)
		print("percent",percent)
		healthbar.set_value(percent)
