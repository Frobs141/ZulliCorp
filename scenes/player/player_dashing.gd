extends PlayerStateTemplate

func on_physics_process(delta: float) -> void:
	player.dash_usable = false
	var prev_speed:float = player.velocity.x
	player.velocity = Vector2(player.dash_speed * delta, 0) * player.dir
	player.move_and_slide()
	await get_tree().create_timer(0.5).timeout
	player.dash_cooldown.start()
	player.velocity.x = 0
	if player.is_on_floor():
		if prev_speed != 0:
			state_machine.change_to(PlayerStates.Moving)
		else:
			state_machine.change_to(PlayerStates.Idle)
	else:
		state_machine.change_to(PlayerStates.Falling)
