# TrojanAttack.gd
class_name TrojanAttack extends BossState

# Estado de movimiento rápido sin escudo del Caballo de Troya.

func enter():
	# [cite_start]Ajusta la velocidad de movimiento al modo Ataque (más rápido) [cite: 1]
	boss.movement_speed = boss.attack_movement_speed
	# Si es necesario, dispara una animación de transformación aquí.

func execute(delta: float):
	# [cite_start]Lógica de movimiento: Más rápido y saltos más altos [cite: 1]
	if not boss.player: return

	var direction = (boss.player.global_position - boss.global_position).normalized()
	boss.velocity.x = direction.x * boss.movement_speed
	
	# Aplicar gravedad y mover el CharacterBody2D
	boss.move_and_slide()
	
	# Permite que el temporizador de ataque en Boss.gd lo transicione a ATTACK.
