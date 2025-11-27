class_name BaseProjectile extends Area2D
# Este es el script PADRE del cual heredarán TODOS los proyectiles del juego.

@export var damage: int = 1         # Cantidad de daño que hace
@export var speed: float = 600.0    # Velocidad de movimiento
@export var direction: Vector2 = Vector2.RIGHT # Dirección inicial (será modificada al disparar)

# Grupo de nodos a los que este proyectil PUEDE hacer daño.
# Ejemplo: "players" (para proyectiles de enemigos/bosses) o "enemies" (para proyectiles del jugador).
@export var target_groups: Array[String] = []

# --- CICLO DE VIDA ---

func _ready():
	# Conectamos la señal de Area2D para detectar cuerpos y áreas
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("area_entered", Callable(self, "_on_area_entered"))
	
	# Asegurarse de que la dirección está normalizada si no viene de una rotación
	direction = direction.normalized()

func _physics_process(delta: float):
	# Lógica de movimiento principal (la misma para todos los proyectiles)
	global_position += direction * speed * delta

# --- LÓGICA DE COLISIÓN ---

func _on_body_entered(body: Node2D):
	# 1. Verificar si el cuerpo está en uno de los grupos objetivo
	var is_target = false
	for group in target_groups:
		if body.is_in_group(group):
			is_target = true
			break
			
	if is_target:
		# 2. Intentar hacer daño si tiene el método take_damage
		if body.has_method("take_damage"):
			body.take_damage(damage)
			
		# 3. Llamar a la función que maneja el impacto (puede ser sobreescrita por hijos)
		on_impact()
	else:
		# Si no es un objetivo (ej: golpea una pared o plataforma)
		on_environment_impact(body)

# Manejo de colisiones con otras áreas (ej: power-ups, trampas, etc.)
func _on_area_entered(area: Area2D):
	# Puede ser sobreescrito por clases hijas si se necesita lógica con áreas
	pass
	
# --- MÉTODOS VIRTUALES (Para que los hijos los sobreescriban) ---

# Llamado cuando el proyectil golpea a un objetivo o una pared/plataforma
func on_impact():
	# Por defecto, se destruye al impactar
	queue_free()

# Llamado cuando el proyectil golpea un entorno (pared, suelo)
func on_environment_impact(_body: Node2D):
	# Por defecto, se destruye al impactar contra el entorno
	queue_free()
