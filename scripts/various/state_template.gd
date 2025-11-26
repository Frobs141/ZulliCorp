#uid://c3qwlix6ki7ne
class_name StateTemplate extends Node

var controlled_node:Node
var state_machine:StateMachine

func enter() -> void:
	pass

func exit() -> void:
	pass

# CAMBIO: _delta para evitar advertencia
func execute(_delta: float) -> void:
	pass

func on_input(_event:InputEvent) -> void:
	pass

func on_unhandled_input(_event:InputEvent) -> void:
	pass

func on_unhandled_key_input(_event:InputEvent) -> void:
	pass
