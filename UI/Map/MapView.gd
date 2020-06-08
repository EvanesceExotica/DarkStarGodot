
#GDQuest Harvester game
extends ViewportContainer

class_name MapView

onready var icons = $Viewport/MapIcons
onready var viewport = $Viewport
export var MapSprite : PackedScene = preload("res://UI/Map/MapSprite.tscn")

func _ready():
	SignalManager.connect("NodeSpawned", self, "OnSpawnerNodeSpawned")
	pass # Replace with function body.

func registerCamera(camera):
	viewport.add_child(camera)

func registerMapObject(remoteTransform : RemoteTransform2D, icon: MapIcon) -> MapSprite:
	var mapSprite : MapSprite = MapSprite.instance()
	mapSprite.global_position = remoteTransform.global_position
	icons.add_child(mapSprite)
	mapSprite.setup(remoteTransform, icon)
	return mapSprite

func OnSpawnerNodeSpawned(node):
	if !node.is_in_group("MiniMap"):
		return
	var mapSprite = registerMapObject(node.get_node("MapTransform"), node.map_icon)
	node.connect("tree_exiting", mapSprite, "queue_free")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
