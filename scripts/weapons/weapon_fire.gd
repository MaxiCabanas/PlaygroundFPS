class_name WeaponFire
extends Object

var _owner: Node3D = null
var _data: WeaponResource = null
var _trigger_is_pulled := false
var _cooldown := 0.0

var _current_target_rot: Vector3
var _current_rot: Vector3


func _init(owner_weapon: Node3D, weapon_data: WeaponResource) -> void:
	_owner = owner_weapon
	_data = weapon_data
	_current_target_rot = _data.rotation
	_current_rot = _data.rotation
	Hud.Add_or_update_property(_owner, "rotation_degrees", true, true)


func trigger_pulled():
	_trigger_is_pulled = true

func trigger_released():
	_trigger_is_pulled = false
	
	
func update(delta: float) -> void:
	if _trigger_is_pulled && _cooldown == 0.0:
		_fire_bullet()
		_current_target_rot += _data.recoil_amount
	
	_cooldown = maxf(_cooldown - delta, 0.0)
	

func update_physics(delta: float) ->void:
	_current_target_rot = _current_target_rot.lerp(_data.rotation, _data.recovery_speed * delta)
	_current_rot = _current_rot.lerp(_current_target_rot, _data.recoil_speed * delta)
	_owner.rotation_degrees = _current_rot


func _fire_bullet() -> void:
	var new_bullet: RigidBody3D
	new_bullet = _data.ammo_scene.instantiate()
	_owner.get_tree().get_root().add_child(new_bullet)
	new_bullet.position = _owner.to_global(_data.muzzle)
	new_bullet.global_rotation = _owner.global_rotation
	var direction := -new_bullet.global_transform.basis.z.normalized() * _data.muzzle_velocity
	new_bullet.apply_impulse(direction)
	_cooldown = 60.0 / _data.bullets_per_minute
