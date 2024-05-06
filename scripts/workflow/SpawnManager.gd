class_name SpawnManager extends Node

@export var PlayerScene: PackedScene

## @NO_REPEAT: tries to pick free spawners first.
## @RANDOM: totally random.
@export_enum("NO_REPEAT", "RANDOM") var spawn_selection_mode: int

var _free_spawners: Array

func _ready() -> void:
	Lobby.player_loaded.rpc_id(1)
	print("server: ", multiplayer.is_server(), "READY")
	if multiplayer.is_server():
		Lobby.all_players_ready.connect(start_game)

func start_game():
	print(multiplayer.is_server(), " players count ", Lobby.players.keys().size())
	for player in Lobby.players:
		print(player)
		_try_reset_free_spawners()
		var spawn_point = _free_spawners.pick_random() as Node3D
		#_free_spawners.erase(spawn_point)
		var player_instance = PlayerScene.instantiate() as Node3D
		player_instance.name = str(player)
		add_child(player_instance, true)

		player_instance.global_position = spawn_point.global_position
		player_instance.global_rotation = spawn_point.global_rotation

func _try_reset_free_spawners():
	if _free_spawners.is_empty():
		_free_spawners = get_children()
