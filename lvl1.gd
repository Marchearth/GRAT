extends Node2D
# drawings move each frame some pixels thats speed
const usual_green = Color(0.633, 1.0, 0.0, 1.0)
const energy_trace_green = Color(0.633, 1.0, 0.0, 0.5)
const midline_alpha = 1.0
const waitval = 0.2 # wait for 0.2 seconds

onready var screen_size = get_node("background").get_rect().size
onready var screen_width = screen_size.x
onready var screen_height = screen_size.y

var midline_arr = []
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

var linear = false

var last_wave
var player_pos
func _ready():
	randomize()
	set_fixed_process(true)

	midline_arr.append(Vector2(screen_size.x/2,0)) #points for middle line
	midline_arr.append(Vector2(screen_size.x/2,screen_size.y))

	get_node("bottommenu/button_group/button_left").connect("pressed", self,
	"on_button_left_pressed")
	get_node("bottommenu/button_group/button_right").connect("pressed", self,
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

func _fixed_process(delta):
	if get_node("bottommenu/button_group/button_left").is_pressed() == true &&\
	get_node("bottommenu/button_group/button_right").is_pressed() != true:
		player_pos = get_node("player").get_pos()
		player_pos.x -= spd
		get_node("player").set_pos(player_pos)

	elif get_node("bottommenu/button_group/button_right").is_pressed() == true &&\
	get_node("bottommenu/button_group/button_left").is_pressed() != true:
		player_pos = get_node("player").get_pos()
		player_pos.x += spd
		get_node("player").set_pos(player_pos)

	ifed_create_new_wave()
	mov_waves(spd)
	update()

func ifed_create_new_wave():
	if waves_arr[waves_arr.size()-1].y >= 0: # if last point is in the edge of the top screen
		if linear == false:
			waves_arr.append(Vector2(randi()%(screen_width-10)+10, 0)) # randomly selected new wave x loc
			waves_arr[waves_arr.size()-1].y = \
			waves_arr[waves_arr.size()-2].y \
			- absolute(waves_arr[waves_arr.size()-2].x - waves_arr[waves_arr.size()-1].x)
			linear = true
		elif linear == true:
			waves_arr.append( Vector2( waves_arr[waves_arr.size()-1].x ,
			-randi()%(int(screen_height/2)-1)+1  ))
			linear = false

func ifed_destroy_old_wave():
	if waves_arr[0] != null && waves_arr[1].y > 640:
		waves_arr.remove(0)

func mov_waves(speed):
	for i in range(0, waves_arr.size()):
		waves_arr[i].y += spd # move every wave by spd down



func _draw():
	draw_line(midline_arr[0], midline_arr[1], Color(0.633, 1.0, 0,
	midline_alpha), 0.01) #midline

	for i in range(0, waves_arr.size() - 1):
		draw_line(waves_arr[i], waves_arr[i+1], energy_trace_green, 4)

func on_button_left_pressed():
	mov_left = true

func on_button_right_pressed():
	mov_right = true

func absolute(val): # get absolute
	if val < 0:
		val = -val
	return val
