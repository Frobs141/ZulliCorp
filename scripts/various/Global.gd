extends Node

var topLeftRooms: Array[Array] = [
	[false],
	[false],
	[true]
]
var topRightRooms: Array[Array]  = [
	[false],
	[false],
	[true]
]
var bottomLeftRooms: Array[Array]  = [
	[false],
	[false],
	[true]
]
var bottomRightRooms: Array[Array]  = [
	[false],
	[false],
	[true]
]

var finalRoomConnected: bool = false
var level: LevelList


func generateLevel() -> void:
	if level.is_empty():
		level.add_last(SelectRoom(topLeftRooms))
		level.add_last(SelectRoom(topRightRooms))
		level.add_last(SelectRoom(bottomLeftRooms))
		level.add_last(SelectRoom(bottomRightRooms))
	else:
		level.edit_node(1, SelectRoom(topLeftRooms))
		level.edit_node(1, SelectRoom(topRightRooms))
		level.edit_node(1, SelectRoom(bottomLeftRooms))
		level.edit_node(1, SelectRoom(bottomRightRooms))

func SelectRoom(rooms: Array) -> Array:
	var room: Array
	if finalRoomConnected:
		room = rooms.filter(getFalse).pick_random()
	else:
		room = rooms.pick_random()
	return room

func getFalse(room: Array):
	return room[1] == false
