extends PlayerStateTemplate

func start() -> void:
	if player.sprite.animation == "fall" or player.sprite.animation == "jump":
		return
	player.sprite.play("run")

func on_physics_process(delta: float):
	player.dir = Input.get_axis("ui_left", "ui_right")
	player.changeDir()
	move(delta)
	handle_gravity(delta)
	player.move_and_slide()
	
func on_input(_event):
	if player.is_on_floor():
		if Input.is_action_just_pressed("jump"): 
			state_machine.change_to(PlayerStates.Jumping)
		elif not Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"): 
			state_machine.change_to(PlayerStates.Idle)
	else:
		if not Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"): 
			state_machine.change_to(PlayerStates.Falling)
	if Input.is_action_just_pressed("dash") and player.dash_usable:
		state_machine.change_to(PlayerStates.Dashing) 
	elif Input.is_action_just_pressed("attack1"):
		state_machine.change_to(PlayerStates.Attack1)
