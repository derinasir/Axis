extends Node3D


const INTENSITY: float = 6.0

func _ready() -> void:
	for i in get_child_count():
		var angle: float = TAU * i / get_child_count()
		var dir = Vector3(cos(angle), 0, sin(angle)).normalized()
		get_child(i).apply_central_impulse(dir * INTENSITY)

	await get_tree().create_timer(5).timeout
	queue_free()
