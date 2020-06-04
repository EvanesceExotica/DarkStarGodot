extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var parent = get_parent()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _on_HookableObjectDetector_area_entered(area):
	if area.has_method("PullMeForward"):#is_type("ZippableObject"):
		area.PullMeForward(parent.player)
		parent.hasObjectHooked = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
