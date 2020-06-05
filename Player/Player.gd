extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player = get_parent()
var basePosition
var mousePosition
onready var slingShot = get_node("SpacetimeSlingshot")
onready var darkStar = get_parent().get_node("DarkStar")
onready var darkStarPosition = darkStar.global_position 
var timer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	basePosition = self.global_position 
	SignalManager.connect("PlayerLeftZone", self, "CountDownToDeath")
	SignalManager.connect("PlayerReenteredZone", self, "ResetVoidDeathTimer")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func ResetVoidDeathTimer():
	if timer != null:
		timer.stop()

func CountDownToDeath():
	print("We're out -- counting down to death")
	timer = Timer.new()
	timer.one_shot = true
	timer.set_wait_time(3)
	add_child(timer)
	timer.connect("timeout", self, "Die")
	timer.start()

func ResetPosition():
	self.global_position = darkStarPosition

func Die():
	print("Player died!")
	SignalManager.emit_signal("PlayerDied")
	ResetPosition()

func FollowMouse():
	mousePosition = get_global_mouse_position()
	var position = self.global_position
	$Tween.stop_all()
	$Tween.interpolate_property(self, "basePosition", position, mousePosition, 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func _process(delta):
	pass
	#if Input.is_action_pressed("right_click"):

func _physics_process(delta):
	if !slingShot.priming && !slingShot.launching && Input.is_action_pressed("right_click"):
		FollowMouse()
		self.global_position = basePosition
