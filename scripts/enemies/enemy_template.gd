class_name BasicEnemyTemplate extends StateTemplate

var enemy:Enemy:
	set(value):
		controlled_node = value
	get:
		return controlled_node

var gravity:float = ProjectSettings.get_setting("physics/2d/default_gravity")
	
func handle_gravity(delta):
	enemy.velocity.y += gravity * delta
