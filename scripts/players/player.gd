class_name Player
extends CharacterBody3D


# LOCOMOTION
@export var jump_speed := 5.0
@export var sprint_jump_speed := 5.0
@export var acceleration = 10.0
@export var deceleration = 10.0
@export var air_acceleration = 2.0
@export var air_deceleration = 2.0

var speed: float
var is_sprinting: bool


# COMBAT
var is_attacking := false


# TARGETING
var is_target_locked := false
var current_target: Node3D


# INPUT
var input_dir: Vector2
var direction_vec: Vector3 = Vector3.ZERO


# CAMERA RIG
const SPRING_ARM_DEFAULT_OFFSET := Vector3(0, 2, 0)
var spring_arm_offset: Vector3


# STAMINA COSTS
@export var jump_stamina_cost: float = 15.0
@export var evade_stamina_cost: float = 25.0


@onready var locomotion_state_machine: StateMachine = $LocomotionStateMachine
@onready var combat_state_machine: StateMachine = $CombatStateMachine
@onready var camera_spring_arm: SpringArm3D = $SpringArm3D
@onready var camera: Camera3D = $SpringArm3D/Camera3D
@onready var combat_manager: Node = $CombatManager
@onready var hurtbox: Hurtbox = $Hurtbox


func _ready() -> void:
	locomotion_state_machine.initialize()
	combat_state_machine.initialize()
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _process(delta: float) -> void:
	locomotion_state_machine.process(delta)
	combat_state_machine.process(delta)
	
	if not is_attacking and combat_manager.combat_stats.stamina < 50:
		combat_manager.combat_stats.stamina += 10 * delta


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
	
	if event.is_action_pressed("Capture Mouse"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		elif Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
