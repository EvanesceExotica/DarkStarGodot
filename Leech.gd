extends "res://Enemies/Enemy.gd"

var drainValue: int = -10
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func DrainStar():
	#this will decrease the amount of time for the dark star to drain
	System.darkStar.DamageFlash(null)
	System.darkStar.hunger.AddDrainer(self)
# Called when the node enters the scene tree for the first time.
func StopDraining():
	#this will increase the amount of time for the dark star to drain when the leech is removed
	System.darkStar.hunger.RemoveDrainer(self)

func Deconstruct():
	#overrides deconstruct
	StopDraining()
	.Deconstruct()

func _ready():
	pass # Replace with function body.

var draining = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !draining:
		draining = true
		DrainStar()
