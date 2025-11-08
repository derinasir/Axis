extends CombatState


@export_node_path("State") var low_slash_state_path
@onready var low_slash_state = get_node(low_slash_state_path)



func input(event: InputEvent) -> State:
	super(event)
	
	if event.is_action_pressed("Attack"):
		anim_state_machine.travel(low_slash_state.animation_name)
		return low_slash_state
	
	return null
