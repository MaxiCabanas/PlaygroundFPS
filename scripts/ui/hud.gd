class_name Hud extends Control

@onready var debug_panel: DebugPanel = %DebugPanel
@onready var debug_messages: DebugMessagesPanel = %Control

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu"):
		get_tree().quit()

static func Show_debug_message(message: String, duration = 5.0):
	HUD.debug_messages.show_debug_message(message, duration)

static func Add_or_update_property(node: Node, property: String, isVisible = true, isDynamic: bool = false, order: int = 0) -> void:
	HUD.debug_panel.add_or_update_property(node, property, isVisible, isDynamic, order)

static func Print_property(title: String, value: String, isVisible = true, order = 0):
	HUD.debug_panel.print_property(title, value, isVisible, order)
