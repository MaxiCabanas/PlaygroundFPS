class_name WeaponResource extends Resource

@export_group("Visuals")
@export var body: PackedScene
@export var default_attachments: Array[PackedScene]

@export_group("Properties")
@export var position: Vector3
@export var rotation: Vector3

@export_subgroup("Sway")
@export var sway: Vector3
@export var sway_amount: float


#@export var front_sight: Vector3
#@export var rear_sight: Vector3
#@export var mag_pos: Vector3
#@export var butt_pos: Vector3
