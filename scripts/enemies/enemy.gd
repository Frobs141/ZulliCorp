class_name Enemy extends CharacterBody2D

# Sistema de señales para efectos visuales o sonidos globales
signal enemy_died(enemy_instance)

@export var max_health: int = 10
@onready var current_health: int = max_health

# Referencia al Label de daño (asegúrate de que el nodo exista en la escena)
@onready var display_damage: Label = $DisplayDamage 

# --- FUNCIÓN UNIFICADA DE DAÑO ---
func take_damage(amount: int) -> void:
	current_health -= amount
	update_damage_label(amount)
	
	if current_health <= 0:
		die()
	else:
		# Aquí podrías llamar a una animación de "Hurt" genérica
		modulate = Color(1, 0, 0) # Flash rojo simple
		await get_tree().create_timer(0.1).timeout
		modulate = Color(1, 1, 1)

func update_damage_label(amount: int):
	if display_damage:
		display_damage.text = str(amount)
		await get_tree().create_timer(0.5).timeout
		display_damage.text = ""

func die():
	emit_signal("enemy_died", self)
	queue_free()
