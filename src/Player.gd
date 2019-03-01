extends KinematicBody2D

export(int) var gravity = 1000
export(int) var walkspeed = 400
export(int) var jumpspeed = 500
export(int) var maxNumJumps  = 1
export(int) var boostMultiplier = 1
var animationPlayer
var armOld
var armNew
var arm2Old
var arm2New
var legOld
var legNew
var leg2Old
var leg2New
var headOld
var headNew
var torsoOld
var torsoNew
var boostSpeed = 1
var teleportNum = 1 #Teleport stuff
var isGliding = false #It means is gliding, Keon- don't delete it
var wallJumps = 0
var maxWallJumps = 0
var touchingGround = false; #Setting velocity.y to 0 also makes is_on_floor() false;
var groundCounter = 1
var velocity = Vector2()
var xscl
var yscl
var numJumps = 0
var canBoost = true
signal kill
signal pause
var justTouchedGround = false
var hasJumped = false

#Here's a list of ability names:
#doubleJump
#teleport
#boost
#glide
#climb
#wallJump

func boost():
	if (canBoost):
		boostSpeed=boostMultiplier
		$boostTime.start()
		canBoost = false
		
func load_textures():
	var file2check = File.new()
	if (file2check.file_exists("res://PlayerSprites/" + PlayerVars.ab2 + "arm.png") && file2check.file_exists("res://PlayerSprites/" + PlayerVars.ab2 + "leg.png")):
		arm2New.texture = load("res://PlayerSprites/" + PlayerVars.ab2 + "arm.png")
		armNew.texture = load("res://PlayerSprites/" + PlayerVars.ab2 + "arm.png")
		leg2New.texture = load("res://PlayerSprites/" + PlayerVars.ab2 + "leg.png")
		legNew.texture = load("res://PlayerSprites/" + PlayerVars.ab2 + "leg.png")
	else:
		armNew.texture = load("res://PlayerSprites/nospritearm.png")
		arm2New.texture = load("res://PlayerSprites/nospritearm.png")
		legNew.texture = load("res://PlayerSprites/nospriteleg.png")
		leg2New.texture = load("res://PlayerSprites/nospriteleg.png")
		
	if (file2check.file_exists("res://PlayerSprites/" + PlayerVars.ab1 + "torso.png") && file2check.file_exists("res://PlayerSprites/" + PlayerVars.ab1 + "head.png")):
		torsoNew.texture = load("res://PlayerSprites/" + PlayerVars.ab1 + "torso.png")
		headNew.texture = load("res://PlayerSprites/" + PlayerVars.ab1 + "head.png")
	else:
		headNew.texture = load("res://PlayerSprites/nospritehead.png")
		torsoNew.texture = load("res://PlayerSprites/nospritetorso.png")
		
func _ready():
	animationPlayer = get_node("AnimationPlayer")
	armOld = get_node("AnimationPlayer/voidtorso/voidlimbsection")
	armNew = get_node("Torso/Arm")
	arm2Old = get_node("AnimationPlayer/voidtorso/voidlimbsection3")
	arm2New = get_node("Torso/Arm2")
	legOld = get_node("AnimationPlayer/voidtorso/voidlimbsection4")
	legNew = get_node("Torso/Leg")
	leg2Old = get_node("AnimationPlayer/voidtorso/voidlimbsection2")
	leg2New = get_node("Torso/Leg2")
	headOld = get_node("AnimationPlayer/voidtorso/voidhead")
	headNew = get_node("Torso/Head")
	torsoOld = get_node("AnimationPlayer/voidtorso")
	torsoNew = get_node("Torso")
	load_textures()
	if(PlayerVars.ab1 == "doubleJump"):
		maxNumJumps += 1;
	if(PlayerVars.ab2 == "doubleJump"):
		maxNumJumps += 1;
	if(PlayerVars.ab1 == "boost"):
		boostMultiplier += 1;
	if(PlayerVars.ab2 == "boost"):
		boostMultiplier +=1;
	if(PlayerVars.ab2 == "wallJump"):
		maxWallJumps += 1
	if(PlayerVars.ab2 == "wallJump"):
		maxWallJumps += 1
	teleportNum = 1
	animationPlayer.play("Default")
	
#	xscl = (get_viewport().size.x / 1024) * .25
#	yscl = (get_viewport().size.y / 600) * .25
#	# Scale the sprites
#	$TopSprite.scale = Vector2(xscl, yscl)
#	$TopSprite.position = Vector2(0, -((xscl * 100) / 2))
#	$BottomSprite.scale = Vector2(xscl, yscl)
#	$BottomSprite.position = Vector2(0, (xscl * 100) / 2)
#	# Scale the collider
#	var transform = $Hitbox.shape
#	var oldscale = transform.extents
#	transform.extents = Vector2(oldscale.x * (xscl * 2), oldscale.y * (2 * yscl))
	
