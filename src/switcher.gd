extends Node2D

var current_scene_path = null
var history = []
var root_scene = "res://MainMenu.gd"

func switch_scene(path):
	#If not on the root scene, store the current scene as the last scene
	if current_scene_path:
		history.append(current_scene_path)
	#Update the current scene to represent the change
	current_scene_path = path
	get_tree().change_scene(path)
	
func return_to_last():
	#If there is a scene to return to that isn't the main scene
	if not history.empty():
		#Get the last scene visited from the END of the history array
		var target = history.pop_back()
		#Update the current scene to represent the change
		get_tree().change_scene(target)
		current_scene_path = target
	#If the only scene left to return to is the root scene
	#AND IT HASN'T YET BEEN RETURNED TO
	elif current_scene_path:
		#Go back to the root scene and set the current path to null
		#So this doesn't get re-run until a different scene has
		#been switched to
		get_tree().change_scene(root_scene)
		current_scene_path = null

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
