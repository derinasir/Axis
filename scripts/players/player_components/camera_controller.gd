extends SpringArm3D

@export var player: Player
@export var pitch_limit_up: float = 45.0
@export var pitch_limit_down: float = -45.0
@export var camera_smoothing: float = 10.0
@export var target_lock_smoothing: float = 5.0

var yaw := 0.0
var pitch := 0.0
var target_yaw := 0.0
var target_pitch := 0.0
var was_locked := false


func _ready() -> void:
	yaw = rotation.y
	pitch = rotation.x
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _process(delta: float) -> void:
	update_lock_transition()

	if player.is_target_locked:
		update_lock_camera(delta)
	else:
		update_free_camera(delta)

	apply_rotation()



func update_lock_transition() -> void:
	if player.is_target_locked and not was_locked:
		was_locked = true
	elif not player.is_target_locked and was_locked:
		target_yaw = yaw
		target_pitch = pitch
		was_locked = false


func update_free_camera(delta: float) -> void:
	var input_vec = Input.get_vector("Camera Left", "Camera Right", "Camera Up", "Camera Down")
	var invert_h = (-1 if Settings.camera_invert_h else 1)
	var invert_v = (-1 if Settings.camera_invert_v else 1)
	
	if Settings.has_connected_gamepads():
		target_yaw -= input_vec.x * Settings.gamepad_sensitivity * invert_h * delta
		target_pitch -= input_vec.y * Settings.gamepad_sensitivity * invert_v * delta
	else:
		var mouse_delta = Input.get_last_mouse_velocity() * 0.001
		target_yaw -= mouse_delta.x * Settings.mouse_sensitivity * invert_h * delta
		target_pitch -= mouse_delta.y * Settings.mouse_sensitivity * invert_v * delta
	
	
	var min_pitch = deg_to_rad(pitch_limit_down)
	var max_pitch = deg_to_rad(pitch_limit_up)
	target_pitch = clamp(target_pitch, min_pitch, max_pitch)
	
	yaw = lerp(yaw, target_yaw, camera_smoothing * delta)
	pitch = lerp(pitch, target_pitch, camera_smoothing * delta)
	pitch = clamp(pitch, min_pitch, max_pitch)


func update_lock_camera(delta: float) -> void:
	if not player.current_target:
		return
	
	var target_pos = player.current_target.global_position
	var dir = (target_pos - global_position).normalized()
	
	var target_y = atan2(-dir.x, -dir.z)
	var target_x = asin(dir.y)
	target_x = clamp(target_x, deg_to_rad(pitch_limit_down), deg_to_rad(pitch_limit_up))
	
	target_yaw = lerp_angle(target_yaw, target_y, target_lock_smoothing * delta)
	target_pitch = lerp_angle(target_pitch, target_x, target_lock_smoothing * delta)
	
	yaw = lerp_angle(yaw, target_yaw, target_lock_smoothing * delta)
	pitch = lerp_angle(pitch, target_pitch, target_lock_smoothing * delta)


func apply_rotation() -> void:
	rotation_degrees = Vector3(rad_to_deg(pitch), rad_to_deg(yaw), 0)
