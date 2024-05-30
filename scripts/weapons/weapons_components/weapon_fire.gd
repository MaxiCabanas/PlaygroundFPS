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
var _current_target_pos: Vector3


func _init(owner_weapon: Node3D, weapon_data: WeaponResource) -> void:
	_owner_weapon = owner_weapon
	_data = weapon_data
	_current_target_rot = _data.rotation
	_current_target_pos = _data.position
	_player = GameInstance.LocalPlayer
	reload()


func reload():
	current_bullets = _data.capacity


func trigger_pulled():
	_trigger_is_pulled = true


func trigger_released():
	_trigger_is_pulled = false


func can_shoot() -> bool:
	return (
			_trigger_is_pulled &&
			_cooldown == 0.0 &&
			current_bullets > 0 &&
			!_owner_weapon.is_reloading
	)


func update(delta: float) -> void:
	if can_shoot():
		_fire_bullet()
		_add_spread(delta)
	
	if _cooldown == 0.0:
		_elapsed_control_lost = lerpf(
				_elapsed_control_lost, 
				0.0, 
				_data.spread_control_recovery_speed * delta)
	
	_cooldown = maxf(_cooldown - delta, 0.0)
	
	Hud.Print_property("elapsed control lost", str(_elapsed_control_lost))
	Hud.Print_property("Bullets", str(current_bullets))


func update_physics(delta: float) ->void:
	#_current_target_rot = _current_target_rot.lerp(
			#_data.rotation, _data.spread_recovery_speed * delta)
	#_owner_weapon.current_rotation = _owner_weapon.current_rotation.lerp(
			#_current_target_rot, _data.spread_speed * delta)
	#
	#_current_target_pos = _current_target_pos.lerp(
			#_data.position, _data.kickback_recovery_speed * delta)
	#_owner_weapon.current_position = _owner_weapon.current_position.lerp(
			#_current_target_pos, _data.kickback_snap_speed * delta)
	_current_target_rot = _current_target_rot.lerp(
			_owner_weapon.last_current_rotation, _data.spread_recovery_speed * delta)
	_owner_weapon.post_spread_rot = _owner_weapon.post_spread_rot.lerp(
			_current_target_rot, _data.spread_speed * delta)
	
	_current_target_pos = _current_target_pos.lerp(
			_owner_weapon.last_current_position, _data.kickback_recovery_speed * delta)
	_owner_weapon.post_spread_pos = _owner_weapon.post_spread_pos.lerp(
			_current_target_pos, _data.kickback_snap_speed * delta)


func _fire_bullet() -> void:
	var new_bullet: Bullet = _data.ammo_scene.instantiate()
	new_bullet.setup(_owner_weapon)
	_cooldown = 60.0 / _data.bullets_per_minute
	current_bullets -= 1
	bullet_fired.emit()


func _add_spread(delta: float) -> void:
	_current_target_rot += _data.get_spread_sample(_elapsed_control_lost, _player.WEAPON_CONTROL)
	_current_target_pos += _data.get_weapon_kick_sample() * delta
	_elapsed_control_lost += (100 - _data.spread_control) * delta
