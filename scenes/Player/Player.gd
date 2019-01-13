extends KinematicBody2D

var id
var info

func init(id, info):
	set_name(str(id))
	id = id
	info = info

# This is really bad
# RPCs should probably be by themselves and only call necessary stuff (e.g. set position)
func handle_movement():
	if Input.is_action_pressed("move_left"):
		rpc("move", position.x - 10)
	if Input.is_action_pressed("move_right"):
		rpc("move", position.x + 10)

sync func move(dist):
	position.x = dist