class_name TrojanTank extends BossState

func enter():
	boss.movement_speed = boss.tank_movement_speed

func execute(_delta: float):
	if not boss.player: return

	var direction = (boss.player.global_position - boss.global_position).normalized()
	boss.velocity.x = direction.x * boss.movement_speed

	boss.move_and_slide()

	if boss.get_node("TankTimer").is_stopped():
		state_machine.transition_to("Idle")
