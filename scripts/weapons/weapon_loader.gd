class_name WeaponLoader extends Node

const EDITOR_ROOT: String = "EDITOR_ROOT"

static func load_weapon(weapon_root: Node3D, weapon_data: WeaponResource) -> WeaponResource:	
	if Engine.is_editor_hint():
		for node in weapon_root.get_children():
			weapon_root.remove_child(node)
			node.queue_free()
	
	var visuals: Array[Mesh] = [weapon_data.body]
	visuals.append_array(weapon_data.default_attachments)
	
	
	for mesh in visuals:
		var mesh_instance = MeshInstance3D.new()
		mesh_instance.mesh = mesh
		mesh_instance.material_override = weapon_data.material
		weapon_root.add_child(mesh_instance)
	
	weapon_root.position = weapon_data.position
	weapon_root.rotation_degrees = weapon_data.rotation

	return weapon_data
