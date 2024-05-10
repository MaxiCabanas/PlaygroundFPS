class_name DebugMessagesPanel extends PanelContainer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var messages_container: VBoxContainer = %VBoxContainer

var active_messages_count: int = 0

func _ready() -> void:
	animation_player.animation_finished.connect(_on_panel_animation_finished)
	
func _on_panel_animation_finished(_anim_name):
	if active_messages_count == 0:
		for child in messages_container.get_children():
			child.queue_free()

func show_debug_message(message: String, duration = 5.0):
	var message_label = Label.new()
	
	message_label.set("text", message)
	messages_container.add_child(message_label)

	if active_messages_count == 0:
		animation_player.play("MessagePanelShowUp")

	var tween: Tween = message_label.create_tween().set_trans(Tween.TRANS_CUBIC)
	
	var property_tweener: PropertyTweener = tween.tween_property(
		message_label, "modulate", Color(1, 1, 1, 0), .5)
	property_tweener.set_delay(duration)
	property_tweener.finished.connect(_on_message_time_out.bind(message_label))
	
	active_messages_count += 1
	
func _on_message_time_out(message_label: Label):
	if messages_container.get_child_count() <= 1:
		animation_player.play_backwards("MessagePanelShowUp")
	else: # we don't queue_free() the last one so the fadeOut looks cooler.
		message_label.queue_free()
		
	active_messages_count -= 1
