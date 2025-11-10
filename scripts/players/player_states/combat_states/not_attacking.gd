extends PlayerState


@export_node_path("State") var attack1_state_path
@onready var attack1_state = get_node(attack1_state_path)

var combo_window_open := false

func enter() -> void:
	super()
	player.is_attacking = false


func input(event: InputEvent) -> State:
	super(event)
	
	if event.is_action_pressed("Attack"):
		return attack1_state
	
	return null
