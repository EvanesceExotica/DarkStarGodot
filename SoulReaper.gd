extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var enemy = get_parent()
onready var positionHolder = enemy.get_node("PositionHolder")
var positions 
var soulNode = preload("res://Enemies/SoulNode.tscn")

func SpawnAroundEnemy():
	var randomIndex = randi()%positions.size()
	var newPosition = positions[randomIndex]
	var newWeakSpot = soulNode.instance()
	newWeakSpot.global_position = newPosition



# Called when the node enters the scene tree for the first time.
func _ready():
	positions = soulNode.get_children()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
