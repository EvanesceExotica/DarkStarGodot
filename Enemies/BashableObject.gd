extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var beingBashed
onready var parentRB = get_parent()
var throwSpeed = 1000;
# Called when the node enters the scene tree for the first time.
func _ready():
	parentRB.add_to_group("Bashable")
	pass # Replace with function body.

func BashMe():
	pass # Replace with function body.
	beingBashed = true
	var origin = self.global_position
	var mousePos = get_global_mouse_position() #Input.mousePosition
	var trans = mousePos - origin;
	trans = trans.normalized() #have to set vector to equal its normalized value, don't forget
	parentRB.linear_velocity = Vector2(trans.x, trans.y) * throwSpeed


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
