extends Node

var LocalPlayer: Node3D = null

func on_player_spawn_complete(player: Node3D) -> void:
	if player.is_multiplayer_authority():
		LocalPlayer = player
