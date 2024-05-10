extends CharacterBody3D

const MAXSPEED = 5.0
const ACC = 0.5
const DESACC = 0.5
const JUMP_VELOCITY = 4.5

@onready var camera_3d: Camera3D = $Camera3D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var velocity_debug: bool = false

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())

func _ready() -> void:
	camera_3d.current = is_multiplayer_authority()

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
