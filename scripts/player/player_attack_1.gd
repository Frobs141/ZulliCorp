extends PlayerStateTemplate

func start() -> void:
	player.sprite.play("attack")
	var animation: String = "basic_attack_R" if player.dir >= 0 else "basic_attack_L"
	$"../../AnimationPlayer".play(animation)
	if player:
		player.sprite.animation_finished.connect(finished)

func finished() -> void:
	if not player.sprite.animation == "attack":
		return
	if player.is_on_floor():
		state_machine.change_to(PlayerStates.Idle)
	else:
		state_machine.change_to(PlayerStates.Falling)
