extends Node2D

var hungerTime = 20
onready var darkStar = get_parent()
onready var hungerBar = get_node("HungerBar")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func StartHungerTimer():
	$Timer.set_wait_time(hungerTime)
	$Timer.start()
	yield($Timer, "timeout")

func AdjustHunger(value):
	var newValue = hungerBar.value + value
	$Tween.stop_all()
	$Tween.interpolate_property(hungerBar, "value", hungerBar.value, newValue, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	yield($Tween, "tween_completed")
	DrainHunger()


func DrainHunger():
	#bigger star gets faster it drains hunger?
	#maybe keep feeding it to stave off disaster?
	$Tween.stop_all()
	$Tween.interpolate_property(hungerBar, "value", hungerBar.value, 0, 20, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func BurnUpFuel():
	#the dark star had to burn its own fuel to stay alive, using up size
	darkStar.Shrink(0.5)
# Called when the node enters the scene tree for the first time.
func _ready():
	$Tween.connect("tween_completed", self, "CheckTweenCompletion")
	DrainHunger()
	pass # Replace with function body.

func CheckTweenCompletion(object, key):
	if hungerBar.value == 0:
		#if the tween drained this to zero
		BurnUpFuel()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
