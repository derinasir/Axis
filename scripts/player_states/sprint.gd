extends PlayerState
#Sprint State


@export_node_path("State") var idle_state_path
@onready var idle_state = get_node(idle_state_path)

@export_node_path("State") var walk_state_path
@onready var walk_state = get_node(walk_state_path)



func enter() -> void:
	super()
	player.spring_arm_offset = player.SPRING_ARM_DEFAULT_OFFSET



func physics_process(delta: float) -> State:
	super(delta)
	
	if player.direction_vec == Vector3.ZERO:
		return idle_state
	
	return null


func input(event: InputEvent) -> State:
	super(event)
	if event.is_action_released("Sprint"):
		return walk_state
	return null
