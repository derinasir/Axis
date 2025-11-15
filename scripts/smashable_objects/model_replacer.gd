extends Node3D

@export var PIECES: PackedScene


func replace_model() -> void:
	var pieces: Node3D = PIECES.instantiate()
	get_parent().add_child(pieces)
	pieces.transform = transform
	
	queue_free()


func _on_combat_manager_died(_damage_data: DamageData) -> void:
	replace_model()
