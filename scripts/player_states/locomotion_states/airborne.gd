extends LocomotionState


@export_node_path("State") var idle_state_path
@onready var idle_state = get_node(idle_state_path)

@export var jump_speed := 4.5
@export var speed_multiplier := 2.0


func enter():
	super()
	player.velocity.y = jump_speed

func physics_process(delta: float) -> State:
	super(delta)
	
	if player.is_on_floor() and player.velocity.y <= 0:
		return idle_state
	
	return null
