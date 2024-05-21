@tool
extends EditorPlugin

var modular_weapons_inspector

func _enter_tree() -> void:
	modular_weapons_inspector = preload("res://addons/modular_weapons/scripts/editor/modular_weapons_inspector.gd").new()
	add_inspector_plugin(modular_weapons_inspector)


func _exit_tree() -> void:
	remove_inspector_plugin(modular_weapons_inspector)
