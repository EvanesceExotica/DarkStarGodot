extends Node2D

onready var clickable = get_node("Clickable")
onready var anim = get_node("AnimationPlayer")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mouseIn = false

signal WeakPointClosed
signal WeakPointSpiked

func ExposeWeakPoint():
	print("Opening weakpoint eye")
	anim.play("OpenEye")
	yield(anim, "animation_finished")
	clickable.disabled = false
	print("Can click now!" + "Disabled is " + str(clickable.disabled))

func StartTimerToClose():
	$Timer.set_wait_time(0.5)
	$Timer.connect("timeout", self, "CloseWeakPoint")
	$Timer.one_shot = true
	$Timer.start()
	#$Timer.set_wait_time(System.ScaleWithTimeScale(0.5))

func CloseWeakPoint():
	anim.play_backwards("OpenEye")
	yield(anim, "animation_finished")
	clickable.disabled = true
	emit_signal("WeakPointClosed")

func SpikeWeakPoint():
	anim.play("Spike")
	clickable.disabled = true
	emit_signal("WeakPointSpiked")

func _on_Weakpoint_mouse_entered():
	print("Mouse in!")
	mouseIn = true
	pass
func _on_Weakpoint_mouse_exited():
	mouseIn = false
	pass

func _input(event):
	#this is just waiting for left click not mouse in 
	if mouseIn && event.is_action_pressed("left_click"):
		print("Click")
		SpikeWeakPoint()
#Called when the node enters the scene tree for the first time.
func _ready():
	clickable.disabled = true
	pass # Replace with function body.
# func _on_Weakpoint_input_event(viewport, event, shape_idx):
# 	if event is InputEventMouseButton:
# 		if (event.is_pressed() and event.button_index == BUTTON_LEFT):
# 			print("Click2")
	pass
# func _input_event(viewport, event, shape_idx):
# 	if event is InputEventMouseButton:
# 		if (event.is_pressed() and event.button_index == BUTTON_LEFT):
# 			print("Click3")
# # Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
