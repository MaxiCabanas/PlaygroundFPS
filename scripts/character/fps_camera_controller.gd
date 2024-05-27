extends Camera3D

@export_category("Camera controls")
@export var camera_sensitivity: float = 0.8
@export var max_camera_pitch_angle: float = 60.0
@export var min_camera_pitch_angle: float = -30.0

@onready var character_root: CharacterBody3D = GameInstance.LocalPlayer
@onready var weapon_holder: WeaponHolder = %weapon_holder

@onready var max_pitch_as_rad := deg_to_rad(max_camera_pitch_angle)
@onready var min_pitch_as_rad := deg_to_rad(min_camera_pitch_angle)

var _mouse_input := Vector2.ZERO
var _camera_rotation := Vector3.ZERO
var _current_recoil := Vector3.ZERO

var _weapon_data: WeaponResource:
	get:
		return weapon_holder.active_weapon.data


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	weapon_holder.on_active_weapon_fire.connect(_add_recoil)


func _process(delta: float) -> void:
	if is_multiplayer_authority():
		_integrate_recoil_to_camera(delta)
		_integrate_input_to_camera(delta)


func _add_recoil() -> void:
	_current_recoil = _weapon_data.get_camera_recoil_sample()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion && Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		_mouse_input = Vector2(-event.relative.x, -event.relative.y) * camera_sensitivity


func _integrate_recoil_to_camera(delta: float) -> void:
	_camera_rotation = _camera_rotation.lerp(
			_camera_rotation + _current_recoil, 
			_weapon_data.recoil_speed * delta)
	_current_recoil = _current_recoil.lerp(Vector3.ZERO, _weapon_data.recovery_speed * delta)
	_camera_rotation.z = lerpf(_camera_rotation.z, 0.0, _weapon_data.recovery_speed * delta)


func _integrate_input_to_camera(delta: float) -> void:
	_camera_rotation.x += _mouse_input.y * delta
	_camera_rotation.x = clampf(_camera_rotation.x, min_pitch_as_rad, max_pitch_as_rad)
	_camera_rotation.y += _mouse_input.x * delta
	
	transform.basis = Basis.from_euler(Vector3(_camera_rotation.x, 0.0, _camera_rotation.z))
	character_root.global_transform.basis = Basis.from_euler(Vector3(0.0, _camera_rotation.y, 0.0))
	
	_mouse_input = Vector2.ZERO
