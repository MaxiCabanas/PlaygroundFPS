class_name Global
extends Object

static func rad_to_deg_v3(vector: Vector3) -> Vector3:
	return Vector3(
			rad_to_deg(vector.x),
			rad_to_deg(vector.y),
			rad_to_deg(vector.z)
	)


static func deg_to_rad_v3(vector: Vector3) -> Vector3:
	return Vector3(
			deg_to_rad(vector.x),
			deg_to_rad(vector.y),
			deg_to_rad(vector.z)
	)


static func randomize_v3(vector: Vector3) -> Vector3:
	return Vector3(
			randf_range(-vector.x, vector.x),
			randf_range(-vector.y, vector.y),
			randf_range(-vector.z, vector.z)
	)
