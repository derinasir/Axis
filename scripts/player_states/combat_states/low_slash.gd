extends CombatState


@export_node_path("State") var power_slash_state_path
@onready var power_slash_state = get_node(power_slash_state_path)



func input(event: InputEvent) -> State:
	super(event)
	
	if event.is_action_pressed("Attack") and combo_window_open:
		anim_state_machine.travel(power_slash_state.animation_name)
		return power_slash_state
	
	return null
