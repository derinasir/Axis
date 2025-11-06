extends PlayerState


@export_node_path("State") var walk_state_path
@onready var walk_state = get_node(walk_state_path)


func enter() -> void:
	super()
	player.spring_arm_offset = player.SPRING_ARM_DEFAULT_OFFSET

func physics_process(delta: float) -> State:
	super(delta)
	
	if player.direction_vec:
		return walk_state
	
	return null
