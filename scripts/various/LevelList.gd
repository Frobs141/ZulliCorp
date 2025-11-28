class_name LevelList extends Node

var head: RoomNode = null
var currentNode: RoomNode = null

func is_empty() -> bool:
	return head == null

func add_last(room: Array) -> void:
	var roomAdded = RoomNode.new(room[0], room[1])
	if self.is_empty():
		head = roomAdded
		roomAdded.next = head
		currentNode = roomAdded
		return
	
	var current: RoomNode = self.head
	while current.next != self.head:
		current = current.next
	
	current.next = roomAdded
	roomAdded.past = current
	roomAdded.next = head

func edit_node(pos: int, newRoom: Array):
	if pos > 4 or pos < 1:
		return "Pusiste mal la posición, estupido."
	var current:RoomNode = head
	var cont: int = 0
	while cont < pos - 1:
		current = current.next
		cont += 1
	current.scene = newRoom[0]
	current.finalRoom = newRoom[1]
	
func go_back() -> void:
	currentNode = currentNode.past

func go_on() -> void:
	currentNode = currentNode.next

func reset() -> void:
	currentNode = head

func get_position(node: RoomNode) -> int:
	var current:RoomNode = head
	var pos: int = 0
	while pos < 4 or current == node:
		current = current.next
		pos += 1
	if pos > 3:
		return -1
	return pos
