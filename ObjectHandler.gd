extends Node2D

var distortions

func handleDistortionEffect(effect):
	print(effect.name + " is being handled")
	#print(distortions.name)
	print(distortions)
	#print(distortions.get_parent().name)
	if distortions:
		print("child added")
		distortions.add_child(effect)

func hideDistortionEffect(effect):
	effect.visible = false

func displayDistortionEffect(effect):
	effect.visible = true
func handleDistortionParent(viewport):
	distortions = viewport
