extends CharacterBody3D

const SPEED = 2.0
const JUMP_VELOCITY = 4.5
const MOUSE_SENS = 0.005
const MAX_ANGLE = deg_to_rad(45)

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var anim_player = $Mesh/animations/AnimationPlayer
@onready var head = $Head
@onready var mesh = $Mesh


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		var y_axis_rotation = event.relative.x * MOUSE_SENS
		rotate_y(-y_axis_rotation)
		mesh.rotate_y(y_axis_rotation)
		
		head.rotate_x(-event.relative.y * MOUSE_SENS)
		head.rotation.x = clamp(head.rotation.x, -MAX_ANGLE, MAX_ANGLE)


func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if input_dir.length() > 0:
		mesh.rotation.y = lerp_angle(
			mesh.rotation.y,
			head.rotation.y + input_dir.angle_to(Vector2.UP),
			0.15
		)
	
	if direction:
		if anim_player.current_animation != "forward":
			anim_player.play("forward")
		
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		if anim_player.current_animation != "idle":
			anim_player.play("idle")
			
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
