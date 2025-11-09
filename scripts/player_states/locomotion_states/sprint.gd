extends LocomotionState
#Sprint State


@export_node_path("State") var idle_state_path
@onready var idle_state = get_node(idle_state_path)

@export_node_path("State") var walk_state_path
@onready var walk_state = get_node(walk_state_path)

@export_node_path("State") var jump_state_path
@onready var jump_state = get_node(jump_state_path)


func physics_process(delta: float) -> State:
	super(delta)
	
	if player.direction_vec == Vector3.ZERO:
		return idle_state
	
	return null


func input(event: InputEvent) -> State:
	super(event)
	if event.is_action_released("Sprint"):
		return walk_state
	
	if event.is_action_pressed("Jump"):
		return jump_state
	
	return null
