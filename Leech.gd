extends "res://Enemies/Enemy.gd"

var drainValue = 10
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func DrainStar():
	System.darkStar.hunger.AddDrainer()
# Called when the node enters the scene tree for the first time.
func StopDraining():
	System.darkStar.hunger.RemoveDrainer()

func Deconstruct():
	#overrides deconstruct
	StopDraining()
	.Deconstruct()

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
