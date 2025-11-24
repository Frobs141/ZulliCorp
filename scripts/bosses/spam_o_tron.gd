extends Node
func _on_attack_timer_timeout():
		# Cuando el tiempo de espera termina, pasamos inmediatamente al estado Attack.
		# El estado Attack lanza la lluvia y nos devuelve al estado Idle para esperar el Timer.
		$StateMachine.change_to("Attack")
