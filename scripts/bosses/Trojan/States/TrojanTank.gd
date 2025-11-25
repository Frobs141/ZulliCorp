# TrojanTank.gd
class_name TrojanTank extends BossState

# Estado de movimiento lento del Caballo de Troya.

func enter():
	# Ajusta la velocidad de movimiento al modo Tanque.
	boss.movement_speed = boss.tank_movement_speed
	# Asegura que el jefe esté listo para el ataque si el timer lo permite.

func execute(delta: float):
	# Lógica de movimiento: Simplemente moverse hacia el jugador
	if not boss.player: return

	var direction = (boss.player.global_position - boss.global_position).normalized()
	boss.velocity.x = direction.x * boss.movement_speed
	
	# Aplicar gravedad y mover el CharacterBody2D
	# Asumimos que la gravedad se aplica en boss._physics_process o en este execute.
	# Si la gravedad está en boss.gd:
	boss.move_and_slide()
	
	# Permite que el temporizador de ataque en Boss.gd lo transicione a ATTACK.
