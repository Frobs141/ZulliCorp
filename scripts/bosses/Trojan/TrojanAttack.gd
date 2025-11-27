class_name TrojanAttack extends BossState

func enter():
	boss.velocity.x = 0
	boss.move_and_slide()

func execute(_delta: float):
	if boss.get_node("AttackTimer").is_stopped():
		state_machine.transition_to("Idle")
