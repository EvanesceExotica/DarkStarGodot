extends Node2D

onready var rippleTrail
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rippling = false
var doubledRipples

onready var rippleEmitter : Particles2D = get_node("RippleEmitter")

func initializeRippleTrail():
	print("Initializing ripples")
	var ripples = rippleEmitter.duplicate()
	doubledRipples = ripples
	ObjectHandler.handleDistortionEffect(ripples)
	ripples.global_position = rippleEmitter.global_position
	doubledRipples.emitting = true


func makeTrail():
	rippling = true
	doubledRipples.emitting = true

func stopTrail():
	rippling = false
	doubledRipples.emitting = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
