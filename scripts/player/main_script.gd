class_name Player extends CharacterBody2D

const speed:int = 35000
const dash_speed:int = 60000
const jump_speed:int = -40000
const max_healt:int = 5
var dir: Vector2
var dash_usable:bool = true
@onready var dash_cooldown: Timer = $DashCooldown
@onready var sprite: Sprite2D = $Icon
@onready var attacks: AnimatedSprite2D = $AnimatedSprite2D

func _on_dash_cooldown_timeout() -> void:
	sprite.modulate = Color(1, 1, 0)
	dash_usable = true
	await get_tree().create_timer(0.2).timeout
	sprite.modulate = Color(1, 1, 1)
