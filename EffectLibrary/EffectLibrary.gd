extends Node2D

export (Dictionary) var effectLibary = {}

var currentEffects = {}
var parent

func _ready():    
	pass
	parent = get_parent()
	parent.connect("newAttributeAdded", self, "InitializeEffect")
	parent.connect("attributeRemoved", self, "StopEffect")


func InitializeEffect(attribute):
	var effect
	if attribute.effect.empty():
		#if there's no visual effect associated with this attribute
		return
	if !currentEffects.has(attribute.effect):
		#if this effect hasn't already been instantiated on the character before
		effect = effectLibary[attribute.effect].instance() #.emitting = true
		#global position is set after you add the child
		add_child(effect)
		effect.global_position = get_parent().global_position
		currentEffects[attribute.effect] = effect
	else:
		#if this effect has already been used before, set it to this variable
		effect = currentEffects[attribute.effect] 

	for child in effect.get_children():
		#make all the particles start emitting
		if child is Particles2D:
			child.emitting = true


	pass

func StopEffect(attribute):
	if attribute.effect.empty():
		return
	var effect = currentEffects[attribute.effect]
	for child in effect.get_children():
		if child is Particles2D:
			child.emitting = false
	#effectLibary[attribute.effect].emitting = false
	pass
