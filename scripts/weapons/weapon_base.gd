@tool
extends Node3D

@export var data: WeaponResource
@export var load_data: bool: 
	set(new_value):
		_load_data(new_value)

var _mouse_movement: Vector2

func _enter_tree() -> void:
	if !Engine.is_editor_hint():
		_load_data()
		Hud.Add_or_update_property(self, "_mouse_movement", true, true)

func _load_data(bool_value = false):
	if data:
		WeaponLoader.load_weapon(self, data)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		_mouse_movement = event.relative
		
func _physics_process(delta: float) -> void:
	if !Engine.is_editor_hint():
		_weapon_idle_sway(delta)

func _weapon_idle_sway(delta: float) -> void:
	Hud.Print_property("Mouse Input Lenght", str(_mouse_movement.length()))
	
	_mouse_movement = _mouse_movement.limit_length(data.max_sway_amount)
	
	position.x = lerp(position.x, 
	data.position.x - (_mouse_movement.x * data.sway_posisition_mult.x * delta), 
	data.sway_speed)
	
	position.y = lerp(position.y, 
	data.position.y + (_mouse_movement.y * data.sway_posisition_mult.y * delta), 
	data.sway_speed)

# rotation

	#rotation_degrees.x = lerp(rotation_degrees.x, 
	#data.rotation.x - (_mouse_movement.y * data.sway_rotation_mult.x * delta), 
	#data.sway_speed)
	#
	rotation_degrees.y = lerp(rotation_degrees.y, 
	data.rotation.y + (_mouse_movement.x * data.sway_rotation_mult.y * delta), 
	data.sway_speed)
	
	#
	rotation_degrees.z = lerp(rotation_degrees.z, 
	data.rotation.z - (_mouse_movement.x * data.sway_rotation_mult.z * delta), 
	data.sway_speed)
