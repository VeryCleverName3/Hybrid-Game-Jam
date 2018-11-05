extends CanvasLayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_PlayAgain_pressed():
	switcher.return_to_last()


func _on_LevelSelect_pressed():
	switcher.switch_scene("res://LevelSelect.tscn")


func _on_MainMenu_pressed():
	switcher.switch_scene("res://MainMenu.tscn")
