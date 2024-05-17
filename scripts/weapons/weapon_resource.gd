class_name WeaponResource extends Resource

enum SwayMode {
	NONE,
	LERP,
	PHYSICS,
}
## The weapon name
@export var name := "New Weapon"

@export_group("Visuals")
@export var body: Mesh
@export var default_attachments: Array[Mesh]
@export var material: Material

@export_group("Properties")
@export var position := Vector3.ZERO
@export var rotation := Vector3.ZERO
@export var muzzle := Vector3.ZERO

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

## Temporary until items are implemented
@export_category("Ammo")
@export var capacity := 30
@export var pellets_per_shot := 1
@export var ammo_scene: PackedScene

@export_category("Specs")
@export var bullets_per_minute := 700
@export var muzzle_velocity := 100.0
