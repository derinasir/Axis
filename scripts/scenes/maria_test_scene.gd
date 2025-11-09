extends Node3D


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/main_menu.tscn")


func _on_reload_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/maria_test_scene.tscn")
