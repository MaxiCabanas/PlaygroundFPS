extends Node

var LocalPlayer: Node3D = null

func on_player_spawn_complete(player: Node3D) -> void:
	print("GAME INSTANCE: ", player.name, " is auth: ", player.is_multiplayer_authority())
	if player.is_multiplayer_authority():
		LocalPlayer = player
