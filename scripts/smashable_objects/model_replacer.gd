extends Node3D

@export var PIECES: PackedScene


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		var pieces: Node3D = PIECES.instantiate()
		get_parent().add_child(pieces)
		pieces.transform = transform
		
		queue_free()
