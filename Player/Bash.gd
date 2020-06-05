extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var enemyInBashZone = true
var bashableEnemy = null
onready var player = get_parent()
signal bashReleased

func _input(event):
	if event.is_action_pressed("ui_bash"):
		if bashableEnemy != null:
			StartBash()
#			bashableEnemy.bashableObject.BashMe()
	if event.is_action_released("ui_bash"):
		emit_signal("bashReleased")


func StartBash():
	System.SlowDownTime()
	player.linear_velocity = Vector2(0, 0)	
	bashableEnemy.linear_velocity = Vector2(0, 0)
	yield(self, "bashReleased")
	System.SpeedUpTime()
	bashableEnemy.bashableObject.BashMe()

func _ready():
	pass # Replace with function body.

func _on_Bash_body_entered(body):
	if body.is_in_group("Bashable"):
		bashableEnemy = body

func _on_Bash_body_exited(body):
	if body == bashableEnemy:
		bashableEnemy = null

	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
