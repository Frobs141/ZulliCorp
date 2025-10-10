extends PlayerStateTemplate

func on_physics_process(delta):
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		player.velocity.x = Input.get_axis("ui_left", "ui_right") * player.speed * delta
		
	if player.velocity.y >= 0 and player.is_on_floor():
		if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
			state_machine.change_to(PlayerStates.Moving)
		else: state_machine.change_to(PlayerStates.Idle)
	
	handle_gravity(delta)
	player.move_and_slide()

func on_input(_event):
	if Input.is_action_just_pressed("dash") and player.dash_usable:
		state_machine.change_to(PlayerStates.Dashing)
