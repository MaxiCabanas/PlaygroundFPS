class_name WeaponResource extends Resource

@export_group("Visuals")
@export var body: Mesh
@export var default_attachments: Array[Mesh]
@export var material: Material

@export_group("Properties")
@export var position: Vector3
@export var rotation: Vector3

@export_subgroup("Sway")
@export var max_sway_amount: float = 28
@export var sway_speed: float = 0.1
@export var sway_posisition_mult: Vector2 = Vector2(0.1, 0.1)
@export var sway_rotation_mult: Vector3 = Vector3(30, 30, 30)

@export_subgroup("Sway Physics")
@export var frecuency: float = 4.58
@export var damping: float = 0.35
@export var responsiveness: float = 0
#@export var front_sight: Vector3
#@export var rear_sight: Vector3
#@export var mag_pos: Vector3
#@export var butt_pos: Vector3
