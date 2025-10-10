extends PlayerStateTemplate

func on_physics_process(delta):
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		player.velocity.x = Input.get_axis("ui_left", "ui_right") * player.speed * delta
	# si esta en el suelo y esta parado sobre él, podemos darle impulso de salto
	if player.is_on_floor() and player.velocity.y >= 0: 
		player.velocity.y = player.jump_speed * delta
	# en otro caso, si está bajando, cambiamos al estado de cayendo
	elif player.velocity.y > 0:
		state_machine.change_to(PlayerStates.Falling)
	
	handle_gravity(delta)
	player.move_and_slide()

func on_input(_event):
	if Input.is_action_just_pressed("dash") and player.dash_usable:
		state_machine.change_to(PlayerStates.Dashing)
