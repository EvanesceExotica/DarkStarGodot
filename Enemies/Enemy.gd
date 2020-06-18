extends RigidBody2D

var energyValue = 0.5
onready var bashableObject = get_node("BashableObject")
onready var soulReaper = get_node("SoulReaper")
func is_class(type):
	return type == "Enemy" or .is_class(type)

func get_class():
	return "Enemy"
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func Deconstruct():
	self.queue_free()
# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Enemies")
	pass # Replace with function body.

func BurstAndDropSoul():
	pass

func RipOutSoul():
	print("OUR SOUL GOT RIPPED OUT")
	self.modulate = Color.aliceblue
	add_to_group("Soulless")
	pass

func KnockOutSoul(enemy):
	#zero out velocity for both -- maybe make shockwave to show energy transfered into soul being knocked out
	self.linear_velocity = Vector2.ZERO
	enemy.linear_velocity = Vector2.ZERO
	enemy.RipOutSoul()
	self.RipOutSoul()

func _on_Enemy_body_entered(body : Node) -> void:
	print("WE COLLIDED")
	#if we've collided with something
	if bashableObject.beingBashed:
		#and we were just bashed by the player
		if body.is_in_group("Bashable"):
			#if what we've collided with is another bashable enemy
			KnockOutSoul(body)

func _on_Enemy_body_exited(body : Node) -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
