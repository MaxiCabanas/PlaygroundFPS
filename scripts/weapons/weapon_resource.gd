@tool
class_name WeaponResource extends WeaponResourceBase

enum SwayMode {
	NONE,
	LERP,
	PHYSICS,
}

@export_category("Sway")
@export var sway_position_mode := SwayMode.PHYSICS
@export var sway_rotation_mode := SwayMode.PHYSICS

@export_group("Sway Lerp")
@export var max_sway_amount := 28.0
@export var sway_speed := 0.1
@export var sway_position_mult := Vector3(0.1, 0.1, 0.0)
@export var sway_rotation_mult := Vector3(30.0, 30.0, 30.0)

@export_group("Sway Physics")
@export_subgroup("Position")
@export var p_frecuency := 1.0
@export var p_damping := 0.5
@export var p_responsiveness := -0.1

@export_subgroup("Rotation")
@export var r_frecuency: float = 1.0
@export var r_damping: float = 0.5
@export var r_responsiveness: float = -0.1

@export_group("Recoil and Spread")
@export_subgroup("Recoil")
## The amount of recoil is added with every shot
@export var cam_recoil_amount: Vector3 = Vector3(5.0, 0.0, 0.0):
	set(value):
		cam_recoil_amount = value
		cam_recoil_amount_rad = Global.deg_to_rad_v3(value)
var cam_recoil_amount_rad: Vector3

@export var cam_recoil_randomness: Vector3 = Vector3(1.0, 1.0, 0.5):
	set(value):
		cam_recoil_randomness = value
		cam_recoil_randomness_rad = Global.deg_to_rad_v3(value)
var cam_recoil_randomness_rad: Vector3
		
## how fast the recoil rotation is reached
@export var recoil_speed: float = 20
@export var recovery_speed: float = 15

@export_subgroup("Kickback")
@export var kickback_strength_base = Vector3(0.0, 0.0, 4.0)
@export var kickback_strength_randomness = Vector3(2.0, 2.0, 2.0)
@export var kickback_snap_speed: float = 30
@export var kickback_recovery_speed: float = 30

@export_subgroup("Spread")
## Max value of recoil when character weapon control is 0.
@export var spread_amount := Vector3(1.0, 1.0, 0.0)
@export var spread_randomness := Vector3(1.0, 1.0, 0.0)
# Spread multiplier when character have no control at all to the weapon
@export var spread_max_amount: float = 3.0
@export_exp_easing() var spread_ease_in = 3.0
## How easily the player can control the spread of the gun. The higher the easiest.
## escentially char.control -= 100 - spread_control * delta
@export_range(0.0, 100.0) var spread_control: float = 30.0
@export var spread_speed: float = 15.0
@export var spread_recovery_speed: float = 10.0

## Temporary until items are implemented
@export_category("Ammo")
@export var capacity := 30
@export var pellets_per_shot := 1
@export var ammo_scene: PackedScene

@export_category("Specs")
@export var bullets_per_minute := 700
@export var muzzle_velocity := 100.0


func _get_property_list() -> Array[Dictionary]:
	var result:Array[Dictionary] = []
	# Don't show it in the inspector and save it to disk
	result.push_back({
		"name": "cam_recoil_amount_rad",
		"type": TYPE_VECTOR3,
		"usage": PROPERTY_USAGE_NO_EDITOR,
	})
	result.push_back({
		"name": "cam_recoil_randomness_rad",
		"type": TYPE_VECTOR3,
		"usage": PROPERTY_USAGE_NO_EDITOR,
	})
	return result


func get_camera_recoil_sample() -> Vector3:
	return cam_recoil_amount_rad + Global.randomize_v3(cam_recoil_randomness_rad)


func get_weapon_kick_sample() -> Vector3:
	return kickback_strength_base + Global.randomize_v3(kickback_strength_randomness)


func get_spread_sample(control_lost_delta: float, char_control: float) -> Vector3:
	var spread = Global.randomize_v3(spread_randomness)
	var control_mult := remap(char_control - control_lost_delta, char_control, 0.0, 0.0, 1.0)
	control_mult = clampf(control_mult, 0.0, 1.0)
	#spread += spread * control_mult * recoil_max_amount
	spread = spread.lerp(spread * spread_max_amount, ease(control_mult, spread_ease_in))
	return spread_amount + spread
