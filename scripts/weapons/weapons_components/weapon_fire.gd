class_name WeaponFire
extends Object

var _player: PlayerController
var _owner_weapon: Weapon = null
var _data: WeaponResource = null
var _trigger_is_pulled := false
var _cooldown := 0.0
var _elapsed_control_lost := 0.0

# Placeholder until items:
var current_bullets: int

var _current_target_rot: Vector3
var _current_rot: Vector3


func _init(owner_weapon: Node3D, weapon_data: WeaponResource) -> void:
	_owner_weapon = owner_weapon
	_data = weapon_data
	current_bullets = _data.capacity
	_current_target_rot = _data.rotation
	_current_rot = _data.rotation
	_player = GameInstance.LocalPlayer


func trigger_pulled():
	_trigger_is_pulled = true

func trigger_released():
	_trigger_is_pulled = false
	
	
func update(delta: float) -> void:
	Hud.Print_property("Elapsed control lost", str(_elapsed_control_lost))
	
	if _trigger_is_pulled && _cooldown == 0.0:
		_fire_bullet()
		_current_target_rot += _data.get_recoil_sample(_elapsed_control_lost, _player.WEAPON_CONTROL)
		_elapsed_control_lost += (100 - _data.spread_control) * delta
	
	if !_trigger_is_pulled:
		_elapsed_control_lost = lerpf(_elapsed_control_lost, 0.0, _data.recovery_speed * delta)
	
	_cooldown = maxf(_cooldown - delta, 0.0)


func update_physics(delta: float) ->void:
	_current_target_rot = _current_target_rot.lerp(_data.rotation, _data.recovery_speed * delta)
	_current_rot = _current_rot.slerp(_current_target_rot, _data.recoil_speed * delta)
	_owner_weapon.rotation_degrees = _current_rot


func _fire_bullet() -> void:
	var new_bullet: RigidBody3D
	new_bullet = _data.ammo_scene.instantiate()
	_owner_weapon.get_tree().get_root().add_child(new_bullet)
	new_bullet.position = _owner_weapon.to_global(_data.muzzle)
	new_bullet.global_rotation = _owner_weapon.global_rotation
	var direction := -new_bullet.global_transform.basis.z.normalized() * _data.muzzle_velocity
	new_bullet.apply_impulse(direction)
	_cooldown = 60.0 / _data.bullets_per_minute
