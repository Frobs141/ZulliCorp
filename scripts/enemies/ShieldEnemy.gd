extends Enemy

class_name ShieldEnemy

# Dirección hacia donde mira (1 derecha, -1 izquierda)
var facing_dir: int = -1 

func _process(_delta):
	# Lógica simple para mirar al jugador
	var player = get_tree().get_first_node_in_group("player")
	if player:
		if player.global_position.x > global_position.x:
			facing_dir = 1
			$Sprite2D.flip_h = true # O false dependiendo de tu sprite
		else:
			facing_dir = -1
			$Sprite2D.flip_h = false

func take_damage(amount: int) -> void:
	var player = get_tree().get_first_node_in_group("player")
	if not player: return

	# Calcular dirección del ataque (si el jugador está a la derecha o izquierda)
	var attack_dir = 1 if player.global_position.x > global_position.x else -1
	
	# Si el jugador está en la misma dirección que el escudo (frente), BLOQUEAR
	if attack_dir == facing_dir:
		print("¡Bloqueado!")
		# Feedback visual de bloqueo (sonido metálico)
		return
	
	# Si ataca por la espalda, recibe daño normal
	super.take_damage(amount)
