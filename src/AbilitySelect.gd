extends CanvasLayer

var imageL = Image.new()
var iconL = ImageTexture.new()
var imageR = Image.new()
var iconR = ImageTexture.new()

func _ready():
	imageL.load("res://leftArrow.png")
	iconL.create_from_image(imageL)
	$TopPic/TopLeft.icon = iconL
	$BottomPic/BottomLeft.icon = iconL
	imageR.load("res://rightArrow.png")
	iconR.create_from_image(imageR)
	$TopPic/TopRight.icon = iconR
	$BottomPic/BottomRight.icon = iconR

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Ok_pressed():
	print(PlayerVars.ab1)
	print(PlayerVars.ab2)
	switcher.switch_scene(PlayerVars.levelGoal)
