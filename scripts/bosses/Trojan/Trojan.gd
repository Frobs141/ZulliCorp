# Trojan.gd
class_name Trojan extends Boss

# ----------------------------------------------------
# PROPIEDADES ESPECÍFICAS
# ----------------------------------------------------
@export var max_shield_health: int = 50
var current_shield_health: int
@export var tank_movement_speed: float = 50.0 # Velocidad en Fase 1 (lento) 
@export var attack_movement_speed: float = 200.0 # Velocidad en Fase 2 (más rápido) 

# ----------------------------------------------------
# CONFIGURACIÓN INICIAL
# ----------------------------------------------------
func _ready():
	# Inicializa la salud base (heredada de Boss) y la salud del escudo
	super._ready()
	current_shield_health = max_shield_health
	
	# La Fase 1 (Tanque) es el estado inicial
	state_machine.change_state(Boss.BossState.PHASE_CHANGE) # Cambiará a TANK después de una animación, si aplica

# ----------------------------------------------------
# POLIMORFISMO: SOBRESCRIBIR LÓGICA DE DAÑO
# ----------------------------------------------------
# Sobreescribe la función take_damage de Boss.gd para implementar la lógica del escudo.
func take_damage(amount: int):
	# Si el jefe está en estado Tanque (Fase 1), el daño va al escudo.
	if state_machine.current_state is TrojanTank:
		current_shield_health -= amount
		
		if current_shield_health <= 0:
			# [cite_start]Escudo destruido: Inicia la transición a la Fase 2 (Ataque) [cite: 1]
			state_machine.change_state(Boss.BossState.PHASE_CHANGE)
			print("Caballo de Troya: Escudo destruido. Transición a Fase 2.")
		else:
			# Recibe daño al escudo, solo entra en estado Hurt si se desea efecto visual
			state_machine.change_state(Boss.BossState.HURT)
	
	# Si está en estado de Ataque (Fase 2, sin escudo), el daño va a la vida real.
	else:
		current_health -= amount # Resta a la vida heredada de Boss.gd
		
		if current_health <= 0:
			handle_death()
		else:
			state_machine.change_state(Boss.BossState.HURT)

# ----------------------------------------------------
# POLIMORFISMO: IMPLEMENTACIÓN DEL PATRÓN DE ATAQUE
# ----------------------------------------------------
# Esta función es llamada por BossAttack.gd y varía según el estado (Fase 1 o Fase 2)
func attack_pattern():
	if state_machine.current_state is TrojanTank:
		# [cite_start]Ataque en Fase Tanque: Salto lento y fácil de esquivar [cite: 1]
		jump(false) # Salto básico
		
	elif state_machine.current_state is TrojanAttack:
		# [cite_start]Ataque en Fase Ataque: Salto alto y eléctrico [cite: 1]
		jump(true) # Salto alto con electricidad

# ----------------------------------------------------
# LÓGICA DE SALTO (USADA POR attack_pattern)
# ----------------------------------------------------
func jump(is_electric: bool):
	# Implementación simplificada del salto
	# Nota: En Godot real, esto se manejaría con velocity.y y gravedad.
	
	var jump_power = 500.0 if is_electric else 250.0
	velocity.y = -jump_power
	
	# Inicia el ataque eléctrico (hitbox Area2D) si es Fase 2
	if is_electric:
		# [cite_start]Lógica para activar el Area2D eléctrico y el efecto de stun [cite: 1]
		print("Caballo de Troya: ¡Salto Eléctrico activado!")
	
	# La transición a IDLE o MOVE se hará cuando toque el suelo.

# ----------------------------------------------------
# POLIMORFISMO: IMPLEMENTACIÓN DE MUERTE/DERROTA
# ----------------------------------------------------
func handle_death():
	# Lógica de derrota final para el jefe Trojan
	print("Caballo de Troya: ¡Derrotado!")
	# Animación de explosión, recompensa, etc.
	queue_free()
