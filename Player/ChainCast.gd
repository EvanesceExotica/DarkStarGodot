extends RayCast2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var chain = get_node("Chain")
onready var parent = get_parent()
signal Colliding(enemy)
var startTarget
var endTarget

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func Cast():
	#we want to cast to player, then swap to cast to enemy depending
	self.global_position = startTarget.global_position
	raycast.cast_to = to_local(System.player.global_position)
	chain.add_point(to_local(System.darkStar.global_position))
	chain.add_point(to_local(System.player.global_position))



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.is_colliding:
		print("Colliding with " + raycast.get_collider())
	if self.is_colliding && !parent.chainList.has(raycast.get_collider()):
		#if the raycast is colliding and this enemy isn't already in our chain
		var enemy = raycast.get_collider()
		emit_signal("Colliding", enemy)
	pass
