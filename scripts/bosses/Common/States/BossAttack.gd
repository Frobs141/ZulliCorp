class_name BossAttack extends BossState

func execute(_delta: float) -> void:
	
	state_machine.transition_to("Idle")
