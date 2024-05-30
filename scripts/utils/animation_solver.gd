class_name AnimationSolver extends Node

func update(delta:float, current:Vector3, target:Vector3, velocity:Vector3) -> Vector3:
	return target


func to_rotation_input(input: Vector2) -> Vector3:
	return Vector3(input.x, input.y, 0)


func to_position_input(input: Vector2) -> Vector3:
	return Vector3(input.x, input.y, 0)
