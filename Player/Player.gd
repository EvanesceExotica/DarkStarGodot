extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player = get_parent()
var basePosition
var mousePosition
onready var slingShot = get_node("SpacetimeSlingshot")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	basePosition = self.global_position 


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func FollowMouse():
	mousePosition = get_global_mouse_position()
	$Tween.interpolate_property(self, "basePosition", self.global_position, mousePosition, 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func _process(delta):
	#if Input.is_action_pressed("right_click"):
	FollowMouse()

func _physics_process(delta):
	if !slingShot.priming && !slingShot.launching && Input.is_action_pressed("right_click"):
		self.global_position = basePosition
