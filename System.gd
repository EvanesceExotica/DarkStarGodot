extends Node2D

var player
var darkStar
#to speed up, multiply motion or other parameters of thing by (1/Engine.time_scale)
func SlowDownTime():
	Engine.time_scale  = 0.3

func SpeedUpTime():
	Engine.time_scale = 1

func _ready():
	pass # Replace with function body.
func ScaleWithTimeScale(value):
	return value*0.3
	
