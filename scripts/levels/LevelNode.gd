class_name LevelNode extends RefCounted # Usamos RefCounted para que se maneje bien la memoria

## Escena del nivel que este nodo representa.
var level_scene: PackedScene = null 

## Referencia al nodo de nivel cargado actualmente en la escena.
var loaded_instance: Node2D = null 

## Referencia al nodo siguiente en la lista (circular)
var next: LevelNode = null 

## Referencia al nodo anterior en la lista (doble)
var prev: LevelNode = null 

func _init(scene: PackedScene):
	level_scene = scene

func get_name() -> String:
	if level_scene:
		return level_scene.resource_path.get_file().split(".")[0]
	return "Unassigned Level"
