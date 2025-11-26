extends CharacterBody2D

class_name AdBot

@export var speed: float = 100.0
var direction: Vector2 = Vector2.LEFT

func _ready():
	# Destruirse después de 10 segundos para no llenar la memoria
	await get_tree().create_timer(10.0).timeout
	queue_free()

func _physics_process(delta: float) -> void:
	# Movimiento simple hacia la izquierda (o la dirección que se configure)
	velocity = direction * speed
	move_and_slide()
