extends EditorInspectorPlugin

const WEAPON_RESOURCE_PROPERTY_EDITOR = preload("res://addons/modular_weapons/scripts/editor/weapon_resource_property_editor.gd")


func _can_handle(object: Object) -> bool:
	return true


func _parse_property(object: Object, type: Variant.Type, name: String, hint_type: PropertyHint, hint_string: String, usage_flags: int, wide: bool) -> bool:
	if hint_type == PROPERTY_HINT_RESOURCE_TYPE && hint_string == "WeaponResourceBase":
		add_property_editor(name, WEAPON_RESOURCE_PROPERTY_EDITOR.new())
	
	return false
