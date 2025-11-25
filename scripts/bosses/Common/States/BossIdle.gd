# BossIdle.gd (Hereda de BossState.gd)
class_name BossIdle extends BossState

# Estado genérico de espera. El jefe puede mirar al jugador.
func execute(delta: float):
	# Lógica para mirar al jugador.
	# La dirección de movimiento (velocity.x) puede usarse para voltear el sprite.
	var direction_to_player = boss.player.global_position.x - boss.global_position.x
	
	if direction_to_player > 0:
		# Mirar a la derecha
		boss.scale.x = 1
	elif direction_to_player < 0:
		# Mirar a la izquierda
		boss.scale.x = -1
		
	# Esperar el temporizador de ataque. La transición la maneja la señal _on_attack_timer_timeout
	# en la clase Boss.gd.
	
	# Si el jefe tiene movimiento simple en IDLE, la lógica iría aquí.
