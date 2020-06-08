extends Node2D

onready var player = get_parent()
onready var line = get_node("SlingLine")
onready var poweThrustMax = 15.0;
onready var powerThrustThreshold = 10.0;

var launching = false
var priming = false
var minimumHoldDuration = 0.05;
var maxPullDistance;
var elasticity = 10;
var mouseStartPosition
var stretchedPastThreshold = false

func _input(event):
	pass

func _ready():
	line.visible = false

func InitializeSlingshot():	
	priming = true
	mouseStartPosition = get_global_mouse_position()
	var distance = 0
	var direction = Vector2(0, 0)
	var mousePos = Vector2(0, 0)
	var scaledValue
	line.visible = true
	System.SlowDownTime()

func PrimeSlingshot():
	# priming = true
	# mouseStartPosition = get_global_mouse_position()
	# var distance = 0
	# var direction = Vector2(0, 0)
	# var mousePos = Vector2(0, 0)
	# var scaledValue

	# line.visible = true

	# while(true):
	var mousePos = get_global_mouse_position()
	var distance = player.global_position.distance_to(mousePos);
	if distance >= powerThrustThreshold:
		if !stretchedPastThreshold:
			stretchedPastThreshold = true
	elif distance < powerThrustThreshold:
		if !stretchedPastThreshold:
			stretchedPastThreshold = false
#	var scaledValue = distance/20.0;

			#NOTE THAT LINE2D will only take local positions
	line.points[0] = self.position
	line.points[1] = get_local_mouse_position()#mousePos

func StopSlingshot():
	line.visible = false
	priming = false

func LaunchSlingshot():
	System.SpeedUpTime()
	line.visible = false
	var mousePos = get_global_mouse_position()
	var distance = player.global_position.distance_to(mousePos)
	var direction = global_position - mousePos
	var velocity = distance * sqrt(elasticity / player.mass);
	player.linear_velocity = direction.normalized() * velocity;
	priming = false
	launching = true

func _process(delta):
	if Input.is_action_just_pressed("left_click") && !priming && !player.bash.bashing: 
		InitializeSlingshot()
	if priming:
		PrimeSlingshot()
	if Input.is_action_just_released("left_click") && priming && !player.bash.bashing:
		priming = false
		LaunchSlingshot()
	if Input.is_action_just_pressed("right_click") && priming && !player.bash.bashing:
		StopSlingshot()
