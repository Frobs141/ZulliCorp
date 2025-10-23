class_name Enemy extends CharacterBody2D

@onready var display_damage: Label = $"Display Damage"

func _on_hitbox_area_entered(area: Area2D) -> void:
	var player: Player = area.get_parent().get_parent()
	recieve_damage(player.attack_damage)

func recieve_damage(damage: int):
	display_damage.text = str(damage)

func _on_hitbox_area_exited(_area: Area2D) -> void:
	await get_tree().create_timer(1).timeout
	display_damage.text = "0"
