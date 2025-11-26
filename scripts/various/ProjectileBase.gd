#IMPORTANTE SI SE CREA CLASE PROJECTILE, MOVER A LA CARPETA PROJECTILES

extends Area2D

class_name BossProjectile

@export var speed: float = 400.0
@export var damage: int = 10
@export var lifetime: float = 5.0 # Tiempo antes de desaparecer si no choca

var direction: Vector2 = Vector2.LEFT

func _ready() -> void:
	# Destruir el proyectil automáticamente después de X segundos
	await get_tree().create_timer(lifetime).timeout
	queue_free()

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

# Esta función se conecta desde el editor (señal body_entered)
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		
		if body.has_method("recieve_damage"): # Nota:  escribieron 'recieve' no 'receive'
			body.recieve_damage(damage)
		queue_free()
	
	# Destruir si choca con el suelo/paredes
	if body is TileMap or body is TileMapLayer:
		queue_free()
