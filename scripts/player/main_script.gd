class_name Player extends CharacterBody2D

const speed:int = 35000
const dash_speed:int = 60000
const jump_speed:int = -40000
const max_healt:int = 5
var attack_damage: int = 10
var dir: float
var dash_usable:bool = true
@onready var dash_cooldown: Timer = $DashCooldown
@onready var sprite: AnimatedSprite2D = $sprite
@onready var hurtbox: Area2D = $Hurtbox

func changeDir() -> void:
	if dir < 0:
		sprite.flip_h = true
	elif dir > 0:
		sprite.flip_h = false

func _on_dash_cooldown_timeout() -> void:
	sprite.modulate = Color(1, 1, 0)
	dash_usable = true
	await get_tree().create_timer(0.2).timeout
	sprite.modulate = Color(1, 1, 1)
