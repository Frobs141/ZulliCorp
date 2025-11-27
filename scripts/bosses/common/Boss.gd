class_name Boss extends Enemy # <--- CAMBIO IMPORTANTE: Hereda de Enemy

# --- Enumeración de Estados ---
enum BossState { IDLE, MOVE, ATTACK, HURT, DEATH, PHASE_CHANGE }

@export var movement_speed: float = 100.0
@export var attack_cooldown: float = 2.0

# Referencias
@onready var state_machine: StateMachine = $StateMachine
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")
@onready var attack_timer: Timer = $AttackTimer

func _ready():
	# Inicializamos la vida usando la variable del padre (Enemy)
	current_health = max_health
	
	# Iniciamos la FSM
	if state_machine:
		# Asegúrate de tener un estado inicial configurado en el editor o aquí
		pass
	
	if attack_timer:
		attack_timer.wait_time = attack_cooldown
		attack_timer.start()

# --- POLIMORFISMO: Sobrescribimos take_damage ---
func take_damage(amount: int) -> void:
	# Aquí iría la lógica de ESCUDO del Troyano más adelante
	# Por ahora, llamamos a la lógica base de Enemy
	super.take_damage(amount)
	
	# Transición a estado HURT si no murió (opcional)
	if current_health > 0 and state_machine:
		# state_machine.change_to("Hurt") # Descomentar si tienes estado Hurt
		pass

func die():
	# Lógica específica de muerte de jefe (cámara lenta, explosión grande)
	print("BOSS MUERTO")
	# Llamar al Global para pasar de nivel
	Global.level_completed()
	super.die() # Elimina el nodo
