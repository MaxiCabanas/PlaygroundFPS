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
#@export var recoil_randomness
@export var recovery_speed: float = 15
## how fast the recoil rotation is reached
@export var recoil_speed: float = 20

## Temporary until items are implemented
@export_category("Ammo")
@export var capacity := 30
@export var pellets_per_shot := 1
@export var ammo_scene: PackedScene

@export_category("Specs")
@export var bullets_per_minute := 700
@export var muzzle_velocity := 100.0

