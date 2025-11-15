class_name RoomNode extends Node

var scene: PackedScene = null
var finalRoom: bool = false
var next: RoomNode = null
var past: RoomNode = null

func _init(room: PackedScene, final: bool) -> void:
	scene = room
	finalRoom = final
