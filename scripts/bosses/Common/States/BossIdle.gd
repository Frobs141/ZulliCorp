class_name BossIdle extends BossState

func execute(_delta: float) -> void:

	var direction_to_player = boss.player.global_position.x - boss.global_position.x

	if direction_to_player > 0:
		boss.scale.x = 1
	elif direction_to_player < 0:
		boss.scale.x = -1
