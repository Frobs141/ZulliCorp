extends PlayerStateTemplate

#func start():
	#if player.is_on_floor():
		#pass

func on_physics_process(delta: float):
	player.dir.x = Input.get_axis("ui_left", "ui_right")
	move(delta)
	handle_gravity(delta)
	player.move_and_slide()
	
func on_input(_event):
	if Input.is_action_just_pressed("jump"): 
		state_machine.change_to(PlayerStates.Jumping)
	elif Input.is_action_just_pressed("dash"):
		state_machine.change_to(PlayerStates.Dashing)
	elif not Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"): 
		state_machine.change_to(PlayerStates.Idle)
