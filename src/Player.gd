extends KinematicBody2D

export(int) var gravity
export(int) var walkspeed
export(int) var jumpspeed
export(int) var maxNumJumps  = 1
export(int) var boostMultiplier = 1
export(String) var ab1
export(String) var ab2
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

func _ready():
	if(ab1 == "doubleJump"):
		maxNumJumps += 1;
	if(ab2 == "doubleJump"):
		maxNumJumps += 1;
	if(ab1 == "boost"):
		boostMultiplier += 1;
	if(ab2 == "boost"):
		boostMultiplier +=1;
	if(ab1 == "wallJump"):
		maxWallJumps += 1
	if(ab2 == "wallJump"):
		maxWallJumps += 1
	teleportNum = 1
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
	velocity.y += delta * gravity
	if(is_on_floor()):
		velocity.y = 0.1
		numJumps = maxNumJumps - 1
		wallJumps = maxWallJumps
		touchingGround = true
		groundCounter = 1
	else:
		groundCounter -= 1
		if(groundCounter < 0):
			touchingGround = false
	if(is_on_ceiling()):
		velocity.y = 0
	velocity.x = 0
	if (Input.is_action_pressed("ui_ability1")):
		if (ab1 =="boost"):
			boost();
		if(ab1 == "teleport"):
			teleportNum = 1000
		if(ab1 == "glide"):
			isGliding = true
		if(ab1 == "climb" and is_on_wall() and velocity.y > -200):
			velocity.y = -200
	if (Input.is_action_pressed("ui_ability2")):
		if (ab2 =="boost"):
			boost();
		if(ab2 == "teleport"):
			teleportNum = 1000
		if(ab2 == "glide"):
			isGliding = true
		if(ab2 == "climb" and is_on_wall() and velocity.y > -200):
			velocity.y = -200
			
	if(isGliding and velocity.y > 100):
		velocity.y = 100
	isGliding = false
		
	if(is_on_wall() and wallJumps > 0 and Input.is_action_just_pressed("ui_space")):
		velocity.y = -jumpspeed * 1.5
		wallJumps -= 1
	
	if (Input.is_action_pressed("ui_right")):
		velocity.x += walkspeed * boostSpeed * teleportNum
	if (Input.is_action_pressed("ui_left")):
		velocity.x -= walkspeed * boostSpeed * teleportNum
	if (Input.is_action_just_pressed("ui_space") && touchingGround):
		velocity.y = -jumpspeed
	elif (Input.is_action_just_pressed("ui_space") && numJumps > 0):
		velocity.y = -jumpspeed
		numJumps -= 1
	if (Input.is_action_pressed("ui_cancel")):
		emit_signal("pause")
	teleportNum = 1
	move_and_slide(velocity, Vector2(0, -1))
	
func _process(delta):
	if (self.position.y > get_viewport().size.y):
		emit_signal("kill")

func _on_boostTime_timeout():
	canBoost = true
	boostSpeed = 1
