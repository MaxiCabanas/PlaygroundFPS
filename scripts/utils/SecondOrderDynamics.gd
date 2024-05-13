class_name SecondObjectDynamics extends Object

var _previous_input_target_pos: Vector3
var _current_position: Vector3
var _current_velocity: Vector3

var _k1: float
var _k2: float
var _k3: float

func _init(f:float, z:float, r:float, x0:Vector3 = Vector3.ZERO) -> void:
	var TWOPIF = (2 * PI * f)
	_k1 = z / (PI * f)
	_k2 = 1 / (TWOPIF * TWOPIF)
	_k3 = r * z / TWOPIF
	
	_previous_input_target_pos = x0
	_current_position = x0
	_current_velocity = Vector3.ZERO
	
func update(delta:float, input_target_pos:Vector3, input_vel:Vector3) -> Vector3:
	#if input_vel == null:
		#input_vel = (input_target_pos - _current_position) / delta
		#_previous_input_target_pos = input_target_pos
	
	_current_position += delta * _current_velocity
	_current_velocity += delta * (input_target_pos + _k3 * input_vel - _current_position - _k1 * _current_velocity) / _k2
	return _current_position
