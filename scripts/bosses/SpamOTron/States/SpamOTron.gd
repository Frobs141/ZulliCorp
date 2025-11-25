# SpamOTron.gd
class_name SpamOTron extends Boss

# ----------------------------------------------------
# PROPIEDADES ESPECÍFICAS
# ----------------------------------------------------
# Las escenas se precargan para instanciación rápida.
const GARBAGE_SCENE = preload("res://scenes/bosses/Common/GarbageProjectile.tscn") # Proyectil de basura
const MINION_SCENE = preload("res://scenes/enemies/AdBot.tscn") # Minion que invoca

@export var garbage_spawn_rate: float = 0.5 # Disparo cada 0.5 segundos
@export var minion_spawn_cooldown: float = 10.0 # Invocar minion cada 10 segundos

@onready var MinionTimer: Timer = $MinionTimer # Asume que hay un nodo Timer llamado "MinionTimer"
@onready var GarbageTimer: Timer = $GarbageTimer # Asume que hay un nodo Timer llamado "GarbageTimer"
@onready var SpawnPoint: Marker2D = $SpawnPoint # Punto de origen de la basura

# ----------------------------------------------------
# CONFIGURACIÓN INICIAL
# ----------------------------------------------------
func _ready():
	super._ready()
	
	# Configuración de temporizadores para invocación
	$MinionTimer.wait_time = minion_spawn_cooldown
	$GarbageTimer.wait_time = garbage_spawn_rate
	
	# Conexión de señales (asegurar que estén conectadas en el editor o en código)
	# $MinionTimer.timeout.connect(_on_minion_timer_timeout)
	# $GarbageTimer.timeout.connect(_on_garbage_timer_timeout)
	
	$MinionTimer.start()
	$GarbageTimer.start()
	state_machine.change_state(Boss.BossState.IDLE) # Empieza en estado IDLE

# ----------------------------------------------------
# POLIMORFISMO: IMPLEMENTACIÓN DEL PATRÓN DE ATAQUE
# ----------------------------------------------------
# El ataque de Spam-O-Tron es continuo, por lo que el BossAttack.gd solo lo activa.
# La lógica principal está en las funciones de invocación.
func attack_pattern():
	# El patrón de ataque es simplemente invocar la lluvia de basura,
	# la cual es manejada por el timer, por lo que este método puede ser simple
	# o usado para un ataque especial si se necesitara.
	pass

# ----------------------------------------------------
# LÓGICA DE INVOCACIÓN (Encapsulación)
# ----------------------------------------------------

# Lanza un proyectil de "basura" en un ángulo aleatorio.
func spawn_garbage_projectile():
	# Crear una nueva instancia de proyectil
	var garbage = GARBAGE_SCENE.instantiate()
	
	# Posición de inicio: Usa un Marker2D ($SpawnPoint) para el origen
	garbage.global_position = $SpawnPoint.global_position
	
	# Dirección aleatoria para simular la "lluvia de basura" (aleatoriedad en x y y)
	# Ejemplo: dirección ligeramente hacia abajo y con dispersión horizontal
	var random_x = randf_range(-0.5, 0.5)
	var random_y = randf_range(-1.0, -0.5) # Direccionando hacia abajo
	garbage.direction = Vector2(random_x, random_y).normalized()
	
	# Asegura que el proyectil se añade al árbol principal de la escena.
	get_parent().add_child(garbage)

# Invoca un Ad-Bot (minion).
func spawn_minion():
	var minion = MINION_SCENE.instantiate()
	
	# Posición de inicio (ejemplo: encima del jefe)
	minion.global_position = global_position + Vector2(0, -100)
	
	# Configurar el minion si es necesario (ej. velocidad de vuelo)
	
	get_parent().add_child(minion)
	print("Spam-O-Tron: Minion 'Ad-Bot' invocado.")

# ----------------------------------------------------
# CONEXIONES DE SEÑALES (Timer Callbacks)
# ----------------------------------------------------

# Conecta esta señal al nodo Timer llamado "GarbageTimer"
func _on_garbage_timer_timeout():
	# Solo genera basura si no está muerto o en estado de transición.
	if state_machine.current_state.get_name() != "DEATH":
		spawn_garbage_projectile()
		# Nota: El timer se reinicia automáticamente si es `autostart` o aquí si no lo es.

# Conecta esta señal al nodo Timer llamado "MinionTimer"
func _on_minion_timer_timeout():
	if state_machine.current_state.get_name() != "DEATH":
		spawn_minion()
		# Nota: El timer se reinicia automáticamente.
		
# ----------------------------------------------------
# POLIMORFISMO: IMPLEMENTACIÓN DE MUERTE/DERROTA
# ----------------------------------------------------
func handle_death():
	# Lógica de derrota final para Spam-O-Tron
	print("Spam-O-Tron: ¡Derrotado!")
	# Detener los timers para que no sigan lanzando proyectiles al morir
	$GarbageTimer.stop()
	$MinionTimer.stop()
	queue_free()
