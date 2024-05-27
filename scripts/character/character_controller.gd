class_name PlayerController
extends CharacterBody3D

const MAXSPEED = 5.0
const ACC = 0.5
const DESACC = 0.5
const JUMP_VELOCITY = 4.5
const WEAPON_CONTROL = 3.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var _gravity_value: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var last_direction: Vector3

var locomotion_flags_tracker: LocomotionFlagsTracker

@onready var camera_3d: Camera3D = %Camera3D


func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())
	locomotion_flags_tracker = LocomotionFlagsTracker.new(self)
	GameInstance.on_player_spawn_complete(self)


func _ready() -> void:
	camera_3d.current = is_multiplayer_authority()


func _physics_process(delta: float) -> void:
	if !is_multiplayer_authority():
		return
	# Add the gravity.
	if !is_on_floor():
		velocity.y -= _gravity_value * delta
		
	# Handle jump.
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized() * MAXSPEED
	
	var acceleration := ACC if direction else DESACC
	var dir = direction if is_on_floor() else last_direction
	
	velocity.x = move_toward(velocity.x, dir.x, acceleration)
	velocity.z = move_toward(velocity.z, dir.z, acceleration)
	
	last_direction = dir
	
	move_and_slide()
	locomotion_flags_tracker.update_flags()
