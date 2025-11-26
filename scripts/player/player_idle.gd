extends PlayerStateTemplate

func start() -> void:
	player.sprite.play("idle")

func on_physics_process(delta: float):
	player.velocity.x = 0
	if player.dir == 0:
		player.dir = 1 if !player.sprite.flip_h else -1
	handle_gravity(delta)
	player.move_and_slide()

func on_input(_event: InputEvent):
	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left"):
		state_machine.change_to(PlayerStates.Moving)
	elif Input.is_action_just_pressed("dash") and player.dash_usable:
		state_machine.change_to(PlayerStates.Dashing)
	elif Input.is_action_just_pressed("jump"):
		state_machine.change_to(PlayerStates.Jumping)
	elif Input.is_action_just_pressed("attack1"):
		state_machine.change_to(PlayerStates.Attack1)
