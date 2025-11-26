class_name Level_List extends RefCounted

var head: LevelNode = null
var current_node: LevelNode = null
var size: int = 0

## Agrega un nuevo nodo a la lista.
func append_scene(scene: PackedScene):
	var new_node = LevelNode.new(scene)
	
	if head == null:
		# Primera inserción: el nodo se apunta a sí mismo (Circular)
		head = new_node
		current_node = new_node
		new_node.next = new_node
		new_node.prev = new_node
	else:
		# Inserción posterior: Enlazamos en forma circular y doble
		var tail = head.prev # La cola es el nodo anterior a la cabeza
		
		# 1. Enlace doble del nuevo nodo
		new_node.prev = tail
		new_node.next = head
		
		# 2. Re-enlace doble de la cabeza y la cola
		head.prev = new_node # La cabeza apunta al nuevo nodo como anterior
		tail.next = new_node # La cola apunta al nuevo nodo como siguiente
		
	size += 1

## Mueve el puntero al siguiente nivel de la lista circular.
func move_next():
	if current_node:
		current_node = current_node.next

## Mueve el puntero al nivel anterior de la lista circular.
func move_prev():
	if current_node:
		current_node = current_node.prev

## Devuelve la escena del nivel actual.
func get_current_scene() -> PackedScene:
	if current_node:
		return current_node.level_scene
	return null

## Devuelve el nodo actual.
func get_current_node() -> LevelNode:
	return current_node
