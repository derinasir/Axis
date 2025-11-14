extends LocomotionState


@export_node_path("State") var walk_state_path
@onready var walk_state = get_node(walk_state_path)

@export_node_path("State") var jump_state_path
@onready var jump_state = get_node(jump_state_path)

@export_node_path("State") var sprint_state_path
@onready var sprint_state = get_node(sprint_state_path)

@export_node_path("State") var fall_state_path
@onready var fall_state = get_node(fall_state_path)

func physics_process(delta: float) -> State:
	super(delta)
	
	
	if player.velocity.y < 0:
		return fall_state
	
	if player.direction_vec:
		if Input.is_action_pressed("Sprint"):
			return sprint_state
		else:
			return walk_state
	
	return null

func input(event: InputEvent) -> State:
	super(event)
	
	if event.is_action_pressed("Jump") and player.combat_manager.has_enough_stamina(player.jump_stamina_cost):
		return jump_state
	
	return null
