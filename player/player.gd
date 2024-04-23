extends CharacterBody3D

const SPEED = 4.0
const JUMP_VELOCITY = 4.5
const MOUSE_SENS = 0.001
const MAX_ANGLE = deg_to_rad(89)

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var head = $Head


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		var y_axis_rotation = event.relative.x * MOUSE_SENS
		rotate_y(-y_axis_rotation)
		head.rotate_x(-event.relative.y * MOUSE_SENS)
		head.rotation.x = clamp(head.rotation.x, -MAX_ANGLE, MAX_ANGLE)


func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
