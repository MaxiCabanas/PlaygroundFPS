extends RigidBody3D


func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	if get_contact_count() > 0:
		var collision_pos := state.get_contact_local_position(0)
		var collision_normal := state.get_contact_local_normal(0)
		BulletsDecalManager.add_decal(collision_pos, collision_normal)
		queue_free()


#func _on_body_entered(body: Node) -> void:
	#get_colliding_bodies()[0]
