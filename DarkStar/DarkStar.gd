extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var timer = get_node("Timer")
#you have to rip out the souls of the enemies

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = get_node("Timer")
	pass # Replace with function body.

func _on_DarkStar_body_entered(body):
#	if body is 
	if body.is_class("Enemy"):#get_type() == "Enemy":
		Grow(body.energyValue)
		body.queue_free()

func _on_DarkStar_body_exited(_body):
#	Grow(0.5)
#	body.queue_free()
	pass

func _input(event):
	if event.is_action_pressed("ui_interact"):
		Grow(0.5)

func Grow(scaleAmount):
	var newScale = Vector2(self.scale.x + scaleAmount, self.scale.y+scaleAmount)
	$Tween.interpolate_property(self, "scale", self.scale, newScale, 1.0, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
