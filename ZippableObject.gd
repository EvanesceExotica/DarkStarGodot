extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var canBeHooked = false
var beingPulled = true
var stopDistance = 80
var pullTarget
onready var rbParent = get_parent() #rigidbody parent
var snapSpeed = 400

func _ready():
	pass # Replace with function body.


func PullMeForward(target):
	pullTarget = target
	var trans = target.global_position - self.global_position
	trans = trans.normalized() * snapSpeed
	rbParent.linear_velocity = Vector2(trans.x, trans.y)
	#rbParent.linear_velocity = Vector2(0, 0)
	#rbParent.linear_velocty = trans * snapSpeed
	

func StopPulling():
	beingPulled = false
	rbParent.linear_velocity = Vector2(0, 0)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if beingPulled && pullTarget != null:
		print(pullTarget.global_position)
		if abs(self.global_position.distance_to(pullTarget.global_position)) <= stopDistance:
			StopPulling()
			


