# BossAttack.gd (Hereda de BossState.gd)
class_name BossAttack extends BossState

# Este estado llama a la función de ataque específica del jefe.

func enter():
	# Inicia el patrón de ataque específico del jefe (Phishing, Spam, Trojan).
	boss.attack_pattern()
	# Asume que el patrón de ataque cambiará el estado al finalizar (e.g., a IDLE o MOVE).

func execute(delta: float):
	# En el estado de ataque, el movimiento suele estar deshabilitado o ser parte del patrón.
	pass
