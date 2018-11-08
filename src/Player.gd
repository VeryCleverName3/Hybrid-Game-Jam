extends KinematicBody2D

export(int) var gravity
export(int) var walkspeed
export(int) var jumpspeed
export(int) var maxNumJumps  = 1
var touchingGround = false; #Setting velocity.y to 0 also makes is_on_floor() false;
var groundCounter = 1
var velocity = Vector2()
var xscl
var yscl
var numJumps = 0
signal kill
signal pause

func _ready():
	xscl = (get_viewport().size.x / 1024) * .25
	yscl = (get_viewport().size.y / 600) * .25
	# Scale the sprites
	$TopSprite.scale = Vector2(xscl, yscl)
	$TopSprite.position = Vector2(0, -((xscl * 100) / 2))
	$BottomSprite.scale = Vector2(xscl, yscl)
	$BottomSprite.position = Vector2(0, (xscl * 100) / 2)
	# Scale the collider
	var transform = $Hitbox.shape
	var oldscale = transform.extents
	transform.extents = Vector2(oldscale.x * (xscl * 2), oldscale.y * (2 * yscl))
	
func _physics_process(delta):
	velocity.y += delta * gravity
	if(is_on_floor()):
		velocity.y = 0.1
		numJumps = maxNumJumps - 1
		touchingGround = true
		groundCounter = 1
	else:
		groundCounter -= 1
		if(groundCounter < 0):
			touchingGround = false
	velocity.x = 0
	if (Input.is_action_pressed("ui_right")):
		velocity.x += walkspeed
	if (Input.is_action_pressed("ui_left")):
		velocity.x -= walkspeed
	if (Input.is_action_just_pressed("ui_space") && touchingGround):
		velocity.y = -jumpspeed
	elif (Input.is_action_just_pressed("ui_space") && numJumps > 0):
		velocity.y = -jumpspeed
		numJumps -= 1
	if (Input.is_action_pressed("ui_cancel")):
		emit_signal("pause")
		
	move_and_slide(velocity, Vector2(0, -1))
	
func _process(delta):
	if (self.position.y > get_viewport().size.y):
		emit_signal("kill")