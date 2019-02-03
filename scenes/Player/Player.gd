extends KinematicBody2D


# MOVEMENT 
const XINIT = 500
const YINIT = 200

export var ACCEL = 200
const MAX_X_SPEED = 500

const GRAV = 50
const FRIC = 0.2

var velocity = Vector2()


# META INFO
var id
var info

func init(id, info):
	set_name(str(id))
	id = id
	info = info
	position.x = XINIT
	position.y = YINIT
	
	

# This is really bad
func handle_movement():
	if Input.is_action_pressed("move_left"):
		velocity.x -= ACCEL
	if Input.is_action_pressed("move_right"):
		velocity.x += ACCEL
	
	velocity.y += GRAV
	
	if Input.is_action_pressed("move_left") == Input.is_action_pressed("move_right"):
		velocity.x = lerp(velocity.x, 0, FRIC)
	
	velocity.x = clamp(velocity.x, -MAX_X_SPEED, MAX_X_SPEED)
	#if not (Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")):
	#	if velocity.x > 0:
	#		velocity.x -= FRIC
	#	elif velocity.x < 0:
	#		velocity.x += FRIC 
		
	
	move_and_slide(velocity)
	
	