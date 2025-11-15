extends Node


var mouse_sensitivity: float = 2.0
var gamepad_sensitivity: float = 5.0
var camera_invert_h: bool = false
var camera_invert_v: bool = false


var connected_gamepads: Array = Input.get_connected_joypads()

func has_connected_gamepads() -> bool:
	return connected_gamepads.size() != 0

func _init() -> void:
	if has_connected_gamepads():
		print("Gamepads connected: " + str(connected_gamepads))
	else:
		print("No gamepads connected")
