class_name Room extends Node2D

@export var tp_right: Area2D
@export var tp_bottom: Area2D
@export var tp_left: Area2D
@export var tp_top: Area2D
@export var final_room: Area2D
@export var player_spawn: Array[Marker2D]
var connected: int = 0
var player : Player = null

func _ready() -> void:
	if tp_bottom:
		tp_bottom.connect("body_entered", bottom)
		connected += 1
	if tp_right:
		tp_right.connect("body_entered", right)
		connected += 1
	if tp_left:
		tp_left.connect("body_entered", left)
		connected += 1
	if tp_top:
		tp_top.connect("body_entered", top)
		connected += 1
	if final_room:
		final_room.connect("body_entered", tp_final)
		final_room.connect("body_exited", no_final)
	if connected < 2:
		print("Esto no puede ser posible.")
	
	spawn_player()

func bottom() -> void:
	Global.tp_down(self)

func right() -> void:
	Global.tp_right(self)
	
func left() -> void:
	Global.tp_left(self)

func top() -> void:
	Global.tp_up(self)

func tp_final() -> void:
	var body: CharacterBody2D = final_room.get_overlapping_bodies()[final_room.get_overlapping_bodies().find(Player)]
	if body.is_in_group("Player"):
		player = body
		player.connect("go_in_final_room", Global.tp_final)

func no_final() -> void:
	var body: CharacterBody2D = final_room.get_overlapping_bodies()[final_room.get_overlapping_bodies().find(Player)]
	if body.is_in_group("Player"):
		player = null

func spawn_player() -> void:
	if player_spawn.size() == 3:
		add_child(preload("res://scenes/player/player.tscn").instantiate())
		var newPlayer : Player = get_tree().get_first_node_in_group("Player")
		newPlayer.position = player_spawn[0].position
	elif player_spawn.size() == 2:
		match Global.level.get_position(Global.pastRoom):
			0:
				if Global.level.get_position(Global.level.currentNode) == 1:
					add_child(preload("res://scenes/player/player.tscn").instantiate())
					var newPlayer : Player = get_tree().get_first_node_in_group("Player")
					newPlayer.position = player_spawn[2].position
				elif Global.level.get_position(Global.level.currentNode) == 1:
					add_child(preload("res://scenes/player/player.tscn").instantiate())
					var newPlayer : Player = get_tree().get_first_node_in_group("Player")
					newPlayer.position = player_spawn[1].position
			1:
				if Global.level.get_position(Global.level.currentNode) == 1:
					add_child(preload("res://scenes/player/player.tscn").instantiate())
					var newPlayer : Player = get_tree().get_first_node_in_group("Player")
					newPlayer.position = player_spawn[1].position
				elif Global.level.get_position(Global.level.currentNode) == 1:
					add_child(preload("res://scenes/player/player.tscn").instantiate())
					var newPlayer : Player = get_tree().get_first_node_in_group("Player")
					newPlayer.position = player_spawn[0].position
			2:
				if Global.level.get_position(Global.level.currentNode) == 1:
					add_child(preload("res://scenes/player/player.tscn").instantiate())
					var newPlayer : Player = get_tree().get_first_node_in_group("Player")
					newPlayer.position = player_spawn[1].position
				elif Global.level.get_position(Global.level.currentNode) == 1:
					add_child(preload("res://scenes/player/player.tscn").instantiate())
					var newPlayer : Player = get_tree().get_first_node_in_group("Player")
					newPlayer.position = player_spawn[0].position
			3:
				if Global.level.get_position(Global.level.currentNode) == 1:
					add_child(preload("res://scenes/player/player.tscn").instantiate())
					var newPlayer : Player = get_tree().get_first_node_in_group("Player")
					newPlayer.position = player_spawn[1].position
				elif Global.level.get_position(Global.level.currentNode) == 1:
					add_child(preload("res://scenes/player/player.tscn").instantiate())
					var newPlayer : Player = get_tree().get_first_node_in_group("Player")
					newPlayer.position = player_spawn[0].position
			_:
				print("Error")
		
		
		
		
		
		
