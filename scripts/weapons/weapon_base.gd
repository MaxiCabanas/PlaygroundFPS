@tool
extends Node3D

@export var data: WeaponResource
@export var load_data: bool:
	set(new_value):
		_load_data(new_value)

var _mouse_movement: Vector2
var physics_solver: SecondObjectDynamics = null
var sway_interpolation: SwayInterpolation = null


func _enter_tree() -> void:
	if !Engine.is_editor_hint():
		_load_data()
		Hud.Add_or_update_property(self, "_mouse_movement", true, true)
		physics_solver = SecondObjectDynamics.new(data.frecuency, data.damping, data.responsiveness, position)
		sway_interpolation = SwayInterpolation.new(data, position, rotation_degrees)


func _load_data(bool_value = false):
	if data:
		WeaponLoader.load_weapon(self, data)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		_mouse_movement = event.relative


func _physics_process(delta: float) -> void:
	if !Engine.is_editor_hint():
		_mouse_movement = _mouse_movement.limit_length(data.max_sway_amount)
		
		#---- Solve position sway with physics
		#-- vel: the aplitude of movement, when bigger most distance the weapon will drag
		var vel: Vector3 = Vector3(_mouse_movement.x * data.sway_posisition_mult.x, 
		-_mouse_movement.y * data.sway_posisition_mult.y, 0.0)
		position = physics_solver.update(delta, data.position, vel)
		
		#---- Solve rotations with simple interpolations
		rotation_degrees = sway_interpolation.update_rotation(delta, _mouse_movement)
		
		
		_mouse_movement = _mouse_movement.lerp(Vector2.ZERO, 0.5)
