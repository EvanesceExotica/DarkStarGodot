extends Node2D

onready var clickable = get_node("Clickable")
onready var anim = get_node("AnimationPlayer")
onready var beam = get_node("Beam")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mouseIn = false

signal WeakPointClosed
signal WeakPointSpiked(weakpoint)

func ExposeWeakPoint():
	StartTimerToClose()
	print("Opening weakpoint eye")
	anim.play("OpenEye")
	yield(anim, "animation_finished")
	clickable.disabled = false
	print("Can click now!" + "Disabled is " + str(clickable.disabled))

func StartTimerToClose():
	$Timer.set_wait_time(System.ScaleWithTimeScale(0.5))
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
	emit_signal("WeakPointSpiked", self)

func _on_Weakpoint_mouse_entered():
	mouseIn = true

func _on_Weakpoint_mouse_exited():
	mouseIn = false


func _input(event):
	#this is just waiting for left click not mouse in 
	if mouseIn && event.is_action_pressed("left_click"):
		print("Click")
		anim.stop()
		SpikeWeakPoint()
#Called when the node enters the scene tree for the first time.
func _ready():
	anim.playback_speed = anim.playback_speed/0.3
	clickable.disabled = true


func ChargeUp():
	print("Preparing to fire at player")
	clickable.disabled = false
	anim.play("ChargeUp")
	anim.connect("animation_finished", self, "CheckAnim")

func CheckAnim(animation):
	if animation == "ChargeUp":
		FireAtPlayer()

func FireAtPlayer():
	print("Firing at player")
	beam.add_point(to_local(self.global_position))
	#beam.add_point(Vector2(80, 0))
	beam.add_point(to_local(System.player.global_position))
	anim.play("Fire")
	SignalManager.emit_signal("PlayerTookDamage", -50)
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
