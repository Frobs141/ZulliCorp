# Boss.gd
class_name Boss extends CharacterBody2D

# ----------------------------------------------------
# 1. ENCAPSULACIÓN: Enumeración de Estados Comunes
# ----------------------------------------------------
enum BossState {
	IDLE,       # Espera, mirando al jugador
	MOVE,       # Moviéndose hacia o lejos del jugador
	ATTACK,     # Ejecutando su patrón de ataque (lanzar gancho, basura, etc.)
	HURT,       # Recibiendo daño
	DEATH,      # Muerte o transición de fase
	PHASE_CHANGE # Para jefes con fases como el Caballo de Troya
}

# ----------------------------------------------------
# 2. PROPIEDADES BASE (Encapsulación)
# ----------------------------------------------------
@export var max_health: int = 100
var current_health: int

@export var movement_speed: float = 100.0
@export var attack_cooldown: float = 2.0
var attack_timer: float = 0.0

# Referencia a la máquina de estados. Usamos @onready para asegurar su existencia.
@onready var state_machine: StateMachine = $StateMachine

# Referencia al nodo del jugador (Asume que el jugador está en el grupo "player")
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")

# ----------------------------------------------------
# 3. MÉTODOS BASE (Abstracción)
# ----------------------------------------------------

func _ready():
	current_health = max_health
	state_machine.change_state(BossState.IDLE)
	
	# Usamos un timer de un solo disparo para el cooldown de ataque
	$AttackTimer.wait_time = attack_cooldown
	$AttackTimer.start()


func _physics_process(delta):
	# Ejecuta la lógica del estado actual
	if state_machine.current_state and state_machine.current_state.has_method("execute"):
		state_machine.current_state.execute(delta)
	
	# Esto es para movimiento simple si el jefe no está atacando
	# velocity.y += 980 * delta # Ejemplo de gravedad
	# move_and_slide()

# ----------------------------------------------------
# 4. POLIMORFISMO Y HERENCIA: Lógica de Daño
# ----------------------------------------------------

# Esta función es la que llama el proyectil o el ataque del jugador.
# Los jefes con lógica de escudo (como Caballo de Troya) SOBRESCRIBIRÁN (override) esta función.
func take_damage(amount: int):
	# Si un jefe hijo no tiene lógica de escudo especial, simplemente usa esta base.
	current_health -= amount
	
	if current_health <= 0:
		handle_death()
	else:
		# Transicionar al estado de daño brevemente
		state_machine.change_state(BossState.HURT)
		
# ----------------------------------------------------
# 5. MÉTODOS "ABSTRACTOS" (A implementar por las clases hijas)
# ----------------------------------------------------

# **Función Polimórfica:** Cada jefe implementará esta función con su patrón de ataque único.
# Se llamará desde el estado BossState.ATTACK.
func attack_pattern():
	# La palabra 'assert' se usa para forzar a las clases hijas a implementar esto.
	# En GDScript, es la forma de simular un método abstracto.
	push_error("Error: 'attack_pattern' debe ser implementado por la clase hija.")
	
# **Función Polimórfica:** Maneja la lógica final de derrota o transición de fase 2.
func handle_death():
	push_error("Error: 'handle_death' debe ser implementado por la clase hija.")
	queue_free() # Eliminar por defecto (será reemplazado)

# ----------------------------------------------------
# 6. SEÑALES (Timer para cooldown de ataque)
# ----------------------------------------------------

# Conecta esta señal al nodo Timer llamado "AttackTimer"
func _on_attack_timer_timeout():
	# Si no estamos muertos o heridos, podemos intentar atacar
	if state_machine.current_state.get_name() != "HURT" and state_machine.current_state.get_name() != "DEATH":
		state_machine.change_state(BossState.ATTACK)
	
	$AttackTimer.start() # Reinicia el temporizador
