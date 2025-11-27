# PhishingBot.gd
class_name PhishingBot extends Boss

# ----------------------------------------------------
# PROPIEDADES Y ESCENAS
# ----------------------------------------------------
const HARPOON_SCENE = preload("res://scenes/enemies/common/Harpoon.tscn")
@export var pull_speed: float = 500.0 # Velocidad para jalar al jugador
@export var close_attack_damage: int = 25 # Daño del golpe de espinas
@export var close_attack_range: float = 100.0 # Distancia para ejecutar el golpe

var is_player_caught: bool = false
var caught_player: CharacterBody2D = null
var active_harpoon: Harpoon = null

@onready var Muzzle: Marker2D = $Muzzle # Punto de origen del arpón

# ----------------------------------------------------
# POLIMORFISMO: IMPLEMENTACIÓN DEL PATRÓN DE ATAQUE
# ----------------------------------------------------
func attack_pattern():
	# El patrón de ataque es lanzar el arpón.
	launch_harpoon()
	
	# Transición a un estado de espera o MOVE mientras el arpón viaja.
	# Si no se define un nuevo estado (PULL), se esperará en IDLE.
	state_machine.change_state(Boss.BossState.IDLE)


# ----------------------------------------------------
# LÓGICA DE ATAQUE DE ARPÓN (Encapsulación)
# ----------------------------------------------------
func launch_harpoon():
	if active_harpoon:
		return # No disparar si ya hay un arpón activo
		
	var harpoon = HARPOON_SCENE.instantiate()
	get_parent().add_child(harpoon)
	
	harpoon.global_position = $Muzzle.global_position
	
	# Establecer la dirección hacia el jugador
	var direction = (player.global_position - harpoon.global_position).normalized()
	harpoon.direction = direction
	
	# Conexión al manejador de enganche (Crucial para el flujo)
	harpoon.player_caught.connect(_on_harpoon_hit_player)
	
	active_harpoon = harpoon
	
# ----------------------------------------------------
# LÓGICA DE ENGANCHE Y GOLPE (Control de Flujo)
# ----------------------------------------------------

# Este método se llama cuando el arpón emite la señal 'player_caught'.
func _on_harpoon_hit_player(player_node: CharacterBody2D, harpoon_instance: Harpoon):
	is_player_caught = true
	caught_player = player_node
	active_harpoon = harpoon_instance
	
	# Deshabilita el control del jugador (Asume una función en el script del jugador)
	if caught_player.has_method("disable_controls"):
		caught_player.disable_controls()
	
	# Inicia el estado de jalar al jugador (necesita el nuevo estado)
	state_machine.change_state(Boss.BossState.PHASE_CHANGE) # Usamos PHASE_CHANGE como PULL temporalmente

# Este método se ejecuta en el estado de PULL (PHASE_CHANGE)
func pull_player_and_attack(delta: float):
	if caught_player:
		var direction_to_boss = (global_position - caught_player.global_position).normalized()
		
		# Mover al jugador hacia el jefe
		var pull_velocity = direction_to_boss * pull_speed * delta
		caught_player.global_position += pull_velocity # Mover directamente la posición
		
		# Si el jugador está lo suficientemente cerca, ejecutar el ataque
		if caught_player.global_position.distance_to(global_position) <= close_attack_range:
			execute_pufferfish_attack()
			
			# Transición a IDLE después del ataque
			state_machine.change_state(Boss.BossState.IDLE)


func execute_pufferfish_attack():
	if caught_player and caught_player.has_method("recieve_damage"):
		# Aplica el daño fuerte del golpe de espinas
		caught_player.recieve_damage(close_attack_damage)
		
		# Libera al jugador y limpia referencias
		if caught_player.has_method("enable_controls"):
			caught_player.enable_controls()
			
		active_harpoon.queue_free()
		active_harpoon = null
		caught_player = null
		is_player_caught = false
		
		print("Phishing Bot: ¡Ataque de espinas ejecutado!")

# ----------------------------------------------------
# POLIMORFISMO: IMPLEMENTACIÓN DE MUERTE/DERROTA
# ----------------------------------------------------
func handle_death():
	# Lógica de derrota final para Phishing Bot
	print("Phishing Bot: ¡Derrotado!")
	
	# Asegura liberar al jugador si muere mientras está enganchado
	if caught_player and caught_player.has_method("enable_controls"):
		caught_player.enable_controls()
	
	queue_free()
