# BossState.gd (Hereda de StateTemplate.gd)
class_name BossState extends StateTemplate

# Referencia específica al nodo Boss (el 'controlled_node' genérico tipificado)
var boss: Boss 

func enter():
	# Inicializa la referencia al nodo principal con el tipo Boss
	boss = controlled_node as Boss
	if not boss:
		push_error("BossState debe ser usado en una máquina de estados controlando un nodo Boss.")

# Este método se ejecutará en _physics_process
func execute(delta: float):
	pass # Implementación específica en cada estado hijo

# Este método se ejecutará en _process
func update(delta: float):
	pass # Implementación específica en cada estado hijo
