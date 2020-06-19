extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player = get_parent()
var basePosition
var mousePosition
onready var slingShot = get_node("SpacetimeSlingshot")
onready var bash = get_node("Bash")
onready var darkStar = get_parent().get_node("DarkStar")
onready var darkStarPosition = darkStar.global_position 
var timer

onready var vfxContainer = get_node("VFXContainer")
export var mapIcon: Resource
onready var cameraTransform = $CameraTransform
onready var emitter = get_node("VFXContainer/RippleEmitter")
onready var distortionTransform = get_node("DistortionTransform")

# Called when the node enters the scene tree for the first time.
func _ready():
	System.set("player", self)
	pass # Replace with function body.
	basePosition = self.global_position 
	SignalManager.connect("PlayerLeftZone", self, "CountDownToDeath")
	SignalManager.connect("PlayerReenteredZone", self, "ResetVoidDeathTimer")
	#vfxContainer.initializeRippleTrail()
	vfxContainer.remove_child(emitter)
	ObjectHandler.handleDistortionEffect(emitter)
	distortionTransform.remote_path = emitter.get_path()
	#emitter.emitting = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func TakeDamage(amount):
	emit_signal("PlayerTookDamage", amount)


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
	#reset to start position and set velocity to zero
	self.global_position = darkStarPosition
	self.linear_velocity = Vector2(0, 0)

func Die():
	print("Player died!")
	SignalManager.emit_signal("PlayerDied")
	ResetPosition()
func _FollowMouse():
	#mousePosition = get_viewport().get_mouse_position()
	mousePosition = get_global_mouse_position()
	var position = self.global_position
	#print(mousePosition)
	#var t = 0;
	#var t = 
	#var newMousePosition = Vector2(mousePosition.x + 20, mousePosition.y + 20)
	basePosition = position.linear_interpolate(mousePosition, 0.05);

func FollowMouse():
	# mousePosition = get_global_mouse_position()
	# var position = self.global_position
	# var t = 0;
	# basePosition = position.linear_interpolate(mousePosition, t);
	$Tween.stop_all()
	$Tween.interpolate_property(self, "basePosition", position, mousePosition, 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func ToggleMap(mapUp : bool, tweenTime : float) -> void:
	if !mapUp:
		$Timer.start(tweenTime)
		yield(timer, "timeout")
	cameraTransform.update_position = !mapUp

func grabCamera(camera : Camera2D) -> void:
	cameraTransform.remote_path = camera.get_path()
func _process(delta):
	pass
	#if Input.is_action_pressed("right_click"):
func StartEmitter():
	emitter.emitting = true

func StopEmitter():
	emitter.emitting = false

func _physics_process(delta):
	if Input.is_action_pressed("right_click") && !slingShot.priming && !slingShot.launching && !bash.bashing:
		_FollowMouse()
		self.global_position = basePosition
		if emitter.emitting == false:
			emitter.emitting = true
	elif slingShot.launching:
		if emitter.emitting == false:
			emitter.emitting = true
	else:
		if emitter.emitting == true:
			emitter.emitting = false
	

		#vfxContainer.makeTrail()
		# if !vfxContainer.rippling:
		# 	vfxContainer.rippling = true
		# 	#vfxContainer.makeTrail()
		# if vfxContainer.rippling:
		# 	vfxContainer.makeTrail()
