extends CharacterBody3D


const SPEED = 0.8
const SPRINT = 2
const MOUSE_SENS = 0.002
const TURN_SPEED = 10
const MAX_ROT_X = deg_to_rad(80)
const MAX_TILT_ANGLE = deg_to_rad(2)

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var time_passed_since = 0.0

@onready var animation_player = $AnimationPlayer
@onready var pivot = $Torso/Pivot
@onready var camera = $Torso/Pivot/Camera
@onready var body = $Body
@onready var head = $Body/Head
@onready var light = $Light
@onready var torso = $Torso
@onready var footsteps = $Footsteps
@onready var flashlight = $Flashlight


func _input(event):
	if event is InputEventMouseMotion:
		body.rotate_y(-event.relative.x * MOUSE_SENS)
		head.rotate_x(-event.relative.y * MOUSE_SENS)
		head.rotation.x = clamp(head.rotation.x, -MAX_ROT_X, MAX_ROT_X)
		light.rotation.y = body.rotation.y
		light.rotation.x = head.rotation.x


func _physics_process(delta):
	time_passed_since += delta
	
	torso.rotation.y = lerp_angle(torso.rotation.y, body.rotation.y, TURN_SPEED * delta)
	pivot.rotation.x = lerp_angle(pivot.rotation.x, head.rotation.x, TURN_SPEED * delta)
	
	if not is_on_floor():
		velocity.y -= gravity * delta

	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (body.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		var scalar = SPRINT if Input.is_action_pressed("sprint") else 1
		velocity.x = direction.x * SPEED * scalar
		velocity.z = direction.z * SPEED * scalar
		
		if animation_player.current_animation != "head_bob":
			animation_player.play("head_bob")
			
		if time_passed_since > SPEED / scalar:
			footsteps.play()
			time_passed_since = 0.0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	pivot.rotation.z = lerp_angle(pivot.rotation.z, sign(input_dir.x) * -MAX_TILT_ANGLE, 0.05)
	camera.rotation.x = lerp_angle(camera.rotation.x, sign(input_dir.y) * MAX_TILT_ANGLE, 0.05)

	move_and_slide()
