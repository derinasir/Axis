extends Control



func _on_castle_guard_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/castle_guard_test_scene.tscn")



func _on_maria_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/maria_test_scene.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
