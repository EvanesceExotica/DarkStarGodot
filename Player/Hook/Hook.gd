extends RigidBody2D

onready var player = get_parent()
onready var chain = get_node("Chain")
onready var hookOrigin = player.get_node("HookOrigin")
# var a = 2
# var b = "text"
var originPosition
var firing = false
var retracting = false
var chainMaxLength = 500
var throwSpeed = 1200
var hasObjectHooked = false
onready var collisionShape = get_node("CollisionShape2D")
# Called when the node enters the scene tree for the first time.
func _ready():
	self.mode = RigidBody2D.MODE_STATIC
	collisionShape.disabled = true
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("ui_interact"):

		pass

func BeginFiring():
	#set firing to true and set the initial position to begin firing
	#velocity only needs to be set once!	
	self.mode = RigidBody2D.MODE_RIGID
	collisionShape.disabled = false
	
	pass # Replace with function body.
	firing = true
	self.global_position = player.global_position
	var origin = player.global_position
	var mousePos = get_global_mouse_position() #Input.mousePosition
	var trans = mousePos - origin;
	trans = trans.normalized() #have to set vector to equal its normalized value, don't forget
	self.linear_velocity = trans * throwSpeed
	#var dir = get_global_mouse_position() - self.global_position
	
	
func ChainExtending():
	#chain.add_point(Vector2(0, 0))
	#chain.points[0] = player.global_position
	#print(self.position)
	chain.points[0] = to_local(hookOrigin.global_position)#self.global_position
	chain.points[1] = to_local(self.global_position)
	#chain.points[1] = Vector2(0, 0)
	#move the chain in the direction of the mouse
	pass	
	# print("Trans is " + str(trans))
	# print(self.linear_velocity)
	# var angle = atan2(dir.y, dir.x) * rad2deg;
	# self.rotation = Qua

func InitializeReturn():
	#set firing to false and retracting to true, zero out the forward velocity, then find the new velocity
	firing = false
	retracting = true
	self.linear_velocity = Vector2(0, 0)
	var targetDirection = player.global_position - self.global_position
	targetDirection = targetDirection.normalized()
	self.linear_velocity = targetDirection * throwSpeed
	#self.linear_velocity = Vector2(0, 0)

func ReturnChain():
	#move the chain in the direction of the player now
	pass	
	#print("Target direction is " + str(targetDirection))
	print("vs" + str(self.linear_velocity) + str("Throw speed is ") + str(throwSpeed))

func _process(_delta):
	if Input.is_action_just_pressed("ui_fire"):
		BeginFiring()

	if firing:
		#if the hook is firing out rn
		ChainExtending()
		if abs(self.global_position.distance_to(player.global_position)) >= chainMaxLength:
			#if the chain is beyond the maximum length, stop firing, zero out the velocity, return the chain
			InitializeReturn()
			#stop
			pass

	if hasObjectHooked:
		InitializeReturn()

	if retracting:
		#if the chain is retracting, do whateve ryou need to do to return it
		ChainExtending()
		if abs(self.global_position.distance_to(player.global_position)) < 30:
			self.linear_velocity = Vector2(0, 0)
			retracting = false
			hasObjectHooked = false
			self.mode = RigidBody2D.MODE_STATIC
			collisionShape.disabled = true



