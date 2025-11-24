class_name Boss extends Enemy

# --- ATRIBUTOS EXCLUSIVOS DE JEFES ---
@export var shield_health: int = 0
@export var max_shield_health: int = 0
@export var weapon_reward_name: String = "" # Nombre del arma que desbloquea al morir

# --- REFERENCIAS ---
# Referencia a la escena del proyectil que usará este jefe (se asigna en el Inspector)
@export var boss_projectile_scene: PackedScene 

func _ready() -> void:
	# Inicializamos el escudo máximo igual al actual al inicio
	max_shield_health = shield_health
	super._ready() # Llama al _ready del padre (Enemy) si tiene lógica importante

# --- SOBRESCRIBIR LA FUNCIÓN DE RECIBIR DAÑO ---
# Esta función reemplaza a la de 'Enemy' para añadir la lógica del escudo
func recieve_damage(damage: int):
	# 1. Si tiene escudo (Lógica del Caballo de Troya Fase 1)
	if shield_health > 0:
		shield_health -= damage
		# Mostramos el daño al escudo en el Label de debug (heredado de Enemy)
		if display_damage:
			display_damage.text = "Shield: -" + str(damage)
		
		# Verificamos si el escudo se rompió
		if shield_health <= 0:
			shield_health = 0
			on_shield_broken() # Llamamos a la función especial
			
	# 2. Si NO tiene escudo, recibe daño normal a la vida
	else:
		super.recieve_damage(damage) # Usa la lógica normal de Enemy (bajar vida, mostrar texto)

# Función placeholder que el Caballo de Troya usará para cambiar de fase
func on_shield_broken() -> void:
	print("El escudo se ha roto. Cambiando de fase...")
	# Aquí el script del Troyano añadirá la lógica de cambio de estado

# Sobrescribimos la muerte para dar la recompensa (si hay)
func die(): # Asumiendo que Enemy tiene una función similar o lógica de muerte
	if weapon_reward_name != "":
		# Aquí llamarías a Global.unlock_weapon(weapon_reward_name)
		print("Arma desbloqueada: ", weapon_reward_name)
	
	queue_free() # Elimina al jefe