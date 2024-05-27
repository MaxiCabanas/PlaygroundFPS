class_name WeaponRecoilWithRecovery
extends Node3D

@onready var _player: PlayerController = GameInstance.LocalPlayer
@onready var _weapon_holder: WeaponHolder = %weapon_holder
@onready var _weapon_root: Weapon = _weapon_holder.active_weapon
@onready var _data: WeaponResource = _weapon_root.data

#@onready var _current_target_rot: Vector3 = _data.rotation
#@onready var _current_rot: Vector3 = _data.rotation
var _current_target_rot: Vector3 = Vector3.ZERO
var _current_rot: Vector3 = Vector3.ZERO

var _last_target_rot: Vector3 = Vector3.ZERO

#var _elapsed_control_lost: float = 0.0


#func _process(delta: float) -> void:
	#_elapsed_control_lost = lerpf(_elapsed_control_lost, 0.0, _data.recovery_speed * delta)


func _physics_process(delta: float) -> void:
	#_current_target_rot = _current_target_rot.lerp(_data.rotation, _data.recovery_speed * delta)
	#_current_rot = _current_rot.slerp(_current_target_rot, _data.recoil_speed * delta)
	_current_target_rot = _current_target_rot.lerp(Vector3.ZERO, _data.recovery_speed * delta)
	_current_rot = _current_rot.slerp(_current_target_rot, _data.recoil_speed * delta)
	rotation_degrees = _current_rot


#func add_recoil() -> void:
	#_last_target_rot = _current_target_rot
	#_current_target_rot += _data.get_recoil_sample(0.0, _player.WEAPON_CONTROL)
	#_current_target_rot += _data.get_recoil_sample(_elapsed_control_lost, _player.WEAPON_CONTROL)
	#_elapsed_control_lost += (100 - _data.spread_control) * delta
	#_elapsed_control_lost += delta
