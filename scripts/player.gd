class_name Player
extends CharacterBody3D


@onready var locomotion_state_machine: StateMachine = $LocomotionStateMachine
@onready var combat_state_machine: StateMachine = $CombatStateMachine
@onready var camera_spring_arm: SpringArm3D = $SpringArm3D
@onready var camera: Camera3D = $SpringArm3D/Camera3D


# ATTACKING
var is_attacking := false


# LOCOMOTION
var speed: float


# TARGETING
var is_target_locked := false
@export var current_target: Node3D


# INPUT
var input_dir: Vector2
var direction_vec: Vector3 = Vector3.ZERO


# CAMERA RIG
var spring_arm_offset: Vector3
const SPRING_ARM_DEFAULT_OFFSET := Vector3(0, 2, 0)


func _ready() -> void:
	locomotion_state_machine.initialize()
	combat_state_machine.initialize()
	
	print(Settings.has_connected_gamepads())
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _process(delta: float) -> void:
	locomotion_state_machine.process(delta)
	combat_state_machine.process(delta)
	
	#print("***************")
	#print(combat_state_machine.current_state)
	#print("---------------")
	#print(locomotion_state_machine.current_state.name)
	#print("***************")
	


func _physics_process(delta: float) -> void:
	locomotion_state_machine.physics_process(delta)
	combat_state_machine.physics_process(delta)
	
	camera_spring_arm.position = position + spring_arm_offset
	input_dir = Input.get_vector("Move Left", "Move Right", "Move Backward", "Move Forward")
	
	if Input.is_action_just_pressed("Target Lock"):
		%TargetManager.set_target()
	elif Input.is_action_just_released("Target Lock"):
		%TargetManager.release_target()
		
	is_target_locked = current_target != null
		
	move_and_slide()


func _input(event: InputEvent) -> void:
	locomotion_state_machine.input(event)
	combat_state_machine.input(event)
	
	if event.is_action_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		elif Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
