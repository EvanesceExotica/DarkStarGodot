extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var enemy = get_parent()
var weakPointSpawnAmount = 0
var maxWeakPointsSpawned = 3
onready var weakPoints = get_children()

var numberOfSpikes = 0
var maxNumberOfSpikes = 3
signal finishedSpawningWeakPoints

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

func IncrementSpikeCounter():
	numberOfSpikes+=1
	if numberOfSpikes >= 3:
		enemy.RipOutSoul()
	else:
		CheckWeakPoints()

func ActivateWeakPoints():
	var randomIndex = randi()%weakPoints.size()
	var weakPointToActivate = weakPoints[randomIndex]
	weakPointToActivate.ExposeWeakPoint()
	yield(weakPointToActivate, "WeakPointClosed")
	weakPointSpawnAmount+=1;

func CheckWeakPoints():
	print("Checking new weak point")
	if weakPointSpawnAmount >= 3:
		emit_signal("finishedSpawningWeakPoints")
	else:
		ActivateWeakPoints()

func _input(event):
	if event.is_action_pressed("ui_interact"):
		CheckWeakPoints()
#func _process(delta):
#	pass
