extends CombatState


@export_node_path("State") var slash_2_state_path
@onready var slash_2_state = get_node(slash_2_state_path)



func input(event: InputEvent) -> State:
	super(event)
	
	if event.is_action_pressed("Attack") and combo_window_open:
		anim_state_machine.travel(slash_2_state.animation_name)
		return slash_2_state
	
	return null
