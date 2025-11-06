extends Node
class_name State

signal entered(state_name: String)
signal exited(state_name: String)

func enter() -> void:
	entered.emit(name)

func exit() -> void:
	exited.emit(name)

func process(_delta: float) -> State:
	return null

func physics_process(_delta: float) -> State:
	return null

func input(_event: InputEvent) -> State:
	return null
