class_name Hud extends Control

@onready var debug_panel: DebugPanel = %DebugPanel
@onready var debug_messages: DebugMessagesPanel = %Control

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu"):
		get_tree().quit()
