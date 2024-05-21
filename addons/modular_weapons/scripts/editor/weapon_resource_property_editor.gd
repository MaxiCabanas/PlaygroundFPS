extends EditorProperty

var _custom_control = Button.new()


func _init() -> void:
	add_child(_custom_control)
	add_focusable(_custom_control)
	
	_custom_control.text = "LOAD"
	_custom_control.pressed.connect(_on_button_pressed)


func _update_property() -> void:
	var resource = get_edited_object()[get_edited_property()] as WeaponResourceBase
	_custom_control.text = "LOAD: %s" % [resource.name]


func _on_button_pressed() -> void:
	var resource = get_edited_object()[get_edited_property()]
	WeaponLoader.load_weapon(get_edited_object(), resource)
