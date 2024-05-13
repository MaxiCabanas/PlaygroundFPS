class_name DebugPanel extends PanelContainer

@onready var properties_container: VBoxContainer = %LabelContainers

var properties_dic: Dictionary
var printed_properties: Array[Dictionary]

#properties_dic: {
	#node1: {
		#"property1": { label = *Label, isDynamic = ´should be updated every frame´}
	#}
#}
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug"):
		set("visible", !get("visible"))

func _process(_delta: float) -> void:
	# draw properties if should be drawn
	for node in properties_dic:
		for property in properties_dic[node]:
			_update_property(node, property)

func add_or_update_property(node: Node, property: String, isVisible = true, isDynamic: bool = false, order: int = 0) -> void:
	if !properties_dic.has(node):
		properties_dic[node] = {}
	
	if !properties_dic[node].has(property):
		properties_dic[node][property] = {}
	
	var property_data = properties_dic[node][property]
	
	if !property_data.has("label") || !property_data.label:
		property_data.label = Label.new()
		property_data.label.set("name", node.name + "_" + property)
		properties_container.add_child(property_data.label)
	
	property_data.label.set("visible", isVisible)
	properties_container.move_child(property_data.label, order)
	property_data.isDynamic = isDynamic
	
	_update_property(node, property, false)

func _update_property(node: Node, property: String, check_is_dynamic: bool = true):
	var property_data = properties_dic[node][property]
	if property_data.label.get("visible") && (!check_is_dynamic || property_data.isDynamic):
			#property_data.label.text = property + ": " + str(node.get(property))
			property_data.label.text = "%s: %s" %[property, str(node.get(property))]

func print_property(title: String, value: String, isVisible: bool, order: int):
	var new_label: Label
	
	for property in printed_properties:
		if property.title == title:
			new_label = property.label
			
	if !new_label:
		new_label = Label.new()
		properties_container.add_child(new_label)
		printed_properties.append({
			"title": title,
			"label": new_label })
	
	new_label.set("text", "%s: %s" %[title, value])
	new_label.set("visible", isVisible)
