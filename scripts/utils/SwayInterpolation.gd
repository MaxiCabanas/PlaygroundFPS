class_name SwayInterpolation extends Object

var _data: WeaponResource
var _sway_multiplier: Vector3
var _current_position: Vector3


func _init(weapon_data: WeaponResource, sway_multiplier: Vector3, initial_pos: Vector3 = Vector3.ZERO) -> void:
	_data = weapon_data
	_sway_multiplier = sway_multiplier
	_current_position = initial_pos

	
func update(delta: float, target: Vector3, input_velocity: Vector3) -> Vector3:
	_current_position.x = lerp(_current_position.x, 
	target.x + (input_velocity.x * _sway_multiplier.x * delta), 
	_data.sway_speed)
	
	_current_position.y = lerp(_current_position.y, 
	target.y + (input_velocity.y * _sway_multiplier.y * delta), 
	_data.sway_speed)
	
	_current_position.z = lerp(_current_position.z, 
	target.z + (input_velocity.z * _sway_multiplier.z * delta), 
	_data.sway_speed)
	return _current_position


#rot:
	#x = y
	#y = x
	#z = -x
static func to_rotation_input(input: Vector2) -> Vector3:
	return Vector3(input.y, input.x, -input.x)
	
#position:
	#x = -x
	#y = y
	#z = 0???
static func to_position_input(input: Vector2) -> Vector3:
	return Vector3(-input.x, input.y, 0)
	
