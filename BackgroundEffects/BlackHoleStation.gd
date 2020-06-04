extends Sprite

onready var interactableObject = get_node("InteractableObject")
var allSanePassengers = []

onready var disembarkPosition = get_node("DisembarkPosition")

onready var outsideCamera = get_node("OutsideCamera")
onready var insideCamera = get_node("InsideCamera")
signal EnteredBlackHoleStation

func _ready():
	pass
	#outsideCamera.current = true

func setCurrentCamera():
	outsideCamera.current = true

func _on_Area2D_mouse_entered():
	interactableObject.handInZone = true
	pass

func _on_Area2D_mouse_exited():
	interactableObject.handInZone = false
	pass

func DropOffPassengers():
	pass
	for character in get_tree().get_nodes_in_group("Characters"):
		if character.IsSane():
			#take the character off of the ship
			allSanePassengers.append(character) #list for characters who made it to the end
			character.global_position = disembarkPosition.global_position
			character.deathHandler.disembarkCharacter(character)


func processInteraction():
	emit_signal("EnteredBlackHoleStation")
	insideCamera.current = true
	
func _on_Button_pressed():
	DropOffPassengers()


func _on_ReturnToShip_pressed():
	SignalManager.emit_signal("ViewInsideShip")
	pass # Replace with function body.
