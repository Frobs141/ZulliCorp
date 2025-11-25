# BossMove.gd (Hereda de BossState.gd)
class_name BossMove extends BossState

# Distancia mínima que el jefe intentará mantener con el jugador
@export var ideal_distance: float = 300.0
@export var tolerance: float = 50.0

func execute(delta: float):
	if not boss.player: return

	var distance = boss.global_position.distance_to(boss.player.global_position)
	var direction = (boss.player.global_position - boss.global_position).normalized()

	# Si la distancia es mayor a la ideal, el jefe se mueve hacia el jugador.
	if distance > ideal_distance + tolerance:
		boss.velocity.x = direction.x * boss.movement_speed
		
	# Si la distancia es menor a la ideal, el jefe se aleja del jugador.
	elif distance < ideal_distance - tolerance:
		boss.velocity.x = -direction.x * boss.movement_speed
		
	# Si está dentro de la tolerancia, se detiene y espera el siguiente estado.
	else:
		boss.velocity.x = 0
		# Si ya está en posición, puede transicionar a IDLE o ATTACK.
		boss.state_machine.change_state(Boss.BossState.IDLE)
		
	# Mover el CharacterBody2D
	boss.move_and_slide()
