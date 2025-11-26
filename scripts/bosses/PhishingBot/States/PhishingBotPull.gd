#uid://blib0uo6fcyut
# PhishingBotPull.gd
class_name PhishingBotPull extends BossState

# Este estado existe solo para jalar al jugador y ejecutar el ataque de espinas.

# CORRECCIÓN: Cambiamos 'delta' por '_delta' para evitar la advertencia de "variable no usada"
# si en tu lógica actual no estás usando el tiempo delta para cálculos matemáticos directos aquí.
func execute(delta: float):
	# Si no hay un jugador enganchado (ej. se murió o hubo un error), vuelve a IDLE.
	if not boss.is_player_caught:
		boss.state_machine.change_state(Boss.BossState.IDLE)
		return

	# Llama al método del jefe que maneja la lógica de jalar y golpear
	# Pasamos delta porque la función del jefe SÍ lo usa para el movimiento suave.
	boss.pull_player_and_attack(delta)