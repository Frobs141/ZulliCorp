#uid://dp2e0lix6c48s
class_name BossIdle extends BossState

# CAMBIO: _delta para evitar advertencia
func execute(_delta: float) -> void:
	# Lógica para mirar al jugador
	var direction_to_player = boss.player.global_position.x - boss.global_position.x

	if direction_to_player > 0:
		boss.scale.x = 1
	elif direction_to_player < 0:
		boss.scale.x = -1

	# El cambio de estado lo maneja el Timer en Boss.gd