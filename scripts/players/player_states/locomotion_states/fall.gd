extends LocomotionState


@export_node_path("State") var idle_state_path
@onready var idle_state = get_node(idle_state_path)

@export_node_path("State") var sprint_state_path
@onready var sprint_state = get_node(sprint_state_path)


func enter() -> void:
	super()
	#var plane_velocity = Vector3(player.velocity.x, 0, player.velocity.z)
	#free_speed = plane_velocity.length()
	#target_locked_speed = plane_velocity.length()


func physics_process(delta: float) -> State:
	super(delta)
	if player.is_on_floor():
		return idle_state
	return null


func input(event: InputEvent) -> State:
	if event.is_action("Sprint") and player.input_dir:
		return sprint_state
	return null
