
class_name PhishingBotPull extends BossState

func execute(delta: float):
	# Si no hay un jugador enganchado (ej. se murió o hubo un error), vuelve a IDLE.
	if not boss.is_player_caught:
		boss.state_machine.change_state(Boss.BossState.IDLE)
		return

	boss.pull_player_and_attack(delta)
