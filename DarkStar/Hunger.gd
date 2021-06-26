extends Node2D

var drainers = []
var defaultHungerDrainValue : int = 50
var currentHungerDrainValue : int = defaultHungerDrainValue
var hungerTime = 20
onready var darkStar = get_parent()
onready var hungerBar = get_node("HungerBar")
onready var innerFuel = get_node("InnerFuel")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func AddDrainer(leech):
	drainers.append(leech)
	currentHungerDrainValue+=leech.drainValue
	print("Being leeched. Hunger value is :  " + str(currentHungerDrainValue))
	#reset the drainHunger
	DrainHunger()

func RemoveDrainer(leech):
	drainers.erase(leech)
	currentHungerDrainValue-=leech.drainValue

	#reset the drainHunger
	DrainHunger()

func StartHungerTimer():
	$Timer.set_wait_time(hungerTime)
	$Timer.start()
	yield($Timer, "timeout")

func AdjustHunger(value):
	#var newValue = hungerBar.value + value
	var newScale = Vector2(hungerBar.scale.x + value, hungerBar.scale.y + value)
	$Tween.stop_all()
	$Tween.interpolate_property($InnerFuel, "scale", $InnerFuel.scale, newScale, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	#$Tween.interpolate_property(hungerBar, "value", hungerBar.value, newValue, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	yield($Tween, "tween_completed")
	DrainHunger()

func ShrinkInnerFuel():
	$Tween.interpolate_property($InnerFuel, "scale", $InnerFuel.scale, Vector2.ZERO, 1.0, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()

func RefillInnerFuel():
	$Tween.interpolate_property($InnerFuel, "scale", $InnerFuel.scale, Vector2.ZERO, 1.0, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()

func DrainHunger():
	#bigger star gets faster it drains hunger?
	#maybe keep feeding it to stave off disaster?
	$Tween.stop_all()
#	$Tween.interpolate_property(hungerBar, "value", hungerBar.value, 0, currentHungerDrainValue, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($InnerFuel, "scale", $InnerFuel.scale, Vector2.ZERO, currentHungerDrainValue, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func BurnUpFuel():
	#the dark star had to burn its own fuel to stay alive, using up size
	darkStar.Shrink(0.5)
# Called when the node enters the scene tree for the first time.
func RestartHungerShrink():
	DrainHunger()

func _ready():
	$Tween.connect("tween_completed", self, "CheckTweenCompletion")
	SignalManager.connect("PlayerTookDamage", self, "AdjustHunger")
	SignalManager.connect("DarkStarShrank", self, "RestartHungerShrink")
	SignalManager.connect("DarkStarGrew", self, "RestartHungerShrink")
	DrainHunger()
	pass # Replace with function body.

func CheckTweenCompletion(object, key):
	print($InnerFuel.scale)
	if $InnerFuel.scale <= Vector2(0.1, 0.1):# .value == 0:
		#if the tween drained this to zero
		BurnUpFuel()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
