class_name SecondObjectDynamicsSolver extends AnimationSolver

#var _current_position: Vector3
var _input_multiplier: Vector3
var _current_velocity: Vector3 = Vector3.ZERO

var _k1: float
var _k2: float
var _k3: float


func _init(f:float, z:float, r:float, input_multiplier: Vector3, x0:Vector3 = Vector3.ZERO) -> void:
	var TWOPIF := (2 * PI * f)
	_k1 = z / (PI * f)
	_k2 = 1 / (TWOPIF * TWOPIF)
	_k3 = r * z / TWOPIF
	
	#_current_position = x0
	_input_multiplier = input_multiplier


func update(delta:float, current:Vector3, input_target_pos:Vector3, input_vel:Vector3) -> Vector3:
	# We are not infering velocity, we are always passing a valid velocity
	#if input_vel == null:
		#input_vel = (input_target_pos - _current_position) / delta
		
	var vel := Vector3(
			input_vel.x * _input_multiplier.x,
			input_vel.y * _input_multiplier.y,
			input_vel.z * _input_multiplier.z
	)
	
	current += delta * _current_velocity
	_current_velocity += delta * (input_target_pos + _k3 * vel - current - _k1 * _current_velocity) / _k2
	return current


#rot:
	#x = -y
	#y = -x
	#z = x
func to_rotation_input(input: Vector2) -> Vector3:
	return Vector3(-input.y, -input.x, input.x)


#position:
	#x = x
	#y = -y
	#z = 0
func to_position_input(input: Vector2) -> Vector3:
	return Vector3(input.x, -input.y, 0.0)

