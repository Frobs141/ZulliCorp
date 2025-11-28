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
	Global.generateLevel()
	if tp_bottom:
		tp_bottom.connect("area_entered", bottom)
		connected += 1
	if tp_right:
		tp_right.connect("area_entered", right)
		connected += 1
	if tp_left:
		tp_left.connect("area_entered", left)
		connected += 1
	if tp_top:
		tp_top.connect("area_entered", top)
		connected += 1
	if final_room:
		final_room.connect("area_entered", tp_final)
		final_room.connect("area_exited", no_final)
	if connected < 2:
		print("Esto no puede ser posible.")
	
	spawn_player()

func bottom(_area: Area2D) -> void:
	match Global.level.get_position(Global.level.currentNode):
			0:
				get_tree().change_scene_to_packed(preload("res://scenes/levels/3-1.tscn"))
				Global.level.go_back()
			1:
				get_tree().change_scene_to_packed(preload("res://scenes/levels/2-1.tscn"))
				Global.level.go_on()
			_:
				print("Error")
	
	#Global.tp_down(self)

func right(_area: Area2D) -> void:
	match Global.level.get_position(Global.level.currentNode):
			0:
				get_tree().change_scene_to_packed(preload("res://scenes/levels/1-1.tscn"))
				Global.level.go_on()
			3:
				get_tree().change_scene_to_packed(preload("res://scenes/levels/2-1.tscn"))
				Global.level.go_back()
			_:
				print("Error")
				
	#Global.tp_right(self)
	
func left(_area: Area2D) -> void:
	match Global.level.get_position(Global.level.currentNode):
			1:
				get_tree().change_scene_to_packed(preload("res://scenes/levels/0-1.tscn"))
				Global.level.go_back()
			2:
				get_tree().change_scene_to_packed(preload("res://scenes/levels/3-1.tscn"))
				Global.level.go_on()
			_:
				print("Error")
	#Global.tp_left(self)

func top(_area: Area2D) -> void:
	match Global.level.get_position(Global.level.currentNode):
		2:
			get_tree().change_scene_to_packed(preload("res://scenes/levels/1-1.tscn"))
			Global.level.go_back()
		3:
			get_tree().change_scene_to_packed(preload("res://scenes/levels/0-1.tscn"))
			Global.level.go_on()
		_:
			print("Error")
	#Global.tp_up(self)

func tp_final(_area: Area2D) -> void:
	var body: CharacterBody2D = final_room.get_overlapping_bodies()[final_room.get_overlapping_bodies().find(Player)]
	if body.is_in_group("player"):
		player = body
		player.connect("go_in_final_room", Global.tp_final)

func no_final() -> void:
	var body: CharacterBody2D = final_room.get_overlapping_bodies()[final_room.get_overlapping_bodies().find(Player)]
	if body.is_in_group("player"):
		player = null

func spawn_player() -> void:
	if player_spawn.size() == 3 and !Global.pastRoom:
		add_child(preload("res://scenes/player/player.tscn").instantiate())
		var newPlayer : Player = get_tree().get_first_node_in_group("player")
		newPlayer.position = player_spawn[0].position
	elif player_spawn.size() == 2:
		match Global.level.get_position(Global.pastRoom):
			0:
				if Global.level.get_position(Global.level.currentNode) == 1:
					add_child(preload("res://scenes/player/player.tscn").instantiate())
					var newPlayer : Player = get_tree().get_first_node_in_group("player")
					newPlayer.position = player_spawn[2].position
				elif Global.level.get_position(Global.level.currentNode) == 3:
					add_child(preload("res://scenes/player/player.tscn").instantiate())
					var newPlayer : Player = get_tree().get_first_node_in_group("player")
					newPlayer.position = player_spawn[1].position
			1:
				if Global.level.get_position(Global.level.currentNode) == 0:
					add_child(preload("res://scenes/player/player.tscn").instantiate())
					var newPlayer : Player = get_tree().get_first_node_in_group("player")
					newPlayer.position = player_spawn[2].position
				elif Global.level.get_position(Global.level.currentNode) == 2:
					add_child(preload("res://scenes/player/player.tscn").instantiate())
					var newPlayer : Player = get_tree().get_first_node_in_group("player")
					newPlayer.position = player_spawn[0].position
			2:
				if Global.level.get_position(Global.level.currentNode) == 1:
					add_child(preload("res://scenes/player/player.tscn").instantiate())
					var newPlayer : Player = get_tree().get_first_node_in_group("player")
					newPlayer.position = player_spawn[1].position
				elif Global.level.get_position(Global.level.currentNode) == 3:
					add_child(preload("res://scenes/player/player.tscn").instantiate())
					var newPlayer : Player = get_tree().get_first_node_in_group("player")
					newPlayer.position = player_spawn[0].position
			3:
				if Global.level.get_position(Global.level.currentNode) == 2:
					add_child(preload("res://scenes/player/player.tscn").instantiate())
					var newPlayer : Player = get_tree().get_first_node_in_group("player")
					newPlayer.position = player_spawn[1].position
				elif Global.level.get_position(Global.level.currentNode) == 0:
					add_child(preload("res://scenes/player/player.tscn").instantiate())
					var newPlayer : Player = get_tree().get_first_node_in_group("player")
					newPlayer.position = player_spawn[1].position
			_:
				print("Error")
		
		
		
		
		
		
