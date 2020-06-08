extends Camera2D

#written by forbjok on Reddit: https://www.reddit.com/r/godot/comments/eu5eyv/sprite_jittering/ */
# # Smoothing duration in seconds
const SMOOTHING_DURATION: = 0.2

# # The node to follow
# #export (NodePath) var targetPath = null
# #onready var target = get_node(targetPath)
var target 
export var maxZoom = 5.0

# # Current position of the camera
var current_position: Vector2

# Position the camera is moving towards
var destination_position: Vector2
var startZoom = zoom
var startPosition = Vector2.ZERO
onready var remoteMap = $RemoteMap
onready var remoteDistort = $RemoteDistort

func _ready() -> void:
	SignalManager.connect("MapToggled", self, "ToggleMap")
	SignalManager.connect("PlayerSpawned", self, "setTarget")
	current_position = position

func setTarget(player):
	target = player

func _process(delta: float) -> void:
	if target != null:
		destination_position = target.position
		current_position += Vector2(destination_position.x - current_position.x, destination_position.y - current_position.y) / SMOOTHING_DURATION * delta

		position = current_position.round()
		force_update_scroll()

#written by GDquest: https://www.youtube.com/watch?v=AobjNjzZhmo

#screenshake

#written by GDQuest: https://www.youtube.com/watch?v=twx7tGWxrNs in their "Harvester" project -- https://github.com/GDQuest/godot-2d-space-game/

#map and distortion stuff



func initializeMapCamera(map : MapView):
	#trying to copy the map over
	var cameraMap = self.duplicate()
	map.registerCamera(cameraMap)
	remoteMap.remote_path = cameraMap.get_path()

func initializeDistortionCamera():
	#duplicate camera, and place it as child of viewport
	var distortCamera = self.duplicate()
	ObjectHandler.handleDistortionEffect(distortCamera)
	remoteDistort.remote_path = distortCamera.get_path()

func ToggleMap(show, duration):
	#this is for zooming the map in and out
	if show:
		$Tween.interpolate_property(self, "zoom", zoom, startZoom, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	else:
		startPosition = position
		$Tween.interpolate_property(self, "zoom", zoom, Vector2(maxZoom, maxZoom), duration, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
	$Tween.start()
