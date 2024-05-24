extends Node

const MAX_DECALS := 30

const DECAL_SCENE := preload("res://scenes/bullet_decal.tscn")

var _decals: Array[Node3D]
var _index: int = 0


func _init() -> void:
	for i in MAX_DECALS:
		_decals.append(Node3D.new())


func add_decal(decal_position: Vector3, decal_normal: Vector3):
	var new_decal := DECAL_SCENE.instantiate()
	_decals[_index].queue_free()
	_decals[_index] = new_decal
	new_decal.look_at_from_position(decal_position, decal_position - decal_normal, Vector3.UP)
	
	get_tree().get_root().add_child(_decals[_index])
	_index = (_index + 1) % MAX_DECALS
