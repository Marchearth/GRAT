extends Node2D
# drawings move each frame some pixels thats speed
var usual_green = Color(0.633, 1.0, 0.0, 1.0)
var energy_trace_green = Color(0.633, 1.0, 0.0, 0.5)

var p_height = 25 #in pixels # /_|_\     | = 10    ,   _ =10/sqrt(3)   ,   / = 10*2/sqrt(3)
var playerdot1 = Vector2(180,500) # player nose dot location
var playerdot2 = Vector2() # left corner
var playerdot3 = Vector2() # right corner
var playerdot_arr = []

onready var screen_size = get_node("background").get_rect().size
onready var screen_width = screen_size.x

var midline_arr = []
var midline_alpha = 1.0
var mov_left = false
var mov_right = false

var dlt = 1 # delta
var spd = 6 # how many pixels is it gonna move every frame
var mov_range = 30 # how many pixels can player go on a single tap
var mov_as_much = 0
var range_counter = 0

var waves_arr = [] # the waves coming down
var midline_x = 0
var first_wave = Vector2()
var start_point = 0

var cleanup_timer
var waitval = 0.2 # wait for 0.2 seconds

func _ready():
	set_fixed_process(true)

	midline_arr.append(Vector2(screen_size.x/2,0)) #points for middle line
	midline_arr.append(Vector2(screen_size.x/2,screen_size.y))
	print("middle line points:", midline_arr)
	get_node("button_left").connect("pressed", self,
	"on_button_left_pressed")
	get_node("button_right").connect("pressed", self,
	"on_button_right_pressed")

	#create starting dot and connect it to middle line
	screen_width = int(screen_width)
	midline_x = screen_width/2

	waves_arr.append(Vector2(midline_x, 0)) # start point
	waves_arr.append(Vector2(randi()%screen_width, 0)) # first wave, y value hasn't been set
	waves_arr[1].y = -absolute(waves_arr[1].x - screen_width/2)
	print(waves_arr.size())

	cleanup_timer = Timer.new()
	cleanup_timer.set_wait_time(waitval)
	cleanup_timer.set_one_shot(false)
	cleanup_timer.connect("timeout", self, "ifed_destroy_old_wave")
	# Call function when it timesout
	add_child(cleanup_timer)
	cleanup_timer.start()

func ifed_create_new_wave():
	if waves_arr[waves_arr.size()-1].y >= 0: # if last point is in the edge of the top screen
		waves_arr.append(Vector2(randi()%(screen_width-1)+1, 0)) # randomly selected new wave x loc
		waves_arr[waves_arr.size()-1].y = \
		waves_arr[waves_arr.size()-2].y \
		- absolute(waves_arr[waves_arr.size()-2].x - waves_arr[waves_arr.size()-1].x)

func ifed_destroy_old_wave():
	print("\n",waves_arr.size())
	if waves_arr[0] != null && waves_arr[1].y > 640:
		waves_arr.remove(0)

func mov_waves(speed):
	for i in range(0, waves_arr.size()):
		waves_arr[i].y += spd # move every wave by spd down

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
	ifed_create_new_wave()
	mov_waves(spd)
	update()

func _draw():
	draw_line(midline_arr[0], midline_arr[1], Color(0.633, 1.0, 0,
	midline_alpha), 0.01) #midline

	draw_colored_polygon(player_coordinates(p_height),
	usual_green, Vector2Array([])) #player
	for i in range(0, waves_arr.size() - 1):
		draw_line(waves_arr[i], waves_arr[i+1], energy_trace_green, 3)

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



func absolute(val): # get absolute
	if val < 0:
		val = -val
	return val

func gravity_player():
	pass
