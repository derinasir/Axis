extends LocomotionState


@export_node_path("State") var idle_state_path
@onready var idle_state = get_node(idle_state_path)


func physics_process(delta: float) -> State:
	super(delta)
	if player.is_on_floor():
		return idle_state
	return null
