extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var firstChainCast = false
var chainList = []
var raycasts = []
onready var raycast = get_node("Raycast")
#onready var chain = get_node("Chain")
var raycastTemplate = preload("res://Player/ChainRaycast.tscn")

func StartChain():
	print("Chain started!")
	#start chain and raycast from dark star to player
	# raycast.global_position = System.darkStar.global_position
	# raycast.raycast.cast_to = to_local(System.player.global_position)
	raycast.startTarget = System.darkStar
	raycast.endTarget = System.player
	#raycast.chain.add_point(to_local(System.player.global_position))
	firstChainCast = true

func CastChain():
	raycast.Cast()
	# raycast.global_position = System.darkStar.global_position
	# raycast.raycast.cast_to = to_local(System.player.global_position)
	# #raycast.chain.points[0] = (to_local(System.darkStar.global_position))
	# #raycast.chain.points[1] = to_local(System.player.global_position)
	# #raycast.chain.points[1] = (-1)*to_local(System.player.global_position)
	# raycast.chain.points[0] = to_local(System.darkStar.position)
	# raycast.chain.points[1] = to_local(System.player.position)
	# print("Player position " + str(to_local(System.player.global_position)) + "vs" + str(raycast.chain.points[1]))
	# #raycast.chain.points[0] = (to_local(System.darkStar.global_position))
	#raycast.chain.points[1] = to_local(System.player.global_position)

func AddNewChainSegment(enemy):
	var newRayCast = raycastTemplate.instance()#RayCast2D.new()
	add_child(newRayCast)
	newRayCast.global_position = enemy.global_position 
	newRayCast.cast_to = to_local(System.player.global_position)
	raycast.chain.add_point(to_local(System.player.global_position))
	raycast.chain.add_point(to_local(System.player.global_position))
	raycast.connect("Collided", self, "CheckChildCollision")	


func ChainEnemy(enemy):
	#maybe being chained slows an enemies speed drastically?
	chainList.append(enemy)
	AddNewChainSegment(enemy)

func BashBackIntoStar():
	#this should, hopefully, force the player to travel back along the enemies they've chained, then drag them screaming into the star
	for enemy in chainList:
		$Tween.interpolate_property(System.player, "position", System.player.global_position, enemy.global_position, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		yield($Tween, "tween_completed")
		enemy.RipOutSoul()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		StartChain()
func CheckChildCollision(enemy):

	pass
func Cast():
	pass
# Called when the node enters the scene tree for the first time.
func _ready():
	raycast.connect("Collided", self, "CheckChildCollision")	
	# var timer = Timer.new()
	# timer.set_wait_time(1)
	# timer.start()
	# yield(timer, "timeout")
	# StartChain()

#func BashThroughEnemies():

func _process(delta):
	if firstChainCast:
		CastChain()
