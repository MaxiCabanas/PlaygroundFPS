extends Control

@onready var player_name: LineEdit = %PlayerName
@onready var remote_address: LineEdit = %RemoteAddress
@onready var tab_container: TabContainer = %TabContainer

@onready var players_name_display: VBoxContainer = %PlayersNameDisplay
@onready var server_start_game: Button = %ServerStartGame

@onready var gameplay_path: String = "res://scenes/gameplay.tscn"

func _ready() -> void:
	tab_container.current_tab = 0
	
	player_name.text_changed.connect(func(new_name): Lobby.player_info.name = new_name)
	
	Lobby.player_connected.connect(_on_player_connected)
	
	#client notifications
	multiplayer.connected_to_server.connect(_on_connected_ok)
	multiplayer.connection_failed.connect(_on_connected_fail)
	multiplayer.server_disconnected.connect(_on_server_disconnected)
	
	
func _on_player_connected(player_id: int, player_info):
	var new_player_label: Label = Label.new()
	var format: String = "%s (%s)"
	new_player_label.name = str(player_id)
	new_player_label.text = format % [player_info.name , player_id]
	players_name_display.add_child(new_player_label)
	

func _on_player_disconnected(player_id: int):
	var player_label = players_name_display.find_child(str(player_id))
	player_label.queue_free()
	
	
func _on_connected_ok():
	HUD.debug_messages.show_debug_message("Connected to server!")
	
	
func _on_connected_fail():
	HUD.debug_messages.show_debug_message("FAILED TO CONNECT TO SERVER.")
	
	
func _on_server_disconnected():
	HUD.debug_messages.show_debug_message("Server disconnected.")


func _on_host_button_up() -> void:
	tab_container.current_tab = 1
	Lobby.create_game()


func _on_join_button_up() -> void:
	tab_container.current_tab = 1
	server_start_game.visible = false
	Lobby.join_game(remote_address.text)


func _on_server_start_game() -> void:
	Lobby.load_game.rpc(gameplay_path)
