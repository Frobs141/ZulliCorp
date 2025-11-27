class_name BossProjectile extends BaseProjectile # ¡Ahora hereda del script base!

func _ready():
	# El proyectil del jefe hace daño al jugador
	damage = 25 
	speed = 800.0
	target_groups = ["players"] # El proyectil del jefe daña solo al jugador
	
	# Aseguramos que la lógica del padre se ejecute (conecta las señales)
	super._ready()

# Ejemplo de sobreescritura: Un proyectil de jefe explota al impactar
func on_impact():
	# Lógica: Reproducir animación de explosión aquí antes de destruirse
	# $AnimationPlayer.play("explosion")
	# yield($AnimationPlayer, "animation_finished")
	
	# Luego, llamamos a la destrucción
	queue_free()
