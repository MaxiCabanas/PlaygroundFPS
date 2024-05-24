extends RigidBody3D

var _physic_state: PhysicsDirectBodyState3D

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	_physic_state = state


func _on_body_entered(body: Node) -> void:
	var collision_pos := _physic_state.get_contact_local_position(0)
	var collision_normal := _physic_state.get_contact_local_normal(0)
	BulletsDecalManager.add_decal(collision_pos, collision_normal)
	queue_free()
