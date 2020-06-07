extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var firstChainCast = false
var chainedEnemies = []
var segments = []
onready var chaincast = get_node("Raycast")
#onready var chain = get_node("Chain")
var chaincastTemplate = preload("res://Player/ChainRaycast.tscn")

func StartChain():
	print("Chain started!")
	#start chain and raycast from dark star to player
	# raycast.global_position = System.darkStar.global_position
	# raycast.raycast.cast_to = to_local(System.player.global_position)

	#this is the first segment in the chain. It'll chain from the dark star to the player
	chaincast.startTarget = System.darkStar
	chaincast.endTarget = System.player

	#add it to the segments list
	segments.append(chaincast)

	#set that the first chain was cast
	firstChainCast = true

func CastChain():
	chaincast.Cast()
	

func AddNewChainSegment(enemy):
	print("New chain started!")
	var newChaincast = chaincastTemplate.instance()#RayCast2D.new()
	add_child(newChaincast)
	#link the new target to the enemy, then the enemy should link from the enemy to the dark star
	segments.back().LinkToNewTarget(enemy)
	#make the last segment in the chain imactive
	segments.back().SetInactive()
	segments.append(newChaincast)
	newChaincast.startTarget = enemy
	newChaincast.endTarget = System.player
	# newRayCast.global_position = enemy.global_position 
	# newRayCast.cast_to = to_local(System.player.global_position)
	# raycast.chain.add_point(to_local(System.player.global_position))
	# raycast.chain.add_point(to_local(System.player.global_position))
	newChaincast.connect("Collided", self, "CheckChildCollision")	

	#set this to the new active chaincast
	chaincast = newChaincast


func ChainEnemy(enemy):
	#maybe being chained slows an enemies speed drastically?
	chainedEnemies.append(enemy)
	AddNewChainSegment(enemy)

func BashBackIntoStar():
	#this should, hopefully, force the player to travel back along the enemies they've chained, then drag them screaming into the star
	for enemy in chainedEnemies:
		$Tween.interpolate_property(System.player, "position", System.player.global_position, enemy.global_position, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		yield($Tween, "tween_completed")
		enemy.RipOutSoul()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		StartChain()

func CheckChildCollision(enemy):
	#do stuff to enemy
	print("Checking collision of " + str(enemy.name))
	AddNewChainSegment(enemy)

func Cast():
	pass
# Called when the node enters the scene tree for the first time.
func _ready():
	chaincast.connect("Collided", self, "CheckChildCollision")	
	# var timer = Timer.new()
	# timer.set_wait_time(1)
	# timer.start()
	# yield(timer, "timeout")
	# StartChain()

#func BashThroughEnemies():

func _process(delta):
	if firstChainCast:
		for item in segments:
			item.Cast()
