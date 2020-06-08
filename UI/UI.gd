extends CanvasLayer


#onready var screenFader : TextureRect = $ScreenFader
onready var map : TextureRect = $MapDisplay
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
#	screenFader.fade_in()

func _unhandled_input(event):
	if event.is_action_pressed("toggle_map") && !map.isAnimating():
		map.toggle()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
