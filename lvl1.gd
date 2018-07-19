extends Node2D
var playerheight = 10 #in pixels
# /_|_\     | = 10    ,   _ =10/sqrt(3)   ,   / = 10*2/sqrt(3)
var playerdot1 = Vector2(180, 500) # player nose dot location
var playerdot2 = Vector2() # left corner 
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	playerdot2.x = playerdot1.x - playerheight/sqrt(3)
	playerdot2.y = playerdot1.y - playerheight
	print(playerdot2)
