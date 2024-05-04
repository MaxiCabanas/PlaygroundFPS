extends Node3D

func _ready() -> void:
	Lobby.player_loaded.rpc_id(1)
