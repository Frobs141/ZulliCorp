extends Node2D

@onready var tp_right: Area2D = $"tp right"
@onready var tp_bottom: Area2D = $"tp bottom"

func _ready() -> void:
	tp_bottom.connect("body_entered", bottom)
	tp_right.connect("body_entered", right)

func bottom() -> void:
	Global.tp_down(self)

func right() -> void:
	Global.tp_right(self)
