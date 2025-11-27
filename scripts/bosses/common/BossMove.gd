class_name BossMove extends BossState

func enter() -> void:
	controlled_node.set_velocity(Vector2.ZERO)

func execute(_delta: float) -> void:

	controlled_node.move_and_slide()

	if controlled_node.get_node("AttackTimer").is_stopped():
		state_machine.transition_to("Attack")
