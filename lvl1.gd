extends Node2D

var float_score = 0
var int_score = 0
var str_score = '0000'
var meteors_arr = []
var current_meteor
var front = -2

func _ready():
	set_fixed_process(true)
	print(meteors_arr.size())
	# SEND OUT FIRST METEORS
	for i in range(0, 5): # 6 is the max active meteor count so numbered 0 to 5
		get_node('meteors/meteor' + str(i)).set_texture(load('img/empty_hexagon.png'))
		get_node('meteors/meteor' + str(i)).set_scale(load('img/empty_hexagon.png'))


func _fixed_process(delta):
	#Score Board
	float_score += 1*delta
	if int_score != int(float_score):
		int_score = int(float_score)
		if int_score < 10: str_score = '000' + str(int_score)
		elif int_score < 100: str_score = '00' + str(int_score)
		elif int_score < 1000: str_score = '0' + str(int_score)
		else: str_score = str(int_score)
		get_node('topmenu/topmenu_container/score_bg/score_num').set_text(str_score)


func create_meteor(destroyed_meteor): # e.g meteor2
	#Create meteors in the creation timeframe, duration between creation timeframes get shorter with gametime

	#MODE_STATIC (?)
	current_meteor = meteors_arr[meteors_arr.size() - 1]
	current_meteor.set_texture(load("res://img/empty_hexagon.png")) #Proper use of this method

func destroy_meteor():
	#Test the meteor locations on timeout
	pass
