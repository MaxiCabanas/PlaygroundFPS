extends Node3D

@export var weapon_resource: WeaponResource

func _enter_tree() -> void:
	WeaponLoader.load_weapon(self, weapon_resource)
