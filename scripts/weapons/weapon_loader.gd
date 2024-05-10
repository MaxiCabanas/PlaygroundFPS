extends Node

var file_text = FileAccess.get_file_as_string("res://assets/configs/types.json")
var parsed_data = JSON.parse_string(file_text)

func load_weapon(weapon_node: Node3D, weapon_data: WeaponResource) -> WeaponResource:
	var visuals: Array[PackedScene] = [weapon_data.body]
	visuals.append_array(weapon_data.default_attachments)
	
	for node in visuals:
		weapon_node.add_child(node.instantiate())
	
	weapon_node.position = weapon_data.position
	weapon_node.rotation = weapon_node.rotation

	return weapon_data
