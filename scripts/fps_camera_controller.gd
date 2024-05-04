extends Camera3D

@export var camera_sensitivity: float = 0.5
@export var max_camera_pitch_angle: float = 60.0
@export var min_camera_pitch_angle: float = -30.0

#@onready var gun_cam: Camera3D = $SubViewportContainer/SubViewport/Camera3D
@onready var character_root: CharacterBody3D = $".."

@onready var max_pitch_as_rad = deg_to_rad(max_camera_pitch_angle)
@onready var min_pitch_as_rad = deg_to_rad(min_camera_pitch_angle)

var _mouse_input: Vector2 = Vector2.ZERO
var _camera_rotation: Vector3 = Vector3.ZERO

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta: float) -> void:
	_update_camera(delta)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion && Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		_mouse_input = Vector2(-event.relative.x, -event.relative.y) * camera_sensitivity

func _update_camera(delta: float):
	_camera_rotation.x += _mouse_input.y * delta
	_camera_rotation.x = clampf(_camera_rotation.x, min_pitch_as_rad, max_pitch_as_rad)
	_camera_rotation.y += _mouse_input.x * delta
	
	transform.basis = Basis.from_euler(Vector3(_camera_rotation.x, 0.0, 0.0))
	character_root.global_transform.basis = Basis.from_euler(Vector3(0.0, _camera_rotation.y, 0.0))
	
	#gun_cam.global_transform = global_transform
	
	_mouse_input = Vector2.ZERO
