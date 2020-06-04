extends Spatial

onready var background = get_node("BGNebula")
onready var particleHolder = get_node("ParticleHolder")
onready var startingGroup = particleHolder.get_node("StartingGroup")
onready var waitingGroup = particleHolder.get_node("WaitingGroup")
onready var waitingGroup2 = particleHolder.get_node("WaitingGroup2")
#onready var waitingGroup3 = particleHolder.get_node("WaitingGroup2")

var direction
var moving = false

var accelerating = false

var slowing = false

var maxSpeedVector = -0.1#Vector3(-0.01, 0, 0)
var currentSpeedVector = maxSpeedVector
#when the stars get double the distance of the particle box emitter extents away 
#they should be completely off screen
#place them back on the other side of the screen
var shiftingElements = []

func _ready():
	shiftingElements.append(startingGroup)
	shiftingElements.append(waitingGroup)
	shiftingElements.append(waitingGroup2)
	#shiftingElements.append(waitingGroup3)
	background.get_surface_material(0).set_shader_param("speed_scale", 0.00)
	SignalManager.connect("OnArrival", self, "setStopped")
	SignalManager.connect("OnDeparture", self, "setMoving")
	
func setMoving():
	moving = true
	background.get_surface_material(0).set_shader_param("speed_scale", 0.01)
	startMovingTween()

func setStopped(nothing):
	print("We should be stopping now")
	startSlowingTween()

func startSlowingTween():
	print("We're slowing down now!")
	slowing = true
	$Tween.interpolate_property(self,"currentSpeedVector", -0.1, 0, 4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	pass

func startMovingTween():
	accelerating = true
	$Tween.interpolate_property(self,"currentSpeedVector", 0, -0.1, 4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	pass

func setUpDirection(_direction):
	direction = _direction
	if direction == -1:
		#if we're moving to the right
		waitingGroup.translation.x = -20
	elif direction == 1:
		waitingGroup.translation.x = 20
		#if we're moving to the left

func translateGroups():
	for i in range(shiftingElements.size()):
		#shiftingElements[i].translate(Vector3(-0.01, 0, 0))
		shiftingElements[i].translate(Vector3(currentSpeedVector, 0, 0))

	if shiftingElements[0].translation.x <= -30:
		#when it's about halfway away, reset it to the end
		#print(shiftingElements[0].name + "reached end point at " + str(OS.get_time().second))
		for i in range (shiftingElements.size()):
			var item = shiftingElements[i]
			#print("At End reached " +  item.name + " is at " + str(item.translation.x))
		var lastPosition = shiftingElements[shiftingElements.size()-1]
		#print("First position at end ," + lastPosition.name + " is at point " + str(lastPosition.translation.x))

		shiftingElements[0].translation = Vector3(30, 0, 0)
		var movingElement = shiftingElements.pop_front()
		shiftingElements.push_back(movingElement)
		var string = ""
		for i in range (shiftingElements.size()):
			var item = shiftingElements[i]
			#print("Now positions are " +  item.name + " is at " + str(item.translation.x))
			#string+= " " + str(shiftingElements[i].name)
	#	print("Now in this order: " + string)

func translateParticleSystems():
	startingGroup.translate(Vector3(-0.01, 0, 0))
	waitingGroup.translate(Vector3(-0.01, 0, 0))
	#this will depend on the direction
	if startingGroup.translation.x <= -20:
		startingGroup.translation = Vector3(20, 0, 0)
		#startingGroup.translation.x == 20
	if waitingGroup.translation.x <= -20:
		waitingGroup.translation = Vector3(20, 0, 0)
		#waitingGroup.translation.x = 20


func _process(delta):
	#translateParticleSystems()
	if moving:
		translateGroups()

func _on_Tween_tween_completed(object, key):
	if(slowing):
		# if we're slowing down to stop, this is the end of the tween and we've stopped, so set moving to false
		slowing = false
		moving = false
		background.get_surface_material(0).set_shader_param("speed_scale", 0.00)
		#we've come to a stop
	if(accelerating):
		#if we're accelerating from a stop but reached our top speed, turn accelerating off
		accelerating = false
		
