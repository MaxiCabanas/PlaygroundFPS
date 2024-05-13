class_name SwayInterpolation extends Object

var _data: WeaponResource
var _current_position: Vector3
var _current_rotation: Vector3


func _init(weapon_data: WeaponResource, initial_pos: Vector3 = Vector3.ZERO, current_rotation = Vector3.ZERO) -> void:
	_data = weapon_data
	_current_position = initial_pos
	_current_rotation = current_rotation


func update_position(delta: float, input_velocity: Vector2) -> Vector3:
	_current_position.x = lerp(_current_position.x, 
	_data.position.x - (input_velocity.x * _data.sway_posisition_mult.x * delta), 
	_data.sway_speed)
	
	_current_position.y = lerp(_current_position.y, 
	_data.position.y + (input_velocity.y * _data.sway_posisition_mult.y * delta), 
	_data.sway_speed)
	return _current_position
	
	
func update_rotation(delta: float, input_velocity: Vector2) -> Vector3:
	_current_rotation.x = lerp(_current_rotation.x, 
	_data.rotation.x + (input_velocity.y * _data.sway_rotation_mult.x * delta), 
	_data.sway_speed)
	
	_current_rotation.y = lerp(_current_rotation.y, 
	_data.rotation.y + (input_velocity.x * _data.sway_rotation_mult.y * delta), 
	_data.sway_speed)
	
	_current_rotation.z = lerp(_current_rotation.z, 
	_data.rotation.z - (input_velocity.x * _data.sway_rotation_mult.z * delta), 
	_data.sway_speed)
	return _current_rotation
