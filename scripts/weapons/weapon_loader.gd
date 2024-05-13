class_name WeaponLoader extends Node

const EDITOR_ROOT: String = "EDITOR_ROOT"

static func load_weapon(weapon_node: Node3D, weapon_data: WeaponResource) -> WeaponResource:
	if Engine.is_editor_hint():
		# IMPLEMENT THIS
		weapon_node.get_node(EDITOR_ROOT)
		var editor_root = Node3D.new()
		editor_root.name = EDITOR_ROOT
	
	var visuals: Array[Mesh] = [weapon_data.body]
	visuals.append_array(weapon_data.default_attachments)
	
	for mesh in visuals:
		var mesh_instance = MeshInstance3D.new()
		mesh_instance.mesh = mesh
		mesh_instance.material_override = weapon_data.material
		weapon_node.add_child(mesh_instance)
	
	weapon_node.position = weapon_data.position
	weapon_node.rotation = weapon_node.rotation

	return weapon_data
