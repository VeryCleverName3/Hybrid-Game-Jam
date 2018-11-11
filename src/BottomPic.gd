extends AnimatedSprite

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


func _on_BottomRight_pressed():
	match (self.animation):
		"DoubleJump":
			PlayerVars.ab2 = "wallJump"
			self.animation = "Teleport"
		"Boost":
			PlayerVars.ab2 = "doubleJump"
			self.animation = "DoubleJump"
		"Teleport":
			PlayerVars.ab2 = "boost"
			self.animation = "Boost"


func _on_BottomLeft_pressed():
	match (self.animation):
		"DoubleJump":
			PlayerVars.ab2 = "boost"
			self.animation = "Boost"
		"Boost":
			PlayerVars.ab2 = "wallJump"
			self.animation = "Teleport"
		"Teleport":
			PlayerVars.ab2 = "doubleJump"
			self.animation = "DoubleJump"
