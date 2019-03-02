extends CanvasLayer

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass



func _on_Resume_pressed():
	get_tree().paused = false
	var children = self.get_children()
	for child in children:
		child.hide()


func _on_MainMenu_pressed():
	get_tree().paused = false
	switcher.switch_scene("res://Scenes/MainMenu.tscn")


func _on_LevelSelect_pressed():
	get_tree().paused = false
	switcher.switch_scene("res://Scenes/LevelSelect.tscn")


func _on_Reset_pressed():
	get_tree().paused = false
	var children = self.get_children()
	for child in children:
		child.hide()
	var currentScene = get_tree().get_current_scene().get_filename()
	switcher.switch_scene(currentScene)
