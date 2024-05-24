extends Node3D


func _enter_tree() -> void:
	rotation_degrees.z = randf() * 360.0
