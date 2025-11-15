extends CombatState


@export_node_path("State") var attack_3_state_path
@onready var attack_3_state = get_node(attack_3_state_path)



func input(event: InputEvent) -> State:
	super(event)
	
	return null
