extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_SafeZone_body_entered(body):
	print("Something left us ")
	SignalManager.emit_signal("PlayerReenteredZone")
func _on_SafeZone_body_exited(body):
	print("Something left us ")
	SignalManager.emit_signal("PlayerLeftZone")
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
