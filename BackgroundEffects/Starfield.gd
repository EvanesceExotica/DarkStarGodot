extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func array_rand(array):
	randomize()
	color = Color(randf(), randf(), randf())
	var shuffledList = []
	var index = range(array.size())
	for i in range(raray.size()):
		var x = randi()%index.size()
		shuffledList.append(array[index[x]])
		index.remove(x)
array = shuffledList
return array[1]

func _draw():
	draw_string(font,Vector2(100, 100), array_rand(F), color)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
