extends PlayerState


@export_node_path("State") var downward_slash_state_path
@onready var downward_slash_state = get_node(downward_slash_state_path)

var combo_window_open := false

func enter() -> void:
	super()
	player.is_attacking = false


func input(event: InputEvent) -> State:
	super(event)
	
	if event.is_action_pressed("Attack"):
		return downward_slash_state
	
	return null
