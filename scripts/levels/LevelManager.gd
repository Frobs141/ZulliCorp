extends Node

var level_list: LevelList

const LEVEL_TROJAN: PackedScene = preload("res://scenes/bosses/Trojan/Trojan.tscn")
const LEVEL_SPAMOTRON: PackedScene = preload("res://scenes/bosses/SpamOTron/SpamOTron.tscn")
const LEVEL_PHISHING: PackedScene = preload("res://scenes/bosses/PhishingBot/PhishingBot.tscn") 

@onready var player: Player = get_node("../Player")

func _ready():
	# Inicializar la lista de niveles
	level_list = LevelList.new()
	
	# 1. Llenar la lista circular con los jefes. El orden define el ciclo.
	level_list.append_scene(LEVEL_TROJAN)
	level_list.append_scene(LEVEL_SPAMOTRON)
	level_list.append_scene(LEVEL_PHISHING)
	
	# 2. Cargar el primer nivel (el actual)
	load_current_level()

## Carga la escena del nivel actual de la lista.
func load_current_level():
	var current_scene = level_list.get_current_scene()
	if current_scene:
		# 1. Crear una instancia del jefe
		var new_boss_instance = current_scene.instantiate() as Boss
		
		# 2. Configurar la posición y la referencia al jugador
		new_boss_instance.global_position = Vector2(800, 400) # Posición inicial
		new_boss_instance.player = player
		
		# 3. Añadir el jefe a la escena principal
		add_child(new_boss_instance)
		
		# 4. Guardar la referencia de la instancia en el LevelNode
		level_list.get_current_node().loaded_instance = new_boss_instance
		print("Jefe cargado: ", level_list.get_current_node().get_name())

## Descarga el nivel actual y avanza al siguiente.
func transition_to_next_level():
	# 1. Obtener la instancia del jefe actual
	var old_boss_instance = level_list.get_current_node().loaded_instance
	
	if old_boss_instance:
		# 2. Eliminar al jefe de la escena
		old_boss_instance.queue_free()
		level_list.get_current_node().loaded_instance = null
		
	# 3. Mover el puntero al siguiente nodo en la lista circular
	level_list.move_next()
	
	# 4. Cargar el nuevo jefe
	load_current_level()

func on_boss_defeated():
	print("¡Jefe derrotado! Pasando al siguiente nivel...")
	transition_to_next_level()
