class_name CombatState
extends PlayerState


@export var animation_name: String
@export_node_path("State") var not_attacking_state_path
@onready var not_attacking_state = get_node(not_attacking_state_path)

var anim_state_machine: AnimationNodeStateMachinePlayback
var combo_window_open := false
var return_not_attacking_state := false

func _ready() -> void:
	%AnimationTree.connect("animation_finished", _on_AnimationTree_animation_finished)


func enter() -> void:
	player.is_attacking = true
	return_not_attacking_state = false
	
	anim_state_machine = %AnimationTree.get("parameters/Combat/playback")
	anim_state_machine.travel(animation_name)


func process(delta) -> State:
	super(delta)
	
	#print(anim_state_machine.get_current_node())

	
	if return_not_attacking_state:
		return not_attacking_state
	
	return null



func _on_AnimationTree_animation_finished(anim_name: String):
	if anim_name == animation_name:
		return_not_attacking_state = true


func _open_combo_window():
	combo_window_open = true

func _close_combo_window():
	combo_window_open = false
	
