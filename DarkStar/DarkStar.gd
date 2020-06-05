extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#onready var timer = get_node("Timer")
onready var hunger = get_node("Hunger")
#you have to rip out the souls of the enemies

func _ready():
#	timer = get_node("Timer")
	SignalManager.connect("PlayerDied", self, "HandlePlayerDeath")

func HandlePlayerDeath():
	Shrink(0.5)

func _on_DarkStar_body_entered(body):
	print(body.name + " entered me")
	if body.is_class("Enemy"):#get_type() == "Enemy":
		Grow(body.energyValue)
		body.queue_free()
		hunger.AdjustHunger(10)

func _on_DarkStar_body_exited(_body):
	pass

func _input(event):
	pass

func Grow(scaleAmount):
	#when the dark star gets more fuel
	var newScale = Vector2(self.scale.x + scaleAmount, self.scale.y+scaleAmount)
	$Tween.interpolate_property(self, "scale", self.scale, newScale, 1.0, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()

func Shrink(scaleAmount):
	#when the dark star burns up its fuel or takes damage
	var newScale = Vector2(self.scale.x - scaleAmount, self.scale.y-scaleAmount)
	$Tween.interpolate_property(self, "scale", self.scale, newScale, 1.0, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
