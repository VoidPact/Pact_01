extends KinematicBody2D


# MOVEMENT 
const XINIT = 500
const YINIT = 200

export var X_ACCEL = 200
export var Y_ACCEL = 1000

const MAX_X_SPEED = 500
const MAX_Y_SPEED = 1000

const GRAV = 50
const FRIC = 0.2
const FLOOR_NORMAL = Vector2(0,-1)

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
		velocity.x -= X_ACCEL
	if Input.is_action_pressed("move_right"):
		velocity.x += X_ACCEL
	if Input.is_action_pressed("jump") && is_on_floor():
		velocity.y -= Y_ACCEL
	
	velocity.y += GRAV
	
	if Input.is_action_pressed("move_left") == Input.is_action_pressed("move_right"):
		velocity.x = lerp(velocity.x, 0, FRIC)
	
	# CLAMP
	velocity.x = clamp(velocity.x, -MAX_X_SPEED, MAX_X_SPEED)
	velocity.y = clamp(velocity.y, -MAX_Y_SPEED, MAX_Y_SPEED)
		
	
	move_and_slide(velocity, FLOOR_NORMAL)
	rpc("update_position", position.x, position.y)
	
remote func update_position(xpos,ypos):
	position.x = xpos
	position.y = ypos