class_name WeaponResource extends Resource

enum SwayMode {
	NONE,
	LERP,
	PHYSICS,
}

@export_group("Visuals")
@export var body: Mesh
@export var default_attachments: Array[Mesh]
@export var material: Material

@export_group("Properties")
@export var position: Vector3
@export var rotation: Vector3

@export_category("Sway")
@export var sway_position_mode: SwayMode = SwayMode.PHYSICS
@export var sway_rotation_mode: SwayMode = SwayMode.PHYSICS

@export_group("Sway Lerp")
@export var max_sway_amount: float = 28
@export var sway_speed: float = 0.1
@export var sway_position_mult: Vector3 = Vector3(0.1, 0.1, 0)
@export var sway_rotation_mult: Vector3 = Vector3(30, 30, 30)

@export_group("Sway Physics")
@export_subgroup("Position")
@export var p_frecuency: float = 1
@export var p_damping: float = 0.5
@export var p_responsiveness: float = -0.1

@export_subgroup("Rotation")
@export var r_frecuency: float = 1
@export var r_damping: float = 0.5
@export var r_responsiveness: float = -0.1
