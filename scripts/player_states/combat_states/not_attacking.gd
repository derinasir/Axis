extends PlayerState


@export_node_path("State") var slash_1_path
@onready var slash_1 = get_node(slash_1_path)

var combo_window_open := false

func enter() -> void:
	super()
	player.is_attacking = false


func input(event: InputEvent) -> State:
	super(event)
	
	if event.is_action_pressed("Attack"):
		return slash_1
	
	return null
