extends KinematicBody2D

var maxSpeed = 750
const LOWER_MAX_SPEED = 400
const UPPER_MAX_SPEED = 500
const ACCELERATION = 50
const DECELERATION = 0.75
const DECELERATION_BOUNDARY = 50

var velocity = Vector2(0, 0)

func find_player_velocity():
	
	if Input.is_action_pressed("move_left") and Input.is_action_pressed("move_up"):           # If player is moving diagonally, lowers the max speed to player doesn't move rediculously fast diagonally.
		maxSpeed = LOWER_MAX_SPEED
	elif Input.is_action_pressed("move_left") and Input.is_action_pressed("move_down"):
		maxSpeed = LOWER_MAX_SPEED
	elif Input.is_action_pressed("move_right") and Input.is_action_pressed("move_up"):
		maxSpeed = LOWER_MAX_SPEED
	elif Input.is_action_pressed("move_right") and Input.is_action_pressed("move_down"):
		maxSpeed = LOWER_MAX_SPEED
	else:
		maxSpeed = UPPER_MAX_SPEED
	
	if Input.is_action_pressed("move_left"):               # Movement for left, right, up, down.
		if velocity.x >= DECELERATION_BOUNDARY:            # When play inputs left movement, checks if player is moving right. If so, the player decelerates before accelerating left.
			velocity.x *= DECELERATION
		else:
			velocity.x -= ACCELERATION
			if velocity.x <= -maxSpeed:                    # Otherwise, player accelerates left. If above MAX_SPEED, player is reset to MAX_SPEED.
				velocity.x = -maxSpeed
	elif Input.is_action_pressed("move_right"):            # Code repeated for right movement, then for up and down.
		if velocity.x <= -DECELERATION_BOUNDARY:
			velocity.x *= DECELERATION
		else:
			velocity.x += ACCELERATION
			if velocity.x >= maxSpeed:
				velocity.x = maxSpeed
	else:		
		velocity.x *= DECELERATION                        # Player's horizontal speed decelerates when left and right isn't pressed.
		
	if Input.is_action_pressed("move_up"):
		if velocity.y >= DECELERATION_BOUNDARY:
			velocity.y *= DECELERATION
		else:
			velocity.y -= ACCELERATION
			if velocity.y <= -maxSpeed:
				velocity.y = -maxSpeed
	elif Input.is_action_pressed("move_down"):
		if velocity.y <= -DECELERATION_BOUNDARY:
			velocity.y *= DECELERATION
		else:
			velocity.y += ACCELERATION
			if velocity.y >= maxSpeed:
				velocity.y = maxSpeed
	else:		
		velocity.y *= DECELERATION

func _physics_process(delta):
	
	find_player_velocity()                             # Calls the player movement function.

	velocity = (move_and_slide(velocity, Vector2(0, 0)))
