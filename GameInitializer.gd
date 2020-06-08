extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var world := $World
onready var camera = get_node("World/PlayerCamera")
onready var mapView = $MapView
onready var playerSpawner = get_node("World/PlayerSpawner")

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.connect("PlayerSpawned", self, "onPlayerSpawned")
	camera.initializeMapCamera(mapView)
	ObjectHandler.handleDistortionParent($DistortMaskView/Viewport)
	playerSpawner.spawnPlayer()
	camera.initializeDistortionCamera()

func onPlayerSpawned(player) -> void:
	player.grabCamera(camera)
	SignalManager.emit_signal("NodeSpawned", player)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
