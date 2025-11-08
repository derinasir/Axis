class_name Hurtbox
extends Area3D


signal was_hit(damage_data: DamageData)


func _on_area_entered(area: Area3D) -> void:
	if area.is_in_group("hitbox"):
		was_hit.emit(area.damage_data)
		area.struck.emit()
