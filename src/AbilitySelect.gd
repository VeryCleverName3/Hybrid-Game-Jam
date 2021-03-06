extends CanvasLayer

var imageL = Image.new()
var iconL = ImageTexture.new()
var imageR = Image.new()
var iconR = ImageTexture.new()

func set_textures():
	var file2check = File.new()
	if (file2check.file_exists("res://PlayerSprites/" + PlayerVars.ab2 + "arm.png") && file2check.file_exists("res://PlayerSprites/" + PlayerVars.ab2 + "leg.png")):
		$Torso/Arm2.texture = load("res://PlayerSprites/" + PlayerVars.ab2 + "arm.png")
		$Torso/Arm.texture = load("res://PlayerSprites/" + PlayerVars.ab2 + "arm.png")
		$Torso/Leg2.texture = load("res://PlayerSprites/" + PlayerVars.ab2 + "leg.png")
		$Torso/Leg2.texture = load("res://PlayerSprites/" + PlayerVars.ab2 + "leg.png")
	else:
		$Torso/Arm2.texture = load("res://PlayerSprites/nospritearm.png")
		$Torso/Arm.texture = load("res://PlayerSprites/nospritearm.png")
		$Torso/Leg.texture = load("res://PlayerSprites/nospriteleg.png")
		$Torso/Leg2.texture = load("res://PlayerSprites/nospriteleg.png")
		
	if (file2check.file_exists("res://PlayerSprites/" + PlayerVars.ab1 + "torso.png") && file2check.file_exists("res://PlayerSprites/" + PlayerVars.ab1 + "head.png")):
		$Torso.texture = load("res://PlayerSprites/" + PlayerVars.ab1 + "torso.png")
		$Torso/Head.texture = load("res://PlayerSprites/" + PlayerVars.ab1 + "head.png")
	else:
		$Torso/Head.texture = load("res://PlayerSprites/nospritehead.png")
		$Torso.texture = load("res://PlayerSprites/nospritetorso.png")
		

func _ready():
	imageL.load("res://leftArrow.png")
	iconL.create_from_image(imageL)
	$TopLeft.icon = iconL
	$BottomLeft.icon = iconL
	imageR.load("res://rightArrow.png")
	iconR.create_from_image(imageR)
	$TopRight.icon = iconR
	$BottomRight.icon = iconR
	if (PlayerVars.ab1 == null):
		PlayerVars.ab1 = "doubleJump"
		PlayerVars.ab2 = "doubleJump"
	set_textures()
	$Torso/Camera.make_current()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Ok_pressed():
	print(PlayerVars.ab1)
	print(PlayerVars.ab2)
	switcher.switch_scene(PlayerVars.levelGoal)


func _on_TopLeft_pressed():
	match(PlayerVars.ab1):
		"doubleJump":
			PlayerVars.ab1 = "teleport"
		"teleport":
			PlayerVars.ab1 = "boost"
		"boost":
			PlayerVars.ab1 = "glide"
		"glide":
			PlayerVars.ab1 = "climb"
		"climb":
			PlayerVars.ab1 = "wallJump"
		"wallJump":
			PlayerVars.ab1 = "doubleJump"
	set_textures()


func _on_TopRight_pressed():
	match(PlayerVars.ab1):
		"doubleJump":
			PlayerVars.ab1 = "wallJump"
		"teleport":
			PlayerVars.ab1 = "doubleJump"
		"boost":
			PlayerVars.ab1 = "teleport"
		"glide":
			PlayerVars.ab1 = "boost"
		"climb":
			PlayerVars.ab1 = "glide"
		"wallJump":
			PlayerVars.ab1 = "climb"
	set_textures()


func _on_BottomRight_pressed():
	match(PlayerVars.ab2):
		"doubleJump":
			PlayerVars.ab2 = "wallJump"
		"teleport":
			PlayerVars.ab2 = "doubleJump"
		"boost":
			PlayerVars.ab2 = "teleport"
		"glide":
			PlayerVars.ab2 = "boost"
		"climb":
			PlayerVars.ab2 = "glide"
		"wallJump":
			PlayerVars.ab2 = "climb"
	set_textures()


func _on_BottomLeft_pressed():
	match(PlayerVars.ab2):
		"doubleJump":
			PlayerVars.ab2 = "teleport"
		"teleport":
			PlayerVars.ab2 = "boost"
		"boost":
			PlayerVars.ab2 = "glide"
		"glide":
			PlayerVars.ab2 = "climb"
		"climb":
			PlayerVars.ab2 = "wallJump"
		"wallJump":
			PlayerVars.ab2 = "doubleJump"
	set_textures()
