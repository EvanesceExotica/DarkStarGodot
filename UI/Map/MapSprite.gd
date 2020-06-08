#implemented from GDQuest Harvester game
extends Sprite

class_name MapSprite

var actingRemoteTransform : RemoteTransform2D

func setup(remoteTransform : RemoteTransform2D, icon: MapIcon) -> void:
	actingRemoteTransform = remoteTransform
	remoteTransform.remote_path = get_path()
	texture = icon.texture
	modulate = icon.color
	scale = Vector2(icon.scale, icon.scale)

func clear() -> void:
	actingRemoteTransform.remote_path = ""
