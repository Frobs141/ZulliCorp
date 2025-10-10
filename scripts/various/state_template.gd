class_name StateTemplate extends Node

## referencia al nodo que vamos a controlar
var controlled_node:Node

## referencia a la maquina de estados
var state_machine:StateMachine

## método que se ejecuta al entrar en el estado
func start():
	pass
	
## método que se ejecuta al abandonar el estado
func end():
	pass
