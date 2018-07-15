extends Node2D

var alpha_value = 1.0
var waitval = 0.01 #If 0 it selects a random value
var flicker_timer
var fade_out = true
var change_val = 0.01# how much is it gonna increase/decrease alpha
var max_limit = 1.0
var min_limit = 0.1

func _ready():
	flicker_timer = Timer.new()
	flicker_timer.set_wait_time(waitval)
	flicker_timer.set_one_shot(false)
	flicker_timer.connect("timeout", self, "on_timer_timeout")
	# Call function when it timesout
	add_child(flicker_timer)
	flicker_timer.start()
	get_node('start_button').connect('pressed', self,
	 'on_start_button_pressed')
	get_node('credits_button').connect('pressed', self,
	 'on_credits_button_pressed')
	

func on_timer_timeout():
	if alpha_value <= min_limit:
			fade_out = false
	elif alpha_value >= max_limit:
			fade_out = true
	if fade_out == true:
		alpha_value -= change_val
	elif fade_out == false:
		alpha_value += change_val
		
	#alpha_value = randf()*1+0 #random value for title alpha
	get_node('title').set_opacity(alpha_value)
	get_node('start_button').set_opacity(alpha_value)
	get_node('credits_button').set_opacity(alpha_value)	
	
	get_node('title').update()
	get_node('start_button').update()
	get_node('credits_button').update()
	
func on_start_button_pressed():
	print('changing to new scene')
	alpha_value = null
	waitval = null
	flicker_timer.queue_free()
	flicker_timer = null
	fade_out = null
	change_val = null
	max_limit = null
	min_limit = null
	get_tree().change_scene('res://lvl1_with_CRT.tscn')

func on_credits_button_pressed():
	print('changing to credits scene')
	alpha_value = null
	waitval = null
	flicker_timer = null
	fade_out = null
	change_val = null
	max_limit = null
	min_limit = null
	get_tree().change_scene('res://credits_with_CRT.tscn')
	
func _process(delta):
	pass