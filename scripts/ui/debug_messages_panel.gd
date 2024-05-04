class_name DebugMessagesPanel extends PanelContainer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var messages_container: VBoxContainer = %VBoxContainer

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_aux"):
		ShowDebugMessage("A very cool debug message!")

func ShowDebugMessage(message: String, duration = 5.0):
	var message_label = Label.new()
	message_label.set("text", message)

	if messages_container.get_child_count() == 0:
		animation_player.play("MessagePanelShowUp")
		
	messages_container.add_child(message_label)
	
	var tween: Tween = message_label.create_tween().set_trans(Tween.TRANS_CUBIC)
	
	var property_tweener: PropertyTweener = tween.tween_property(
		message_label, "modulate", Color(1, 1, 1, 0), .5)
	property_tweener.set_delay(duration)
	property_tweener.finished.connect(_on_message_time_out.bind(message_label))
	
func _on_message_time_out(message_label: Label):
	message_label.queue_free()
	if messages_container.get_child_count() <= 1:
		animation_player.play_backwards("MessagePanelShowUp")
