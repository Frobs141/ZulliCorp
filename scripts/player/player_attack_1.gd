extends PlayerStateTemplate

func start() -> void:
	player.attack.play("slash")
	var animation: String = "basic_attack_R" if player.dir >= 0 else "basic_attack_L"
	$"../../AnimationPlayer".play(animation)
	
func _on_animated_sprite_2d_animation_finished() -> void:
	if player.is_on_floor():
		state_machine.change_to(PlayerStates.Idle)
	else:
		state_machine.change_to(PlayerStates.Falling)
