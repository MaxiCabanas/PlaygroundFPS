@tool
extends Node3D

@export var data: WeaponResource
@export var load_data: bool:
	set(new_value):
		_load_data(new_value)

var _mouse_movement: Vector2
var physics_solver_pos: SecondObjectDynamics = null
var physics_solver_rot: SecondObjectDynamics = null
var sway_solver_pos: SwayInterpolation = null
var sway_solver_rot: SwayInterpolation = null


func _enter_tree() -> void:
	if !Engine.is_editor_hint():
		_load_data()


func _ready() -> void:
	if is_multiplayer_authority():
		if data.sway_position_mode == WeaponResource.SwayMode.PHYSICS:
			physics_solver_pos = SecondObjectDynamics.new(data.p_frecuency, data.p_damping, data.p_responsiveness, position)
		elif data.sway_position_mode == WeaponResource.SwayMode.LERP:
			sway_solver_pos = SwayInterpolation.new(data, data.sway_posisition_mult, position)
			
		if data.sway_rotation_mode == WeaponResource.SwayMode.PHYSICS:
			physics_solver_rot = SecondObjectDynamics.new(data.r_frecuency, data.r_damping, data.r_responsiveness, rotation_degrees)
		elif data.sway_rotation_mode == WeaponResource.SwayMode.LERP:
			sway_solver_rot = SwayInterpolation.new(data, data.sway_rotation_mult, rotation_degrees)


func _load_data(bool_value = false):
	if data:
		WeaponLoader.load_weapon(self, data)


func _input(event: InputEvent) -> void:
	if !is_multiplayer_authority():
		return
		
	if event is InputEventMouseMotion:
		_mouse_movement = event.relative


func _physics_process(delta: float) -> void:
	if !Engine.is_editor_hint() && is_multiplayer_authority():
		_mouse_movement = _mouse_movement.limit_length(data.max_sway_amount)
		
		#---- Solve position sway with physics
		#-- vel: the aplitude of movement, when bigger most distance the weapon will drag
		if physics_solver_pos:
			var vel: Vector3 = Vector3(_mouse_movement.x * data.sway_posisition_mult.x, 
			-_mouse_movement.y * data.sway_posisition_mult.y, 0.0)
			position = physics_solver_pos.update(delta, data.position, vel)
		
		if physics_solver_rot:
			var vel2:Vector3 = Vector3(-_mouse_movement.y * data.sway_rotation_mult.x,
			-_mouse_movement.x * data.sway_rotation_mult.y, 
			_mouse_movement.x * data.sway_rotation_mult.z)
			rotation_degrees = physics_solver_rot.update(delta, data.rotation, vel2)
		
		#---- Solve rotations with simple interpolations
		if sway_solver_pos:
			position = sway_solver_pos.update(delta, data.position, SwayInterpolation.to_position_input(_mouse_movement))
			
		if sway_solver_rot:
			rotation_degrees = sway_solver_rot.update(delta, data.rotation, SwayInterpolation.to_rotation_input(_mouse_movement))
		
		_mouse_movement = _mouse_movement.lerp(Vector2.ZERO, 0.5)
