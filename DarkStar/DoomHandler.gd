extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var darkStar = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	StartDoomClock()
	pass # Replace with function body.

func StartDoomClock():
	$Timer.set_wait_time(5)
	$Timer.start()
	yield($Timer, "timeout")
	Inhale()

func StartExplosionClock():
	$Timer.set_wait_time(5)
	$Timer.start()
	yield($Timer, "timeout")
	Exhale()

func Relax():
	$Timer.set_wait_time(2)
	$Timer.start()
	yield($Timer, "timeout")
	darkStar.gravity_point = false
	StartDoomClock()

func Exhale():
	print("BOOM")
	darkStar.gravity = -1000
	Relax()

func Inhale():
	print("GASP")
	darkStar.gravity = 1000
	darkStar.gravity_point = true
	StartExplosionClock()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
