extends Node

export var Player : PackedScene

func _ready() -> void:
	randomize()

func spawnPlayer() -> void:
	var player = Player.instance()
	get_parent().add_child(player)
	player.global_position = System.darkStar.global_position
	SignalManager.emit_signal("PlayerSpawned", player)
