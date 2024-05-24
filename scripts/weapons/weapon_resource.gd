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

@export_group("Recoil")
## The amount of recoil is added with every shot
@export var recoil_amount: Vector3 = Vector3(55.0, 0.0, 0.0)
@export var recoil_randomness: Vector3 = Vector3(5.0, 5.0, 5.0)
## Max value of recoil when character weapon control is 0.
@export var recoil_max_amount: float = 3.0
@export_exp_easing() var recoil_ease_in = 3.0
## How easily the player can control the spread of the gun. The higher the easiest.
## escentially char.control -= 100 - spread_control * delta
@export_range(0.0, 100.0) var spread_control: float = 30.0
## how fast the recoil rotation is reached
@export var recoil_speed: float = 20
@export var recovery_speed: float = 15

## Temporary until items are implemented
@export_category("Ammo")
@export var capacity := 30
@export var pellets_per_shot := 1
@export var ammo_scene: PackedScene

@export_category("Specs")
@export var bullets_per_minute := 700
@export var muzzle_velocity := 100.0


func get_recoil_sample(control_lost: float, char_control: float):
	
	var spread = Vector3(
			randf_range(-recoil_randomness.x, recoil_randomness.x),
			randf_range(-recoil_randomness.y, recoil_randomness.y),
			randf_range(-recoil_randomness.z, recoil_randomness.z)
	)
	var control_mult := remap(char_control - control_lost, char_control, 0.0, 0.0, 1.0)
	control_mult = clampf(control_mult, 0.0, 1.0)
	#spread += spread * control_mult * recoil_max_amount
	spread += spread.lerp(spread * recoil_max_amount, ease(control_mult, recoil_ease_in))
	return recoil_amount + spread
