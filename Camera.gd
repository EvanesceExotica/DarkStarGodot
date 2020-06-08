extends Camera2D

#Borrowed from GDQuest Harvester
export var maxZoom = 5.0
var startZoom = zoom
var startPosition = Vector2.ZERO
onready var remoteMap = $RemoteMap
onready var remoteDistort = $RemoteDistort

func _ready():
	SignalManager.connect("MapToggled", self, "ToggleMap")

func RenderMapCamera(map):
	#trying to copy the map over
	var cameraMap = self.duplicate()
	map.registerCamera(cameraMap)
	remoteMap.remote_path = cameraMap.get_path()

func RenderDistortionCamera():
	var distortCamera = self.duplicate()
	remoteDistort.remote_path = distortCamera.get_path()

func ToggleMap(show, duration):
	#this is for zooming the map in and out
	if show:
		$Tween.interpolate_property(self, "zoom", zoom, startZoom, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	else:
		startPosition = position
		$Tween.interpolate_property(self, "zoom", zoom, Vector2(maxZoom, maxZoom), duration, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
	$Tween.start()