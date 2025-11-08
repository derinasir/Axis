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



@export var player: Player

var lock_state_blend : float = 0
var desired_lock_state_blend: int = LockedStateBlend.FREE

var locomotion_blend := Vector2.ZERO
var desired_locomotion_blend := Vector2.ZERO 


func _process(delta: float) -> void:
	desired_lock_state_blend = (
		LockedStateBlend.LOCKED if player.is_target_locked else LockedStateBlend.FREE
		)
	
	
	desired_locomotion_blend = player.input_dir
	desired_locomotion_blend *= 2 if player.locomotion_state_machine.current_state.name == "Sprint" else 1
	
	
	lock_state_blend = lerp(lock_state_blend, float(desired_lock_state_blend), 10 * delta)
	locomotion_blend = lerp(locomotion_blend, desired_locomotion_blend, 10 * delta)
	
	set("parameters/Locomotion/TargetLockBlend/blend_amount", lock_state_blend)
	set("parameters/Locomotion/FreeRoamLocomotion/blend_position", locomotion_blend.length())
	set("parameters/Locomotion/TargetLocomotion/blend_position", locomotion_blend)
