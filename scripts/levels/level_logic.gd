extends Node2D

# Arrastra aquí la escena del Jefe que corresponde a este nivel (ej: SpamOTron.tscn)
@export var boss_scene: PackedScene 

func _ready():
	spawn_player()
	spawn_boss()

func spawn_player():
	# Instancia al jugador globalmente o lo busca
	var player_scene = preload("res://scenes/player/player.tscn")
	var player = player_scene.instantiate()
	
	# Lo mueve a la posición del Marker2D
	if has_node("PlayerSpawn"):
		player.position = $PlayerSpawn.position
	else:
		player.position = Vector2(100, 100) # Default
	
	add_child(player)

func spawn_boss():
	if boss_scene and has_node("BossSpawn"):
		var boss = boss_scene.instantiate()
		boss.position = $BossSpawn.position
		
		# Conectar señal de muerte del jefe para ganar el nivel
		if boss.has_signal("enemy_died"):
			boss.connect("enemy_died", _on_boss_died)
			
		add_child(boss)

func _on_boss_died(boss_instance):
	# Avisar al Global que pasamos de nivel
	Global.level_completed()
