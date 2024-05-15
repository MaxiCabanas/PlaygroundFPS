class_name StateMachine
extends Node

var current_state: State
var states: Dictionary = {}

func _ready() -> void:
	for state in get_children():
		if state is State:
			states[state.name.to_lower()] = state


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
