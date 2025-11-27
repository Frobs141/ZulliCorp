class_name Player extends CharacterBody2D

const speed:int = 35000
const dash_speed:int = 60000
const jump_speed:int = -50000
const max_healt:int = 5
var attack_damage: int = 10
var dir: float
var dash_usable:bool = true
@onready var dash_cooldown: Timer = $DashCooldown
@onready var sprite: Sprite2D = $Icon
@onready var attack: AnimatedSprite2D = $Attack/AnimatedSprite2D

func changeDir() -> void:
	if dir < 0:
		attack.flip_v = true
		attack.rotation_degrees = 180
	elif dir > 0:
		attack.flip_v = false
		attack.rotation_degrees = 0

func _on_dash_cooldown_timeout() -> void:
	sprite.modulate = Color(1, 1, 0)
	dash_usable = true
	await get_tree().create_timer(0.2).timeout
	sprite.modulate = Color(1, 1, 1)
	
var current_health: int = max_healt # Inicializa la vida actual al máximo

func take_damage(amount: int) -> void:
	# 1. Reducir la vida
	current_health = current_health - amount
	
	# 2. Lógica visual o de invulnerabilidad (temporal, si aplica)
	# Por ejemplo, una señal visual (parpadeo) o un timer de invulnerabilidad.
	# sprite.modulate = Color.RED # Ejemplo de feedback visual
	
	# 3. Lógica de Muerte
	if current_health <= 0:
		die() # Llama a la función de muerte
		
func die() -> void:
	# Lógica para la muerte del jugador (ej. reiniciar nivel, mostrar pantalla de Game Over)
	print("Player has died!")
	queue_free() # Quita el jugador de la escena (temporalmente)

# Opcional: Implementa las funciones que usa el PhishingBot al atraparte
func disable_controls() -> void:
	# Deshabilita la entrada de usuario
	set_process_input(false)
	set_physics_process(false)
	
func enable_controls() -> void:
	# Rehabilita la entrada de usuario
	set_process_input(true)
	set_physics_process(true)