func _physics_process(delta):
	armNew.transform = armOld.transform
	arm2New.transform = arm2Old.transform
	legNew.transform = legOld.transform
	leg2New.transform = leg2Old.transform
	velocity.y += delta * gravity
	if(is_on_floor()):
		velocity.y = 0.1
		numJumps = maxNumJumps - 1
		wallJumps = maxWallJumps
		justTouchedGround = true
		hasJumped = false
		if(touchingGround):
			justTouchedGround = false
		touchingGround = true
		groundCounter = 1
	else:
		groundCounter -= 1
		if(groundCounter < 0):
			touchingGround = false
	if(is_on_ceiling()):
		velocity.y = 0
	if(animationPlayer.current_animation != "Jump" and not touchingGround and (not hasJumped)):
		animationPlayer.play("Jump")
		hasJumped = true
	velocity.x = 0
	if (Input.is_action_pressed("ui_ability1")):
		if (PlayerVars.ab1 =="boost"):
			boost();
		if(PlayerVars.ab1 == "teleport"):
			teleportNum = 1000
		if(PlayerVars.ab1 == "glide"):
			isGliding = true
		if(PlayerVars.ab1 == "climb" and is_on_wall() and velocity.y > -200):
			velocity.y = -200
	if (Input.is_action_pressed("ui_ability2")):
		if (PlayerVars.ab2 =="boost"):
			boost();
		if(PlayerVars.ab2 == "teleport"):
			teleportNum = 1000
		if(PlayerVars.ab2 == "glide"):
			isGliding = true
		if(PlayerVars.ab2 == "climb" and is_on_wall() and velocity.y > -200):
			velocity.y = -200
			
	if(isGliding and velocity.y > 100):
		velocity.y = 100
	isGliding = false
		
	if(is_on_wall() and wallJumps > 0 and Input.is_action_just_pressed("ui_space")):
		velocity.y = -jumpspeed * 1.5
		wallJumps -= 1
	
	if (Input.is_action_pressed("ui_right")):
		velocity.x += walkspeed * boostSpeed * teleportNum
		armOld.flip_h = true
		armNew.flip_h = true
		arm2Old.flip_h = true
		arm2New.flip_h = true
		legOld.flip_h = true
		legNew.flip_h = true
		leg2Old.flip_h = true
		leg2New.flip_h = true
		headOld.flip_h = true
		headNew.flip_h = true
		torsoOld.flip_h = true
		torsoNew.flip_h = true
	if (Input.is_action_pressed("ui_left")):
		armOld.flip_h = false
		armNew.flip_h = false
		arm2Old.flip_h = false
		arm2New.flip_h = false
		legOld.flip_h = false
		legNew.flip_h = false
		leg2Old.flip_h = false
		leg2New.flip_h = false
		headOld.flip_h = false
		headNew.flip_h = false
		torsoOld.flip_h = false
		torsoNew.flip_h = false
		velocity.x -= walkspeed * boostSpeed * teleportNum
	if(not (Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left")) and touchingGround):
		animationPlayer.play("Default")
	if(Input.is_action_just_pressed("ui_left") or justTouchedGround):
		if(touchingGround):
			animationPlayer.play("Run")
	elif(Input.is_action_just_pressed("ui_right") or justTouchedGround):
		if(touchingGround):
			animationPlayer.play("Run")
		
		
	if (Input.is_action_just_pressed("ui_space") && touchingGround):
		velocity.y = -jumpspeed
	elif (Input.is_action_just_pressed("ui_space") && numJumps > 0):
		velocity.y = -jumpspeed
		numJumps -= 1
	if (Input.is_action_pressed("ui_cancel")):
		emit_signal("pause")
	teleportNum = 1
	move_and_slide(velocity, Vector2(0, -1))
	var numberOfCollisions = get_slide_count()
	if numberOfCollisions > 0:
		for i in range(get_slide_count()):
			_on_Collision(get_slide_collision(i))
	
func _process(delta):
	if (self.position.y > 10000):
		emit_signal("kill")

func _on_boostTime_timeout():
	canBoost = true
	boostSpeed = 1

func collisionWithSpike():
	emit_signal("kill")

func _on_Collision(body):
	match body.collider.name.split("#")[0]:
		"Spike":
			collisionWithSpike()
		"Bottom":
			collisionWithSpike()