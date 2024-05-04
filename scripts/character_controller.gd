extends CharacterBody3D

const MAXSPEED = 5.0
const ACC = 0.5
const DESACC = 0.5
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var velocity_debug: bool = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu"):
		get_tree().quit()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if !is_on_floor():
		velocity.y -= gravity * delta
		
	# Handle jump.
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized() * MAXSPEED
	
	var acceleration = ACC if direction else DESACC
	velocity.x = move_toward(velocity.x, direction.x, acceleration)
	velocity.z = move_toward(velocity.z, direction.z, acceleration)
	
	move_and_slide()
