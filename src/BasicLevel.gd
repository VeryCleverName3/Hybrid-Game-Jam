extends Node2D

export(Vector2) var startPosition

func _ready():
	$Player.position = startPosition
	var children = $PauseScreen.get_children()
	for child in children:
		child.hide()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Player_kill():
	switcher.switch_scene("res://Scenes/KillScreen.tscn")

func _on_Player_pause():
	var children = $PauseScreen.get_children()
	for child in children:
		child.show()
	get_tree().paused = true