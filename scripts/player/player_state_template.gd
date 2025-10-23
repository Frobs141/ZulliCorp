class_name PlayerStateTemplate extends StateTemplate

var player:Player:
	set(value):
		controlled_node = value
	get:
		return controlled_node

var gravity:float = ProjectSettings.get_setting("physics/2d/default_gravity")

func move(delta: float) -> void:
	player.velocity.x = player.dir * player.speed * delta
	
func handle_gravity(delta):
	player.velocity.y += gravity * delta
