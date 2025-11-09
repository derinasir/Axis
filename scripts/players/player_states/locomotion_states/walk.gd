extends LocomotionState
#Walk State


@export_node_path("State") var idle_state_path
@onready var idle_state = get_node(idle_state_path)

@export_node_path("State") var sprint_state_path
@onready var sprint_state = get_node(sprint_state_path)

@export_node_path("State") var jump_state_path
@onready var jump_state = get_node(jump_state_path)

@export_node_path("State") var fall_state_path
@onready var fall_state = get_node(fall_state_path)


func physics_process(delta: float) -> State:
	super(delta)
	if player.direction_vec == Vector3.ZERO:
		return idle_state
	
	if not player.is_on_floor():
		return fall_state
	
	
	
	return null


func input(event: InputEvent) -> State:
	super(event)
	if event.is_action_pressed("Sprint"):
		return sprint_state
	
	if event.is_action_pressed("Jump"):
		return jump_state
	
	return null
