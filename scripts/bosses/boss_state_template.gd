class_name BossStateTemplate extends BasicEnemyTemplate

# Variable tipada para acceder a las funciones únicas de Boss (como shield_health)
var boss: Boss

func start():
	# Casteamos el nodo controlado a Boss para tener autocompletado y acceso a sus variables
	boss = controlled_node as Boss
	# Si BasicEnemyTemplate tiene lógica en start, la llamamos:
	super.start()

# Aquí pondremos lógica común como revisar si el jefe debe cambiar de fase por vida baja
func check_phase_transition():
	pass
