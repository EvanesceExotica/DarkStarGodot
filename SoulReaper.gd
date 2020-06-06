extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var enemy = get_parent()
var weakPointSpawnAmount = 0
var maxWeakPointsSpawned = 3
onready var weakPoints = get_children()
var remainingWeakpoints
var numberOfSpikes = 0
var maxNumberOfSpikes = 3
signal finishedSpawningWeakPoints
var chargeUpPoint
var timesToFire = 1
var spikedPoints = []

# func SpawnAroundEnemy():
# 	var randomIndex = randi()%positions.size()
# 	var newPosition = positions[randomIndex]
# 	var newWeakSpot = soulNode.instance()
# 	newWeakSpot.global_position = newPosition
# 	newWeakSpot.connect("TimedOut", self, "SpawnWeakPoints")



# Called when the node enters the scene tree for the first time.
func _ready():
	for point in weakPoints:
		if point is Timer:
			weakPoints.erase(point)
	for point in weakPoints:
		point.connect("WeakPointClosed", self, "CheckWeakPoints")
		point.connect("WeakPointSpiked", self, "IncrementSpikeCounter")
		
	pass

func IncrementSpikeCounter(whichWeakPoint):
	#remove the weak point that was spiked so it doesn't come up again
	spikedPoints.append(whichWeakPoint)
	remainingWeakpoints.erase(whichWeakPoint)
	#add to the number of times weak poitns have been spiked
	numberOfSpikes+=1
	#if the weak points have been spiked three times, rip out the soul
	if numberOfSpikes >= 3:
		enemy.RipOutSoul()
#else check for more weak points
	else:
		CheckWeakPoints()

func ActivateWeakPoints():
	#get a random index in the remaining weakpoints
	var randomIndex = randi()%remainingWeakpoints.size()

	#choose a random weakpoint from the list to activate
	var weakPointToActivate = remainingWeakpoints[randomIndex]
	if weakPointSpawnAmount == chargeUpPoint:
		remainingWeakpoints.erase(weakPointToActivate)
		remainingWeakpoints.push_back(weakPointToActivate)
		remainingWeakpoints[0].ChargeUp()
	#call the 'expose weakpoint' method, wait for the weak point to either close or be spiked
	weakPointToActivate.ExposeWeakPoint()
	weakPointSpawnAmount+=1; #add to the number of weakpoints that've been activated already (there'll be a maxiumum)

func CheckWeakPoints():
	if weakPointSpawnAmount >= 3:
		#if the number of weakpoints that have opened has reached max, we want to end the bash. Conseuuence for this is *player* getting launched off maybe? 
		SignalManager.emit_signal("BashComplete")
		#emit_signal("finishedSpawningWeakPoints")
	else:
		#if there are still weak points to activate, choose another to activate
		ActivateWeakPoints()
			#if the weak points we've activated is equal to the point in which we've chosen to fire at the player
			
func ChooseFirePoint():
	#choosing on which weakpoint activation to try and fire, not which weakpoint to fire from
	#should be four.
	var chargeUpPoint = randi()%maxWeakPointsSpawned+1

func BeginReapingSoul():
	remainingWeakpoints = [] + weakPoints
	ChooseFirePoint()
	CheckWeakPoints()


func _input(event):
	pass
#	if event.is_action_pressed("ui_interact"):
#		CheckWeakPoints()
