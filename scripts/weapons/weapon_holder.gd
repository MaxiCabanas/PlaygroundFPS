class_name WeaponHolder
extends Node3D

signal on_weapon_changed(active_weapon)
signal on_active_weapon_fire()

var active_weapon: Weapon:
	set(new_value):
		if active_weapon:
			active_weapon.on_fire.disconnect(_active_weapon_fire)
		active_weapon = new_value
		on_weapon_changed.emit(active_weapon)
		active_weapon.on_fire.connect(_active_weapon_fire)


func _ready() -> void:
	active_weapon = get_child(0)
	active_weapon


func _active_weapon_fire() -> void:
	on_active_weapon_fire.emit()


# implement weapon switch
func _input(event: InputEvent) -> void:
	pass
