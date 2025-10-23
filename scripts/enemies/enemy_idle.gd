extends BasicEnemyTemplate

func on_physics_process(delta: float) -> void:
	enemy.velocity = Vector2.ZERO
	handle_gravity(delta)
	enemy.move_and_slide()
