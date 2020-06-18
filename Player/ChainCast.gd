extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var chain = get_node("Chain")
onready var parent = get_parent()
onready var raycast = get_node("RayCast2D")
signal Collided(enemy)
var startTarget
var endTarget

func SetActive():
	raycast.enabled = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func Cast():
	#we want to cast to player, then swap to cast to enemy depending
	self.global_position = startTarget.global_position
	raycast.cast_to = to_local(endTarget.global_position)
	chain.points[0]=(to_local(startTarget.global_position))
	chain.points[1]=(to_local(endTarget.global_position))

func LinkToNewTarget(target):
	print("Linked to new target")
	endTarget = target

func LinkToEnd():
	var newPosition = Position2D.new()
	System.darkStar.add_child(newPosition)
	newPosition.global_position = System.player.global_position
	endTarget = newPosition

func SetInactive():
	raycast.enabled = false
	chain.default_color = Color.red

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	if raycast.is_colliding():
	#	print("Collding with " + str(raycast.get_collider().name))
		if(!parent.chainedEnemies.has(raycast.get_collider())):
		#if the raycast is colliding and this enemy isn't already in our chain
			var enemy = raycast.get_collider()
			emit_signal("Collided", enemy)
	# pass
