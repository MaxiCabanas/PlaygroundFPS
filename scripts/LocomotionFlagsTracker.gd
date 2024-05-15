class_name LocomotionFlagsTracker
extends Node

enum LocomotionFlags {
	IDLE = 1 << 0,
	WALKING = 1 << 1,
	RUNNING = 1 << 2,
	CROUCHING = 1 << 3,
	PRONE = 1 << 4,
	JUMPING = 1 << 5,
	LEANING_LEFT = 1 << 6,
	LEANING_RIGHT = 1 << 7,
	FALLING = 1 << 8,
}

const MOVEMENT_FLAGS: int = (
		LocomotionFlags.IDLE|
		LocomotionFlags.WALKING|
		LocomotionFlags.RUNNING
)

const AIR_FLAGS: int = (
		LocomotionFlags.JUMPING|
		LocomotionFlags.FALLING
)

var _owner: Node3D = null
var locomotion_flags: int
var flags_as_string: String:
	get:
		return flags_to_string()

func _init(node_owner: Node3D) -> void:
	_owner = node_owner


func update_locomotion_flags():
	locomotion_flags &= ~AIR_FLAGS
	if !_owner.is_on_floor():
		if _owner.velocity.y > 0:
			locomotion_flags |= LocomotionFlags.JUMPING
		else:
			locomotion_flags |= LocomotionFlags.FALLING

	locomotion_flags &= ~MOVEMENT_FLAGS
	if Vector2(_owner.velocity.x, _owner.velocity.z).is_zero_approx():
		locomotion_flags |= LocomotionFlags.IDLE
	else:
		locomotion_flags |= LocomotionFlags.WALKING

	Hud.Print_property("PlayerStates", flags_as_string)

	#DEBUG OTHER PLAYERS FLAGS
	var players = _owner.get_tree().get_nodes_in_group("Player")
	for player in players:
		if !player.is_multiplayer_authority():
			var pc = player as PlayerController
			var flags = pc.locomotion_flags_tracker.flags_as_string
			var label = "Player %s FLAGS" %player.name
			Hud.Print_property(label, flags)

func flags_to_string() -> String:
	var flags: String = ""
	if (locomotion_flags & LocomotionFlags.IDLE) != 0:
		flags = flags + "IDLE, "
	if (locomotion_flags & LocomotionFlags.WALKING) != 0:
		flags = flags + "WALKING, "
	if (locomotion_flags & LocomotionFlags.RUNNING) != 0:
		flags = flags + "RUNNING, "
	if (locomotion_flags & LocomotionFlags.CROUCHING) != 0:
		flags = flags + "CROUCHING, "
	if (locomotion_flags & LocomotionFlags.PRONE) != 0:
		flags = flags + "PRONE, "
	if (locomotion_flags & LocomotionFlags.JUMPING) != 0:
		flags = flags + "JUMPING, "
	if (locomotion_flags & LocomotionFlags.LEANING_LEFT) != 0:
		flags = flags + "LEANING_LEFT, "
	if (locomotion_flags & LocomotionFlags.LEANING_RIGHT) != 0:
		flags = flags + "LEANING_RIGHT, "
	if (locomotion_flags & LocomotionFlags.FALLING) != 0:
		flags = flags + "FALLING, "
	return flags
