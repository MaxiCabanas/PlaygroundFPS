class_name Bullet
extends RigidBody3D

var _physic_state: PhysicsDirectBodyState3D

func setup(owner_weapon: Weapon) -> void:
	owner_weapon.get_tree().get_root().add_child(self)
	global_position = owner_weapon.to_global(owner_weapon.data.muzzle)
	global_rotation = owner_weapon.global_rotation
	var direction: Vector3 = -global_transform.basis.z.normalized() * owner_weapon.data.muzzle_velocity
	apply_impulse(direction)


func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	_physic_state = state


func _on_body_entered(body: Node) -> void:
	var collision_pos := _physic_state.get_contact_local_position(0)
	var collision_normal := _physic_state.get_contact_local_normal(0)
	BulletsDecalManager.add_decal(collision_pos, collision_normal)
	queue_free()
