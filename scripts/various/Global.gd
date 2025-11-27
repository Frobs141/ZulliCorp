extends Node

# Instancia de nuestra Estructura de Datos
var level_list: LevelList

# Variables de estado del juego
var player_health: int = 100 # Para mantener la vida entre niveles si quieres

func _ready():
	level_list = LevelList.new()
	
	# --- AQUÍ SE DEFINEN TUS 3 NIVELES ---
	# Cuando tu compañero tenga los tilesets, crearemos estas 3 escenas.
	# Por ahora, usaremos placeholders o las escenas de los jefes si no hay niveles aún.
	
	# Idealmente:
	# level_list.add_level("res://scenes/levels/Nivel1.tscn")
	# level_list.add_level("res://scenes/levels/Nivel2.tscn")
	# level_list.add_level("res://scenes/levels/Nivel3.tscn")
	
	# TEMPORAL (Para probar con lo que tienes):
	level_list.add_level("res://scenes/bosses/SpamOTron/SpamOTron.tscn") 
	# (Nota: Esto cargará solo al jefe en el vacío, luego lo cambiaremos por el Nivel completo)

func start_game():
	load_current_level()

func load_current_level():
	var path = level_list.get_current_level_path()
	if path != "":
		# Cambio de escena seguro
		call_deferred("_deferred_change_scene", path)

func _deferred_change_scene(path: String):
	get_tree().change_scene_to_file(path)

func level_completed():
	print("Nivel Completado. Viajando al siguiente nodo...")
	level_list.go_next()
	load_current_level()
