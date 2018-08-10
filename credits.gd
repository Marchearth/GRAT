extends Node2D

var text_timer
var waitval = 0.1 # time between text lines
var step = 0 #Which text to show by step
var legal_string = ''
var text_to_show = ['Credits and Sources',
'---------------------',
'',
'made by Bugra Coskun',
'using the Godot Engine',
'find more of my projects at',
'marchearth.github.io',
'',
'Font: Commodore64Pixelized',
'by Devin D. Cook',
'',
'CRT Effect: ',
'SimpleGodotCRTShader',
'by Henrique Alves ',
'',
'Graphic Design:',
'Gorkem Goger',
'dalugnswood@outlook.com'
 ]

func _ready():
	#Setup timer for text pop up
	text_timer = Timer.new()
	text_timer.set_wait_time(waitval)
	text_timer.set_one_shot(false)
	text_timer.connect("timeout", self, "on_timer_timeout")
	add_child(text_timer)
	text_timer.start()
	
	get_node('creditext').clear() #Clear up test text from text box
	
func on_timer_timeout():
	if text_to_show[step] != '':
		legal_string = '> ' + text_to_show[step] + '\n'
	else:
		legal_string = text_to_show[step] + '\n'
	get_node('creditext').add_text(legal_string)
	step += 1
	if step == text_to_show.size():
		text_timer.queue_free()
	