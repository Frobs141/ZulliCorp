class_name LevelList extends RefCounted

var head: LevelNode = null # La cabeza de la lista (primer nivel)
var current_node: LevelNode = null # El puntero actual (nivel activo)
var size: int = 0

# --- MÉTODOS DE ESTRUCTURA DE DATOS ---

# Verificar si está vacía
func is_empty() -> bool:
	return head == null

# Agregar un nivel al final de la lista (Insertar)
func append_scene(scene: PackedScene):
	var new_node = LevelNode.new(scene)
	
	if is_empty():
		# Caso 1: La lista está vacía. El nodo se apunta a sí mismo.
		head = new_node
		current_node = head
		new_node.next = head
		new_node.prev = head
	else:
		# Caso 2: Ya hay nodos. Insertamos entre el Último (tail) y la Cabeza.
		var tail = head.prev # En una circular, el anterior a la cabeza es la cola.
		
		# Configurar el nuevo nodo
		new_node.next = head
		new_node.prev = tail
		
		# Actualizar los punteros de los vecinos
		tail.next = new_node # El que era último ahora apunta al nuevo
		head.prev = new_node # La cabeza ahora apunta atrás al nuevo
	
	size += 1
	print("Estructura: Nodo agregado. Total niveles: ", size)

# Mover el puntero al siguiente nodo (Circular)
func move_next():
	if current_node:
		current_node = current_node.next
		print("Estructura: Avanzando a -> ", current_node.get_name())

# Mover el puntero al nodo anterior (Circular)
func move_prev():
	if current_node:
		current_node = current_node.prev
		print("Estructura: Retrocediendo a -> ", current_node.get_name())

# Obtener el dato del nodo actual
func get_current_scene() -> PackedScene:
	if current_node:
		return current_node.level_scene
	return null

# Obtener el nodo actual completo
func get_current_node() -> LevelNode:
	return current_node
