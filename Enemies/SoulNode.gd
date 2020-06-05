extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func StartLifeTimer():
	$Timer.set_wait_time(0.2)
	$Timer.one_shot = false
	$Timer.start()


func GrowIntoExistence():
	$Tween.interpolate_property(self, "scale", self.scale, Vector2(1, 1), 0.1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()

func ShrinkFromExistence():
	$Tween.interpolate_property(self, "scale", self.scale, Vector2(0, 0), 0.1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()

# Called when the node enters the scene tree for the first time.
func _ready():
	self.scale = Vector2(0, 0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
