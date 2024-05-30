class_name Weapon
extends Node3D

signal on_fire()

@export var data: WeaponResourceBase

@onready var last_current_position: Vector3 = data.position
@onready var last_current_rotation: Vector3 = data.rotation
@onready var post_spread_pos: Vector3 = data.position
@onready var post_spread_rot: Vector3 = data.rotation
@onready var reload_timer: Timer = $ReloadTimer

var is_reloading: bool:
	get:
		return !reload_timer.is_stopped()

var _owner_char: PlayerController
var _mouse_movement: Vector2

# Components
var _weapon_flags_tracker: WeaponFlagsTracker = null
var _weapon_animator: WeaponAnimatior = null
var _weapon_fire: WeaponFire = null


func _enter_tree() -> void:
	if data:
		WeaponLoader.load_weapon(self, data)
		
	_owner_char = GameInstance.LocalPlayer
	_weapon_flags_tracker = WeaponFlagsTracker.new(self)
	_weapon_animator = WeaponAnimatior.new(self, data)
	
	_weapon_fire = WeaponFire.new(self, data)
	_weapon_fire.bullet_fired.connect(func(): on_fire.emit())


func _ready() -> void:
	reload_timer.timeout.connect(func(): _weapon_fire.reload())


# REFACTOR: move this to weapon_holder to unify weapons input
func _input(event: InputEvent) -> void:
	if !is_multiplayer_authority():
		return
		
	if event is InputEventMouseMotion:
		_mouse_movement = event.relative
		
	if event.is_action_pressed("fire"):
		_weapon_fire.trigger_pulled()
	elif event.is_action_released("fire"):
		_weapon_fire.trigger_released()
	elif event.is_action_pressed("reload"):
		_start_reload()


func _process(delta: float) -> void:
	if is_multiplayer_authority():
		_weapon_fire.update(delta)
		_weapon_flags_tracker.update_flags()


func _physics_process(delta: float) -> void:
	if !is_multiplayer_authority():
		return
	
	_mouse_movement = _mouse_movement.limit_length(data.max_sway_amount)
	
	_weapon_animator.update_physics(delta, _mouse_movement)
	_weapon_fire.update_physics(delta)
	
	position = post_spread_pos
	rotation_degrees = post_spread_rot
	
	_mouse_movement = _mouse_movement.lerp(Vector2.ZERO, 0.5)


func _start_reload() -> void:
	reload_timer.start()
