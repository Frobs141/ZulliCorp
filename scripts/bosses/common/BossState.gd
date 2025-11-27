class_name BossState extends StateTemplate

var boss: Boss 

func enter() -> void:
	if controlled_node is Boss:
		boss = controlled_node as Boss

func execute(_delta: float) -> void:
	pass
