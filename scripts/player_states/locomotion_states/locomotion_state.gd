class_name LocomotionState
extends PlayerState


@export var free_speed := 1.0
@export var target_locked_speed := 1.0

var gravity_scale = 1

var to_target: Vector3


func enter() -> void:
	super()
	player.spring_arm_offset = player.SPRING_ARM_DEFAULT_OFFSET


func physics_process(delta: float) -> State:
	player.speed = target_locked_speed if player.is_target_locked else free_speed

	
	player.velocity.x = player.direction_vec.x * player.speed
	player.velocity.z = player.direction_vec.z * player.speed
	
	player.velocity.x *= 2 if Input.is_action_pressed("Sprint") and not player.is_on_floor() else 1
	player.velocity.z *= 2 if Input.is_action_pressed("Sprint") and not player.is_on_floor() else 1
		
	
	if player.is_target_locked and player.current_target:
		to_target = (player.current_target.global_position - player.global_position)
		player.direction_vec = transform_to_target_space(player.direction_vec)
	else:
		player.direction_vec = transform_to_camera_space(player.direction_vec)
	
	player.direction_vec.y = 0
	player.direction_vec = player.direction_vec.normalized()
	

	
	var target_rotation
	if player.is_target_locked and player.is_on_floor():
		target_rotation = atan2(-to_target.x, -to_target.z)
		player.rotation.y = lerp_angle(player.rotation.y, target_rotation, 0.09)
	else:
		target_rotation = atan2(-player.direction_vec.x, -player.direction_vec.z)
		if player.velocity:
			player.rotation.y = lerp_angle(player.rotation.y, target_rotation, 0.09)

	
	
	if not player.is_on_floor():
		player.velocity.y += player.get_gravity().y * gravity_scale * delta
	
	
	return null

func transform_to_target_space(direction_vec: Vector3) -> Vector3:
	var target_basis = Basis(Vector3.UP, atan2(to_target.x, to_target.z))
	return (target_basis * Vector3(-player.input_dir.x, 0, player.input_dir.y))
	

func transform_to_camera_space(direction_vec: Vector3) -> Vector3:
	return (
		player.camera.global_basis * Vector3(player.input_dir.x, 0, -player.input_dir.y)
	)
