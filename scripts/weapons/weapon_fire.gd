class_name WeaponFire
extends Object

var _owner: Node3D = null
var _data: WeaponResource = null
var _trigger_state := false
var _cooldown := 0.0


func _init(owner_weapon: Node3D, weapon_data: WeaponResource) -> void:
	_owner = owner_weapon
	_data = weapon_data
	Hud.Add_or_update_property(self, "_cooldown", true, true)


func trigger_pressed():
	_trigger_state = true


func trigger_released():
	_trigger_state = false
	
	
func update(delta: float) -> void:
	if _trigger_state && _cooldown == 0.0:
		var new_bullet: RigidBody3D
		new_bullet = _data.ammo_scene.instantiate()
		_owner.get_tree().get_root().add_child(new_bullet)
		new_bullet.position = _owner.to_global(_data.muzzle)
		new_bullet.global_rotation = _owner.global_rotation
		var direction := -new_bullet.global_transform.basis.z * _data.muzzle_velocity
		new_bullet.apply_impulse(direction)
		_cooldown = 60.0 / _data.bullets_per_minute
	
	_cooldown = maxf(_cooldown - delta, 0.0)
	

