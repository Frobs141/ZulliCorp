#uid://bdj1rxks0l3yh
class_name BossMove extends BossState

## Se llama al entrar al estado.
func enter() -> void:
	controlled_node.set_velocity(Vector2.ZERO)
	# Iniciar el movimiento inmediatamente
	
## Se llama cada frame. Cambiamos delta a _delta
func execute(_delta: float) -> void:
	# Lógica de movimiento será implementada en la FASE 3
	controlled_node.move_and_slide()
	
	# Transición: si el timer de ataque se detiene, pasar a Attack
	if controlled_node.get_node("AttackTimer").is_stopped():
		state_machine.transition_to("Attack")
