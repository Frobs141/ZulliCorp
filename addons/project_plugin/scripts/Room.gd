class_name Room extends Node2D

@export var tp_right: Area2D
@export var tp_bottom: Area2D
@export var tp_left: Area2D
@export var tp_top: Area2D
@export var final_room: Area2D
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
