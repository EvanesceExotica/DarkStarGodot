extends Node2D

onready var starView = get_node("Starview")
func _process(delta):
	var texture = starView.get_texture()
	$Screen.texture = texture
