@tool
extends EditorScript


# Called when the script is executed (using File -> Run in Script Editor).
func _run() -> void:
	var editor_interface = get_editor_interface()
	var editor_selection = editor_interface.get_selection()
	
	var resource_path = editor_interface.get_current_path()
	var weapon_resource = ResourceLoader.load(resource_path)
	
	for property in editor_selection.get_selected_nodes():
		weapon_resource.set(property.name, property.position)
		
	ResourceSaver.save(weapon_resource, resource_path)
