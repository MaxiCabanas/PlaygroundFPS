class_name LowPassFilterSolver extends AnimationSolver

var _step: float
var _input_multiplier: Vector3
#var _current: Vector3


func _init(step: float, input_multiplier: Vector3, initial_pos: Vector3 = Vector3.ZERO) -> void:
	_step = step
	_input_multiplier = input_multiplier
	#_current = initial_pos


func update(delta: float, current:Vector3, target: Vector3, input_velocity: Vector3) -> Vector3:
	current.x = lerp(current.x, 
	target.x + (input_velocity.x * _input_multiplier.x * delta), 
	_step)
	
	current.y = lerp(current.y, 
	target.y + (input_velocity.y * _input_multiplier.y * delta), 
	_step)
	
	current.z = lerp(current.z, 
	target.z + (input_velocity.z * _input_multiplier.z * delta), 
	_step)
	return current


#rot:
	#x = y
	#y = x
	#z = -x
func to_rotation_input(input: Vector2) -> Vector3:
	return Vector3(input.y, input.x, -input.x)


#position:
	#x = -x
	#y = y
	#z = 0???
func to_position_input(input: Vector2) -> Vector3:
	return Vector3(-input.x, input.y, 0)

