@tool
extends EditorPlugin

func _enter_tree() -> void:
	add_custom_type("Room", "Node2D", preload("res://addons/project_plugin/scripts/Room.gd"), preload("res://addons/project_plugin/plain-circle.svg"))


func _exit_tree() -> void:
	remove_custom_type("Room")
