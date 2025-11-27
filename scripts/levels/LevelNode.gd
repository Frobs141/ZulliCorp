class_name LevelNode extends RefCounted # Usamos RefCounted para que se maneje bien la memoria

# DATO: La escena del nivel que este nodo guarda
var level_scene: PackedScene = null

# DATO EXTRA: Una referencia a la instancia cargada (el jefe vivo)
var loaded_instance: Node2D = null

# PUNTEROS (Referencias)
var next: LevelNode = null # Puntero al siguiente nodo
var prev: LevelNode = null # Puntero al nodo anterior

func _init(scene: PackedScene):
	level_scene = scene

# Función auxiliar para obtener el nombre del nivel (para debug)
func get_name() -> String:
	if level_scene:
		return level_scene.resource_path.get_file().split(".")[0]
	return "Unassigned Level"
