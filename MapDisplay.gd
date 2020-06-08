extends TextureRect


onready var anim = $AnimationPlayer

func toggle() -> void:
	if visible:
		anim.play("disappear")
	else:
		anim.play("appear")
	SignalManager.emit_signal("MapToggled", visible, anim.current_animation_length)

func isAnimating() -> bool:
	return anim.is_playing()


