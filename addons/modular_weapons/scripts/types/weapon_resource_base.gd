# We need this base resource so ModularWeapons plug-in can recognize and instantiate
# the weapon.
class_name WeaponResourceBase extends Resource


## The weapon name
@export var name := "New Weapon"

@export_group("Visuals")
@export var body: Mesh
@export var default_attachments: Array[Mesh]
@export var material: Material

@export_group("Base Properties")
@export var position := Vector3.ZERO
@export var rotation := Vector3.ZERO
@export var muzzle := Vector3.ZERO
