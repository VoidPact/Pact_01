extends KinematicBody2D

func _physics_process(delta):
	handle_movement()

func handle_movement():
	if Input.is_action_pressed("move_left"):
		rpc("move", position.x - 10)
	if Input.is_action_pressed("move_right"):
		rpc("move", position.x + 10)

sync func move(dist):
	position.x = dist