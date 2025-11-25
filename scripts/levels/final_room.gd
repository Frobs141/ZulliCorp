extends Node2D

func _ready() -> void:
	add_child(preload("res://scenes/player/player.tscn").instantiate())
	var newPlayer : Player = get_tree().get_first_node_in_group("Player")
	newPlayer.position = $Marker2D.position
