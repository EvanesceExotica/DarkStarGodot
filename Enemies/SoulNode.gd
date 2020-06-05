extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func StartLifeTimer():
	$Timer.set_wait_time(0.2)
#	$Timer.set_wait_time(ScaleWithTimeScale(0.2))
	$Timer.one_shot = false
	$Timer.connect("timeout", self, "TimedOut")
	$Timer.start()

func TimedOut():
	print("Timedout")
	emit_signal("TimedOut")
	print("Timed out")
	ShrinkFromExistence()

func _on_SoulNode_input_event(viewport, event, shape_idx):
	print("click")
	if event is InputEventMouseButton && event.pressed:
		print("Click!")
		emit_signal("Struck")
		ShrinkFromExistence()
	


func GrowIntoExistence():
	$Tween.interpolate_property(self, "scale", self.scale, Vector2(1, 1), 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	#$Tween.interpolate_property(self, "scale", self.scale, Vector2(1, 1), ScaleWithTimeScale(0.1), Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()
	yield($Tween, "tween_completed")

func ShrinkFromExistence():
	#$Tween.interpolate_property(self, "scale", self.scale, Vector2(0, 0), ScaleWithTimeScale(0.1), Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.interpolate_property(self, "scale", self.scale, Vector2(0, 0), 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()
	yield($Tween, "tween_completed")
#	self.queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	self.scale = Vector2(0.1, 0.1)
	GrowIntoExistence()
	StartLifeTimer()
	pass # Replace with function body.

func ScaleWithTimeScale(value):
	return value*0.3