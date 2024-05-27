class_name WeaponFire
extends Object

signal bullet_fired()

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

var _current_target_pos: Vector3
var _current_pos: Vector3



func _init(owner_weapon: Node3D, weapon_data: WeaponResource) -> void:
	_owner_weapon = owner_weapon
	_data = weapon_data
	current_bullets = _data.capacity
	_current_target_rot = _data.rotation
	_current_rot = _data.rotation
	_current_target_pos = _data.position
	_current_pos = _data.position
	_player = GameInstance.LocalPlayer


func trigger_pulled():
	_trigger_is_pulled = true

func trigger_released():
	_trigger_is_pulled = false
	
	
func update(delta: float) -> void:
	if _trigger_is_pulled && _cooldown == 0.0:
		_fire_bullet()
		_add_spread(delta)
	
	if !_trigger_is_pulled:
		_elapsed_control_lost = lerpf(_elapsed_control_lost, 0.0, _data.spread_recovery_speed * delta)
	
	_cooldown = maxf(_cooldown - delta, 0.0)
	
	Hud.Print_property("elapsed control lost", str(_elapsed_control_lost))


func update_physics(delta: float) ->void:
	_current_target_rot = _current_target_rot.lerp(_data.rotation, _data.spread_recovery_speed * delta)
	_current_rot = _current_rot.lerp(_current_target_rot, _data.spread_speed * delta)
	_owner_weapon.rotation_degrees = _current_rot
	
	_current_target_pos = _current_target_pos.lerp(
			_data.position, _data.kickback_recovery_speed * delta)
	_current_pos = _current_pos.lerp(
			_current_target_pos, _data.kickback_snap_speed * delta)
	_owner_weapon.position = _current_pos


func _fire_bullet() -> void:
	var new_bullet: Bullet = _data.ammo_scene.instantiate()
	new_bullet.setup(_owner_weapon)
	_cooldown = 60.0 / _data.bullets_per_minute
	bullet_fired.emit()


func _add_spread(delta: float) -> void:
	_current_target_rot += _data.get_spread_sample(_elapsed_control_lost, _player.WEAPON_CONTROL)
	_current_target_pos += _data.get_weapon_kick_sample() * delta
	_elapsed_control_lost += (100 - _data.spread_control) * delta
