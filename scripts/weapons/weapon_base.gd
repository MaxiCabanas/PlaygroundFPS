@tool
extends Node3D

@export var data: WeaponResource
@export var load_data: bool:
	set(new_value):
		_load_data(new_value)

var _mouse_movement: Vector2
var _weapon_animator: WeaponAnimatior = null


func _enter_tree() -> void:
	if Engine.is_editor_hint():
		return
	
	_load_data()
	_weapon_animator = WeaponAnimatior.new(self, data)


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
		
		_weapon_animator.update(delta, _mouse_movement)
		
		_mouse_movement = _mouse_movement.lerp(Vector2.ZERO, 0.5)
