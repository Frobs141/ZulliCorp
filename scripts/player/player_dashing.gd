extends PlayerStateTemplate

func start():
	if player.sprite.animation == "idle":
		player.sprite.play("run")
	player.sprite.pause()

func on_physics_process(delta: float) -> void:
	player.dash_usable = false
	var prev_speed:float = player.velocity.x
	player.velocity = Vector2(player.dash_speed * delta, 0) * player.dir
	player.move_and_slide()
	await get_tree().create_timer(0.5).timeout
	player.dash_cooldown.start()
	player.velocity.x = 0
	if prev_speed != 0:
		state_machine.change_to(PlayerStates.Moving)
	else:
		if player.is_on_floor():
			state_machine.change_to(PlayerStates.Idle)
		else:
			state_machine.change_to(PlayerStates.Falling)

func end():
	player.sprite.play()
