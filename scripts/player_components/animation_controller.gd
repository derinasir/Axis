extends AnimationTree


enum FreeRoamBlend {
	IDLE = 0,
	WALK = 1,
	SPRINT = 2
}

enum LockedStateBlend { 
	FREE = 0,
	LOCKED = 1
}

enum FallBlend {
	ON_GROUND = 0,
	FALLING = 1
} 



@export var player: Player

var lock_state_blend : float = 0
var desired_lock_state_blend: int = LockedStateBlend.FREE

var locomotion_blend := Vector2.ZERO
var desired_locomotion_blend := Vector2.ZERO 

var fall_blend: float = FallBlend.ON_GROUND
var desired_fall_blend : float

var jump_blend: float
var desired_jump_blend: float


func _process(delta: float) -> void:
	desired_lock_state_blend = (
		LockedStateBlend.LOCKED if player.is_target_locked else LockedStateBlend.FREE
		)
	
	
	desired_locomotion_blend = player.input_dir
	desired_locomotion_blend *= 2 if player.locomotion_state_machine.current_state.name == "Sprint" else 1
	
	if not player.is_on_floor() and player.velocity.y < 0:
		desired_fall_blend = 0.3
	else:
		desired_fall_blend = FallBlend.ON_GROUND
	
	desired_jump_blend = float(int(locomotion_blend.length()))
	
	lock_state_blend = lerp(lock_state_blend, float(desired_lock_state_blend), 10 * delta)
	locomotion_blend = lerp(locomotion_blend, desired_locomotion_blend, 10 * delta)
	jump_blend = lerp(jump_blend, desired_jump_blend, 10 * delta)
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, "fall_blend", desired_fall_blend, 0.1
	).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BOUNCE)
	
	#fall_blend = lerp(fall_blend, desired_fall_blend, 10 * delta)
	
	set("parameters/Locomotion/TargetLockBlend/blend_amount", lock_state_blend)
	set("parameters/Locomotion/FreeRoamLocomotion/blend_position", locomotion_blend.length())
	set("parameters/Locomotion/JumpBlendSpace/blend_position", int(locomotion_blend.length()))
	set("parameters/Locomotion/TargetLocomotion/blend_position", locomotion_blend)
	set("parameters/Locomotion/FallBlend/blend_amount", fall_blend)



func _on_airborne_entered(state_name: String) -> void:
	set("parameters/Locomotion/JumpOneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
