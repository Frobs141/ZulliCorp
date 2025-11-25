# Harpoon.gd
class_name Harpoon extends Area2D

# ----------------------------------------------------
# SEÑALES (Encapsulación: El arpón avisa cuando engancha)
# ----------------------------------------------------
signal player_caught(player_node, harpoon_instance)

# ----------------------------------------------------
# PROPIEDADES
# ----------------------------------------------------
@export var speed: float = 800.0
@export var damage: int = 5
@export var max_distance: float = 1000.0

var direction: Vector2 = Vector2.RIGHT
var start_position: Vector2

# ----------------------------------------------------
# LÓGICA DE MOVIMIENTO
# ----------------------------------------------------
func _ready():
	start_position = global_position
	# Conexión automática de la señal de colisión (asegurar el nodo CollisionShape2D)
	# body_entered.connect(_on_body_entered) 

func _physics_process(delta: float):
	# Mueve el arpón en la dirección
	global_position += direction * speed * delta
	
	# Lógica para hacer que el arpón desaparezca si viaja muy lejos (falla)
	if global_position.distance_to(start_position) > max_distance:
		queue_free()

# ----------------------------------------------------
# DETECCIÓN DE COLISIÓN
# ----------------------------------------------------
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		# 1. Emite la señal con la referencia al jugador y a sí mismo
		player_caught.emit(body, self)
		# 2. El arpón debe detenerse y esperar a ser jalado por el jefe
		speed = 0
		# Nota: No lo liberamos aquí; el Phishing Bot lo hará al terminar el ataque.
		
	# Si choca con el entorno, se destruye (falla)
	elif body is TileMap or body is TileMapLayer:
		queue_free()
