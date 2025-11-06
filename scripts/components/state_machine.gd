extends Node
class_name StateMachine

signal state_entered(new_state: String, previous_state: String)
signal state_exited(new_state: String)

@export var initial_state: State

var previous_state: State
var current_state: State


func initialize() -> void:
	if initial_state:
		initial_state.enter()
		current_state = initial_state
		emit_signal("state_entered", current_state.name, "")
	else:
		assert(false, "Initial state empty")


func transition_to(new_state) -> void:
	if !new_state:
		push_warning("new_state returned null")
	
	
	current_state.exit()
	emit_signal("state_exited", current_state.name)

	previous_state = current_state
	current_state = new_state
	
	current_state.enter()
	emit_signal("state_entered",current_state.name, previous_state.name)



func process(delta) -> void:
	var new_state = current_state.process(delta)
	if new_state:
		transition_to(new_state)


func physics_process(delta) -> void:
	var new_state = current_state.physics_process(delta)
	if new_state:
		transition_to(new_state)


func input(event: InputEvent) -> void:
	var new_state = current_state.input(event)
	if new_state:
		transition_to(new_state)
