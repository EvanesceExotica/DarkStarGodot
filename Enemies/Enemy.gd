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
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
