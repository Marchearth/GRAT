extends KinematicBody2D

var motion = Vector2()
var screen_width
var vertical_speed = 300
var horizontal_speed = 300
var fall_acc = 25 #downward acceleration
var terminal_velocity = 400
var float_energy = 0
var int_energy = 0
var str_energy = '%000'

func _ready():
	set_fixed_process(true)
	screen_width = 360#get_parent().get("screen_width")

func _fixed_process(delta):
	# HORIZONTAL MOVEMENT
	if get_parent().get_node("bottommenu/button_group/button_left").is_pressed() == true &&\
	get_parent().get_node("bottommenu/button_group/button_right").is_pressed() == true:
		motion.x = 0

	elif get_parent().get_node("bottommenu/button_group/button_left").is_pressed() == true:
		if get_pos().x > 15: motion.x = - horizontal_speed
		else: motion.x = 0

	elif get_parent().get_node("bottommenu/button_group/button_right").is_pressed() == true:
		if get_pos().x < screen_width - 12 : motion.x = horizontal_speed
		else: motion.x = 0

	else: motion.x = 0

	# VERTICAL MOVEMENT
	if get_parent().get_node("bottommenu/button_group/button_jump").is_pressed() == true:
		if get_pos().y > 680 : pass #GAME OVER
		elif get_pos().y > 0: motion.y = - vertical_speed
	else:
		#if motion.y < 0: motion.y = 0
		if motion.y < terminal_velocity:
			motion.y += fall_acc

	move_and_slide(motion)

	if int_energy < 100: float_energy += 5*get_pos().y/10000
	if int_energy != int(float_energy): # if energy value changes
		int_energy = int(float_energy)
		if int_energy < 10 : str_energy = '00' + str(int_energy) + '%'
		elif int_energy < 100 : str_energy = '0' + str(int_energy) + '%'
		else: str_energy = str(int_energy) + '%'
		print(str_energy)
	get_parent().get_node("topmenu/topmenu_container/stats_container/energy_cont/energy_per")\
	.set_text(str_energy)
