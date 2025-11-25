extends Node

var topLeftRooms: Array[Array] = [
	[preload("res://scenes/levels/tl_test.tscn") ,false],
	[preload("res://scenes/levels/tl_test.tscn") ,false],
	[preload("res://scenes/levels/tl_test.tscn") ,true]
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
		level.add_last(SelectRoom(bottomRightRooms))
		level.add_last(SelectRoom(bottomLeftRooms))
	else:
		level.edit_node(1, SelectRoom(topLeftRooms))
		level.edit_node(2, SelectRoom(topRightRooms))
		level.edit_node(4, SelectRoom(bottomLeftRooms))
		level.edit_node(3, SelectRoom(bottomRightRooms))

func SelectRoom(rooms: Array) -> Array:
	var room: Array
	if finalRoomConnected:
		room = rooms.filter(getFalse).pick_random()
	else:
		room = rooms.pick_random()
	return room

func tp_left(room: Node2D) -> void:
	if room.get_node("tp_up"):
		level.go_on()
	elif room.get_node("tp_down"):
		level.go_back()
	get_tree().change_scene(level.currentNode.scene)

func tp_right(room: Node2D) -> void:
	if room.get_node("tp_down"):
		level.go_on()
	elif room.get_node("tp_up"):
		level.go_back()
	get_tree().change_scene(level.currentNode.scene)

func tp_up(room: Node2D) -> void:
	if room.get_node("tp_left"):
		level.go_on()
	elif room.get_node("tp_right"):
		level.go_back()
	get_tree().change_scene(level.currentNode.scene)

func tp_down(room: Node2D) -> void:
	if room.get_node("tp_right"):
		level.go_on()
	elif room.get_node("tp_left"):
		level.go_back()
	get_tree().change_scene_to_packed(level.currentNode.scene)
	
func tp_final() -> void:
	get_tree().change_scene_to_packed(preload("res://scenes/levels/final_room.tscn"))
	
func getFalse(room: Array):
	return room[1] == false
