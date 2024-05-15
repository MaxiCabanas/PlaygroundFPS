class_name WeaponAnimatior extends Object

var _owner: Node3D = null
var _data = WeaponResource
var _position_solver: AnimationSolver = null
var _rotation_solver: AnimationSolver = null

func _init(owner: Node3D, weapon_data: WeaponResource) -> void:
	_owner = owner
	_data = weapon_data
	
	_position_solver = (
			LowPassFilterSolver.new(
					_data.sway_speed, 
					_data.sway_position_mult, 
					_data.position
			) if _data.sway_position_mode == WeaponResource.SwayMode.LERP
			else SecondObjectDynamicsSolver.new(
					_data.p_frecuency, 
					_data.p_damping, 
					_data.p_responsiveness, 
					_data.position
			)
	)
	
	_rotation_solver = (
			LowPassFilterSolver.new(
					_data.sway_speed,
					_data.sway_rotation_mult, 
					_data.rotation
			) if _data.sway_position_mode == WeaponResource.SwayMode.LERP
			else SecondObjectDynamicsSolver.new(
					_data.r_frecuency,
					_data.r_damping,
					_data.r_responsiveness,
					_data.rotation
			)
	)

func update(delta: float, input: Vector2) -> void:
	var pos_input := _position_solver.to_position_input(input)
	_owner.position = _position_solver.update(delta, _data.position, pos_input)
	
	var rot_input := _rotation_solver.to_rotation_input(input)
	_owner.rotation_degrees = _rotation_solver.update(delta, _data.rotation, rot_input)
