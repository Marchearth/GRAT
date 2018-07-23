extends Node2D
# drawings move each frame some pixels thats speed

#movement might be better if changed from jump style to move as long
#as its pressed style

var p_height = 25 #in pixels
# /_|_\     | = 10    ,   _ =10/sqrt(3)   ,   / = 10*2/sqrt(3)
var playerdot1 = Vector2(180,580) # player nose dot location
var playerdot2 = Vector2() # left corner 
var playerdot3 = Vector2() # right corner
var playerdot_arr = []
onready var screen_size = get_node("background").get_rect().size
var midline_arr = []
var midline_alpha = 1.0
var mov_left = false
var mov_right = false 

var dlt = 1 # delta
var spd = 5 # how many pixels is it gonna move every frame
var mov_range = 30 # how many pixels can player go on a single tap
var mov_as_much = 0
var range_counter = 0

func _ready():
	set_fixed_process(true)
	
	midline_arr.append(Vector2(screen_size.x/2,0)) #points for middle line
	midline_arr.append(Vector2(screen_size.x/2,screen_size.y))
	print("middle line points:", midline_arr)
	
	get_node("button_left").connect("pressed", self,
	"on_button_left_pressed")
	get_node("button_right").connect("pressed", self,
	"on_button_right_pressed")
	
func _fixed_process(delta):

	if get_node("button_left").is_pressed() == true &&\
	get_node("button_right").is_pressed() != true:
		if playerdot1.x >= 0:
			playerdot1.x -=spd
	
	elif get_node("button_right").is_pressed() == true &&\
	get_node("button_left").is_pressed() != true:
		if playerdot1.x <= screen_size.x:
			playerdot1.x +=spd
		
	elif playerdot1.x != midline_arr[0].x: # if its not in the middle
		if playerdot1.x > midline_arr[0].x: #if bigger
			playerdot1.x -= spd
		elif playerdot1.x < midline_arr[0].x: #if smaller
			playerdot1.x += spd
	update()
	
func on_button_left_pressed():
	mov_left = true
	mov_as_much += mov_range
func on_button_right_pressed():
	mov_right = true
	mov_as_much += mov_range

func player_coordinates(playerheight):
	playerdot_arr.clear() # erase all prior info in array
	playerdot2.x = playerdot1.x - playerheight/sqrt(3)
	playerdot2.y = playerdot1.y + playerheight
	playerdot3.x = playerdot1.x + playerheight/sqrt(3)
	playerdot3.y = playerdot2.y
	playerdot_arr.append(playerdot1)
	playerdot_arr.append(playerdot2)
	playerdot_arr.append(playerdot3)
	return playerdot_arr
	
func _draw():
	draw_line(midline_arr[0], midline_arr[1], Color(0.633, 1.0, 0, 
	midline_alpha), 0.01) #midline 
	draw_colored_polygon(player_coordinates(p_height),
	 Color(0.633, 1, 0, 1), Vector2Array([])) #player

func gravity_player():
	pass
