extends Enemy

class_name TurretEnemy

@export var projectile_scene: PackedScene # Asigna el proyectil enemigo aquí
@export var attack_range: float = 300.0
@export var fire_rate: float = 1.5

@onready var shoot_timer: Timer = $ShootTimer
@onready var player_check: RayCast2D = $RayCast2D # Para ver si hay paredes

var player: Node2D

func _ready():
	player = get_tree().get_first_node_in_group("player")
	shoot_timer.wait_time = fire_rate
	shoot_timer.start()

func _on_shoot_timer_timeout():
	if not player: return
	
	var dist = global_position.distance_to(player.global_position)
	if dist <= attack_range:
		shoot()

func shoot():
	if not projectile_scene: return
	
	# Instanciar bala
	var projectile = projectile_scene.instantiate()
	projectile.global_position = global_position
	# Calcular dirección
	projectile.direction = (player.global_position - global_position).normalized()
	get_parent().add_child(projectile)
