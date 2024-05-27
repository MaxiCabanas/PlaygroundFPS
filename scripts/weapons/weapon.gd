class_name Weapon
extends Node3D

signal on_fire()

@export var data: WeaponResourceBase

var _owner_char: PlayerController
var _weapons_instances: Dictionary
var _mouse_movement: Vector2

# Components
var _weapon_animator: WeaponAnimatior = null
var _weapon_fire: WeaponFire = null


func _enter_tree() -> void:
	if data:
		WeaponLoader.load_weapon(self, data)
		
	_owner_char = GameInstance.LocalPlayer
	_weapon_animator = WeaponAnimatior.new(self, data)
	
	_weapon_fire = WeaponFire.new(self, data)
	_weapon_fire.bullet_fired.connect(func(): on_fire.emit())


func _input(event: InputEvent) -> void:
	if !is_multiplayer_authority():
		return
		
	if event is InputEventMouseMotion:
		_mouse_movement = event.relative
		
	if event.is_action_pressed("fire"):
		_weapon_fire.trigger_pulled()
	elif event.is_action_released("fire"):
		_weapon_fire.trigger_released()


func _process(delta: float) -> void:
	if is_multiplayer_authority():
		_weapon_fire.update(delta)


func _physics_process(delta: float) -> void:
	if !is_multiplayer_authority():
		return
	
	_mouse_movement = _mouse_movement.limit_length(data.max_sway_amount)
	
	_weapon_animator.update_physics(delta, _mouse_movement)
	#_weapon_fire.update_physics(delta)
	
	_mouse_movement = _mouse_movement.lerp(Vector2.ZERO, 0.5)
