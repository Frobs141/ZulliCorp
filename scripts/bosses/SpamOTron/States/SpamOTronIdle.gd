# SpamOTronIdle.gd (Hereda de BossState.gd)
class_name SpamOTronIdle extends BossState

func enter():
	# Asegura que el jefe esté quieto.
	boss.velocity = Vector2.ZERO

func execute(delta: float):
	# El jefe solo permanece estático o con un movimiento muy leve.
	# Los temporizadores se encargan de la generación de proyectiles.
	pass
