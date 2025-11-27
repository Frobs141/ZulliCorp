class_name PlayerProjectile extends BaseProjectile # ¡Ahora hereda del script base!

func _ready():
	# Establece los valores que quieres que sean diferentes al BaseProjectile (si los hay)
	damage = 10 # El jugador hace más daño
	speed = 1000.0
	target_groups = ["enemies", "bosses"] # El proyectil del jugador daña enemigos y jefes
	
	# Aseguramos que la lógica del padre se ejecute (conecta las señales)
	super._ready()
